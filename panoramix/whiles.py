import collections
import logging
import sys
from copy import copy

from panoramix.core import arithmetic
from panoramix.core.algebra import (
    _max_op,
    add_ge_zero,
    add_op,
    apply_mask,
    apply_mask_to_storage,
    bits,
    calc_max,
    div_op,
    divisible_bytes,
    flatten_adds,
    ge_zero,
    get_sign,
    le_op,
    lt_op,
    mask_op,
    max_op,
    max_to_add,
    min_op,
    minus_op,
    mul_op,
    neg_mask_op,
    or_op,
    safe_ge_zero,
    safe_le_op,
    safe_lt_op,
    safe_max_op,
    safe_min_op,
    simplify,
    simplify_max,
    sub_op,
    to_bytes,
    try_add,
)
from panoramix.core.arithmetic import is_zero, to_real_int
from panoramix.core.masks import get_bit, to_mask, to_neg_mask
from panoramix.core.memloc import (
    apply_mask_to_range,
    fill_mem,
    memloc_overwrite,
    range_overlaps,
    split_setmem,
    split_store,
    splits_mem,
)
from panoramix.matcher import Any, match
from panoramix.prettify import (
    explain,
    pformat_trace,
    pprint_repr,
    pprint_trace,
    pretty_repr,
)
from panoramix.simplify import simplify_trace
from panoramix.utils.helpers import (
    C,
    contains,
    find_f_list,
    find_f_set,
    find_op_list,
    opcode,
    replace,
    replace_f,
    replace_f_stop,
    rewrite_trace,
    rewrite_trace_full,
    rewrite_trace_ifs,
    rewrite_trace_multiline,
    to_exp2,
    walk_trace,
)

from panoramix.postprocess import cleanup_mul_1

logger = logging.getLogger(__name__)
logger.level = logging.CRITICAL  # switch to INFO for detailed

"""

    Rube Goldberg would be proud.

"""


def make_whiles(trace):
    trace = make(trace)
    explain("Loops -> whiles", trace)

    # clean up jumpdests
    trace = rewrite_trace(
        trace, lambda line: [] if opcode(line) == "jumpdest" else [line]
    )
    trace = simplify_trace(trace)

    return trace


"""

    make whiles

"""


def make(trace):
    res = []

    for idx, line in enumerate(trace):
        if m := match(line, ("if", ":cond", ":if_true", ":if_false")):
            res.append(("if", m.cond, make(m.if_true), make(m.if_false)))

        elif m := match(line, ("label", ":jd", ":vars", ...)):
            jd, vars = m.jd, m.vars
            try:
                before, inside, remaining, cond = to_while(trace[idx + 1 :], jd)
            except Exception:
                continue

            inside = inside  # + [str(inside)]

            inside = make(inside)
            remaining = make(remaining)

            for _, v_idx, v_val in vars:
                before = replace(before, ("var", v_idx), v_val)
            before = make(before)

            res.extend(before)
            res.append(("while", cond, inside, repr(jd), vars))
            res.extend(remaining)

            return res

        elif m := match(line, ("goto", ":jd", ":setvars")):
            res.append(("continue", repr(m.jd), m.setvars))

        else:
            res.append(line)

    return res


def get_jds(line):
    if m := match(line, ("goto", ":jd", ...)):
        return [m.jd]
    return []


def is_revert(trace):
    if len(trace) > 1:
        return False

    line = trace[0]
    return (line == ("return", 0)) or (opcode(line) in ("revert", "invalid"))


def to_while(trace, jd, path=None):
    path = path or []

    while True:
        if trace == []:
            raise
        line = trace[0]
        trace = trace[1:]

        if m := match(line, ("if", ":cond", ":if_true", ":if_false")):
            cond, if_true, if_false = m.cond, m.if_true, m.if_false
            if is_revert(if_true):
                path.append(("require", is_zero(cond)))
                trace = if_false
                continue

            if is_revert(if_false):
                path.append(("require", cond))
                trace = if_true
                continue

            jds_true = find_f_list(if_true, get_jds)
            jds_false = find_f_list(if_false, get_jds)

            assert (jd in jds_true) != (jd in jds_false), (jds_true, jds_false)

            def add_path(line):
                if m := match(line, ("goto", Any, ":svs")):
                    path2 = path
                    for _, v_idx, v_val in m.svs:
                        path2 = replace(path2, ("var", v_idx), v_val)

                    return path2 + [line]
                else:
                    return [line]

            if jd in jds_true:
                if_true = rewrite_trace(if_true, add_path)
                return path, if_true, if_false, cond
            else:
                if_false = rewrite_trace(if_false, add_path)
                return path, if_false, if_true, is_zero(cond)

        else:
            path.append(line)

    assert False, f"no if after label?{jd}"
