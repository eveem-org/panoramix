from utils.helpers import cached, cleanup_mul_1, opcode, to_exp2

from .algebra import mul_op, sub_op


def type_to_mask(s):
    lookup = {
        "bool": 1,
        "uint8": 8,
        "uint16": 16,
        "uint32": 32,
        "uint64": 64,
        "int8": 8,
        "bytes1": 1,
        "int16": 16,
        "bytes2": 16,
        "int32": 32,
        "bytes4": 32,
        "int64": 64,
        "bytes8": 64,
        "int128": 128,
        "uint128": 128,
        "bytes16": 128,
        "addr": 160,
        "address": 160,
        "uint256": 256,
        "bytes32": 256,
        "int256": 256,
        "int": 256,
        "uint": 256,
    }

    if s in lookup:
        return lookup[s]
    else:
        return None


def mask_to_type(num, force=False):
    # force causes to always return some soft of type,
    # if it's not found in the lookup then the smallest
    # one that fits

    lookup = {
        1: "bool",
        8: "uint8",
        16: "uint16",
        32: "uint32",
        64: "uint64",
        128: "uint128",
        160: "addr",
        256: "uint256",
    }

    if type(num) != int:
        return num

    if num in lookup:
        return lookup[num]

    elif force:
        if num > 256:
            return "big" + str(num)

        for mask, res in lookup.items():
            if mask > num:
                return lookup[mask]

        assert False

    else:
        return None


def get_bit(num, pos):
    return 1 if num & 2 ** pos > 0 else 0


def mask_to_int(size, offset):
    assert type(size) in (int, float), size
    assert type(offset) in (int, float), offset

    return (2 ** size - 1) * (2 ** offset)


def find_mask(num):
    # finds a mask that encompasses the number

    assert type(num) == int

    i = 0
    while get_bit(num, i) == 0 and i < 256:
        i += 1
    mask_pos = i - i % 8

    mask_pos_plus_len = 256

    while i < 256:
        if get_bit(num, i) != 0:
            mask_pos_plus_len = i - i % 8 + 8
        i += 1

    return (mask_pos_plus_len - mask_pos, mask_pos)


assert find_mask(0xFABBA10000) == (24, 16)
assert find_mask(0xFABBA10000) == (24, 16)
assert find_mask(0x7ABBA20000) == (24, 16)  # rounding to eights


@cached
def to_mask(num):
    num = cleanup_mul_1(num)

    if opcode(num) == "not":
        return to_neg_mask(num[1])

    if opcode(num) == "sub":
        if opcode(num[1]) == "exp" and num[2] == 1:
            mul = to_exp2(num[1][1])
            if mul == None:
                return None

            mask_pos = 0
            mask_len = mul_op(mul, num[1][2])

            # add type assert, that num[1][2] < 32?

            return (mask_len, sub_op(256, mask_len))

    if opcode(num) == "add" and num[1] == -1:
        return to_mask(("sub", num[2], 1,))

    if type(num) != int:
        return None

    i = 0
    while get_bit(num, i) == 0 and i < 256:
        i += 1
    mask_pos = i

    while get_bit(num, i) == 1 and i < 256:
        i += 1
    mask_pos_plus_len = i

    while i < 256:
        if get_bit(num, i) != 0:
            return None
        i += 1

    return mask_pos_plus_len - mask_pos, mask_pos


def to_neg_mask(num):
    if opcode(num) == "not":
        return to_mask(num[1])

    if type(num) != int:
        return None

    i = 0
    while get_bit(num, i) == 1 and i < 256:
        i += 1
    mask_pos = i

    while get_bit(num, i) == 0 and i < 256:
        i += 1
    mask_pos_plus_len = i

    while i < 256:
        if get_bit(num, i) != 1:
            return None
        i += 1

    return mask_pos_plus_len - mask_pos, mask_pos
