import collections
import json
import logging
from copy import deepcopy

from core.arithmetic import simplify_bool
from core.masks import mask_to_type, type_to_mask
from pano.matcher import Any, match
from pano.prettify import explain_text, pprint_logic, prettify
from utils.helpers import (
    COLOR_BLUE,
    COLOR_BOLD,
    COLOR_GRAY,
    COLOR_GREEN,
    COLOR_HEADER,
    COLOR_OKGREEN,
    COLOR_UNDERLINE,
    COLOR_WARNING,
    ENDC,
    FAIL,
    C,
    EasyCopy,
    color,
    find_f,
    find_f_list,
    opcode,
    replace_f,
)
from utils.signatures import (
    get_abi_name,
    get_func_name,
    get_func_params,
    set_func,
    set_func_params_if_none,
)

logger = logging.getLogger(__name__)


def find_parents(exp, child):
    if type(exp) not in (list, tuple):
        return []

    res = []

    for e in exp:
        if e == child:
            res.append(exp)
        res.extend(find_parents(e, child))

    return res


class Function(EasyCopy):
    def __init__(self, hash, trace):
        self.hash = hash
        self.name = get_func_name(hash)
        self.color_name = get_func_name(hash, add_color=True)
        self.abi_name = get_abi_name(hash)

        self.const = None
        self.read_only = None
        self.payable = None

        self.hash = hash

        self.trace = deepcopy(trace)
        self.orig_trace = deepcopy(self.trace)

        self.params = self.make_params()

        if "unknown" in self.name:
            self.make_names()

        self.trace = self.cleanup_masks(self.trace)
        self.ast = None

        self.analyse()

        assert self.payable is not None

        self.is_regular = self.const is None and self.getter is None

    def cleanup_masks(self, trace):
        def rem_masks(exp):
            if m := match(exp, ("bool", ("cd", ":int:idx"))):
                idx = m.idx
                if idx in self.params and self.params[idx][0] == "bool":
                    return ("cd", idx)

            elif m := match(exp, ("mask_shl", ":size", 0, 0, ("cd", ":int:idx"))):
                size, idx = m.size, m.idx
                if idx in self.params:
                    kind = self.params[idx][0]
                    def_size = type_to_mask(kind)
                    if size == def_size:
                        return ("cd", idx)

            return exp

        return replace_f(trace, rem_masks)

    def make_names(self):
        new_name = self.name.split("(")[0]

        self.name = "{}({})".format(
            new_name, ", ".join((p[0] + " " + p[1]) for p in self.params.values())
        )
        self.color_name = "{}({})".format(
            new_name,
            ", ".join(
                (p[0] + " " + COLOR_GREEN + p[1] + ENDC) for p in self.params.values()
            ),
        )

        self.abi_name = "{}({})".format(
            new_name, ",".join(p[0] for p in self.params.values())
        )

    def ast_length(self):
        if self.trace is not None:
            return len((self.print().split("\n"))), len(self.print())
        else:
            return 0, 0

    def priority(self):
        # sorts functions in this order:
        # - self-destructs
        # - (read-only? would be nice, but some read-only funcs can be very long, e.g. etherdelta)
        # - length

        if self.trace is None:
            return 0

        if "selfdestruct" in str(self.trace):
            return -1

        else:
            return self.ast_length()[1]

    def make_params(self):
        """
            figures out parameter types from the decompiled function code.

            does so by looking at all 'cd'/calldata occurences and figuring out
            how they are accessed - are they masked? are they used as pointers?

        """

        params = get_func_params(self.hash)
        if len(params) > 0:
            res = {}
            idx = 4
            for p in params:
                res[idx] = (p["type"], p["name"])
                idx += 32
        else:
            # good testing: solidstamp, auditContract
            # try to find all the references to parameters and guess their types

            def f(exp):
                if match(exp, ("mask_shl", Any, Any, Any, ("cd", Any))) or match(
                    exp, ("cd", Any)
                ):
                    return [exp]
                return []

            occurences = find_f_list(self.trace, f)

            sizes = {}
            for o in occurences:
                if m := match(o, ("mask_shl", ":size", Any, Any, ("cd", ":idx"))):
                    size, idx = m.size, m.idx

                if m := match(o, ("cd", ":idx")):
                    idx = m.idx
                    size = 256

                if idx == 0:
                    continue

                if m := match(idx, ("add", 4, ("cd", ":in_idx"))):
                    # this is a mark of 'cd' being used as a pointer
                    sizes[m.in_idx] = -1
                    continue

                if idx not in sizes:
                    sizes[idx] = size

                elif size < sizes[idx]:
                    sizes[idx] == size

            for idx in sizes:
                if type(idx) != int or (idx - 4) % 32 != 0:
                    logger.warning("unusual cd (not aligned)")
                    return {}

            # for every idx check if it's a bool by any chance
            for idx in sizes:
                li = find_parents(self.trace, ("cd", idx))
                for e in li:
                    if opcode(e) not in ("bool", "if", "iszero"):
                        break

                    if m := match(e, ("mask_shl", Any, ":off", Any, ":val")):
                        off, val = m.off, m.val
                        assert val == ("cd", idx)
                        if off != 0:
                            sizes[idx] = -2  # it's a tuple!
                else:
                    sizes[idx] = 1

            res = {}
            count = 1
            for k in sizes:

                if type(k) != int:
                    logger.warning(f"unusual calldata reference {k}")
                    return {}

            for idx in sorted(sizes.keys()):
                size = sizes[idx]

                if size == -2:
                    kind = "tuple"
                elif size == -1:
                    kind = "array"
                elif size == 1:
                    kind = "bool"
                else:
                    kind = mask_to_type(size, force=True)

                assert kind != None, size

                res[idx] = (kind, f"_param{count}")
                count += 1

        return res

    def serialize(self):
        trace = self.trace

        res = {
            "hash": self.hash,
            "name": self.name,
            "color_name": self.color_name,
            "abi_name": self.abi_name,
            "length": self.ast_length(),
            "getter": self.getter,
            "const": self.const,
            "payable": self.payable,
            "print": self.print(),
            "trace": trace,
            "params": self.params,
        }
        try:
            assert json.dumps(res)  # check if serialisation works well
        except:
            logger.error("failed serialization %s", self.name)
            raise

        return res

    def print(self):
        out = self._print()
        return "\n".join(out)

    def _print(self):
        set_func(self.hash)
        set_func_params_if_none(self.params)

        if self.const is not None:

            val = self.const
            if opcode(val) == "return":
                val = val[1]

            return [
                COLOR_HEADER
                + "const "
                + ENDC
                + str(self.color_name.split("()")[0])
                + " = "
                + COLOR_BOLD
                + prettify(val)
                + ENDC
            ]

        else:
            comment = ""

            if not self.payable:
                comment = "# not payable"

            if self.name == "_fallback()":
                if self.payable:
                    comment = "# default function"
                else:
                    comment = "# not payable, default function"  # qweqw

            header = [
                color("def ", C.header)
                + self.color_name
                + (color(" payable", C.header) if self.payable else "")
                + ": "
                + color(comment, C.gray)
            ]

            if self.ast is not None:
                res = list(pprint_logic(self.ast))
            else:
                res = list(pprint_logic(self.trace))

            if len(res) == 0:
                res = ["  stop"]

            return header + res

    def simplify_string_getter_from_storage(self):
        """
            a heuristic for finding string getters and replacing them
            with a simplified version

            test cases: unicorn
                        0xF7dF66B1D0203d362D7a3afBFd6728695Ae22619 name
                        0xf8e386EDa857484f5a12e4B5DAa9984E06E73705 version

            if you want to see how it works, turn this func off
            and see how test cases decompile
        """

        if not self.read_only:
            return

        if len(self.returns) == 0:
            return

        for r in self.returns:
            if not (
                m := match(
                    r,
                    (
                        "return",
                        ("data", ("arr", ("storage", 256, 0, ("length", ":loc")), ...)),
                    ),
                )
            ):
                return
            loc = m.loc

        self.trace = [
            (
                "return",
                (
                    "storage",
                    256,
                    0,
                    ("array", ("range", 0, ("storage", 256, 0, ("length", loc))), loc),
                ),
            )
        ]
        self.getter = self.trace[0][1]

    def analyse(self):
        assert len(self.trace) > 0

        def find_returns(exp):
            if opcode(exp) == "return":
                return [exp]
            else:
                return []

        exp_text = []

        self.returns = find_f_list(self.trace, find_returns)

        exp_text.append(("possible return values", prettify(self.returns)))

        first = self.trace[0]

        if (
            opcode(first) == "if"
            and simplify_bool(first[1]) == "callvalue"
            and (first[2][0] == ("revert", 0) or opcode(first[2][0]) == "invalid")
        ):
            self.trace = self.trace[0][3]
            self.payable = False
        elif (
            opcode(first) == "if"
            and simplify_bool(first[1]) == ("iszero", "callvalue")
            and (first[3][0] == ("revert", 0) or opcode(first[3][0]) == "invalid")
        ):
            self.trace = self.trace[0][2]
            self.payable = False
        else:
            self.payable = True

        exp_text.append(("payable", self.payable))

        self.read_only = True
        for op in [
            "store",
            "selfdestruct",
            "call",
            "delegatecall",
            "codecall",
            "create",
        ]:
            if f"'{op}'" in str(self.trace):
                self.read_only = False

        exp_text.append(("read_only", self.read_only))

        """
            const func detection
        """

        self.const = self.read_only
        for exp in ["storage", "calldata", "calldataload", "store", "cd"]:
            if exp in str(self.trace) or len(self.returns) != 1:
                self.const = False

        if self.const:
            self.const = self.returns[0]
            if len(self.const) == 3 and opcode(self.const[2]) == "data":
                self.const = self.const[2]
            if len(self.const) == 3 and opcode(self.const[2]) == "mask_shl":
                self.const = self.const[2]
            if len(self.const) == 3 and type(self.const[2]) == int:
                self.const = self.const[2]
        else:
            self.const = None

        if self.const:
            exp_text.append(("const", self.const))

        """
            getter detection
        """

        self.getter = None
        self.simplify_string_getter_from_storage()
        if self.const is None and self.read_only and len(self.returns) == 1:
            ret = self.returns[0][1]
            if match(ret, ("bool", ("storage", Any, Any, ":loc"))):
                self.getter = (
                    ret  # we have to be careful when using this for naming purposes,
                )
                # because sometimes the storage can refer to array length

            elif opcode(ret) == "mask_shl" and opcode(ret[4]) == "storage":
                self.getter = ret[4]
            elif opcode(ret) == "storage":
                self.getter = ret
            elif opcode(ret) == "data":
                terms = ret[1:]
                # for structs, we check if all the parts of the struct are storage from the same
                # location. if so, we return the location number

                t0 = terms[0]  # 0xFAFfea71A6da719D6CAfCF7F52eA04Eb643F6De2 - documents
                if m := match(t0, ("storage", 256, 0, ":loc")):
                    loc = m.loc
                    for e in terms[1:]:
                        if not match(e, ("storage", 256, 0, ("add", Any, loc))):
                            break
                    else:
                        self.getter = t0

                # kitties getKitten - with more cases this and the above could be uniformed
                if self.getter is None:
                    prev_loc = -1
                    for e in terms:

                        def l2(x):
                            if m := match(x, ("sha3", ("data", Any, ":l"))):
                                if type(m.l) == int and m.l < 1000:
                                    return m.l
                            if (
                                opcode(x) == "sha3"
                                and type(x[1]) == int
                                and x[1] < 1000
                            ):
                                return x[1]
                            return None

                        loc = find_f(e, l2)
                        if not loc or (prev_loc != -1 and prev_loc != loc):
                            break
                        prev_loc = loc

                    else:
                        self.getter = ("struct", ("loc", loc))

            else:
                pass

        if self.getter:
            exp_text.append((f"getter for", prettify(self.getter)))

        explain_text("function traits", exp_text)

        return self
