# coding: tilde

#
#  Algebra handles symbolic operations and comparisons
#
#  E.g. if you want to figure out if ('ADD', 2, 'x') is bigger than 'x'.,
#       you call lt_op(add_op(2,'x'), 'x')
#   
#  The code here is crazy-fragile and inconsistent.
#  Modifying it is akin to playing kal-toh ( https://www.youtube.com/watch?v=8i2idMe142s )
#  
#  Should be refactored together with arithmetic.py
#  I considered replacing it with a generic SMT-solver, but I'm quite sure a generic
#  solution would be way slower.
#
#  A better option would be to use a system similar to ACL2.
#


from utils.helpers import opcode, EasyCopy, all_concrete, to_exp2, cached

from .variants import variants

class CannotCompare(Exception):
    pass


# copied from other modules, need to rework module structures
# to avoid circular dependencies
def mask_to_int(size, offset):
    if offset < 0:
        size = size + offset
        if size < 1:
            return 0
        return (2**size-1)

    return (2**size-1)*(2**offset)


@cached
def simplify(exp):

    if exp ~ ('max', *terms):
        els = [simplify(e) for e in terms]
        res = -2**256
        for e in els:
            try:
                res = max_op(res, e)
            except:
                return ('max', ) + tuple(els)
        return res

    if exp ~ ('mask_shl', :size, :offset, :shl, :val):
        size, offset, shl, val = simplify(size), simplify(offset), simplify(shl), simplify(val)

        if all_concrete(size, offset, shl, val):
            return apply_mask(val, size, offset, shl)

        if (size, offset, shl) == (256, 0, 0):
            return val

    if exp ~ ('add', *terms):

        res = 0
        for e in terms:
            res = add_op(res, simplify(e))

        assert type(res) != list

        return res

    if exp ~ ('mul', *terms):
        res = 1
        for e in exp[1:]:
            res = mul_op(res, simplify(e))
        assert type(res) != list

        return res

    return exp


def calc_max(exp):
    if type(exp) != tuple:
        return exp

    exp = (opcode(exp), ) + tuple(calc_max(e) for e in exp[1:])

    if exp ~ ('max', *terms):
        m = -(2**256)

        for e in terms:
            if type(e) != int:
                break
            m = max(m, e)
        else:
            return m

    return exp

@cached
def add_ge_zero(exp):
    '''
        technically, it can return wrong results, e.g.:

        (sub (mask 4, 4, -4, 'sth') (mask 4, 0, 'sth'))
        for sth 11...111 == 0
        for sth 0 == 0
        for sth 00010011 < 0

        in practice it (hopefully) doesn't happen -- need to fix "variants"
        to deliver more variants based on masks and other expressions?

    '''

    assert opcode(exp) == 'add', exp
    assert len(exp) > 2, exp

    exp = simplify(exp)
    if type(exp) == int:
        return exp >= 0

#    print(exp)
    var = tuple(simplify(calc_max(e)) for e in variants(exp))

    if not all_concrete(*var):
        return None

    if all(v >= 0 for v in var):
        return True

    if all(v < 0 for v in var):
        return False

    return None


def minus_op(exp):

    return mul_op(-1, exp)


def sub_op(left, right):

    if (type(left), type(right)) == (int, int):
        return left-right # optimisation

    if left == 0:
        return minus_op(right)

    if right == 0:
        return left

    return add_op(left, minus_op(right))

exp = ('add', )
assert exp ~ ('add', ...)
assert exp ~ ('add', *terms)

def flatten_adds(exp):
    res = exp

    while len([a for a in res if opcode(a) == 'add']) > 0:
        exp = []
        for r in res:
            if r ~ ('add', *terms):
                assert len(r[1:]) > 1
                exp += r[1:]
            else:
                exp.append(r)

        res = exp

    return res


def max_to_add(exp):
    if opcode(exp) != 'max':
        return exp

    exp = exp[1:]

    for e in exp:
        if opcode(e) != 'add' and type(e) != int:
            return simplify_max(('max', )+exp)

    for e in exp:
        if type(e) == int:
            m = min(x if type(x) == int else (x[1] if type(x) == tuple and len(x)>1 and type(x[1]) == int else 0) for x in exp)
                                                # used to be x[1] but 0x0000136DAE58AFCF1EDd2071973d4a7a6fbe98A5 didn't work
            res = ('max', e - m)
            for e2 in exp:
                if e2 != e:
                    res += (sub_op(e2, m), )

            return ('add', m, res)

    m = 10**20
    for e in exp:
        if type(e[1]) != int:
            m = 0
            break
        else:
            m = min(m, e[1])

    common = []
    first = exp[0]
    for f in first:
        if all(f in e[1:] for e in exp[1:]):
            common.append(f)


    if len(common) > 0:
        a = add_op(m, *common)
    else:
        a = m

    res = []
    for e in exp:
        res.append(sub_op(e, a))

    if type(a) == int:
        prefix = (a, )
    else:
        prefix = a[1:]

    return ('add', ) + prefix + (simplify_max(('max', ) + tuple(res)), )




@cached
def add_op(*args):
    if len(args) == 1:
        return args[0]
    elif len(args) == 0:
        return 0

    assert len(args) > 1
    assert 'mul' not in args # some old bug, it's ok for ['mul'..] to be in args, but not 'mul' directly

    # speed optimisation
    real = 0
    for r in args:
        if type(r) in (int, float):
            real += r
        else:
            break
    else:
        return real
    # / speed

    res = flatten_adds(list(args))

    for idx, r in enumerate(res):
        if opcode(r) != 'mul':
            res[idx] = mul_op(1, r)

    real = 0
    symbolic = []

    for r in res:
        assert opcode(r) != 'add'

        if type(r) in [int,float]:
            real += r
            continue

        assert opcode(r) == 'mul'

        # look at all the previously found symbolic expressions
        # perhaps you can add to the previous one - if so, do it
        # else, add this as a new symbolic exp
        for idx, rr in enumerate(symbolic):

            tried = try_add(r, rr) or try_add(rr, r)

            if tried is not None and tried != 0:

                if tried ~ ('mul', ...):
                    symbolic[idx] = tried

                elif tried ~ ('mask_shl', int:size, 0, 256-size, :val):
                    symbolic[idx] = ('mul', 2**(256-size), val)

                else:
                    assert tried ~ ('add', int:num, :term), tried

                    symbolic[idx] = term
                    real += num

                break

        else:
            symbolic.append(r)

    symbolic = tuple(s for s in symbolic if s[1] != 0)

    # rem mul_1
    symbolic = tuple(s[2] if opcode(s)=='mul' and len(s) == 3 and s[1]==1 else s for s in symbolic)

    if real == 0:
        res = symbolic
    else:
        if real > 0:
            real = real % (2**256)
        res = (real, ) + symbolic

    if len(res) == 0:
        return 0

    if len(res) == 1:
        return res[0]


    return ('add', ) + res


def bits(exp):
    return mul_op(exp, 8)

def mul_op(*args):
    # super common
    if len(args) == 1:
        return args[0]

    if args ~ (int:num1, int:num2):
        return args[0] * args[1]

    for a in args:
        assert type(a) != list

        if p := to_exp2(a):

            rest = list(args)
            rest.remove(a)

            exp = mul_op(*rest)

            assert type(exp) != list, exp
            return mask_op(exp, size=256-p, shl=p)

    # flatten muls
    res = tuple()
    for a in args:
        assert type(a) != list
        if a ~ ('mul', *terms):
            res += terms
        else:
            res += (a, )

    # convert (mul (add x y) z) into (add (mul x z) (mul y z))
    # bc we're trying to keep a flat ordered hierarchy

    add_list = tuple(a for a in res if opcode(a) == 'add')
    if len(add_list) > 0:
        el = add_list[0]
        assert opcode(el) == 'add'

        without = list(res)
        without.remove(el)

        ret = tuple(mul_op(x, *without) for x in el[1:])
        return add_op(*ret)

    # multiply real numbers, add symbolic ones to output
    real = 1
    symbolic = tuple()
    for r in res:
        assert opcode(r) != 'add'

        if r == 0:
            return 0
        elif type(r) in (int, float):
            real = int(real * r) # arithmetic, or regular?
        else:
            symbolic += (r, )

    assert len(symbolic) == 0 or symbolic[0] != 'mul' # some old bug

    if len(symbolic) == 0:
        return real
    else:
        return ('mul', real, ) + symbolic

def get_sign(exp):

    if exp == 0:
        return 0

    elif ge_zero(sub_op(exp,1)) == True:
        return 1

    elif ge_zero(exp) == False:
        return -1

    else:
        return None

def safe_gt_zero(exp):
    return safe_ge_zero(sub_op(exp, 1))

def safe_ge_zero(exp):
    try:
        return ge_zero(exp)
    except CannotCompare:
        return None


def to_bytes(exp):
    if type(exp) == int:
        return (exp+7) // 8, exp % 8

    if type(exp) == tuple and exp[:4] == ('mask_shl', 253, 0, 3):
        return exp[4], 0

    if exp ~ ('mask_shl', int:size, int:offset, int:shl, :val) and shl >= 3:
#    if opcode(exp) == 'mask_shl' and type(exp[1]) == int and type(exp[3]) == int and exp[3]>=3:# == ('mask_shl', 253, 0, 3):
        return ('mask_shl', size, offset, shl - 3, val), 0


    if opcode(exp) == 'mul' and len(exp) == 3:
        if exp[1] % 8 == 0:
            return to_bytes(exp[1])

    if opcode(exp) == 'add':
        res = []
        for e in exp[1:]:
            if type(e) == int or opcode(e) == 'mask_shl':
                by, bi = to_bytes(e)
                if bi == 0:
                    res.append(by)
                else:
                    raise

            elif opcode(e) == 'mul' and len(e) == 3:
                if e[1] % 8 == 0:
                    res.append(('mul', e[1] // 8, e[2]))
                elif opcode(e[2]) == 'mask_shl' and e[2][:4] == ('mask_shl', 253, 0, 3):
                    res.append(('mul', e[1], e[2][4]))
                else:
                    raise

            else:
                raise

        return ('add', ) + tuple(res), 0

    return mask_op(exp, shr=3), 0


def divisible_bytes(exp):
    # returns true if an expression can be divided by 8 (into bytes) without exceptions raised etc
    try:
        return True if to_bytes(exp)[1]==0 else False
    except:
        return False

assert to_bytes(('add', ('mask_shl', 253, 0, 3, ('cd', ('add', 4, ('cd', 36)))), ('mul', -1, ('mask_shl', 253, 0, 3, ('add', 36, ('cd', 36)))))) == (('add', ('cd', ('add', 4, ('cd', 36))), ('mul', -1, ('add', 36, ('cd', 36)))), 0)


ge_zero_cache = {}
def ge_zero(exp):
    if type(exp) == int:
        return exp >= 0

    if exp in ge_zero_cache:
        if ge_zero_cache[exp] is None:
            raise CannotCompare
        return ge_zero_cache[exp]

    ge_zero_cache[exp] = _ge_zero(exp)
    if ge_zero_cache[exp] is None:
        raise CannotCompare
    return ge_zero_cache[exp]

def _ge_zero(exp):
    # returns True if exp>=0, False if exp<=0, CannotCompare if it doesn't know

    if type(exp) in (int, float):
        return exp >= 0

    if type(exp) == str:
        return True

    if opcode(exp) == 'mul':
        counter = 1
        for e in exp[1:]:
            c = ge_zero(e)
            if c == True:
                counter *= 1
            elif c == False:
                counter *= -1

        return counter >= 0

    if opcode(exp) == 'bool':
        return True

    if opcode(exp) == 'mask_shl':
        return ge_zero(exp[4])

    if opcode(exp) in ['cd', 'storage','msize']:
        return True

    if opcode(exp) in ['add', 'or']:
        return add_ge_zero(exp)

    if opcode(exp) in ('var', 'ext_call.return_data'):
        return True

    raise CannotCompare

@cached
def lt_op(left, right): # left < right
    if left ~ ('add', int:num, ('max', *terms)):
        left = ('max', ) + tuple(add_op(t, num) for t in terms)

    if right ~ ('add', int:num, ('max', *terms)):
        right = ('max', ) + tuple(add_op(t, num) for t in terms)

    if type(left) == int and type(right) == int:
        return left < right

    if right ~ ('max', ...):
        left, right = right, left

    if left ~ ('max', ...):
        results = [lt_op(l, right) for l in left[1:]]

        if all([r is True for r in results]):
            return True

        if any([r is False for r in results]):
            return False

        return None

    if left ~ ('add', _, ('var', :num)) and \
       right ~ ('add', _, ('var', :num2)) and \
        num != num2:
            raise CannotCompare

    sleft = str(left)
    sright = str(right)

    if left ~ ('var', :num) and str(left) not in sright:
        raise CannotCompare

    if right ~ ('var', :num) and str(right) not in sleft:
        raise CannotCompare

    if type(right) == int and left ~ ('add', int:num, ('var', _)):
        if right >= num:
            return False
        else:
            raise CannotCompare

    if type(left) == int and right ~ ('add', int:num, ('var', _)):
        if left < num:
            return True
        else:
            raise CannotCompare

    return lt2(left, right)

def lt2(left, right):
    subbed = sub_op(right, left)

    sgn = get_sign(subbed)

    if sgn is None:
        raise CannotCompare
    else:
        return sgn > 0

def safe_lt_op(left, right):

    try:
        return lt_op(left, right)
    except CannotCompare:
        return None

def safe_le_op(left, right):
    try:
        return le_op(left, right)
    except CannotCompare:
        return None

def simplify_max(exp):
    if opcode(exp) != 'max':
        return exp

    if opcode(exp) == 'max':
        res = ('max', )
        for e in exp[1:]:
            if opcode(e) == 'max':
                res += e[1:]
            else:
                res += (e, )

        return res

@cached
def le_op(left, right): # left <= right

#    right = add_op(1, right)
#    return lt_op(left, right)
    
    if opcode(left) == 'max':
        left = max_to_add(left)

    if opcode(right) == 'max':
        right = max_to_add(right)

    if type(left) in (int, float) and type(right) in (int, float):
        return left <= right

    subbed = sub_op(right, left)

    return ge_zero(subbed)


def max_op(left, right):
    try:

        if le_op(left, right):
            return right
        else:
            return left

    except CannotCompare:

        if le_op(right, left):
            return left
        else:
            return right

def safe_max_op(left, right):
    try:
        return max_op(left, right)
    except CannotCompare:
        return None


def _max_op(base, what):
    # compares base with what, different from algebra's max because it can return (max, x,y,z)
    if opcode(base) != 'max':

        if safe_lt_op(what, base) is True:
            return base

        if safe_lt_op(what, base) is False:
            return what

        return ('max', base, what)

    else: # opcode(base) == 'max':
        res = []
        for b in base[1:]:
            cmp = safe_lt_op(what, b)

            if cmp is True:
                return base

            if cmp is False:
                res.append(what)

            if cmp is None:
                res.append(b)

        res.append(what)

        res = tuple(set(res))
        if len(res)>1:
            return ('max',)+res
        else:
            return res[0]

assert _max_op(('max', 128, 'unknown'), 200) == ('max', 200, 'unknown')
assert _max_op(('max', 128, 'unknown'), 64) == ('max', 128, 'unknown')


def div_op(a, b):
    assert type(a) != list
    assert type(b) != list
    if b == 1:
        return a

    if type(a) != int and type(b) == int:
        if b < 0:
            a = mul_op(-1, a)
            b = -b

        if to_exp2(b):
            return mask_op(a, size=256-to_exp2(b), shr=to_exp2(b))


    if type(a) != int or type(b) != int:
#        return None
        return ('div', a, b)

    else:
        return a // b


def safe_min_op(left, right):
    try:
        return min_op(left, right)
    except CannotCompare:
        return None

def min_op(left, right):

    try:
        if le_op(left, right):

            return left
        else:
            return right

    except CannotCompare:
        if le_op(right, left):
            return right
        else:
            return left



def or_op(*args):
    if len(args) == 1:
        return args[0]
#    assert len(args) > 1

    res = tuple()

    for r in args:
        if r == 0:
            pass

        elif r ~ ('or', *terms):
            assert len(terms)>1
            res += terms

        elif r not in res:
            res += (r, )

    if len(res) == 0:
        return 0

    if len(res) == 1:
        return res[0]

    assert len(res)>1

    return ('or', ) + res

def neg_mask_op(exp, size, offset):
    exp1 = mask_op(exp, size = sub_op(256, add_op(size, offset)), offset = add_op(offset,size))
    exp2 = mask_op(exp, size = offset, offset = 0)

    return or_op(exp1, exp2)

def strategy_concrete(size, offset, shl, exp_size, exp_offset, exp_shl, exp):
    '''
        This is an optimised version of strategy_1, the program would
        work correctly without it, but much slower, since concrete values
        for masks are very common
    '''

    outer_left = offset + size
    outer_right = offset

    inner_left = exp_offset + exp_size + exp_shl
    inner_right = exp_offset + exp_shl

    left, right = min(outer_left, inner_left), max(outer_right, inner_right)

    if inner_left <= inner_right:
        return 0
    if inner_left <= outer_right:
        return 0

    new_offset = right - exp_shl
    new_size = left - right
    new_shl = shl + exp_shl

    if new_size > 0:
        return mask_op(exp, size=new_size, offset=new_offset, shl=new_shl)
    else:
        return 0

def strategy_0(size, offset, shl, exp_size, exp_offset, exp_shl, exp):
    return 0 if exp == 0 else None

def strategy_1(size, offset, shl, exp_size, exp_offset, exp_shl, exp):
    # default one

    outer_left = add_op(offset, size)
    outer_right = offset

    inner_left = add_op(exp_offset, exp_size, exp_shl)
    inner_right = add_op(exp_offset, exp_shl)

    left, right = safe_min_op(outer_left, inner_left), safe_max_op(outer_right, inner_right)

    if safe_le_op(inner_left, inner_right) is True:
        return 0
    if safe_le_op(inner_left, outer_right) is True:
        return 0

    if None not in (left, right):
        new_offset = sub_op(right, exp_shl)
        new_size = sub_op(left, right)
        new_shl = add_op(shl, exp_shl)

        gezero = safe_ge_zero(new_size)

        if gezero is not False and new_size != 0:
            return mask_op(exp, size=new_size, offset=new_offset, shl=new_shl)

        elif gezero is False or new_size==0:
            return 0

def strategy_2(size, offset, shl, exp_size, exp_offset, exp_shl, exp):
    # move inner left by size, apply mask, and move back

    return strategy_1(size, sub_op(offset, exp_size),
        add_op(shl, exp_size), exp_size, exp_offset,
        sub_op(exp_shl, exp_size), exp)

def strategy_3(size, offset, shl, exp_size, exp_offset, exp_shl, exp):
    # move inner left by it's shl, apply mask, move back

    return strategy_1(size, sub_op(offset, exp_shl), add_op(shl, exp_shl), exp_size, exp_offset, 0, exp)


def strategy_final(size, offset, shl, exp_size, exp_offset, exp_shl, exp):

    return ('mask_shl', size, offset, shl, ('mask_shl', exp_size, exp_offset, exp_shl, exp))


def mask_mask_op(size, offset, shl, exp_size, exp_offset, exp_shl, exp):
    if all_concrete(offset, shl, exp_offset, exp_shl, exp_size, size):
        return strategy_concrete(size, offset, shl, exp_size, exp_offset, exp_shl, exp)

    strategies = (strategy_0, strategy_1, strategy_2, strategy_3, strategy_final)

    for s in strategies:
        res = s(size, offset, shl, exp_size, exp_offset, exp_shl, exp)
        if res is not None:
            return res

    assert False

mask_dict = {}
def mask_op(exp, size = 256, offset = 0, shl = 0, shr = 0):
    if size == 0:
        return 0

    idx = size, offset, shl, shr, exp
    if idx in mask_dict:
        return mask_dict[idx]

    ret = _mask_op(exp, size, offset, shl, shr)
    mask_dict[idx] = ret
    return ret

def _mask_op(exp, size = 256, offset = 0, shl = 0, shr = 0):
    if size == 0:
        return 0
#    if (size, offset, shl, shr) == (256, 0, 0, 0):
#        return exp

    if exp ~ ('div', :num, 1):
        exp = num # should be done somewhere else, but it's 0:37 at night

    shl = sub_op(shl, shr)
    shr = 0


    if exp ~ ('storage', :stor_size, :stor_offset, :stor_idx):
        # trimming the storage inside

        #if safe_le_op(offset, minus_op(shl)):
        #    offset = minus_op(shl)

        # for shl > 0, we are either dealing with multiplication (e.g. store * 32 - happens often)
        # or with trimming the storage and moving around (store << 96)
        # e.g. 0xfF18DBc487b4c2E3222d115952bABfDa8BA52F5F, setupToken
        # below heuristics handle all this, and deliver good results in practice
        # but may be incorrect in some unusual cases

        if type(shl) == int and (shl > 0 and shl < 8):
            pass

        elif type(shl) == int and shl >= 8 and size == 256 \
           and (new_exp := apply_mask_to_storage(exp, size-shl, offset, shl)):
            return new_exp

        elif new_exp := apply_mask_to_storage(exp, size, offset, shl):
            return new_exp

    if exp ~ ('or', *rest):
        return or_op( *[mask_op(e, size, offset, shl, shr) for e in rest])

    if exp ~ ('mask_shl', *params):
        shl = sub_op(shl, shr)
        double_mask = mask_mask_op(size, offset, shl, *params)

        return double_mask

    if type(size) != int or size > 0:
        return ('mask_shl', size, offset, sub_op(shl,shr), exp)
    else:
        return 0

def apply_mask_to_storage(exp, size, offset, shl):
    assert exp ~ ('storage', :stor_size, :stor_offset, :stor_idx)

#    shr = minus_op(shl)

    stor_offset = add_op(stor_offset, offset)
    stor_size = sub_op(stor_size, offset)
    shl = add_op(shl, offset)
    offset = 0

    if safe_lt_op(size, stor_size):
        stor_size = size

    if safe_le_op(stor_size, 0) is True:
        return 0

    res = ('storage', stor_size, stor_offset, stor_idx)

    shr = 0

    if shl == 0:
        return res
    else:
        if res ~ ('storage', size, 0, :stor_idx) and offset == 0:
            shr = minus_op(shl)
            return ('storage', size, shr, stor_idx)

def apply_mask(val, size, offset=0, shl=0):
    assert all_concrete(val, size, offset, shl)

    mask = mask_to_int(size, offset)
    val = val & mask

    if shl > 0:
        val = val << shl

    if shl < 0:
        val = val >> -shl

    return val


def try_add(self, other):
    if (res := _try_add(self, other)) is not None:
        return res

    return __try_add(self, other)


def __try_add(self, other):
    if self ~ ('mul', :num, ('mask_shl', int:size, int:off, int:shl, :val)) and shl > 0:
        self = ('mul', num + 2**shl, ('mask_shl', size+shl, off, 0, val))

    if other ~ ('mul', :num, ('mask_shl', int:size, int:off, int:shl, :val)) and shl > 0:
        other = ('mul', num + 2**shl, ('mask_shl', size+shl, off, 0, val))

    return _try_add(self, other)

def _try_add(self, other):
    # tries to add (mul a x) (mul b y)
    # 'self' name to be refactored

#   so proud of this /s

    assert self ~ ('mul', int, *terms)
    if len(terms) > 1:
        return None

    assert other ~ ('mul', int, *terms)
    if len(terms) > 1:
        return None


    if self ~ ('mul', -1, :val) and \
       other ~ ('mul', :mul, ('mask_shl', int:other_size, 0, int:shl, val)) and other_size == 256 - shl:
            mul *= 2**shl - 1
            return mul_op(mul, val)

#    if self, other == mul(x, exp), mul(y, exp)
#                   => mul(x+y, exp)

    if self ~ ('mul', int:x, :exp) and \
       other ~ ('mul', int:y, exp):
         return ('mul', x + y, exp)


#    if self, other == mul(x, mask_shl(256-y, y, 0, exp)),
#                      mul(x, mask_shl(y, 0, 0, exp))
#                   => mul(x, (mask_shl, 256, 0, 0, exp))

    if self ~ ('mul', :x, :self_mask) and \
       other ~ ('mul', x, :other_mask):

        if opcode(self_mask) == 'mask_shl' and opcode(other_mask) == 'mask_shl' and\
            self_mask[1]+self_mask[2]==256 and self_mask[2] == other_mask[1] and other_mask[2] == 0 and\
            self_mask[3] == other_mask[3] and self_mask[4] == other_mask[4]:
                return mul_op(self[1], mask_op(self_mask[4], size=256, offset=0, shl=self_mask[3]))


#   if self, other == mul(x, mask_shl(256-y, y, 0, ADD(2**y - 1, mul(1, exp)))),
#                     mul(-x, exp)
#                  => mul(x, 2**y - mask_op(exp, size=y))

    '''
    to be tested:

    if other ~ ('mul', :x, :exp) and \
       self ~ ('mul', -x, ('mask_shl', 256-y, int:y, 0, ('add', 2**y-1, ('mul', 1, exp)))):
           return mul_op(-x, sub_op(2**y, mask_op(x, size=y)))
    '''

    if opcode(self[2]) == 'mask_shl' and opcode(other[2]) != 'mask_shl' and self[1] == minus_op(other[1]):
        x = other[2]
        for y in [3,4,5,6,7,8,16,32,64,128]:
            m = ('mask_shl', 256-y, y, 0, ('add', 2**y-1, ('mul', 1, x) ) )# - x #== 2**y-1 - Mask(y,0,0, x)
            if self[2] == m:
                return mul_op(self[1], sub_op(2**y, mask_op(x, size=y)))



#   if self, other == mul(-x, mask_shl(256-y, y, 0, exp),
#                     mul(x, exp)
#                  => mul(x, mask_op(exp, size=y))

    if opcode(self[2]) == 'mask_shl' and opcode(other[2]) != 'mask_shl' and self[1] == minus_op(other[1]):
        x = other[2]
        for y in [3,4,5,6,7,8,16,32,64,128]:
            m = ('mask_shl', 256-y, y, 0, x)# - x #== 2**y-1 - Mask(y,0,0, x)
            if self[2] == m:
                return mul_op(other[1], mask_op(x, size=y))
            m = ('mask_shl', 251-y, y, 0, x)  # close enough ;)
                                              # happens in memcopy loops, shouldn't cause significant bugs
                                              # and helps clean up the code a lot

            if self[2] == m:
                return mul_op(other[1], mask_op(x, size=y))

    # other

    if self ~ ('mul', :num, ('mask_shl', 256, 0, 0, :exp)):
        self = ('mul', num, exp)

    if other ~ ('mul', :num, ('mask_shl', 256, 0, 0, :exp)):
        other = ('mul', num, exp)

    assert self ~ ('mul', int:num1, :exp1)
    assert other ~ ('mul', int:num2, :exp2)

    if exp1 == exp2:
        return mul_op(num1 + num2, exp1)

    # mask 256,0,0,x - 6,0,0,x == 250,6,0,x

    if num1 == -num2 and exp2 ~ ('mask_shl', int:size, 0, 0, exp1):
        return ('mul', num1, ('mask_shl', 256-size, size, 0, exp1))

    if num1 == -num2 and \
       exp1 ~ ('mask_shl', int:size1, 0, 0, :x) and \
       exp2 ~ ('mask_shl', int:size2, 0, 0, x) and \
       size2 < size1:
            return ('mul', num1, ('mask_shl', size1-size2, 0, 0, x))

    return None

def erase_op(exp, size, shl):
    assert False

assert max_to_add(('max', 480, ('add', 356, ('cd', ('add', 4, ('cd', 36)))))) == ('add', 356, ('max', 124, ('cd', ('add', 4, ('cd', 36)))))
assert add_op(64, ('var', 4)) == ('add', 64, ('var', 4))

l = ('add', 128, ('cd', ('add', 4, ('cd', 36))))
r = ('add', 128, ('mask_shl', 251, 5, 0, ('add', 31, ('cd', ('add', 4, ('cd', 36))))))
assert le_op(l, r) == True, le_op(r, l)

#exit()
