"""

    Postprocess goes through a function trace, and removes all the unnecessary memcalls.

    Assumes that the trace is a tree structure (that is - needs to be run *before* the folder)

"""
from core.algebra import minus_op
from utils.helpers import opcode


def cleanup_mul_1(trace):
    def cleanup_exp(exp):
        if type(exp) != tuple:

            return exp

        # mask_shl storage -> storage
        if (
            opcode(exp) == "mask_shl"
            and opcode(exp[4]) == "storage"
            and exp[1] == exp[4][1]
            and type(exp[2]) == int
            and exp[2] == minus_op(exp[3])
            and exp[2] == exp[4][2]
        ):
            return cleanup_exp(exp[4])

        if exp[:4] == ("mask_shl", 160, 0, 0) and exp[4] in ("caller",):
            return exp[4]

        if opcode(exp) == "bool" and type(exp[1]) == int:
            return 1 if exp[1] != 0 else 0

        # mask_shl, 200, 56, 0, "'supportsInterface(bytes4)'" -> supportsInterface(bytes4)
        if (
            opcode(exp) == "mask_shl"
            and type(exp[1]) == int
            and type(exp[2]) == int
            and type(exp[3]) == int
            and type(exp[4]) == str
            and exp[1] + exp[2] == 256
            and exp[3] == 0
            and exp[4][0] == exp[4][-1] == "'"
        ):
            s = exp[4][1:-1]
            if len(s) * 8 == exp[1]:
                return s

        if exp[:4] == ("mask_shl", 256, 0, 0):
            e = cleanup_exp(exp[4])

            if type(e) == int and e < 0x100 ** 32:
                return e

            if opcode(e) == "sha3":
                return e

                # ^ should be more generic

        #        if opcode(exp) == 'iszero' and \
        #            opcode(exp[1]) == 'eq':
        #             return ('Neq', ) + cleanup_exp(exp[1][1:])

        if opcode(exp) == "mul" and exp[1] == 1:
            if len(exp) == 3:
                assert False
                return cleanup_exp(exp[2])
            else:
                assert len(exp) > 3, exp
                return ("mul",) + tuple([cleanup_exp(x) for x in exp[2:]])

        return tuple([cleanup_exp(x) for x in exp])

    res = []

    for line in trace:
        if opcode(line) == "if":
            cond, if_true, if_false = line[1:]
            res.append(
                (
                    "if",
                    cleanup_exp(cond),
                    cleanup_mul_1(if_true),
                    cleanup_mul_1(if_false),
                )
            )

        elif opcode(line) == "while":
            cond, tr, jd, setvars = line[1], line[2], line[3], line[4]
            res.append(
                (
                    "while",
                    cleanup_exp(cond),
                    cleanup_mul_1(tr),
                    jd,
                    cleanup_exp(setvars),
                )
            )

        elif opcode(line) == "LOOP":
            tr, jd = line[1:]
            res.append(("LOOP", cleanup_mul_1(tr), jd))

        else:
            res.append(cleanup_exp(line))

    return res
