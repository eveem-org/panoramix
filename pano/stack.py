import logging
from copy import copy

import core.arithmetic as arithmetic
from core.algebra import mask_op, neg_mask_op
from core.masks import to_mask, to_neg_mask
from pano.prettify import prettify
from utils.helpers import EasyCopy, opcode, to_exp2

logger = logging.getLogger(__name__)

"""

    Symbolic stack module, used by vm.py.

"""


def fold_stacks(self, latter, depth):
    """

        When a loop is discovered, this function takes the stack from the beginningg
        of the loop, and from the end of the loop, and tries to figure out the loop variables.

        It then returns a stack that has variables in it instead of values.

    """
    assert len(self) == len(latter), (self, latter)
    vars = []

    first = list(self)
    second = list(latter)

    for idx, el in reversed(list(enumerate(copy(first)))):
        el2 = second[idx]

        if el != el2:
            temp_var_counter = len(first) - idx + depth * 1000

            vars.append(("var", temp_var_counter, first[idx], idx))
            first[idx] = ("var", temp_var_counter)

    return first, vars


class Stack(EasyCopy):
    def __init__(self, val=None):
        if type(val) == tuple:
            val = list(val)

        self.stack = val or []

    def __str__(self):
        return (
            "["
            + (", ".join([prettify(el, parentheses=False) for el in self.stack]))
            + "]"
        )

    def light_copy(self):
        ret = copy(self)
        ret.stack = copy(self.stack)
        return ret

    def peek(self):
        if self.len() > 0:
            return self.stack[-1]
        else:
            return None

    def append(self, el):
        assert el is not None, self.stack

        self.stack.append(self.simplify(el))

    def pop(self):
        return self.stack.pop()

    def len(self):
        return len(self.stack)

    def swap(self, idx):
        pos = -1 * idx - 1
        self.stack[-1], self.stack[pos] = self.stack[pos], self.stack[-1]

    def dup(self, idx):
        assert idx > 0
        self.stack.append(self.stack[-idx])

    def folded_with(self, latter, loader_jds, depth):
        assert self.len() == latter.len()
        vars = []

        first = copy(self.stack)
        second = copy(latter.stack)

        for idx, el in reversed(list(enumerate(copy(first)))):
            el2 = second[idx]

            if el != el2:
                temp_var_counter = len(first) - idx + depth * 1000

                vars.append(("var", temp_var_counter, first[idx], idx))
                first[idx] = ("var", temp_var_counter)

        return Stack(first), vars

    def unfold(self, vars):
        first = self.stack

        for idx, el in vars.items():
            first[len(first) - idx] = el

    def jump_dests(self, jump_dests):

        res = []

        for el in self.stack:
            if (
                type(el) == int
                and el in jump_dests
                or (type(el) == int and el > 2000 and el < 5000)
            ):
                res.append(str(el))

        return res

    simplify_cache = {}

    @staticmethod
    def simplify(exp):
        if type(exp) == int:
            return exp & arithmetic.UINT_256_MAX
        if type(exp) != tuple:
            return exp

        if exp in Stack.simplify_cache:
            return Stack.simplify_cache[exp]

        ret = Stack._simplify(exp)

        Stack.simplify_cache[exp] = ret

        return ret

    @staticmethod
    def _simplify(exp):
        op = opcode(exp)

        if op in arithmetic.opcodes:
            exp = arithmetic.eval(exp)

        if op in ("and", "div", "mul"):
            left = exp[1]
            right = exp[2]

        if op == "and":
            left_mask = to_mask(left)

            if left_mask:
                (m1, m2) = left_mask
                exp = mask_op(right, m1, m2)

            else:  # could be 'elif to_mask(right)', but that's slower bc we have to call to_mask twice then
                right_mask = to_mask(right)

                if right_mask:
                    (m1, m2) = right_mask
                    exp = mask_op(left, m1, m2)

                elif to_neg_mask(left):
                    bounds = to_neg_mask(left)
                    exp = neg_mask_op(right, *bounds)

                elif to_neg_mask(right):
                    bounds = to_neg_mask(right)
                    exp = neg_mask_op(left, *bounds)

        elif op == "div" and len(exp) == 3 and to_exp2(right):
            shift = to_exp2(right)
            exp = mask_op(left, size=256 - shift, offset=shift, shr=shift)

        elif op == "mul" and len(exp) == 3 and to_exp2(left):
            shift = to_exp2(left)
            exp = mask_op(right, size=256 - shift, shl=shift)

        elif op == "mul" and len(exp) == 3 and to_exp2(right):
            shift = to_exp2(right)
            exp = mask_op(left, size=256 - shift, shl=shift)

        return exp

    def cleanup(self):

        stack = self.stack

        for i, s in enumerate(stack):
            if type(stack[i]) == tuple:
                if s[0] == "lt" and type(s[1]) == int and type(s[2]) == int:
                    if s[1] < s[2]:
                        stack[i] = ("bool", 1)
                    else:
                        stack[i] = ("bool", 0)

                elif s[0] == "iszero" and type(s[1]) == int:
                    if s[1] == 0:
                        stack[i] = ("bool", 1)
                    else:
                        stack[i] = ("bool", 0)

                elif (
                    s[0] == "iszero" and opcode(s[1]) == "bool" and type(s[1][1]) == int
                ):
                    stack[i] = ("bool", 1 - s[1][1])

                elif stack[i][0] == "iszero" and opcode(stack[i][1]) == "iszero":
                    if opcode(stack[i][1][1]) in (
                        "iszero",
                        "eq",
                        "lt",
                        "gt",
                        "slt",
                        "sgt",
                    ):
                        stack[i] = stack[i][1][1]
                    else:
                        stack[i] = ("bool", stack[i][1][1])
