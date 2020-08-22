import json
import logging
import os
import os.path
import traceback

from panoramix.matcher import match
from panoramix.utils.helpers import (
    COLOR_GRAY,
    ENDC,
    EasyCopy,
    colorize,
    find_f,
    find_f_list,
    padded_hex,
    pretty_bignum,
    cache_dir,
)
from panoramix.utils.opcode_dict import opcode_dict
from panoramix.utils.signatures import get_func_name, make_abi
from panoramix.utils.supplement import fetch_sig

logger = logging.getLogger(__name__)

cache_sigs = {
    True: {},
    False: {},
}

LOADER_TIMEOUT = 60


class Loader(EasyCopy):
    signatures = {}

    lines = {}  # global, let's assume one loader for now
    binary = []  # array of ints, each int represents a byte in the source file

    @staticmethod
    def find_sig(sig, add_color=False):
        if "???" in sig:
            return None

        if sig in Loader.signatures:
            if "unknown" not in Loader.signatures[sig]:
                return Loader.signatures[sig]

        if sig in cache_sigs[add_color]:
            return cache_sigs[add_color][sig]

        if len(sig) < 8:
            return None

        a = fetch_sig(sig)
        if a is None:
            return None

        # duplicate of get_func_name from signatures
        if "params" in a:
            res = "{}({})".format(
                a["name"],
                ", ".join(
                    [
                        colorize(x["type"], COLOR_GRAY, add_color) + " " + x["name"][1:]
                        for x in a["params"]
                    ]
                ),
            )
        else:
            res = a["folded_name"]

        cache_sigs[add_color][sig] = res
        return res

    def __init__(self):
        self.last_line = None
        self.jump_dests = []
        self.func_dests = {}  # func_name -> jumpdest
        self.hash_targets = {}  # hash -> (jumpdest, stack)
        self.func_list = []

        self.binary = None

    def load_addr(self, address):
        assert address.isalnum()
        address = address.lower()

        dir_ = cache_dir() / "code" / address[:5]
        if not dir_.is_dir():
            dir_.mkdir(parents=True)

        cache_fname = dir_ / f"{address}.bin"

        if cache_fname.is_file():
            logger.info("Code for %s found in cache...", address)
            with cache_fname.open() as source_file:
                code = source_file.read().strip()
        else:
            logger.info("Fetching code for %s...", address)
            from web3 import Web3
            from web3.auto import w3

            code = w3.eth.getCode(Web3.toChecksumAddress(address)).hex()[2:]
            if code:
                with cache_fname.open("w+") as f:
                    f.write(code)

        self.load_binary(code)

    def run(self, vm):
        assert self.binary is not None, "Did you run load_*() first?"

        try:
            # decompiles the code, starting from location 0
            # and running VM in a special mode that returns 'funccall'
            # in places where it looks like there is a func call

            trace = vm.run(0, timeout=LOADER_TIMEOUT)

            def func_calls(exp):
                if m := match(exp, ("funccall", ":fx_hash", ":target", ":stack")):
                    return [(m.fx_hash, m.target, m.stack)]
                else:
                    return []

            func_list = find_f_list(trace, func_calls)

            for fx_hash, target, stack in func_list:
                self.add_func(target=target, hash=fx_hash, stack=stack)

            # find default

            def find_default(exp):

                if (m := match(exp, ("if", ":cond", ":if_true", ":if_false"))) and str(
                    ("cd", 0)
                ) in str(m.cond):
                    if find_f_list(m.if_false, func_calls) == []:
                        fi = m.if_false[0]
                        if m2 := match(fi, ("jd", ":jd")):
                            return int(m2.jd)

                    if find_f_list(m.if_true, func_calls) == []:
                        fi = m.if_true[0]
                        if m2 := match(fi, ("jd", ":jd")):
                            return int(m2.jd)

            default = find_f(trace, find_default) if func_list else None
            self.add_func(default or 0, name="_fallback()")

        except Exception:
            logger.exception("Loader issue.")
            self.add_func(0, name="_fallback()")

        make_abi(self.hash_targets)
        for hash, (target, stack) in self.hash_targets.items():
            fname = get_func_name(hash)
            self.func_list.append((hash, fname, target, stack))

    def next_line(self, i):
        i += 1
        while i not in self.lines and self.last_line > i:
            i += 1

        if i <= self.last_line:
            return i
        else:
            return None

    def add_func(self, target, hash=None, name=None, stack=()):

        assert hash is not None or name is not None  # we need at least one
        assert not (hash is not None and name is not None)  # we don't want both

        if hash is not None:
            padded = padded_hex(hash, 8)  # lines[i-12][2]
            if padded in self.signatures:
                name = self.signatures[padded]
            else:
                name = "unknown_{}(?????)".format(padded)
                self.signatures[padded] = name

        if hash is None:
            self.hash_targets[name] = target, stack
        else:
            self.hash_targets[padded_hex(hash, 8)] = target, stack

        self.func_dests[name] = target

    def disasm(self):
        for line_no, op, param in self.parsed_lines:
            yield f"{hex(line_no)}, {op}, {hex(param) if param is not None else ''}"

    def load_binary(self, source):
        stack = []
        self.binary = []

        if source[:2] == "0x":
            source = source[2:]

        while len(source[:2]) > 0:
            num = int("0x" + source[:2], 16)
            self.binary.append(num)
            stack = [num] + stack
            source = source[2:]

        line = 0

        parsed_lines = []

        while len(stack) > 0:
            popped = stack.pop()

            orig_line = line

            if popped not in opcode_dict:
                op = "UNKNOWN"
                param = popped

            else:
                param = None
                op = opcode_dict[popped]

                if op == "jumpdest":
                    self.jump_dests.append(line)

                if op[:4] == "push":
                    num_words = int(op[4:])

                    param = 0
                    for i in range(num_words):
                        try:
                            param = param * 0x100 + stack.pop()
                            line += 1
                        except Exception:
                            break

            parsed_lines.append((orig_line, op, param))
            line += 1

        self.parsed_lines = parsed_lines
        self.last_line = line
        self.lines = {}

        for line_no, op, param in parsed_lines:
            if op[:4] == "push" and param > 1000000000000000:
                param = pretty_bignum(
                    param
                )  # convert big numbers into strings if possibble
                # should be moved to prettify really

            if op[:3] == "dup":
                param = int(op[3:])
                op = "dup"

            if op[:4] == "swap":
                param = int(op[4:])
                op = "swap"

            self.lines[line_no] = (line_no, op, param)

        return self.lines
