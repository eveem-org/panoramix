# coding: tilde

from copy import copy
import core.arithmetic as arithmetic
import logging
import collections

from core.memloc import range_overlaps, splits_mem, fill_mem, memloc_overwrite, split_setmem, apply_mask_to_range, split_store

from utils.helpers import C, rewrite_trace_multiline, opcode, cached, walk_trace, to_exp2, replace, find_op_list
from utils.helpers import contains, find_f_set, find_f_list, rewrite_trace, rewrite_trace_full, replace, replace_f, replace_f_stop, rewrite_trace_ifs

from core.algebra import simplify, calc_max, add_ge_zero, minus_op, sub_op, flatten_adds, max_to_add, divisible_bytes, _max_op, div_op
from core.algebra import add_op, bits, mul_op, get_sign, safe_ge_zero, ge_zero, lt_op, safe_lt_op, safe_le_op, simplify_max, le_op, max_op, safe_max_op, safe_min_op, min_op, or_op, neg_mask_op, mask_op, apply_mask_to_storage, apply_mask, try_add, to_bytes

from core.arithmetic import is_zero, to_real_int

from pano.prettify import pformat_trace, pprint_trace, pprint_repr

from .postprocess import cleanup_mul_1

from utils.profiler import checkpoint, checkpoint_start, log_checkpoints, func_caller

from core.masks import get_bit

from core.masks import to_mask, to_neg_mask

from pano.prettify import pretty_repr, explain

from pano.simplify import simplify_trace

import sys

logger = logging.getLogger(__name__)
logger.level = logging.CRITICAL # switch to INFO for detailed

'''

    Rube Goldberg would be proud.

'''

def make_whiles(trace): 

    trace = make(trace)

    explain('Loops -> whiles', trace)

    # clean up jumpdests
    trace = rewrite_trace(trace, lambda line: [] if line ~ ('jumpdest', ...) else [line])

    trace = simplify_trace(trace)

    return trace

'''

    make whiles

'''


def make(trace):
    res = []

    for idx, line in enumerate(trace):
        if line ~ ('if', :cond, :if_true, :if_false):
            res.append(('if', cond, make(if_true), make(if_false)))

        elif line ~ ('label', :jd, :vars, ...):
            try:
                before, inside, remaining, cond = to_while(trace[idx+1:], jd)
            except:
                continue
                return trace

            inside = inside #+ [str(inside)]

            inside = make(inside)
            remaining = make(remaining)

            for _, v_idx, v_val in vars:
                before = replace(before, ('var', v_idx), v_val)
            before = make(before)


            res.extend(before)
            res.append(('while', cond, inside, repr(jd), vars))
            res.extend(remaining)

            return res

        elif line ~ ('goto', :jd, :setvars):
            res.append(('continue', repr(jd), setvars))

        else:
            res.append(line)

    return res


def get_jds(line):
    if line ~ ('goto', :jd, ...):
        return [jd]

    else:
        return []

def is_revert(trace):
    if len(trace) > 1:
        return False

    line = trace[0]
    if (line ~ ('return', 0)) or \
       (line ~ ('revert', ...)) or \
       (line ~ ('invalid', ...)):
        return True

    return False

def to_while(trace, jd, path = None):
    path = path or []

    while True:
        if trace == []:
            raise
        line = trace[0]
        trace = trace[1:]

        if (line ~ ('if', :cond, :if_true, :if_false)):
            if is_revert(if_true):
                path.append(('require', is_zero(cond)))
                trace = if_false
                continue

            if is_revert(if_false):
                path.append(('require', cond))
                trace = if_true
                continue

            jds_true = find_f_list(if_true, get_jds)
            jds_false = find_f_list(if_false, get_jds)

            assert (jd in jds_true) != (jd in jds_false), (jds_true, jds_false)

            def add_path(line):
                if line ~ ('goto', _, :svs):
                    path2 = path
                    for _, v_idx, v_val in svs:
                        path2 = replace(path2, ('var', v_idx), v_val)

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


    assert False, f'no if after label?{jd}'
