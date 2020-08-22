import collections
import logging
from copy import copy
from time import gmtime, strftime

import panoramix.core.arithmetic as arithmetic
from panoramix.core.algebra import (
    _max_op,
    add_ge_zero,
    add_op,
    apply_mask,
    apply_mask_to_storage,
    bits,
    calc_max,
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
    memloc_overwrite,
    range_overlaps,
    sizeof,
    split_setmem,
    split_store,
    splits_mem,
)
from panoramix.matcher import Any, match
from panoramix.prettify import pformat_trace, pprint_trace
from panoramix.utils.helpers import (
    contains,
    find_f_list,
    find_f_set,
    is_array,
    opcode,
    replace,
    replace_f,
    rewrite_trace,
    rewrite_trace_full,
    rewrite_trace_multiline,
    to_exp2,
    walk_trace,
)


"""

    Some nasty last-minute hacks and heurestics I wrote to finally get the April release to production.

    One of the very few places in Panoramix that are blatantly mathematically incorrect, but
    help to make a ton of contracts way more readable (and - in practice - being always valid)

"""


def postprocess_exp(exp):
    if opcode(exp) == "data":
        terms = exp[1:]
        # make arrays in data
        concrete = [t for t in terms if type(t) == int and t % 32 == 0]
        if len(concrete) == 1:
            # potential array in data?
            assert concrete[0] % 32 == 0
            loc = concrete[0] // 32
            if loc + 1 < len(terms) and loc > terms.index(concrete[0]):
                arr = ("arr",) + terms[loc:]

                # heuristics for cleaning up various misprocessed stuff

                if (
                    m := match(arr, ("arr", ":l", (":op", Any, ":l"), ...))
                ) and is_array(m.op):
                    arr = arr[:3]

                elif (
                    m := match(
                        arr,
                        (
                            "arr",
                            ":l",
                            (
                                "mask_shl",
                                ("mask_shl", 253, 0, 3, ":l"),
                                Any,
                                Any,
                                ("data", (":op", ":st", ":l"), ...),
                                ...,
                            ),
                        ),
                    )
                ) and is_array(m.op):
                    arr = ("arr", m.l, (m.op, m.st, m.l))

                t2 = tuple([arr if t == loc * 32 else t for t in terms[:loc]])
                return ("data",) + t2

    # this would really require debugging as to why such thing happens, and a nicer cleanup.
    # but it's last minute fixes again :)

    if m := match(
        exp,
        (
            "arr",
            ":l",
            (
                "mask_shl",
                ("mask_shl", Any, 0, 3, ":l"),
                ("add", 256, Any),
                ("add", -256, Any),
                ("data", ("call.data", ":s", ":l"), ...),
                ...,
            ),
        ),
    ):
        return ("arr", m.l, ("call.data", m.s, m.l))

    return exp


def postprocess_trace(line):
    """
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
    """

    #    if line ~ ('setmem', ('range', :s, ('mask_shl', 251, 5, 0, ('add', 31, ('cd', ('add', 4, :param))))), ('data', ('call.data', ('add', 36, param), ('cd', ('add', 4, param))), ('mem', ...))):
    #        lin = ('setmem', ('range', s, ('cd', ('add', 4, param))), ('call.data', ('add', 36, param), ('cd', ('add', 4, param))))
    #        return [lin]

    if m := match(
        line, ("if", ("iszero", ("storage", 5, 0, ":l")), ":if_true", ":if_false")
    ):
        l, if_true, if_false = m.l, m.if_true, m.if_false

        def find_arr_l(exp):
            if match(exp, ("arr", ("storage", 256, 0, l), ...)):
                return [exp]

        true_arr = find_f_list(if_true, find_arr_l)
        false_arr = find_f_list(if_true, find_arr_l)

        if len(true_arr) > 0 and len(true_arr) == len(false_arr):
            return if_true

    if m := match(
        line, ("if", ("iszero", ("mask_shl", 5, 0, 0, ":l")), ":if_true", ":if_false")
    ):
        l, if_true, if_false = m.l, m.if_true, m.if_false

        def find_arr_l(exp):
            if match(exp, ("arr", l, ...)):
                return [exp]

        true_arr = find_f_list(if_true, find_arr_l)
        false_arr = find_f_list(if_true, find_arr_l)

        if len(true_arr) > 0 and len(true_arr) == len(false_arr):
            return if_true

    """
        When writing strings to storage, there are usually three cases - when string is 0,
        when string is < 31 (special format that takes just one storage slot), and when string >= 32.

        e.g. 0xf97187f566eC6374cB08470CCe593fF0Dd36d8A9, baseURI
             0xFcD0d8E3ae34922A2921f7E7065172e5317f8ad8, name

        The below hides the cases for < 31, and for 0, and shows only for >31. Technically incorrect,
        and I'm not super comfortable with this, but some of the code would be very unreadable without it.


    """

    if m := match(line, ("if", ("lt", 31, ":some_len"), ":if_true", ":if_false")):
        some_len, if_true, if_false = m.some_len, m.if_true, m.if_false
        if len(if_true) == 2:
            first, second = if_true[0], if_true[1]
            if (
                opcode(first) == "store"
                and contains(first, some_len)
                and (
                    m := match(
                        second,
                        ("if", ("iszero", some_len), ":deep_true", ":deep_false"),
                    )
                )
            ):
                return [first] + m.deep_false

    if (
        m := match(
            line,
            (
                "if",
                (
                    "iszero",
                    (
                        "mask_shl",
                        255,
                        1,
                        0,
                        (
                            "and",
                            ("storage", 256, 0, ":loc"),
                            (
                                "add",
                                -1,
                                (
                                    "mask_shl",
                                    248,
                                    0,
                                    8,
                                    ("iszero", ("storage", 1, 0, ":loc")),
                                ),
                            ),
                        ),
                    ),
                ),
                ":if_true",
                ":if_false",
            ),
        )
    ) or (
        m := match(
            line,
            (
                "if",
                (
                    "iszero",
                    (
                        "mask_shl",
                        255,
                        1,
                        0,
                        (
                            "and",
                            (
                                "add",
                                -1,
                                (
                                    "mask_shl",
                                    248,
                                    0,
                                    8,
                                    ("iszero", ("storage", 1, 0, ":loc")),
                                ),
                            ),
                            ("storage", 256, 0, ":loc"),
                        ),
                    ),
                ),
                ":if_true",
                ":if_false",
            ),
        )
    ):
        if_true, if_false, loc = m.if_true, m.if_false, m.loc

        if len(if_false) == 1:
            first = if_false[0]

            if (
                m := match(
                    first,
                    (
                        "if",
                        ("lt", 31, ("storage", 256, 0, ("length", loc))),
                        ":deep_true",
                        ":deep_false",
                    ),
                )
            ) or (
                m := match(
                    first,
                    (
                        "if",
                        ("lt", 31, ("storage", 256, 0, ("length", ("loc", loc)))),
                        ":deep_true",
                        ":deep_false",
                    ),
                )
            ):
                return m.deep_true

    return [line]


def rewrite_string_stores(lines):
    # ugly af, and not super-precise. it should be split into 2 parts,
    # converting array->storage writes in loop_to_setmem_from_storage
    # and then relying on those storage writes here for cleanup

    assert len(lines) == 3
    l1, l2, l3 = lines[0], lines[1], lines[2]
    if (
        (
            m1 := match(
                l1,
                ("store", 256, 0, ":idx", ("add", 1, ("mask_shl", 255, 0, 1, ":src"))),
            )
        )
        and (m2 := match(l2, ("while", ("gt", Any, Any), ":path2", Any, ":setvars")))
        and match(l3, ("while", ("gt", ...), ":path3", ...))
        and len(m2.path2) == 2
        and (x := m2.path2[0])
        and match(
            x,
            (
                "store",
                256,
                0,
                ("add", ("var", Any), Any),
                ("mem", ("range", ("var", ":v"), 32)),
            ),
        )
    ):
        return [
            (
                "store",
                256,
                0,
                ("array", "", ("sha3", m1.idx)),
                ("arr", m1.src, ("mem", ("range", m2.setvars[1][2], m1.src))),
            )
        ]

    return None


def rewrite_memcpy(lines):  # 2
    assert len(lines) == 2
    l1 = lines[0]
    l2 = lines[1]

    if m := match(
        l1,
        (
            "setmem",
            (
                "range",
                ":s",
                ("mask_shl", 251, 5, 0, ("add", 31, ("cd", ("add", 4, ":param")))),
            ),
            (
                "data",
                ("call.data", ("add", 36, ":param"), ("cd", ("add", 4, ":param"))),
                ("mem", ...),
            ),
        ),
    ):
        return (
            "setmem",
            ("range", s, ("cd", ("add", 4, m.param))),
            ("call.data", ("add", 36, m.param), ("cd", ("add", 4, m.param))),
        )


# (setmem (range (add 128 (mask_shl 251 5 0 (add 31 (cd (add 4 (cd 68)))))) (mask_shl 251 5 0 (add 31 (cd (add 4 (cd 68)))))) (data (call.data (add 36 (cd 68)) (cd (add 4 (cd 68)))) (mem (range (add 128 (cd (add 4 (cd 68)))) (add (mask_shl 251 5 0 (add 31 (cd (add 4 (cd 68))))) (mul -1 (cd (add 4 (cd 68)))))))))
#        (if (iszero (mask_shl 5 0 0 (cd (add 4 (cd 68))))) (t


"""

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

"""
