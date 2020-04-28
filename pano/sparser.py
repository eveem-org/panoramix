# coding: tilde

from pano.prettify import pprint_trace, pretty_stor
from pano.matcher import match, Any

from utils.helpers import opcode, find_f, replace, replace_f, tuplify, replace_lines, get_op, hashable,  to_exp2

from core.algebra import minus_op, safe_le_op, divisible_bytes, to_bytes

from core.masks import mask_to_type

from utils.helpers import COLOR_GREEN, COLOR_GRAY, ENDC

import logging

logger = logging.getLogger(__name__)


'''
    helpers

'''

def get_loc(exp):
    def f(exp):
        if type(exp) != tuple:
            return None

        elif opcode(exp) in ('storage', 'stor'):
#        elif exp ~ ('storage', ...): # if we have a storage reference within the storage
                                     # don't follow this one when looking for loc
            return None

        elif m := match(exp, ('loc', ':num')):
            return m.num

        elif m := match(exp, ('name', Any, ':num')):
            return m.num

        else:
            for e in exp:
                if (loc:=f(e)) is not None:
                    return loc

            return None

    if m := match(exp, ('type', Any, ('field', Any, ':m_idx'))):
        exp = m.m_idx

    if m := match(exp, ('storage', Any, Any, ':e')):
        exp = m.e

    if m := match(exp, ('stor', Any, Any, ':e')):
        exp = m.e

    if m := match(exp, ('stor', ':e')):
        exp = m.e

    return f(exp)


def get_name_full(exp):
    def f(exp):
        if type(exp) != tuple:
            return None

        elif opcode(exp) in ('stor', 'storage'):#exp ~ ('storage', ...): # if we have a storage reference within the storage
                                     # don't follow this one when looking for loc
            return None

        elif exp ~ ('name', :name, _):
            return exp

        else:
            for e in exp:
                if (loc:=f(e)) is not None:
                    return loc

            return None

    if exp ~ ('type', _, ('field', _, :m_idx)):
        exp = m_idx

    if exp ~ ('storage', _, _, :e):
        exp = e

    if exp ~ ('stor', _, _, :e):
        exp = e

    if exp ~ ('stor', :e):
        exp = e

    return f(exp)

def get_name(exp):
    r = get_name_full(exp)
    if r is None:
        return None
    else:
        return match(r, ('name', ':name', Any)).name


def find_stores(exp):

    if exp ~ ('store', :size, :off, :idx, :val):
        res = {('storage', size, off, idx)}

    elif exp ~ ('storage', _, _, _):
        res = {exp}

    else:
        res = set()

    if type(exp) == tuple or type(exp) == list:
        for e in exp:
            res = res.union(find_stores(e))

    return res


'''
    proper

'''

def rewrite_functions(functions):
    '''
        rewrites functions, putting storage names there,
        then detects storage types and returns a list of those in a form of
        ('def', name, loc, type)
        that can be displayed by pretty_type from prettify

    '''

    storages = list(find_stores([f.trace for f in functions]))

    # (storage 256 0 (sha3 (cd 4) 7)
    # -> (storage 256 0 (array (cd 4) (loc 7)))

    # (storage 256 0 6)
    # (storage 256 0 (loc 6))
    # (storage 256 0 (length (loc 6))
    # (storage 256 0 (array idx (loc 6))
    # (storage 256 0 (map idx (loc 6))


    storages_assoc = _sparser(storages)

    names = find_storage_names(functions)
    replace_names_in_assoc(names, storages_assoc)
    replace_names_in_assoc_bool(names, storages_assoc)


    for func in functions:
        func.trace = repl_stor(func.trace, storages_assoc)

    stordefs = {}

    for src, dest in storages_assoc.items():
        d = dest
        loc = get_loc(d)
        if loc is None: loc = 99

        assert loc is not None, d
        if loc not in stordefs:
            stordefs[loc] = set()

        if type(loc) != int:
            continue

        stordefs[loc].add(d)

    def get_type(stordefs):
        sizes = set()
        offsets = set()
        for s in stordefs:
            if s ~ ('stor', :size, :off, (:op, :idx, ...)) and op in ('map', 'array'):
                sizes.add(size)
                if safe_le_op(0, off) is True:
                    offsets.add(off)

        if 256 in sizes:
            sizes.remove(256)

        if 0 in offsets:
            offsets.remove(0)

        if len(offsets) > 0:
            # for structs, find their size by looking at how the index is multiplied

            for s in stordefs:
                if s ~ ('stor', _, _, (:op, :idx, ...)) and op in ('map', 'array'):
                    if idx ~ ('stor', _, int:siz, ('length', ...)) and siz < 0:
                        return ('struct', -siz + 1)

            return 'struct'

        if len(sizes) == 0:
            return 256
        else:
            return min(sizes)

    defs = []

    def sort(it):
        try:
            return sorted(it)
        except Exception:
            return sorted(it, key=str)

    for loc in sort(stordefs.keys()):
            for l in sort(stordefs[loc]):
                if match(l, ('stor', int, int, ('loc', Any))) or match(l, ('stor', int, int, ('name', ...))):
                    continue

                name = get_name(l)
                if name is None:
                    name = 'stor' + str(loc)

                if m := match(l, ('stor', int, int, ':idx')):
                    idx = m.idx
                    if opcode(idx) == 'map':
                        defs.append(('def', name, loc, ('mapping', get_type(stordefs[loc]))))
                    elif opcode(idx) in ('array', 'length'):
                        defs.append(('def', name, loc, ('array', get_type(stordefs[loc]))))

                break

            # This is executed if we didn't add any defs in the loop above.
            else:
                # all stor references are not arrays/maps, let's just print them out
                for l in sort(stordefs[loc]):
                    name = get_name(l)

                    if name is None:
                        if type(loc) == int and loc >= 1000:
                            name = 'stor' + hex(loc)[2:6].upper()
                        else:
                            name = 'stor' + str(loc)

                    defs.append(('def', name, loc, ('mask', l[1], l[2])))


    return defs


def to_stordef(exp):
    return exp
    if opcode(exp) in ('mask_shl', 'cd', 'storage', 'var'):
        return 'idx'

    if type(exp) == tuple:
        return tuple(to_stordef(e) for e in exp)
    else:
        return exp


'''

'''

def repl_stor(exp, assoc):
    if type(exp) == list:
        return [repl_stor(e, assoc) for e in exp]

    if opcode(exp) == "store":
        _, size, off, idx, val = exp
        dest = assoc[('storage', size, off, idx)]
        return ('store', ) + dest[1:] + (repl_stor(val, assoc), )

    elif hashable(exp) and exp in assoc:
        return assoc[exp]

    elif type(exp) == tuple:
        return tuple([repl_stor(e, assoc) for e in exp])

    else:
        return exp


used_locs = set()

def replace_names_in_assoc_bool(names, storages_assoc):
    # we are replacing bools only after the other storage
    # because in some situations there are functions like
    # areTokensAvailable == bool(tokens.length)
    # and, if possible we don't want to use this getter's name for such purpose
    #
    # there are better/more precise ways to handle this though
    for getter, name in names.items():
        if not (getter ~ ('bool', ('storage', :size, :off, int:loc))):
            continue

        if ('array', loc) in used_locs:
            pass
        elif ('stor', size, off, loc) in used_locs:
            pass
        else:
            for src, pattern in storages_assoc.items():
#                print(pattern)
                if pattern == ('stor', size, off, ('loc', loc)):
                    storages_assoc[src] = ('stor', size, off, ('name', name, loc))


def replace_names_in_assoc(names, storages_assoc):
    for pattern, name in names.items():

        if opcode(pattern) == 'bool':
            continue

        if opcode(pattern) == 'struct':
            stor_id = pattern
        else:
            stor_id = storages_assoc[pattern]

        if stor_id ~ ('stor', :size, :off, ('loc', :num)):
            # if we found a simple getter for a storage number,
            # we need to check first if a given location is only accessed
            # this way. otherwise it may be a function like getLength, that
            # returns the array length, and we don't want to use it as a storage name
            if all(match(pattern, ('stor', Any, Any, ('loc', Any))) \
                   for pattern in storages_assoc if get_loc(pattern) == num):

                used_locs.add(stor_id)

                for src, pattern in storages_assoc.items():
                    if pattern == stor_id:
                        storages_assoc[src] = ('stor', size, off, ('name', name, num))

        elif stor_id ~ ('stor', _, _, ('map', _, :loc)) or \
             stor_id ~ ('stor', _, _, ('array', _, :loc)) or \
             stor_id ~ ('struct', :loc):

            # for arrays, we don't want 'address' at the end of the name. looks better
            new_name = name.split('Address')[0]
            if len(new_name) > 0:
                name = new_name

            loc_id = get_loc(loc)
            used_locs.add(('array', loc_id))

            for src, pattern in storages_assoc.items():
                if get_loc(pattern) == loc_id:
                    pattern = replace(pattern, ('loc', loc_id), ('name', name, loc_id))
                    storages_assoc[src] = pattern

        else:
            logger.warning('storage pattern not found')


'''
    find storage names based on function name
'''

def find_storage_names(functions):

    res = {}

    for func in functions:
        trace = func.trace

        if func.getter:
            getter = func.getter

            assert opcode(getter) in ('storage', 'struct', 'bool')

            # func name into potential storage name

            new_name = func.name

            if new_name[:3] == 'get' and len(new_name.split('(')[0])>3:
                new_name = new_name[3:]

            if new_name != new_name.upper():
                # otherwise we get stuff like bILLIONS in 0xF0160428a8552AC9bB7E050D90eEADE4DDD52843
                new_name = new_name[0].lower() + new_name[1:]

            new_name = new_name.split('(')[0]

            if match(getter, ('storage', 160, ...)):
                if ('address' not in new_name.lower()) and \
                   ('addr' not in new_name.lower()) and \
                   ('account' not in new_name.lower()) and \
                   ('owner' not in new_name.lower()):
                        new_name += 'Address'

            res[getter] = new_name

    return res

'''
    sparser proper
'''



def mask_to_mul(exp):
    if exp ~ ('mask_shl', int:size, int:offset, int:shl, :val):
        if shl > 0 and offset == 0 and size == 256 - shl:
            if shl <= 8:
                return ('mul', 2**shl, val)

        if shl < 0 and offset == -shl and size == 256 - offset:
            if shl >= -8:
                return ('div', 2**shl, val)

    return exp

def stor_replace_f(storages, f):
    def internal_f(exp, f):
        if exp ~ ('storage', ...):
            return exp

        if type(exp) == tuple:
            exp = tuple(internal_f(e, f) for e in exp)

        return f(exp)


    res = []
    for stor in storages:
        assert stor ~ ('stor', :size, :off, :idx)

        res.append(('stor', size, off, internal_f(idx, f)))

    return res

def _sparser(orig_storages):

    storages = []
    for idx, s in enumerate(orig_storages):
        storages.append(('stor', )+s[1:])

    def simplify_sha3(e):
        e = rainbow_sha3(e)

        if e ~ ('sha3', ('data', *terms)):
            e = ('sha3', ) + terms
        if e ~ ('sha3', int:loc):
            return ('loc', e[1])
        elif e ~ ('sha3', ('sha3', *terms), int:loc):
            return ('map', ('data', *terms), ('loc', loc))
        elif e ~ ('sha3', :idx, int:loc):
            return ('map', idx, ('loc', loc))
        else:
            return e

    storages = stor_replace_f(storages, simplify_sha3)

    '''
        is add a struct or a loc?
    '''

    res = []
    for s in storages:
        if s ~ ('stor', :size, ('mask_shl', :o_size, :o_off, :o_shl, :arr_idx), :idx) and size == 2**o_shl:
            new_osize = minus_op(o_size)
            if idx ~ ('add', int:num, _):
                idx = num
            s = ('stor', size, 0, ('array', ('mask_shl', o_size+o_shl, o_off, 0, arr_idx), ('loc', idx)))

        res.append(s)

    storages = res

    storages = stor_replace_f(storages, mask_to_mul)

    res = []
    for s in storages:
        assert s ~ ('stor', :size, :offset, :idx)

        if idx ~ ('add', int:num, *terms) and get_loc(terms) is not None:
            offset += 256 * num
            idx = ('add', ) + terms

        res.append(('stor', size, offset, idx))

    storages = res

    '''

        array is when you add to a loc

    '''

    def add_to_arr(exp):
        if exp ~ ('add', :left, :right):
            if opcode(left) == 'loc':
                right, left = left, right

            if opcode(right) == 'loc':
                return ('array', left, right)

        return exp

    storages = replace_f(storages, add_to_arr)

    '''

        (s 256 0 (add 3 (mul 0.125 idx)))

    '''

    res = []
    for s in storages:
        assert s ~ ('stor', :size, :offset, :idx)

        idx ~ ('add', :idx)

        if idx ~ ('add', ...) and get_loc(idx) is None:
            if idx ~ ('add', int:loc, :pos):
                s = ('stor', size, offset, ('array', pos, ('loc', loc)))
            else:
                logger.warning(f'Weird storage index, {idx}')

        res.append(s)

    storages = res

    '''

        convert regular storages into lengths or locs

        that is - find all the idxs that (stor _ _ idx) exists
                  but are also referenced through (stor _ _ (sth... (loc idx)))

    '''

    assert len(storages) == len(orig_storages)


    res = []
    for s in storages:
        assert s ~ ('stor', :size, :offset, :idx)

        if type(idx) == int:

            if str(('loc', idx)) in str(storages):
                assert type(idx) == int, idx
                idx = ('length', ('loc', idx))

            else:
                idx = ('loc', idx)

        res.append(('stor', size, offset, idx))
    storages = res

    '''
        cleanup of nested maps

    '''
    res = []
    for s in storages:

        if s ~ ('stor', :size, :off, ('range', ('array', :beg, :loc), :end)):
            s = ('stor', size, off, ('array', ('range', beg, end), loc))

        res.append(s)

    storages = res


    def double_map(exp):
        exp ~ ('add', :exp) # remove 'add' with just one term. should be somewhere else
        if exp ~ ('sha3', ('map', *terms)):
            return ('map', *terms) # this is sth weird, see 0xf97187f566eC6374cB08470CCe593fF0Dd36d8A9, transferFrom
        if exp ~ ('sha3', :idx, ('map', *terms)):
            return ('map', idx, ('map', *terms))

        if exp ~ ('add', :idx, ('map', *terms)):
            return ('array', idx, ('map', *terms))
        if exp ~ ('sha3', :idx, :loc):
            return ('map', idx, loc)


        # this all should be recursive
        if exp ~ ('add', ('sha3', ('array', *terms)), :num):
            return ('array', num, ('array', )+terms)
        if exp ~ ('add', :num, ('sha3', ('array', *terms))):
            return ('array', num, ('array', )+terms)

        if exp ~ ('sha3', ('array', :idx, :loc)):
            return ('array', idx, loc)


        if exp ~ ('add', ('map', *terms), :num):
            return ('array', num, ('map', )+terms)
        if exp ~ ('add', :num, ('map', *terms)):
            return ('array', num, ('map', )+terms)

        if exp ~ ('add', ('var', :x), ('array', :idx, :loc)):
            return ('array', ('add', idx, ('var', x)), loc)

        if exp ~ ('add', ('array', :idx, :loc), ('var', :x)):
            return ('array', ('add', idx, ('var', x)), loc)


        return exp

    storages = replace_f(storages, double_map)

    assert len(storages) == len(orig_storages)

    '''

        let's make a dict with output...

    '''

    res = {}
    for idx, s in enumerate(orig_storages):
        dst = storages[idx]
        res[s] = dst

    '''

        and replace storage definitions in it recursively

    '''

    def repl_res(exp):
        if type(exp) != tuple:
            return exp

        if exp in res:
            exp = res[exp]

        return tuple([repl_res(e) for e in exp])

    new_res = {}
    for src, dest in res.items():
        new_res[src] = repl_res(dest)
        assert 'storage' not in str(new_res[src])

    res = new_res

    return res


'''
    data
'''

# to generate additional
# Web3.sha3(b'\x00'*31+b'\x01') == ('loc', 1)
'''
>>> for i in range(20):
...     h = Web3.sha3(b'\x00'*31 + bytes([i])).hex()
...     print(f"'{h}': ('loc':{i}),")
... '''


def rainbow_sha3(exp):
    if type(exp) == int and len(hex(exp)) > 40:
        for src, dest in sha3_loc_table.items():
            if hex(exp) in src:
                # sometimes the last bytes of exp are cut off (e.g. in ED), that's why
                # we're not doing exact matches. should check why they are cut off though
                # perhaps there's some problem with mask processing in whiles
                return dest

    return exp

sha3_loc_table = {
#0x7050c9e0f4ca769c69bd3a8ef740bc37934f8e2c036e5a723fd8ee048ed3f8c3 == ('sha3', 'org.zeppelinos.proxy.implementation')
    # source: https://github.com/zeppelinos/labs/blob/master/initializer_with_sol_editing/contracts/UpgradeabilityProxy.sol
    # ^ not replacing, because rest of the system doesn't handle arbitrary string locations
    '0x290decd9548b62a8d60345a988386fc84ba6bc95484008f6362f93160ef3e563': ('loc', 0),
    '0xb10e2d527612073b26eecdfd717e6a320cf44b4afac2b0732d9fcbe2b7fa0cf6': ('loc', 1),
    '0x405787fa12a823e0f2b7631cc41b3ba8828b3321ca811111fa75cd3aa3bb5ace': ('loc', 2),
    '0xc2575a0e9e593c00f959f8c92f12db2869c3395a3b0502d05e2516446f71f85b': ('loc', 3),
    '0x8a35acfbc15ff81a39ae7d344fd709f28e8600b4aa8c65c6b64bfe7fe36bd19b': ('loc', 4),
    '0x036b6384b5eca791c62761152d0c79bb0604c104a5fb6f4eb0703f3154bb3db0': ('loc', 5),
    '0xf652222313e28459528d920b65115c16c04f3efc82aaedc97be59f3f377c0d3f': ('loc', 6),
    '0xa66cc928b5edb82af9bd49922954155ab7b0942694bea4ce44661d9a8736c688': ('loc', 7),
    '0xf3f7a9fe364faab93b216da50a3214154f22a0a2b415b23a84c8169e8b636ee3': ('loc', 8),
    '0x6e1540171b6c0c960b71a7020d9f60077f6af931a8bbf590da0223dacf75c7af': ('loc', 9),
    '0xc65a7bb8d6351c1cf70c95a316cc6a92839c986682d98bc35f958f4883f9d2a8': ('loc', 10),
    '0x0175b7a638427703f0dbe7bb9bbf987a2551717b34e79f33b5b1008d1fa01db9': ('loc', 11),
    '0xdf6966c971051c3d54ec59162606531493a51404a002842f56009d7e5cf4a8c7': ('loc', 12),
    '0xd7b6990105719101dabeb77144f2a3385c8033acd3af97e9423a695e81ad1eb5': ('loc', 13),
    '0xbb7b4a454dc3493923482f07822329ed19e8244eff582cc204f8554c3620c3fd': ('loc', 14),
    '0x8d1108e10bcb7c27dddfc02ed9d693a074039d026cf4ea4240b40f7d581ac802': ('loc', 15),
    '0x1b6847dc741a1b0cd08d278845f9d819d87b734759afb55fe2de5cb82a9ae672': ('loc', 16),
    '0x31ecc21a745e3968a04e9570e4425bc18fa8019c68028196b546d1669c200c68': ('loc', 17),
    '0xbb8a6a4669ba250d26cd7a459eca9d215f8307e33aebe50379bc5a3617ec3444': ('loc', 18),
    '0x66de8ffda797e3de9c05e8fc57b3bf0ec28a930d40b0d285d93c06501cf6a090': ('loc', 19),
    '0xad3228b676f7d3cd4284a5443f17f1962b36e491b30a40b2405849e597ba5fb5' : ('map', 0, ('loc', 0)),
    '0xa6eef7e35abe7026729641147f7915573c7e97b47efa546f5f6e3230263bcb49' : ('map', 0, ('loc', 1)),
    '0xac33ff75c19e70fe83507db0d683fd3465c996598dc972688b7ace676c89077b' : ('map', 0, ('loc', 2)),
    '0x3617319a054d772f909f7c479a2cebe5066e836a939412e32403c99029b92eff' : ('map', 0, ('loc', 3)),
    '0x17ef568e3e12ab5b9c7254a8d58478811de00f9e6eb34345acd53bf8fd09d3ec' : ('map', 0, ('loc', 4)),
    '0x05b8ccbb9d4d8fb16ea74ce3c29a41f1b461fbdaff4714a0d9a8eb05499746bc' : ('map', 0, ('loc', 5)),
    '0x54cdd369e4e8a8515e52ca72ec816c2101831ad1f18bf44102ed171459c9b4f8' : ('map', 0, ('loc', 6)),
    '0x6d5257204ebe7d88fd91ae87941cb2dd9d8062b64ae5a2bd2d28ec40b9fbf6df' : ('map', 0, ('loc', 7)),
    '0x5eff886ea0ce6ca488a3d6e336d6c0f75f46d19b42c06ce5ee98e42c96d256c7' : ('map', 0, ('loc', 8)),
    '0xec8156718a8372b1db44bb411437d0870f3e3790d4a08526d024ce1b0b668f6b' : ('map', 0, ('loc', 9)),
    '0x13da86008ba1c6922daee3e07db95305ef49ebced9f5467a0b8613fcc6b343e3' : ('map', 0, ('loc', 10)),
    '0xdf7de25b7f1fd6d0b5205f0e18f1f35bd7b8d84cce336588d184533ce43a6f76' : ('map', 0, ('loc', 11)),
    '0x13649b2456f1b42fef0f0040b3aaeabcd21a76a0f3f5defd4f583839455116e8' : ('map', 0, ('loc', 12)),
    '0x81955a0a11e65eac625c29e8882660bae4e165a75d72780094acae8ece9a29ee' : ('map', 0, ('loc', 13)),
    '0xe710864318d4a32f37d6ce54cb3fadbef648dd12d8dbdf53973564d56b7f881c' : ('map', 0, ('loc', 14)),
    '0xf4803e074bd026baaf6ed2e288c9515f68c72fb7216eebdd7cae1718a53ec375' : ('map', 0, ('loc', 15)),
    '0x6e0956cda88cad152e89927e53611735b61a5c762d1428573c6931b0a5efcb01' : ('map', 0, ('loc', 16)),
    '0x4ad3b33220dddc71b994a52d72c06b10862965f7d926534c05c00fb7e819e7b7' : ('map', 0, ('loc', 17)),
    '0x7e7fa33969761a458e04f477e039a608702b4f924981d6653935a8319a08ad7b' : ('map', 0, ('loc', 18)),
    '0x8fa6efc3be94b5b348b21fea823fe8d100408cee9b7f90524494500445d8ff6c' : ('map', 0, ('loc', 19)),
    '0xada5013122d395ba3c54772283fb069b10426056ef8ca54750cb9bb552a59e7d' : ('map', 1, ('loc', 0)),
    '0xcc69885fda6bcc1a4ace058b4a62bf5e179ea78fd58a1ccd71c22cc9b688792f' : ('map', 1, ('loc', 1)),
    '0xe90b7bceb6e7df5418fb78d8ee546e97c83a08bbccc01a0644d599ccd2a7c2e0' : ('map', 1, ('loc', 2)),
    '0xa15bc60c955c405d20d9149c709e2460f1c2d9a497496a7f46004d1772c3054c' : ('map', 1, ('loc', 3)),
    '0xabd6e7cb50984ff9c2f3e18a2660c3353dadf4e3291deeb275dae2cd1e44fe05' : ('map', 1, ('loc', 4)),
    '0x1471eb6eb2c5e789fc3de43f8ce62938c7d1836ec861730447e2ada8fd81017b' : ('map', 1, ('loc', 5)),
    '0x3e5fec24aa4dc4e5aee2e025e51e1392c72a2500577559fae9665c6d52bd6a31' : ('map', 1, ('loc', 6)),
    '0xb39221ace053465ec3453ce2b36430bd138b997ecea25c1043da0c366812b828' : ('map', 1, ('loc', 7)),
    '0xad67d757c34507f157cacfa2e3153e9f260a2244f30428821be7be64587ac55f' : ('map', 1, ('loc', 8)),
    '0x92e85d02570a8092d09a6e3a57665bc3815a2699a4074001bf1ccabf660f5a36' : ('map', 1, ('loc', 9)),
    '0xbbc70db1b6c7afd11e79c0fb0051300458f1a3acb8ee9789d9b6b26c61ad9bc7' : ('map', 1, ('loc', 10)),
    '0x72c6bfb7988af3a1efa6568f02a999bc52252641c659d85961ca3d372b57d5cf' : ('map', 1, ('loc', 11)),
    '0xd421a5181c571bba3f01190c922c3b2a896fc1d84e86c9f17ac10e67ebef8b5c' : ('map', 1, ('loc', 12)),
    '0xfd54ff1ed53f34a900b24c5ba64f85761163b5d82d98a47b9bd80e45466993c5' : ('map', 1, ('loc', 13)),
    '0xa7c5ba7114a813b50159add3a36832908dc83db71d0b9a24c2ad0f83be958207' : ('map', 1, ('loc', 14)),
    '0x169f97de0d9a84d840042b17d3c6b9638b3d6fd9024c9eb0c7a306a17b49f88f' : ('map', 1, ('loc', 15)),
    '0x8c6065603763fec3f5742441d3833f3f43b982453612d76adb39a885e3006b5f' : ('map', 1, ('loc', 16)),
    '0x17bc176d2408558f6e4111feebc3cab4e16b63e967be91cde721f4c8a488b552' : ('map', 1, ('loc', 17)),
    '0x71a67924699a20698523213e55fe499d539379d7769cd5567e2c45d583f815a3' : ('map', 1, ('loc', 18)),
    '0x4155c2f711f2cdd34f8262ab8fb9b7020a700fe7b6948222152f7670d1fdf34d' : ('map', 1, ('loc', 19)),
}
