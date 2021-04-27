import logging
import sys
from copy import copy

import core.arithmetic as arithmetic
import utils.opcode_dict as opcode_dict
from core.algebra import (
    add_op,
    bits,
    lt_op,
    mask_op,
    minus_op,
    mul_op,
    or_op,
    sub_op,
    to_bytes,
)
from core.arithmetic import is_zero, simplify_bool
from pano.matcher import match
from pano.prettify import pprint_trace
from utils.helpers import (
    C,
    EasyCopy,
    all_concrete,
    opcode,
    precompiled,
    precompiled_var_names,
)

from .stack import Stack, fold_stacks

loader_dests = None
logger = logging.getLogger(__name__)


"""

    A symbolic EVM.

    It executes the contract, and returns the resulting `trace` of execution - which is the decompiled form.


    The most difficult part of this module is the loop detection and simplification algorithm.
    In over 10 iterations I didn't find a simpler way that is just as effective.

    Unfortunately, because of the complexity, I don't fully understand how it works.
    Ergo, I cannot explain it to you :) Good luck!

    On the upside, some stuff, like apply_stack is quite straightforward.

"""


def mem_load(pos, size=32):
    return ("mem", ("range", pos, size))


def find_nodes(node, f):
    assert type(node) == Node

    if f(node):
        res = [node]
    else:
        res = []

    for n in node.next:
        res.extend(find_nodes(n, f))

    return res


node_count = 0


class Node:
    def __str__(self):
        return f"Node({self.jd})"

    def __repr__(self):
        # technically not a proper _repr_, but some trace printout functions use this
        # instead of a proper str
        return self.__str__()

    def __init__(self, vm, start, safe, stack, condition=True, trace=None):
        global node_count

        node_count += 1
        #        if node_count % 1000 == 0:
        #            print(node_count)

        if node_count > 100_000:
            raise RuntimeError("Too many nodes / function too big.")

        self.vm = vm
        self.prev = []
        self.next = []
        self.trace = trace
        self.start = start
        self.safe = safe
        self.stack = stack
        self.history = {}
        self.depth = 0
        self.label_history = {}
        self.label = None

        self.condition = condition

        stack_obj = Stack(stack)
        self.jd = (start, len(stack), tuple(stack_obj.jump_dests(loader_dests)))

    def apply_vars(var_list):
        for orig_name, new_name in var_list:
            assert match(orig_name, ("var", ":name"))
            assert match(new_name, ("var", int))

            self.trace = replace(self.trace, orig_name, new_name)

            for n in self.next:
                n.apply_vars(var_list)

    def make_trace(self):
        if self.trace is None:
            return ["nil"]

        begin_vars = []
        if self.is_label():
            for _, var_idx, var_val, _ in self.label.begin_vars:
                begin_vars.append(("setvar", var_idx, var_val))

        if self.vm.just_fdests and self.trace != [("revert", 0)]:
            t = self.trace[0]
            if match(t, ("jump", ":target_node", ...)):
                begin = [("jd", str(self.jd[0]))]  # , str(self.trace))]
            else:
                begin = ["?"]
        else:
            begin = []

        begin += [("label", self, tuple(begin_vars))] if self.is_label() else []

        last = self.trace[-1]

        if opcode(last) == "jump":
            return begin + self.trace[:-1] + last[1].make_trace()

        if m := match(last, ("if", ":cond", ":if_true", ":if_false")):
            if_true = m.if_true.make_trace()
            if_false = m.if_false.make_trace()
            return begin + self.trace[:-1] + [("if", m.cond, if_true, if_false)]

        return begin + self.trace

    def set_label(self, loop_dest, vars, stack):
        self.label = loop_dest
        loop_dest.begin_vars = vars

        assert len(self.stack) == len(stack)
        self.stack = stack
        loop_dest.prev_trace = loop_dest.trace
        loop_dest.trace = [("jump", self)]
        loop_dest.next = []
        self.set_prev(loop_dest)

    def set_prev(self, prev):
        self.prev = prev
        self.depth = prev.depth + 1

        self.history = copy(prev.history)
        self.history[prev.jd] = prev

        self.label_history = copy(prev.label_history)
        if prev.label:
            self.label_history[prev.jd] = prev.label

        prev.next.append(self)

    def is_label(self):
        return self.label is not None

    def run(self):
        logger.debug("Node.run(%s)", self)
        self.prev_trace = self.trace
        self.trace = self.vm._run(self.start, self.safe, self.stack, self.condition)

        last = self.trace[-1]

        if opcode(last) == "jump":
            n = last[1]

            n.set_prev(self)

        if opcode(last) == "if":
            if_true, if_false = last[2], last[3]

            if_true.set_prev(self)
            if_false.set_prev(self)


class VM(EasyCopy):
    def __init__(self, loader, just_fdests=False):

        global loader_dests
        loader_dests = loader.jump_dests

        self.loader = loader

        # (line_no, op, param)
        self.lines = loader.lines  # a shortcut

        self.just_fdests = just_fdests

        self.counter = 0
        global node_count
        node_count = 0

    def run(self, start, history={}, condition=None, re_run=False, stack=()):

        func_node = Node(vm=self, start=start, safe=True, stack=list(stack))
        trace = [
            ("setmem", ("range", 0x40, 32), 0x60),
            ("jump", func_node, "safe", tuple()),
        ]

        root = Node(vm=self, trace=trace, start=start, safe=True, stack=list(stack))
        func_node.set_prev(root)

        """

            BFS symbolic execution, ends up with a decompiled
            code, with labels and gotos.

            Depth-first would be way easier to implement, but it tends
            to work way slower because of the loops.

        """

        for j in range(20):  # 20

            for i in range(200):  # 300
                """

                    Find all the jumps, and expand them until
                    the next jump.

                """

                self.expand_trace(root)

                """
                     find all the jumps that lead to an already
                     reached jumpdest (with similar stack, otherwise
                     we'd catch function calls as all).

                     replace them with 'loop' identifier
                """

                self.replace_loops(root)

                """
                    repeat until there are no more jumps
                    to explore (so, until the trace didn't change)

                """

                nodes = find_nodes(root, lambda n: n.trace is None)

                if len(nodes) == 0:
                    break

            trace = self.continue_loops(root)

            tr = root.make_trace()
            nodes = find_nodes(root, lambda n: n.trace is None)

            if len(nodes) == 0:
                break

        tr = root.make_trace()
        return tr

    def expand_trace(self, root):
        nodes = find_nodes(root, lambda n: n.trace is None)

        for node in nodes:
            node.run()

    def replace_loops(self, root):
        nodes = find_nodes(root, lambda n: n.trace is None)

        for node in nodes:
            if (
                node.jd in node.history
                and node.jd[1] > 0
                and len(node.history[node.jd].stack) == len(node.stack)
            ):  # jd[1] == stack_len
                folded, vars = fold_stacks(
                    node.history[node.jd].stack, node.stack, node.depth
                )
                loop_line = (
                    "loop",
                    node.history[node.jd],
                    node.stack,
                    folded,
                    tuple(vars),
                )
                node.trace = [loop_line]

    def continue_loops(self, root):

        loop_list = find_nodes(
            root,
            lambda n: n.trace is not None
            and len(n.trace) == 1
            and opcode(n.trace[0]) == "loop",
        )

        for node in loop_list:
            assert node.trace is not None
            assert len(node.trace) == 1
            assert opcode(node.trace[0]) == "loop"

            line = node.trace[0]
            loop_dest, stack, new_stack, vars = line[1:]

            if loop_dest.is_label():
                old_stack = loop_dest.stack
                beginvars = loop_dest.label.begin_vars
                set_vars = []

                for _, var_idx, val, stack_pos in beginvars:
                    sv = ("setvar", var_idx, stack[stack_pos])
                    set_vars.append(sv)

                if len(list(set_vars)) == 0:
                    folded, var_list = fold_stacks(
                        old_stack, stack, loop_dest.label.depth
                    )
                    node.trace = None
                    node.set_label(loop_dest, tuple(var_list), folded)
                    continue

                node.trace = [("goto", loop_dest, tuple(set_vars))]

            else:
                node.trace = None
                node.set_label(loop_dest, tuple(vars), new_stack)

    def _run(self, start, safe, stack, condition):
        logger.debug("VM._run stack=%s", stack)
        self.stack = Stack(stack)
        trace = []

        i = start
        lines = self.lines

        if i not in lines:
            if type(i) != int:
                return [("undefined", "remco jump", i)]
            else:
                return [("invalid", "jumdest", i)]

        if not safe:
            if lines[i][1] == "jumpdest":
                i = self.loader.next_line(i)
                if i not in lines:
                    return [("invalid", "eof?")]
            else:
                return [("invalid", "jump")]

        while True:
            line = lines[i]

            res = self.handle_jumps(trace, line, condition)
            if res is not None:
                return res

            if line[1] == "jumpdest":
                n = Node(
                    self,
                    start=i,
                    safe=False,
                    stack=tuple(self.stack.stack),
                    condition=condition,
                )
                logger.debug("jumpdest %s", n)
                trace.append(("jump", n))
                return trace

            else:
                self.apply_stack(trace, line)

            i = self.loader.next_line(i)

        assert False

    def handle_jumps(self, trace, line, condition):

        i, op = line[0], line[1]
        stack = self.stack

        if "--explain" in sys.argv and op in (
            "jump",
            "jumpi",
            "selfdestruct",
            "stop",
            "return",
            "invalid",
            "assert_fail",
            "revert",
        ):
            trace.append(C.asm(f"       {stack}"))
            trace.append("")
            trace.append(f"[{line[0]}] {C.asm(op)}")

        if op in (
            "jump",
            "jumpi",
            "selfdestruct",
            "stop",
            "return",
            "invalid",
            "assert_fail",
            "revert",
        ):
            logger.debug("[%s] %s", i, op)

        if op == "jump":
            target = stack.pop()

            n = Node(
                self,
                start=target,
                safe=False,
                stack=tuple(self.stack.stack),
                condition=condition,
            )

            trace.append(("jump", n))
            return trace

        elif op == "jumpi":
            target = stack.pop()
            if_condition = simplify_bool(stack.pop())

            tuple_stack = tuple(self.stack.stack)
            n_true = Node(
                self,
                start=target,
                safe=False,
                stack=tuple_stack,
                condition=if_condition,
            )
            n_false = Node(
                self,
                start=self.loader.next_line(i),
                safe=True,
                stack=tuple_stack,
                condition=is_zero(if_condition),
            )

            if self.just_fdests:
                if (
                    (m := match(if_condition, ("eq", ":fx_hash", ":is_cd")))
                    and str(("cd", 0)) in str(m.is_cd)
                    and isinstance(m.fx_hash, int)
                ):
                    n_true.trace = [("funccall", m.fx_hash, target, tuple_stack)]
                if (
                    (m := match(if_condition, ("eq", ":is_cd", ":fx_hash")))
                    and str(("cd", 0)) in str(m.is_cd)
                    and isinstance(m.fx_hash, int)
                ):
                    n_true.trace = [("funccall", m.fx_hash, target, tuple_stack)]

            if_true = ("jump", n_true)
            if_false = ("jump", n_false)

            bool_condition = arithmetic.eval_bool(
                if_condition, condition, symbolic=False
            )

            if bool_condition is not None:
                if bool_condition:
                    trace.append(("jump", n_true))
                    return trace  # res, False

                else:
                    trace.append(("jump", n_false))
                    return trace

            trace.append(("if", if_condition, n_true, n_false,))
            logger.debug("jumpi -> if %s", trace[-1])
            return trace

        elif op in ["return", "revert"]:
            p = stack.pop()
            n = stack.pop()

            if n == 0:
                trace.append((op, 0))
            else:
                return_data = mem_load(p, n)
                trace.append((op, return_data,))

            return trace

        elif op in ["stop", "assert_fail", "invalid"]:
            trace.append((op,))
            return trace

        elif op == "UNKNOWN":
            trace.append(("invalid",))
            return trace

        elif op == "selfdestruct":
            trace.append(("selfdestruct", stack.pop(),))
            return trace

        return None

    def apply_stack(self, ret, line):
        def trace(exp, *format_args):
            try:
                logger.debug("Trace: %s", str(exp).format(*format_args))
            except Exception:
                pass

            if type(exp) == str:
                ret.append(exp.format(*format_args))
            else:
                ret.append(exp)

        stack = self.stack

        op = line[1]

        previous_len = stack.len()

        if "--verbose" in sys.argv or "--explain" in sys.argv:
            trace(C.asm("       " + str(stack)))
            trace("")

            if "push" not in op and "dup" not in op and "swap" not in op:
                trace("[{}] {}", line[0], C.asm(op))
            else:
                if type(line[2]) == str:
                    trace("[{}] {} {}", line[0], C.asm(op), C.asm(" ”" + line[2] + "”"))
                elif line[2] > 0x1000000000:
                    trace("[{}] {} {}", line[0], C.asm(op), C.asm(hex(line[2])))
                else:
                    trace("[{}] {} {}", line[0], C.asm(op), C.asm(str(line[2])))

        param = 0
        if len(line) > 2:
            param = line[2]

        if op in [
            "exp",
            "and",
            "eq",
            "div",
            "lt",
            "gt",
            "slt",
            "sgt",
            "mod",
            "xor",
            "signextend",
            "smod",
            "sdiv",
        ]:
            stack.append(arithmetic.eval((op, stack.pop(), stack.pop(),)))

        elif op[:4] == "push":
            stack.append(param)

        elif op == "pop":
            stack.pop()

        elif op == "dup":
            stack.dup(param)

        elif op == "mul":
            stack.append(mul_op(stack.pop(), stack.pop()))

        elif op == "or":
            stack.append(or_op(stack.pop(), stack.pop()))

        elif op == "add":
            stack.append(add_op(stack.pop(), stack.pop()))

        elif op == "sub":
            left = stack.pop()
            right = stack.pop()

            if type(left) == int and type(right) == int:
                stack.append(arithmetic.sub(left, right))
            else:
                stack.append(sub_op(left, right))

        elif op in ["not", "iszero"]:
            stack.append((op, stack.pop()))

        elif op == "shl":
            off = stack.pop()
            exp = stack.pop()
            if all_concrete(off, exp):
                stack.append(exp << off)
            else:
                stack.append(mask_op(exp, shl=off))

        elif op == "shr":
            off = stack.pop()
            exp = stack.pop()
            if all_concrete(off, exp):
                stack.append(exp >> off)
            else:
                stack.append(mask_op(exp, offset=minus_op(off), shr=off))

        elif op == "sar":
            off = stack.pop()
            exp = stack.pop()
            if all_concrete(off, exp):
                sign = exp & (1 << 255)
                if off >= 256:
                    if sign:
                        stack.append(2 ** 256 - 1)
                    else:
                        stack.append(0)
                else:
                    shifted = exp >> off
                    if sign:
                        shifted |= (2 ** 256 - 1) << (256 - off)
                    stack.append(shifted)
            else:
                # FIXME: This won't give the right result...
                stack.append(mask_op(exp, offset=minus_op(off), shr=off))

        elif op == "mstore":
            memloc = stack.pop()
            val = stack.pop()
            trace(("setmem", ("range", memloc, 32), val,))

        elif op == "msize":
            self.counter += 1
            vname = f"_{self.counter}"
            trace(("setvar", vname, "msize"))
            stack.append(("var", vname))

        elif op == "mload":
            memloc = stack.pop()
            loaded = mem_load(memloc)

            self.counter += 1
            vname = f"_{self.counter}"
            trace(("setvar", vname, ("mem", ("range", memloc, 32))))
            stack.append(("var", vname))

        elif op == "sha3":
            p = stack.pop()
            n = stack.pop()
            res = mem_load(p, n)

            self.counter += 1
            vname = f"_{self.counter}"
            vval = (
                "sha3",
                res,
            )

            trace(("setvar", vname, vval))
            stack.append(("var", vname))

        elif op == "calldataload":
            stack.append(("cd", stack.pop(),))

        elif op == "byte":
            val = stack.pop()
            num = stack.pop()
            off = sub_op(256, to_bytes(num))
            stack.append(mask_op(val, 8, off, shr=off))

        elif op == "balance":
            addr = stack.pop()
            if opcode(addr) == "mask_shl" and addr[:4] == ("mask_shl", 160, 0, 0):
                stack.append(("balance", addr[4],))
            else:
                stack.append(("balance", addr,))

        elif op in [
            "callvalue",
            "caller",
            "address",
            "number",
            "gas",
            "origin",
            "timestamp",
            "chainid",
            "difficulty",
            "gasprice",
            "coinbase",
            "gaslimit",
            "calldatasize",
            "returndatasize",
        ]:
            stack.append(op)

        elif op == "swap":
            stack.swap(param)

        elif op == "selfbalance":
            stack.append(("balance", "address",))

        elif op[:3] == "log":
            p = stack.pop()
            s = stack.pop()
            topics = []
            param = int(op[3])
            for i in range(param):
                el = stack.pop()
                topics.append(el)

            trace(("log", mem_load(p, s),) + tuple(topics))

        elif op == "sload":
            sloc = stack.pop()
            stack.append(("storage", 256, 0, sloc))

        elif op == "sstore":
            sloc = stack.pop()
            val = stack.pop()
            trace(("store", 256, 0, sloc, val))

        elif op == "extcodecopy":
            addr = stack.pop()
            mem_pos = stack.pop()
            code_pos = stack.pop()
            data_len = stack.pop()

            trace(
                (
                    "setmem",
                    ("range", mem_pos, data_len),
                    ("extcodecopy", addr, ("range", code_pos, data_len)),
                )
            )

        elif op == "codecopy":
            mem_pos = stack.pop()
            call_pos = stack.pop()
            data_len = stack.pop()

            if (type(call_pos), type(data_len)) == (
                int,
                int,
            ) and call_pos + data_len < len(self.loader.binary):
                res = 0
                for i in range(call_pos - 1, call_pos + data_len - 1):
                    res = res << 8
                    res += self.loader.binary[
                        i
                    ]  # this breaks with out of range for some contracts
                    # may be because we're usually getting compiled code binary
                    # and not runtime binary
                trace(
                    ("setmem", ("range", mem_pos, data_len), res)
                )  # ('bytes', data_len, res)))

            else:
                trace(
                    (
                        "setmem",
                        ("range", mem_pos, data_len),
                        ("code.data", call_pos, data_len,),
                    )
                )

        elif op == "codesize":
            stack.append(len(self.loader.binary))

        elif op == "calldatacopy":
            mem_pos = stack.pop()
            call_pos = stack.pop()
            data_len = stack.pop()

            if data_len != 0:
                call_data = ("call.data", call_pos, data_len)
                #                call_data = mask_op(('call.data', bits(add_op(data_len, call_pos))), size=bits(data_len), shl=bits(call_pos))
                trace(("setmem", ("range", mem_pos, data_len), call_data))

        elif op == "returndatacopy":
            mem_pos = stack.pop()
            ret_pos = stack.pop()
            data_len = stack.pop()

            if data_len != 0:
                return_data = ("ext_call.return_data", ret_pos, data_len)
                #                return_data = mask_op(('ext_call.return_data', bits(add_op(data_len, ret_pos))), size=bits(data_len), shl=bits(ret_pos))
                trace(("setmem", ("range", mem_pos, data_len), return_data))

        elif op == "call":
            self.handle_call(op, trace)

        elif op == "staticcall":
            self.handle_call(op, trace)

        elif op == "delegatecall":
            gas = stack.pop()
            addr = stack.pop()

            arg_start = stack.pop()
            arg_len = stack.pop()
            ret_start = stack.pop()
            ret_len = stack.pop()

            call_trace = (
                "delegatecall",
                gas,
                addr,
            )  # arg_start, arg_len, ret_start, ret_len)

            if arg_len == 0:
                fname = None
                fparams = None

            elif arg_len == 4:
                fname = mem_load(arg_start, 4)
                fparams = 0

            else:
                fname = mem_load(arg_start, 4)
                fparams = mem_load(add_op(arg_start, 4), sub_op(arg_len, 4))

            call_trace += (fname, fparams)

            trace(call_trace)

            self.call_len = ret_len
            stack.append("delegate.return_code")

            if 0 != ret_len:
                return_data = ("delegate.return_data", 0, ret_len)

                trace(("setmem", ("range", ret_start, ret_len), return_data))

        elif op == "callcode":
            gas = stack.pop()
            addr = stack.pop()
            value = stack.pop()

            arg_start = stack.pop()
            arg_len = stack.pop()
            ret_start = stack.pop()
            ret_len = stack.pop()

            call_trace = (
                "callcode",
                gas,
                addr,
                value,
            )

            if arg_len == 0:
                fname = None
                fparams = None

            elif arg_len == 4:
                fname = mem_load(arg_start, 4)
                fparams = 0

            else:
                fname = mem_load(arg_start, 4)
                fparams = mem_load(add_op(arg_start, 4), sub_op(arg_len, 4))

            call_trace += (fname, fparams)

            trace(call_trace)

            self.call_len = ret_len
            stack.append("callcode.return_code")

            if 0 != ret_len:
                return_data = ("callcode.return_data", 0, ret_len)

                trace(("setmem", ("range", ret_start, ret_len), return_data))

        elif op == "create":
            wei, mem_start, mem_len = stack.pop(), stack.pop(), stack.pop()

            call_trace = ("create", wei)

            code = mem_load(mem_start, mem_len)
            call_trace += (code,)

            trace(call_trace)

            stack.append("create.new_address")

        elif op == "create2":
            wei, mem_start, mem_len, salt = (
                stack.pop(),
                stack.pop(),
                stack.pop(),
                stack.pop(),
            )

            call_trace = ("create2", wei, ("mem", ("range", mem_start, mem_len)), salt)

            trace(call_trace)

            stack.append("create2.new_address")

        elif op in ("extcodesize", "extcodehash", "blockhash"):
            stack.append((op, stack.pop(),))

        elif op in ["mulmod", "addmod"]:
            stack.append(("mulmod", stack.pop(), stack.pop(), stack.pop()))

        elif op == "pc":
            stack.append(line[0])

        elif op == "mstore8":
            memloc = stack.pop()
            val = stack.pop()

            trace(("setmem", ("range", memloc, 8), val,))

        else:
            assert op not in [
                "jump",
                "jumpi",
                "revert",
                "return",
                "stop",
                "jumpdest",
                "UNKNOWN",
            ]

        if stack.len() - previous_len != opcode_dict.stack_diffs[op]:
            logger.error("line: %s", line)
            logger.error("stack: %s", stack)
            logger.error(
                "expected %s, got %s stack diff",
                opcode_dict.stack_diffs[op],
                stack.len() - previous_len,
            )
            assert False, f"opcode {op} not processed correctly"

        stack.cleanup()

    def handle_call(self, op, trace):
        stack = self.stack

        gas = stack.pop()
        addr = stack.pop()
        if op == "call":
            wei = stack.pop()
        else:
            assert op == "staticcall"
            wei = 0

        arg_start = stack.pop()
        arg_len = stack.pop()
        ret_start = stack.pop()
        ret_len = stack.pop()

        if addr == 4:  # Identity

            m = mem_load(arg_start, arg_len)
            trace(("setmem", ("range", ret_start, arg_len), m))

            stack.append("memcopy.success")

        elif type(addr) == int and addr in precompiled:

            m = mem_load(arg_start, arg_len)
            args = mem_load(arg_start, arg_len)
            var_name = precompiled_var_names[addr]

            trace(("precompiled", var_name, precompiled[addr], args))
            trace(("setmem", ("range", ret_start, ret_len), ("var", var_name)))

            stack.append("{}.result".format(precompiled[addr]))

        else:
            assert op in ("call", "staticcall")
            call_trace = (
                op,
                gas,
                addr,
                wei,
            )

            if arg_len == 0:
                call_trace += None, None

            elif arg_len == 4:

                call_trace += mem_load(arg_start, 4), None

            else:
                fname = mem_load(arg_start, 4)
                fparams = mem_load(add_op(arg_start, 4), sub_op(arg_len, 4))
                call_trace += fname, fparams

            trace(call_trace)
            #           trace(('comment', mem_load(arg_start, arg_len)))

            self.call_len = ret_len

            stack.append("ext_call.success")

            if lt_op(0, ret_len):
                return_data = ("ext_call.return_data", 0, ret_len)
                trace(("setmem", ("range", ret_start, ret_len), return_data))
