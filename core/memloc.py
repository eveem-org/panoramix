# coding: tilde
from .algebra import add_op, lt_op, le_op, CannotCompare, to_bytes, safe_gt_zero, safe_le_op
from utils.helpers import opcode, cached, before_after, contains, replace, is_array
import logging
from pano.matcher import match, Any

import sys

from utils.profiler import checkpoint, checkpoint_start

logger = logging.getLogger(__name__)

logger.level = logging.CRITICAL# INFO

from .masks import find_mask

from .algebra import simplify, calc_max, add_ge_zero, minus_op, sub_op, flatten_adds, max_to_add
from .algebra import add_op, bits, mul_op, get_sign, safe_ge_zero, ge_zero, lt_op, safe_lt_op, safe_le_op
from .algebra import simplify_max, le_op, max_op, safe_max_op, safe_min_op, min_op, or_op, neg_mask_op, mask_op
from .algebra import apply_mask_to_storage, apply_mask, try_add, all_concrete
from .algebra import lt_op

def apply_mask_to_range(memloc, size, offset):
    assert (m := match(memloc, ('range', ':range_pos', ':range_len')))
    range_pos = m.range_pos
    range_len = m.range_len

    size_bytes, size_bits = to_bytes(size)
    offset_bytes, offset_bits = to_bytes(offset)

    assert offset_bits == size_bits == 0, (offset_bits, size_bits) # for now
    assert safe_le_op(add_op(size_bytes, offset_bytes), range_len) is True, (size_bytes, offset_bytes, range_len) # otherwise we need to learn to handle that

    range_pos = add_op(range_pos, sub_op(range_len, add_op(size_bytes, offset_bytes)))
    range_len = size_bytes #sub_op(range_len, add_op(offset_bytes, size_bytes))

    return ('range', range_pos, range_len)

assert apply_mask_to_range(('range', 212, 32), 160, 0) == ('range', 224, 20)
assert apply_mask_to_range(('range', 212, 32), 160, 96) == ('range', 212, 20)

def cmp_to_key(mycomp):
    class K:
        def __init__(self, obj):
            self.obj = obj

        def __lt__(self, other):
            return lt_op(self.obj, other.obj)

    return K(mycomp)

def split_or(value):
    orig_value = value

    if opcode(value) not in ('or', 'mask_shl'):
        return [(256,0,value)]

    if opcode(value) == 'mask_shl':
        value = ('or', value)

    opcode_, *terms = value
    assert opcode_ == 'or'


    ret_rows = []

    for row in terms:
        if m := match(row, ('bool', ':arg')):
            row = ('mask_shl', 8, 0, 0, ('bool', m.arg)) # does weird things if size == 1, in loops.activateSafeMode

        if row == 'caller':
            row = ('mask_shl', 160, 0, 0, 'caller') # does weird things if size == 1, in loops.activateSafeMode

        if row == 'block.timestamp':
            row = ('mask_shl', 64, 0, 0, 'caller') # does weird things if size == 1, in loops.activateSafeMode


        if m := match(row, ('mul', 1, ':val')):
            row = m.val

        if opcode(row) == 'mask_shl' and all_concrete(row):
            row = apply_mask(row[4] if row[4]<256 else 256, row[1], row[2], row[3])

        if type(row) in [int, float]:
            size, offset = find_mask(row)
            shl = 0
            row = ('mask_shl', size, offset, 0, row)

        if m := match(row, ('mem', ':mem_idx')):
            if opcode(m.mem_idx) != 'range':
                m.mem_idx = ('range', m.mem_idx, 32)

            mem_begin = m.mem_idx[1]
            mem_len = m.mem_idx[2]
            ret_rows.append((bits(mem_len), 0, row))
            continue

        if m := match(row, ('storage', ':size', ':off', ':idx')):
            ret_rows.append((m.size, 0, row))
            continue

        if opcode(row) != 'mask_shl':
            return [(256,0, value)]

        assert opcode(row) == 'mask_shl'
        _, size, offset, shl, value = row

        stor_size = size
        stor_offset = add_op(offset, shl)
        shl = sub_op(shl, stor_offset)
        if type(value) == int:
            value = apply_mask(value, size, offset, shl)

        elif (m := match(value, ('mem', ':idx'))) and add_op(offset, shl) == 0:
            new_memloc = apply_mask_to_range(m.idx, size, offset)
            value = ('mem', new_memloc)

        else:
            value = mask_op(value, size=size, offset=offset, shl=shl)


        ret_rows.append((stor_size, stor_offset, value, ))

    if len(ret_rows) == 2:
        '''
        a special case where rows are symbolic and complimentary. happens often
        (('mask_shl', 5, 0, 3, ('cd', ('add', 4, ('cd', 68)))), 0, ('mem', ('range', ('add', 160, ('mask_shl', 251, 5, 0, ('cd', ('add', 4, ('cd', 68)))), ('mul', -1, ('mask_shl', 5, 0, 0, ('cd', ('add', 4, ('cd', 68)))))), ('mask_shl', 5, 0, 0, ('cd', ('add', 4, ('cd', 68)))))))
        (('mask_shl', 253, 0, 3, ('add', 32, ('mul', -1, ('mask_shl', 5, 0, 0, ('cd', ('add', 4, ('cd', 68))))))), ('add', 256, ('mul', -1, ('mask_shl', 253, 0, 3, ('add', 32, ('mul', -1, ('mask_shl', 5, 0, 0, ('cd', ('add', 4, ('cd', 68))))))))), ('mem', ('range', ('add', 185, ('mask_shl', 251, 5, 0, ('add', 31, ('cd', ('add', 4, ('cd', 68))))), ('mask_shl', 251, 5, 0, ('add', 31, ('cd', ('add', 4, ('cd', 164))))), ('mask_shl', 251, 5, 0, ('cd', ('add', 4, ('cd', 68)))), ('mask_shl', 251, 0, 5, 1)), ('add', 32, ('mul', -1, ('mask_shl', 5, 0, 0, ('cd', ('add', 4, ('cd', 68)))))))))
        '''
        first = ret_rows[0]
        second = ret_rows[1]
        if first[1] != 0 and second[1] == 0:
            second, first = first, second

        f_size, f_off, f_val = first
        s_size, s_off, s_val = second

        try:
            if f_off == 0 and s_off == ('add', 256, ('mul', -1, ('mask_shl', 253, 0, 3, ('add', 32, ('mul', -1, ('mask_shl', 5, 0, 0, f_size[4])))))):
                assert match(s_size, ('mask_shl', Any, Any, Any, ('add', 32, ('mul', -1, ...))))
                return ret_rows
        except (TypeError, IndexError):
            pass

    try:
        ret_rows.sort(key = lambda row: cmp_to_key(row[1])) # sort by offsets, descending
    except:
        return [(256,0, orig_value)]

    # insert zeroes into empty spaces

    result = []

    pos = 0

    for r in ret_rows:
        if type(r[1]) != int or type(r[0]) != int:
            return [(256,0, value)]
        if r[1] > pos:
            result.append((r[1]-pos, pos, 0))

        result.append(r)
        pos = r[1]+r[0]

    if pos < 256:
        result.append((256-pos, pos, 0))

    return result

def sizeof(exp): # returns size of expression in *bits*
    if exp ~ ('storage', :size, ...):
        return size

    if exp ~ ('mask_shl', :size, :off, :shl, _):
        return add_op(size, off, shl)

    if exp ~ (:op, _, :size_bytes) and is_array(op):
        return bits(size_bytes)

    if exp ~ ('mem', ('range', _, :size_bytes)):
        return bits(size_bytes)

    if exp ~ ('mem', :idx):
        assert False

    if exp ~ ('arr', :l, _):
        assert False, exp

#    if exp ~ ('bytes', :l, _):
#        return bits(l)
    if type(exp) == int and exp > 2**256:
        return bits(((exp).bit_length() + 7) // 8) # number of bytes needed to contain the number, rounded up

    return 256
    return None

def split_setmem(line):
    if opcode(line) != 'setmem':
        return [line]

    assert line ~ ('setmem', :mem_idx, :mem_val)

    if opcode(mem_val) != 'or':
        return [line]

    post_split = split_or(mem_val)

    res = []
    for size, offset, split_val in post_split:
        try:

            split_idx = apply_mask_to_range(mem_idx, size, offset)
        except:
            logger.warning('problem with split_setmem')
            return [line]
        res.append(('setmem', split_idx, split_val))

    return res

def split_store(line):
    if line ~ ('store', 256, 0, int:idx, ('mask_shl', int:size, int:off, 0, ('storage', 256, 0, idx))) and size < 256:

        lines = []
        if off > 0:
            lines.append(('store', off, 0, idx, 0))
#        lines.append(('store', size, off, idx, ('storage', size, off, idx)))
        if size + off < 256:
            lines.append(('store', (256 - size - off), size + off, idx, 0))

        return lines

    if line ~ ('store', :size, :off, :idx, :val) and size==256 and off==0:

        splitted = split_or(val)

        res = []
        for s_size, s_off, s_val in splitted:
            if safe_le_op(off, s_off) and safe_le_op(add_op(s_size, s_off), add_op(off, size)):
                if s_val != ('storage', s_size, s_off, idx): # ignore writing the same to the same storage
                    res.append(('store', s_size, s_off, idx, s_val))
            else:
                logger.warning('unusual store')
                return [line]

        return res
    else:
        return [line]


def memloc_overwrite(memloc, split):
    # returns mem ranges excluding the ones that are *for sure* overwritten by 'split'
    # e.g. overwrites(('range', 64, 32), ('range', 70, 10)) -> [('range', 64, 6), (range, 80, 16)]
    # e.g. overwrites(('range', 64, 32), ('range', 70, 'unknown')) -> [('range', 64, 32)], bc. 'unknown' can be 0

    assert memloc ~ ('range', :m_left, :m_len)
    assert split ~ ('range', :s_left, :s_len)

    m_right = add_op(m_left, m_len)
    s_right = add_op(s_left, s_len)

    if safe_le_op(m_right, s_left) is True: # split after memory - no overlap
        return [memloc]
    if safe_le_op(s_right, m_left) is True: # split before memory - no overlap
        return [memloc]

    left_len = sub_op(s_left, m_left)
    right_len = sub_op(m_right, s_right)

    range_left = ('range', m_left, left_len)
    range_right = ('range', s_right, right_len)

    left_ge_zero, right_ge_zero = safe_ge_zero(left_len), safe_ge_zero(right_len)

    if left_ge_zero is None or right_ge_zero is None:
        # we can't compare some numbers, conservatively return whole range
        return [memloc]

    res = []

    if safe_ge_zero(left_len) is True and left_len != 0:
        res.append(range_left)

    if safe_ge_zero(right_len) is True and right_len != 0:
        res.append(range_right)

    return res

assert memloc_overwrite(('range', 64, 32), ('range', 70, 10)) == [('range', 64, 6), ('range', 80, 16)]
assert memloc_overwrite(('range', 64, 32), ('range', 70, add_op('unknown',100))) == [('range', 64, 6)]
assert memloc_overwrite(('range', 64, 'x'), ('range', 70, add_op('unknown',100))) == [('range', 64, 'x')]

def slice_exp(exp, left, right):
    size = sub_op(right, left)

    logger.info(f'slicing {exp}, offset {left} bytes, until {right} bytes')
    # e.g. mem[32 len 10], 2, 4 == mem[34,2]

    if exp ~ ('mem', ('range', :rleft, :rlen)):
        if safe_le_op(add_op(left, size), rlen):
            return ('mem', ('range', add_op(rleft, left), size))
        else:
            return None

    if exp ~ (:op, :rleft, :rlen) and is_array(op):
        if safe_le_op(add_op(left, size), rlen):#, (rleft, rlen, left, size, right)
            return (op, add_op(rleft, left), size)
        else:
            return None

    logger.info(f"sizeof exp {sizeof(exp)}")
    off = sub_op(sizeof(exp), bits(right))
    logger.info(f"applying mask, size 8*{size}, offset {off}")

    m = mask_op(exp, size=bits(size), offset=off, shr=off)
    logger.info(f"result {m}")
    return m

assert slice_exp(('mem', ('range', 32, 10)), 2, 4) == ('mem', ('range', 34, 2))
assert slice_exp(('mask_shl', 32, 0, 0, ('cd', 0)), 0, 4) == ('mask_shl', 32, 0, 0, ('cd', 0))
assert slice_exp(('mask_shl', 32, 0, 0, ('cd', 0)), 2, 4) == ('mask_shl', 16, 0, 0, ('cd', 0))
assert slice_exp(('mask_shl', 32, 0, 0, ('cd', 0)), 0, 2) == ('mask_shl', 16, 16, -16, ('cd', 0))


def splits_mem(memloc, split, memval, split_val=None):
    # returns memory values we can be confident of, after overwriting the split part of memory

    assert memloc ~ ('range', :m_left, :m_len)
    assert split ~ ('range', :s_left, :s_len)

    m_right = add_op(m_left, m_len)
    s_right = add_op(s_left, s_len)

    logger.info(f'applying split [{s_left} (len {s_len}) {s_right}]')
    logger.info(f'            to [{m_left} (len {m_len}) {m_right}]')

    if not safe_ge_zero(s_len):
        s_len = 'undefined'
        s_right = add_op(s_left, s_len)

    if safe_le_op(m_right, s_left) is True: # split after memory - no overlap
        return [(memloc, memval)]

    if safe_le_op(s_right, m_left) is True: # split before memory - no overlap
        return [(memloc, memval)]


    left = safe_max_op(s_left, m_left)
    right = safe_min_op(s_right, m_right)

    logger.info(f'split overwrites memory from {left} to {right}')

    # left/right relative to beginning of memory location
    in_left = sub_op(left, m_left)
    in_right = sub_op(right, m_left)

    logger.info(f'that is, relative to memloc {in_left} to {in_right}')
    if safe_le_op(in_left, m_len) is not True or left is None:
        logger.info(f'we are not sure that m_len: {m_len} is bigger than beginning of split, returning []')
        return []

    assert in_left == 0 if safe_le_op(right, m_left) else True

    val_left = slice_exp(memval, 0, in_left) if left is not None else None
    val_right = slice_exp(memval, in_right, sub_op(m_right, m_left)) if right is not None else None
    res = []

    left_len = sub_op(left, m_left) #sizeof(val_left)
    right_len = sub_op(m_right, right)

    if safe_ge_zero(left_len) is True and left_len != 0 and val_left is not None:
        res.append((('range', m_left, left_len), val_left))

    if split_val is not None:
        center_left = safe_max_op(m_left, s_left)
        center_right = safe_min_op(m_right, s_right)

        center_len = sub_op(center_right, center_left)

        if is_array(opcode(split_val)):# in ARRAY_OPCODES:
            #mem[a len b] = calldata[x len b]
            #log mem[c len d]
            # -> calldata[x+ c - a, center_len]
            arr_offset, arr_len = split_val[1:]
            center_offset = add_op(arr_offset, sub_op(center_left, s_left))
            center_val = (opcode(split_val), center_offset, center_len)

        else:
            center_offset = sub_op(s_right, center_right)
            center_val = mask_op(split_val, size=mul_op(center_len,8), offset=mul_op(center_offset, 8), shr=mul_op(center_offset, 8) )

        center_range = ('range', center_left, center_len)


        if safe_ge_zero(center_len) and center_len != 0:
            res.append((center_range, center_val))

    if safe_ge_zero(right_len) is True and right_len != 0 and val_right is not None:
        res.append((('range', right, right_len), val_right))

    return res

assert splits_mem(('range', 66, 32), ('range', 65, 32), 'a') == [(('range', 97, 1), ('mask_shl', 8, 0, 0, 'a'))], splits_mem(('range', 66, 32), ('range', 65, 32), 'a')
assert splits_mem(('range', 64, 32), ('range', 65, 32), 'a') == [(('range', 64, 1), ('mask_shl', 8, 248, -248, 'a'))], splits_mem(('range', 64, 32), ('range', 65, 32), 'a')
assert splits_mem(('range', 4, 32), ('range', 65, 32), 'a') == [(('range', 4, 32), 'a')]
assert splits_mem(('range', 104, 32), ('range', 65, 32), 'a') == [(('range', 104, 32), 'a')]
assert splits_mem(('range', 64, 32), ('range', 65, 30), 'a') == [(('range', 64, 1), ('mask_shl', 8, 248, -248, 'a')), (('range', 95, 1), ('mask_shl', 8, 0, 0, 'a'))]

assert splits_mem(('range', 64, 32), ('range', 'x', 32), 'a') == [] # not sure means return empty
assert splits_mem(('range', 64, 32), ('range', 65, 'x'), 'a') == [(('range', 64, 1), ('mask_shl', 8, 248, -248, 'a'))]
assert splits_mem(('range', 64, 'x'), ('range', 65, sub_op('x',2)), 'a') == [], splits_mem(('range', 64, 'x'), ('range', 65, sub_op('x',2)), 'a') # because it's either '1' if x>=1 or '0' if x == 0

assert splits_mem(('range', 64, 32), ('range', 65, 30), 'a','b') == [(('range', 64, 1), ('mask_shl', 8, 248, -248, 'a')), (('range', 65, 30), ('mask_shl', 240, 0, 0, 'b')), (('range', 95, 1), ('mask_shl', 8, 0, 0, 'a'))]

assert splits_mem(('range', 'x', 32),('range', 'y', 32),'a','b') == []

assert splits_mem(('range', 64, 32), ('range', 65, 32), 'a','b') == [(('range', 64, 1), ('mask_shl', 8, 248, -248, 'a')), (('range', 65, 31), ('mask_shl', 248, 8, -8, 'b'))]
assert splits_mem(('range', 64, 32), ('range', 63, 32), 'a','b') == [(('range', 64, 31), ('mask_shl', 248, 0, 0, 'b')), (('range', 95, 1), ('mask_shl', 8, 0, 0, 'a'))]
assert splits_mem(('range', 64, 32), ('range', 630, 32), 'a','b') == [(('range', 64, 32), 'a')]
assert splits_mem(('range', 64, 32), ('range', 1, 32), 'a','b') == [(('range', 64, 32), 'a')]

#assert splits_mem(('range', 64, 'x'), ('range', 64, 'x'), 'a', ('array', 10, 'x')) == [(('range', 64, 'x'), ('array', 10, 'x'))]

'''
#assert splits_mem(('range', 64, 32), ('add', 10, 'x')), ('range', 70, ('add', 10, 'x')), 'a', ('array', 10, ('add', 10, 'x'))) == [(('range', 64, 6), ('mask_shl', 48, ('mask_shl', 253, 0, 3, ('add', 4, 'x')), ('mul', -1, ('mask_shl', 253, 0, 3, ('add', 4, 'x'))), 'a')), (('range', 70, ('add', 4, 'x')), ('array', 10, ('add', 4, 'x')))]
'''

def splits_len(split_list):
    sum_range = 0
    for el in split_list:
        el_range = el[0]
        sum_range = add_op(sum_range, el_range[2])

    return sum_range

'''
test_s = splits_mem(('range', 64, 32), ('range', 65, 32), 'a','b')
assert splits_len(test_s) == 32

test_s = splits_mem(('range', 64, 32), ('range', 65, 30), 'a','b')
assert splits_len(test_s) == 32, test_s
'''
def replace_max_with_MAX(exp):
    if opcode(exp) != 'max':
        return exp, None

    exp = max_to_add(exp)

    res = exp

    for e in exp:
        if opcode(e) == 'max':
            res = e

    exp = replace(exp, res, 'MAX')
    exp = simplify(exp)
    return exp, res


strict = '--strict' in sys.argv

#@cached
def fill_mem(exp, mem_idx, mem_val):

    # speed - if exp contains a variable used in mem_idx
    #         or mem_idx contains a variable not used in exp
    #         there can be no match.
    #
    #         ugly, but shaves off 15% exec time
    logger.info(f'filling mem: {exp} with mem[{mem_idx}] == {mem_val}')

    if mem_idx ~ ('range', ('var', :num), _) and \
       not contains(exp, ('var', num)):
            assert not strict or __fill_data(exp, mem_idx, mem_val) == exp
            return exp

    if exp ~ ('mem', ('range', ('var', :num), _)) and \
       not contains(mem_idx, ('var', num)):
            assert not strict or __fill_data(exp, mem_idx, mem_val) == exp
            return exp

    logger.info(f'no speed improvements')


    # /speed

    f = _fill_mem(exp, mem_idx, mem_val)
    return f



def _fill_mem(exp, split, split_val):
    if exp == ('mem', split):
        return split_val

    assert exp ~ ('mem', :memloc), exp
    assert memloc ~ ('range', :m_left, :m_len)
    assert split ~ ('range', :s_left, :s_len)


    m_right = add_op(m_left, m_len)
    s_right = add_op(s_left, s_len)

    logger.debug(f'orig memloc: {m_left} len {m_len} right {m_right}')
    logger.debug(f'split memloc: {s_left} len {s_len} right {s_right}')


    if safe_le_op(m_right, s_left) is not False: # if the split is before memory, or we can't compare - not replacing
        logger.info(f"split before memory or can't compare - not replacing")
        return exp

    if safe_le_op(s_right, m_left) is not False: # -,,- after memory
        logger.info(f"split after memory or can't compare - not replacing")
        return exp

    left = safe_max_op(s_left, m_left)
    right = safe_min_op(s_right, m_right)

    logger.info(f"split begins at {left} ends at {right}")

    if left is None or right is None:
        return exp # if we can't figure out which one is smaller/larger, we're not replacing

    memloc, memloc_max = replace_max_with_MAX(memloc)
    split, split_max = replace_max_with_MAX(split)
    # 'max' op tends to mess up with all the algebra stuff, so we're replacing
    # it with a variable 'MAX' for the time being

    if split_max != memloc_max:
        logger.warn('different maxes')
        return exp

    # by now we know:
    # - the split overlaps memory for sure
    # - we know the boundaries of split
    # - so we now return data (before_split, split_val, after_split)

    res_left = slice_exp(exp, 0, sub_op(left, m_left))
    if res_left is None:
        return exp
    logger.info(f"value left untouched on left: {res_left}")

    res_right = slice_exp(exp, sub_op(right, m_left), sub_op(m_right, m_left))
    if res_right is None:
        return exp

    logger.info(f"value right untouched on right: {res_right}")

    res = []

    if safe_gt_zero(sizeof(res_left)) is True:
        logger.info(f'size of left untouched > 0, adding to output')
        res.append(res_left)

    elif safe_gt_zero(sizeof(res_left)) is None:
        logger.info(f"we don't know if left size > 0, aborting")
        return exp

    center_in_start = sub_op(left, s_left)
    center_in_len = sub_op(right, s_left)

    logger.info(f"inserted value offset {center_in_start}, length {center_in_len}")
    logger.info(f"cutting this out of {split_val}")

    res_center = slice_exp(split_val, center_in_start, center_in_len)

    logger.info(f"inserted value after slicing: {res_center}")

    if res_center is None:
        return exp

    if safe_ge_zero(sizeof(res_center)) is True:
        res.append(res_center)
    else:
        assert False, sizeof(res_center)  # this shouldn't happen considering the above checks?

    if safe_ge_zero(sizeof(res_right)) is True:
        if sizeof(res_right) != 0:
            res.append(res_right)
    elif safe_ge_zero(sizeof(res_right)) is None:
        return exp

    assert None not in res

    return ('data', ) + tuple(res)


@cached
def range_overlaps(range1, range2):
    assert range1 ~ ('range', :r1_begin, :r1_len)
    assert range2 ~ ('range', :r2_begin, :r2_len)

    r1_end = add_op(r1_begin, r1_len)
    r2_end = add_op(r2_begin, r2_len)

    try:
        if lt_op(r2_begin, r1_begin):
            r1_begin, r1_end, r2_begin, r2_end = r2_begin, r2_end, r1_begin, r1_end

        # r1 begins before r2 for sure now
        if le_op(r1_end, r2_begin) is True:
            return False
        else:
            return True

    except CannotCompare:
        return None


@cached
def range_contains(outer, inner):
    # checks if outer range *fully* contains inner range
    assert outer ~ ('range', :outer_begin, :outer_len)
    assert inner ~ ('range', :inner_begin, :inner_len)

    outer_end = add_op(outer_begin, outer_len)
    inner_end = add_op(inner_begin, inner_len)

    try:
        if not le_op(outer_begin, inner_begin):
            return False

        if not le_op(inner_end, outer_end):
            return False

        return True

    except CannotCompare:
        return None


assert range_overlaps(('range', ('add', 256, ('mask_shl', 246, 5, 0, ('ext_call.return_data', 128, 32))), 32), ('range', 160, 96)) == False

assert range_overlaps(('range', 260, 32), ('range', 292, 32)) == False
assert range_overlaps(('range', 324, 32), ('range', 292, 32)) == False
assert range_overlaps(('range', 292, 32), ('range', 300, 32)) == True
assert range_overlaps(('range', 300, 32), ('range', 292, 32)) == True


assert range_contains(('range', 64,10), ('range', 64, 32)) == False
assert range_contains(('range', 64, 32), ('range', 64, 10)) == True
assert range_contains(('range', 64, 32), ('range', 64, 32)) == True
assert range_contains(('range', 64, 32), ('range', ('var', 1), 32)) == None
assert range_contains(('range', 10, 32), ('range', 100, 'x')) == False

