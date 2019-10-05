# coding: tilde

from copy import copy
import core.arithmetic as arithmetic
import logging
import collections

from core.memloc import range_overlaps, splits_mem, memloc_overwrite, split_setmem, apply_mask_to_range, split_store, sizeof

from utils.helpers import contains, rewrite_trace_multiline, opcode, cached, walk_trace, to_exp2, replace, find_f_set, find_f_list, rewrite_trace, rewrite_trace_full, replace_f, is_array

from core.algebra import simplify, calc_max, add_ge_zero, minus_op, sub_op, flatten_adds, max_to_add, divisible_bytes, _max_op
from core.algebra import add_op, bits, mul_op, get_sign, safe_ge_zero, ge_zero, lt_op, safe_lt_op, safe_le_op, simplify_max, le_op, max_op, safe_max_op, safe_min_op, min_op, or_op, neg_mask_op, mask_op, apply_mask_to_storage, apply_mask, try_add, to_bytes

from core.arithmetic import is_zero, to_real_int

from pano.prettify import pformat_trace, pprint_trace

from utils.profiler import checkpoint, checkpoint_start, print_checkpoints, func_caller

from core.masks import get_bit

from time import gmtime, strftime

from core.masks import to_mask, to_neg_mask

import utils.profiler

from utils.profiler import *


def postprocess_exp(exp):
    if exp ~ ('data', *terms):
        # make arrays in data
        concrete = [t for t in terms if type(t) == int and t % 32 == 0]
        if len(concrete) == 1:
            # potential array in data?
            assert concrete[0] % 32 == 0
            loc = concrete[0] // 32
            if loc + 1 < len(terms) and loc > terms.index(concrete[0]):
                arr = ('arr', ) + terms[loc:]

    # heuristics for cleaning up various misprocessed stuff
    
                if arr ~ ('arr', :l, (:op, _, l), ...) and is_array(op):
                    arr = arr[:3]

                elif arr ~ ('arr', :l, ('mask_shl', ('mask_shl', 253, 0, 3, l), _, _, ('data', (:op, :st, l), ...), ...)) and is_array(op):
                    arr = ('arr', l, (op, st, l))
                
                t2 = tuple([arr if t == loc*32 else t for t in terms[:loc]])
                return ('data', ) + t2

    # this would really require debugging as to why such thing happens, and a nicer cleanup.
    # but it's last minute fixes again :)

    if exp ~ ('arr', :l, ('mask_shl', ('mask_shl', _, 0, 3, l), ('add', 256, _), ('add', -256, _), ('data', ('call.data', :s, l), ...), ...)):
       return ('arr', l, ('call.data', s, l))

    
    return exp


def postprocess_trace(line):
    '''
        let's find all the stuff like
        
         if (some_len % 32) == 0:
            return Array(some_len, some_stuff)
         else:
            mem[...] = leftover
            return Array(some_len, some_stuff, leftover)

        and replace it with just return Array(some_len, some_stuff)

        in theory this is incorrect, because perhaps program does something totally different
        in the one branch, andd something entirely different in another.
        but this cleans up tremendous amounts of output, and didn't find a counterexample yet.
    '''

#    if line ~ ('setmem', ('range', :s, ('mask_shl', 251, 5, 0, ('add', 31, ('cd', ('add', 4, :param))))), ('data', ('call.data', ('add', 36, param), ('cd', ('add', 4, param))), ('mem', ...))):
#        lin = ('setmem', ('range', s, ('cd', ('add', 4, param))), ('call.data', ('add', 36, param), ('cd', ('add', 4, param))))
#        return [lin]

    if line ~ ('if', ('iszero', ('storage', 5, 0, :l)), :if_true, :if_false):
        def find_arr_l(exp):
            if exp ~ ('arr', ('storage', 256, 0, l), ...):
                return [exp]

        true_arr = find_f_list(if_true, find_arr_l)
        false_arr = find_f_list(if_true, find_arr_l)

        if len(true_arr) > 0 and len(true_arr) == len(false_arr):
            return if_true


    if line ~ ('if', ('iszero', ('mask_shl', 5, 0, 0, :l)), :if_true, :if_false):
        def find_arr_l(exp):
            if exp ~ ('arr', l, ...):
                return [exp]
        true_arr = find_f_list(if_true, find_arr_l)
        false_arr = find_f_list(if_true, find_arr_l)

        if len(true_arr) > 0 and len(true_arr) == len(false_arr):
            return if_true


    '''
        When writing strings to storage, there are usually three cases - when string is 0,
        when string is < 31 (special format that takes just one storage slot), and when string >= 32.

        e.g. 0xf97187f566eC6374cB08470CCe593fF0Dd36d8A9, baseURI
             0xFcD0d8E3ae34922A2921f7E7065172e5317f8ad8, name

        The below hides the cases for < 31, and for 0, and shows only for >31. Technically incorrect,
        and I'm not super comfortable with this, but some of the code would be very unreadable without it.


    '''

    if line ~ ('if', ('lt', 31, :some_len), :if_true, :if_false):
        if len(if_true) == 2:
            first, second = if_true[0], if_true[1]
            if first ~ ('store', ...) and contains(first, some_len) \
               and second ~ ('if', ('iszero', some_len), :deep_true, :deep_false):
                    return [first] + deep_false

    if line ~ ('if', ('iszero', ('mask_shl', 255, 1, 0, ('and', ('storage', 256, 0, :loc), ('add', -1, ('mask_shl', 248, 0, 8, ('iszero', ('storage', 1, 0, loc))))))), :if_true, :if_false) \
        or line ~ ('if', ('iszero', ('mask_shl', 255, 1, 0, ('and', ('add', -1, ('mask_shl', 248, 0, 8, ('iszero', ('storage', 1, 0, :loc)))), ('storage', 256, 0, loc)))), :if_true, :if_false):

        if len(if_false) == 1:
            first = if_false[0]

            if first ~ ('if', ('lt', 31, ('storage', 256, 0, ('length', loc))), :deep_true, :deep_false) \
                or first ~ ('if', ('lt', 31, ('storage', 256, 0, ('length', ('loc', loc)))), :deep_true, :deep_false):
                return deep_true

    return [line]

def rewrite_string_stores(lines):
    # ugly af, and not super-precise. it should be split into 2 parts,
    # converting array->storage writes in loop_to_setmem_from_storage
    # and then relying on those storage writes here for cleanup

    assert len(lines) == 3
    l1, l2, l3 = lines[0], lines[1], lines[2]
    if l1 ~ ('store', 256, 0, :idx, ('add', 1, ('mask_shl', 255, 0, 1, :src))) \
       and l2 ~ ('while', ('gt', _, _), :path2, _, :setvars) \
       and l3 ~ ('while', ('gt', ...), :path3, ...) \
       and len(path2) == 2 and (x:= path2[0]) \
       and x ~ ('store', 256, 0, ('add', ('var', _), _), ('mem', ('range', ('var', :v), 32))):
            return [
                ('store', 256, 0, ('array', '', ('sha3', idx)), ('arr', src, ('mem', ('range', setvars[1][2], src))))
            ]

    return None

def rewrite_memcpy(lines): # 2
    assert len(lines) == 2
    l1 = lines[0]
    l2 = lines[1]

    if l1 ~ ('setmem', ('range', :s, ('mask_shl', 251, 5, 0, ('add', 31, ('cd', ('add', 4, :param))))), ('data', ('call.data', ('add', 36, param), ('cd', ('add', 4, param))), ('mem', ...))):
        return ('setmem', ('range', s, ('cd', ('add', 4, param))), ('call.data', ('add', 36, param), ('cd', ('add', 4, param))))
#(setmem (range (add 128 (mask_shl 251 5 0 (add 31 (cd (add 4 (cd 68)))))) (mask_shl 251 5 0 (add 31 (cd (add 4 (cd 68)))))) (data (call.data (add 36 (cd 68)) (cd (add 4 (cd 68)))) (mem (range (add 128 (cd (add 4 (cd 68)))) (add (mask_shl 251 5 0 (add 31 (cd (add 4 (cd 68))))) (mul -1 (cd (add 4 (cd 68)))))))))
#        (if (iszero (mask_shl 5 0 0 (cd (add 4 (cd 68))))) (t


'''

    test case for above:

    (store 256 0 0 (add 1 (mask_shl 255 0 1 (cd (add 4 (cd 36))))))
        (while (gt (add 160 (mask_shl 251 5 0 (add 31 (cd (add 4 (cd 4))))) (cd (add 4 (cd 36)))) (var 0)) (t
          (store 256 0 (add (var 1) (sha3 0)) (mem (range (var 0) 32)))
          (continue id8785 ((setvar 1 (add 1 (var 1))) (setvar 0 (add 32 (var 0)))))
        ) id8785 [('setvar', 1, 0), ('setvar', 0, ('add', 160, ('mask_shl', 251, 5, 0, ('add', 31, ('cd', ('add', 4, ('cd', 4)))))))])
        (while (gt (mask_shl 251 5 -5 (add 31 (storage 256 0 (length (loc 0))))) (var 0)) (t
          (store 256 0 (add (var 0) (sha3 0)) 0)
          (continue id3054 ((setvar 0 (add 1 (var 0)))))
        ) id3054 [('setvar', 0, ('mask_shl', 251, 0, -5, ('add', 31, ('cd', ('add', 4, ('cd', 36))))))])
        (store 256 0 1 (add 1 (mask_shl 255 0 1 (cd (add 4 (cd 4))))))
        (while (gt (add 128 (cd (add 4 (cd 4)))) (var 0)) (t
          (store 256 0 (add (var 1) (sha3 1)) (mem (range (var 0) 32)))
          (continue id2702 ((setvar 1 (add 1 (var 1))) (setvar 0 (add 32 (var 0)))))
        ) id2702 [('setvar', 1, 0), ('setvar', 0, 128)])
        (while (gt (mask_shl 251 5 -5 (add 31 (storage 256 0 (length (loc 1))))) (var 0)) (t
          (store 256 0 (add (var 0) (sha3 1)) 0)
          (continue id6799 ((setvar 0 (add 1 (var 0)))))
        ) id6799 [('setvar', 0, ('mask_shl', 251, 0, -5, ('add', 31, ('cd', ('add', 4, ('cd', 4))))))])

'''



@cached
def simplify_exp(exp):

    if type(exp) == list:
        return exp

    if exp ~ ('mask_shl', 246, 5, 0, :exp):
        exp = ('mask_shl', 251, 5, 0, exp) # mathematically incorrect, but this appears as an artifact of other
                                            # ops often.

    if exp ~ ('and', *terms):
        real = 2**256-1
        symbols = []
        for t in terms:
            if type(t) == int and t >=0:
                real = real & t
            elif t ~ ('and', *tms):
                symbols += tms
            else:
                symbols.append(t)

        if real != 2**256-1:
            res = (real, )
        else:
            res = tuple()

        res += tuple(symbols)
        exp = ('and', ) + res

    if exp ~ ('data', *terms) and \
        all([t == 0 for t in terms]):
            return 0

    if exp ~ ('mask_shl', int:size, int:off, -off, ('cd', int:num)) and \
            size in (8, 16, 32, 64, 128) and off > 0:
                return ('mask_shl', size, 0, 0, ('cd', num)) # calldata params are left-padded usually, it seems

    if exp ~ ('bool', ('bool', :e)):
        exp = ('bool', e)    

    if exp ~ ('eq', :sth, 0) or \
       exp ~ ('eq', 0, sth):
            exp = ('iszero', sth)

    if exp ~ ('mask_shl', int:size, 5, 0, ('add', int:num, *terms)) and \
            size > 240 and num % 32 == 31 and num > 32:
                exp = ('add', num//32, ('mask_shl', 256, 5, 0, ('add', 31, )+terms))

    if exp ~ ('iszero', ('mask_shl', :size, :off, :shl, :val)):
        exp = ('iszero', ('mask_shl', size, off, 0, val))

    if exp ~ ('max', :single):
        exp = single

    if exp ~ ('mem', ('range', _, 0)):
        return None # sic. this happens usually in params to logs etc, we probably want None here

    if exp ~ ('mod', :exp2, int:num) and (size:=to_exp2(num)):
        return mask_op(exp2, size=size)

    # same thing is added in both expressions ?
    if exp ~ (:op, ('add', *e1), ('add', *e2)) and op in ('lt', 'le', 'gt', 'ge'):
        t1 = tuple(t for t in e1 if t not in e2)
        t2 = tuple(t for t in e2 if t not in e1)
        exp = (op, add_op(*t1), add_op(*t2))

    if exp ~ ('add', :e):
#        print('single add')
        return simplify_exp(e)

    if exp ~ ('mul', 1, :e):
        return simplify_exp(e)

    if exp ~ ('div', :e, 1):
        return simplify_exp(e)

    if exp ~ ('mask_shl', 256, 0, 0, :val):
        return simplify_exp(val)

    if exp ~ ('mask_shl', int:size, int:offset, int:shl, :e):
        exp = mask_op(simplify_exp(e), size, offset, shl)

    if exp ~ ('mask_shl', :size, 0, 0, ('div', :expr, ('exp', 256, :shr))):
        exp = mask_op(simplify_exp(expr), size, 0, shr=bits(shr))
        
    if exp ~ ('mask_shl', _, _, :shl, ('storage', :size, _, _)) and \
        safe_le_op(size, minus_op(shl)):
        return 0

    if exp ~ ('or', :sth, 0):
        return sth

    if exp ~ ('add', *terms):
        res = 0
        for el in terms:
            el = simplify_exp(el)
            if el ~ ('add', ...:pms):
                for e in pms:
                    res = add_op(res, e)
            else:
                res = add_op(res, el)
        exp = res

    if exp ~ ('mask_shl', ...):
        exp = cleanup_mask_data(exp)

    if exp ~ ('mask_shl', :size, 0, 0, ('mem', ('range', :mem_loc, :mem_size))):
        if divisible_bytes(size) and safe_le_op(to_bytes(size)[0], mem_size):
           return ('mem', apply_mask_to_range(('range', mem_loc, mem_size), size, 0))

    if exp ~ ('mask_shl', :size, :off, :shl, ('mem', ('range', :mem_loc, :mem_size))) and shl == minus_op(off):
        if divisible_bytes(size) and safe_le_op(to_bytes(size)[0], mem_size) and divisible_bytes(off):
           return ('mem', apply_mask_to_range(('range', mem_loc, mem_size), size, off))


    if exp ~ ('data', *params):
        res = []

        # simplify inner expressions, and remove nested 'data's
        for e in params:
            e = simplify_exp(e) # removes further nested datas, and does other simplifications
            if opcode(e) == 'data':
                res.extend(e[1:])
            else:
                res.append(e)

        # sometimes we may have on expression split into two masks next to each other
        # e.g.  (mask_shl 192 64 -64 (cd 36)))) (mask_shl 64 0 0 (cd 36))
        #       (in solidstamp withdrawRequest)
        # merge those into one.

        res2 = res
        res = None
        while res2 != res: # every swipe merges up to two elements next to each other. repeat until there are no new merges
                           # there's a more efficient way of doing this for sure.
            res, res2 = res2, []
            idx = 0
            while idx < len(res):
                el = res[idx]
                if idx == len(res) -1:
                    res2.append(el)
                    break

                next_el = res[idx+1]
                idx += 1

                if el ~ ('mask_shl', :size, :offset, :shl, :val) \
                   and next_el == ('mask_shl', offset, 0, 0, val) \
                   and add_op(offset, shl) == 0:
                    res2.append(('mask_shl', add_op(size, offset), 0, 0, val))
                    idx += 1

                else:
                    res2.append(el)

        res = res2

        # could do the same for mem slices, but no case of that happening yet

        if len(res) == 1:
            return res[0]
        else:
            return ('data', ) + tuple(res)

    if exp ~ ('mul', -1, ('mask_shl', :size, :offset, :shl, ('mul', -1, :val))):
        return ('mask_shl', simplify_exp(size), simplify_exp(offset), simplify_exp(shl), simplify_exp(val))

    if type(exp) == int and to_real_int(exp)>-(8**22): # if it's larger than 30 bytes, it's probably
                                                          # an address, not a negative number
        return to_real_int(exp)

    if exp ~ ('and', :num, :num2):
        num = arithmetic.eval(num)
        num2 = arithmetic.eval(num2)
        if type(num) == int or type(num2) == int:
            return simplify_mask(exp)

    if type(exp) == list:
        r = simplify_exp(tuple(exp))
        return list(r)

    if type(exp) != tuple:
        return exp

    if exp ~ ('mask_shl', int:size, int:offset, int:shl, int:val):
        return apply_mask(val, size, offset, shl)

    if exp ~ ('mask_shl', :size, 5, :shl, ('add', 31, ('mask_shl', 251, 0, 5, :val))):
        return simplify_exp(('mask_shl', size, 5, shl, val))

    if exp ~ ('mul', *terms):
        res = 1
        for e in terms:
            res = mul_op(res, simplify_exp(e))

        res ~ ('mul', 1, res)

        return res

    if exp ~ ('max', *terms):
        els = [simplify_exp(e) for e in terms]
        res = 0
        for e in els:
            res = _max_op(res, e)
        return res

    res = tuple()
    for e in exp:
        res += (simplify_exp(e), )

    return res


def simplify_mask(exp):
    op = opcode(exp)

    if op in arithmetic.opcodes:
        exp = arithmetic.eval(exp)

    if exp ~ ('and', :left, :right):

        if mask := to_mask(left):
            exp = mask_op(right, *mask)

        elif mask := to_mask(right):
            exp = mask_op(left, *mask)

        elif bounds := to_neg_mask(left):
            exp = neg_mask_op(right, *bounds)

        elif bounds := to_neg_mask(right):
            exp = neg_mask_op(left, *bounds)

    elif exp ~ ('div' , :left, int:right) and (shift := to_exp2(right)):
            exp = mask_op(left, size = 256-shift, offset = shift, shr = shift)

    elif exp ~ ('mul', int:left, :right) and (shift := to_exp2(left)):
            exp = mask_op(right, size=256-shift, shl = shift)

    elif exp ~ ('mul', :left, int:right) and (shift := to_exp2(right)):
            exp = mask_op(left, size=256-shift, shl = shift)

    return exp


def cleanup_mask_data(exp):
    # if there is a mask over some data,
    # it removes pieces of data that for sure won't
    # fit into the mask (doesn't truncate if something)
    # partially fits
    # e.g. mask(200, 8, 8 data(123, mask(201, 0, 0, sth), mask(8,0, 0, sth_else)))
    #      -> mask(200, 0, 0, mask(201, 0, 0, sth))

    def _cleanup_right(exp):
        # removes elements that are cut off by offset
        assert exp ~ ('mask_shl', :size, :offset, :shl, :val)

        if opcode(val) != 'data':
            return exp

        last = val[-1]
        if sizeof(last) is not None and safe_le_op(sizeof(last), offset):
            offset = sub_op(offset, sizeof(last))
            shl = add_op(shl, sizeof(last))
            if len(val) == 3:
                val = val[1]
            else:
                val = val[:-1]

            return mask_op(val, size, offset, shl)

        return exp

    def _cleanup_left(exp):
        # removes elements that are cut off by size+offset
        assert exp ~ ('mask_shl', :size, :offset, :shl, :val)

        if opcode(val) != 'data':
            return exp

        total_size = add_op(size, offset) # simplify_exp

        sum_sizes = 0
        val = list(val[1:])
        res = []
        while len(val) > 0:
            last = val.pop()
            if sizeof(last) is None:
                return exp
            sum_sizes = simplify_exp(add_op(sum_sizes, sizeof(last)))
            res.insert(0, last)
            if safe_le_op(total_size, sum_sizes):
                return exp[:4] + (('data', )+tuple(res), )


        return exp

    assert opcode(exp) == 'mask_shl'

    prev_exp = None
    while prev_exp != exp:
        prev_exp = exp
        exp = _cleanup_right(exp)

    prev_exp = None
    while prev_exp != exp:
        prev_exp = exp
        exp = _cleanup_left(exp)

    if exp ~ ('mask_shl', :size, 0, 0, ('data', *terms)):
        # if size of data is size of mask, we can remove the mask altogether
        sum_sizes = 0
        for e in terms:
            s = sizeof(e)
            if s is None:
                return exp
            sum_sizes = add_op(sum_sizes, s)

        if sub_op(sum_sizes, size) == 0:
            return ('data', ) + terms

    return exp
