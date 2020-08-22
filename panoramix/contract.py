import collections
import logging

import panoramix.folder as folder
import panoramix.sparser as sparser
from panoramix.matcher import Any, match
from panoramix.prettify import pprint_ast, pprint_trace, prettify, pretty_stor
from panoramix.utils.helpers import (
    COLOR_GREEN,
    ENDC,
    find_f_list,
    opcode,
    replace_f,
    replace_lines,
    to_exp2,
    tuplify,
)

from panoramix.function import Function
from panoramix.sparser import get_loc, get_name

logger = logging.getLogger(__name__)


def deserialize(trace):
    res = []
    for line in trace:
        line_t = tuple(line)

        if opcode(line_t) == "while":
            _, cond, path, lid, setvars = line_t
            cond = tuplify(cond)
            setvars = tuplify(setvars)
            assert type(lid) == str

            path = deserialize(path)
            res.append(("while", cond, path, lid, setvars))

        elif opcode(line_t) == "if":
            _, cond, if_true, if_false = line_t
            cond = tuplify(cond)
            if_true = deserialize(if_true)
            if_false = deserialize(if_false)
            res.append(("if", cond, if_true, if_false))

        else:
            res.append(tuplify(line))

    return res


class Contract:
    def __init__(self, functions, problems):
        self.problems = problems
        self.functions = []
        for func in functions.values():
            self.functions.append(func)

        self.stor_defs = {}

    def json(self) -> dict:
        return {
            "problems": self.problems,
            "stor_defs": self.stor_defs,
            "functions": [f.serialize() for f in self.functions],
        }

    def load(self, data):
        self.problems = data["problems"]
        self.functions = []
        self.stor_defs = data["stor_defs"] if "stor_defs" in data else {}

        for func in data["functions"]:
            self.functions.append(
                Function(hash=func["hash"], trace=deserialize(func["trace"]))
            )

        return self

    def postprocess(self):
        try:
            self.stor_defs = sparser.rewrite_functions(self.functions)
        except Exception:
            # this is critical, because it causes full contract to display very
            # badly, and cannot be limited in scope to just one affected function
            logger.exception("Storage postprocessing failed. This is very bad!")
            self.stor_defs = {}

        for func in self.functions:

            def replace_names(exp):
                if (m := match(exp, ("cd", ":int:idx"))) and m.idx in func.params:
                    return ("param", func.params[m.idx][1])
                return exp

            func.trace = replace_f(func.trace, replace_names)

        # const list, sort by putting all-caps consts at the end - looks way better this way
        self.consts = [
            f for f in self.functions if f.const and f.name.upper() != f.name
        ] + [f for f in self.functions if f.const and f.name.upper() == f.name]

        self.make_asts()

    def make_asts(self):
        """
            we need to do ast creation from the contract, not function level,
            because some simplifications (type/field removal) require insight to all the functions,
            not just a single one
        """

        for func in self.functions:
            func.ast = self.make_ast(func.trace)

        def find_stor_masks(exp):
            if opcode(exp) == "type":
                return [exp]
            else:
                return []

        stor_masks = frozenset(
            find_f_list([f.ast for f in self.functions], find_stor_masks)
        )

        stor_loc_to_masks = collections.defaultdict(set)
        stor_name_to_masks = collections.defaultdict(set)
        for mask in stor_masks:
            stor_loc_to_masks[get_loc(mask)].add(mask)
            stor_name_to_masks[get_name(mask)].add(mask)

        def cleanup(exp):

            if m := match(exp, ("field", 0, ("stor", ("length", ":idx")))):
                return ("stor", ("length", m.idx))

            if m := match(
                exp, ("type", 256, ("field", 0, ("stor", ("length", ":idx"))))
            ):
                return ("stor", ("length", m.idx))

            if m := match(exp, ("type", 256, ("stor", ("length", ":idx")))):
                return ("stor", ("length", m.idx))

            if m := match(
                exp,
                (
                    "type",
                    ":e_type",
                    ("field", ":e_field", ("stor", ("name", ":e_name", ":loc"))),
                ),
            ):
                e_type, e_field, e_name, loc = m.e_type, m.e_field, m.e_name, m.loc
                for mask in stor_name_to_masks[e_name]:
                    assert (
                        get_loc(mask) == loc
                    )  # otherwise, two locs with the same name?

                    assert (
                        m := match(
                            mask, ("type", ":m_type", ("field", ":m_field", Any))
                        )
                    )
                    if m.m_field != e_field or m.m_type != e_type:
                        return exp

                return ("stor", ("name", e_name, loc))

            if m := match(exp, ("type", ":e_type", ":stor")):
                e_type, stor = m.e_type, m.stor
                e_loc = get_loc(stor)

                for mask in stor_loc_to_masks[e_loc]:
                    if not match(
                        mask, ("type", 256, ("field", 0, ("stor", ("length", Any))))
                    ):
                        assert (m := match(mask, ("type", ":m_type", Any)))
                        if m.m_type != e_type:
                            return exp

                return stor

            if m := match(exp, ("field", ":e_off", ":stor")):
                e_off, stor = m.e_off, m.stor
                e_loc = get_loc(stor)

                for mask in stor_loc_to_masks[e_loc]:
                    if not match(
                        mask, ("type", 256, ("field", 0, ("stor", ("length", Any))))
                    ):
                        assert (
                            m := match(mask, ("type", Any, ("field", ":m_off", Any)))
                        )
                        if m.m_off != e_off:
                            return exp

                return stor

            return exp

        for f in self.functions:
            f.ast = replace_f(f.ast, cleanup)

    def make_ast(self, trace):
        trace = folder.fold(trace)

        def store_to_set(line):
            if m := match(line, ("store", ":size", ":off", ":idx", ":val")):
                return ("set", ("stor", m.size, m.off, m.idx), m.val)
            else:
                return line

        def loc_to_name(exp):
            if m := match(exp, ("loc", ":int:num")):
                num = m.num
                if num < 1000:
                    return ("name", "stor" + str(num), num)
                else:
                    return ("name", "stor" + hex(num)[2:6].upper(), num)

            if m := match(exp, ("loc", ":num")):
                return (
                    "name",
                    "stor" + prettify(m.num, add_color=False, parentheses=True),
                    m.num,
                )

            return exp

        def arr_rem_mul(exp):
            if m := match(
                exp,
                ("array", ("mask_shl", ":size", ":off", ":int:shl", ":idx"), ":loc"),
            ):
                size, off, shl, idx, loc = m.size, m.off, m.shl, m.idx, m.loc
                r = 2 ** shl
                e_loc = get_loc(loc)

                for s in self.stor_defs:
                    assert match(s, ("def", Any, ":d_loc", ":d_def"))
                    if match(s, ("def", Any, e_loc, ("array", ("struct", r)))):
                        return ("array", ("mask_shl", size, off, 0, idx), loc)

            elif m := match(exp, ("array", ("mul", ":int:r", ":idx"), ":loc")):
                r, idx, loc = m.r, m.idx, m.loc
                e_loc = get_loc(loc)

                for s in self.stor_defs:
                    assert match(s, ("def", Any, ":d_loc", ":d_def"))
                    if match(s, ("def", Any, e_loc, ("array", ("struct", r)))):
                        return ("array", idx, loc)
            return exp

        def mask_storage(exp):
            if m := match(exp, ("stor", ":size", ":off", ":idx")):
                size, off, idx = m.size, m.off, m.idx
                if isinstance(off, int) and off < 0:
                    off = 0
                return ("type", size, ("field", off, ("stor", idx)))
            else:
                return exp

        def other_1(exp):
            if (
                (
                    m := match(
                        exp, ("mask_shl", ":int:size", ":n_size", ":size_n", ":str:val")
                    )
                )
                and 256 - m.size == m.n_size
                and m.size - 256 == m.size_n
                and m.size + 16 == len(m.val) * 8
                and len(m.val) > 0
                and m.val[0] == m.val[-1] == "'"
            ):  # +16 because '' in strings
                return m.val
            else:
                return exp

        def other_2(exp):
            if (
                m := match(exp, ("if", ("eq", ":a", ":b"), ":if_true"))
            ) and m.if_true == [("return", ("eq", m.a, m.b))]:
                return ("if", ("eq", m.a, m.b), [("return", ("bool", 1))])

            elif (m := match(exp, ("mask_shl", 160, 0, 0, ":str:e"))) and m.e in (
                "address",
                "coinbase",
                "caller",
                "origin",
            ):
                return m.e

            elif (
                (
                    m := match(
                        exp, ("mask_shl", ":int:size", ":int:off", ":int:m_off", ":e")
                    )
                )
                and m.m_off == -m.off
                and m.off in range(1, 9)
                and m.size + m.off in [8, 16, 32, 64, 128, 256]
            ):
                return ("div", ("mask", m.size + m.off, 0, m.e), 2 ** m.off)

            elif exp == ("mask_shl", 32, 224, 0, ("cd", 0)):
                return ("cd", 0)

            elif m := match(exp, ("mask_shl", 160, 0, 96, ":val")):
                # nasty hack for stuff like 0xF8DFaC6CAe56736FD2a05e45108490C6Cb40147D approve
                return ("mask_shl", 160, 0, 0, m.val)

            else:
                return exp

        trace = replace_f(trace, store_to_set)
        trace = replace_f(trace, loc_to_name)
        trace = replace_f(trace, arr_rem_mul)
        trace = replace_f(trace, mask_storage)
        trace = replace_f(trace, other_1)
        trace = replace_f(trace, other_2)
        return trace
