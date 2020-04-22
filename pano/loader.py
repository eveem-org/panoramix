import json
import logging
import os.path
import traceback

from pano.matcher import match
from utils.helpers import (
    COLOR_GRAY,
    ENDC,
    EasyCopy,
    assure_dir_exists,
    colorize,
    find_f,
    find_f_list,
    padded_hex,
    pretty_bignum,
)
from utils.opcode_dict import opcode_dict
from utils.profiler import checkpoint
from utils.signatures import get_func_name, make_abi
from utils.supplement import fetch_sig

logger = logging.getLogger(__name__)

cache_sigs = {
    True: {},
    False: {},
}


def code_fetch(address, network="mainnet"):
    assert (
        network == "mainnet"
    ), "only mainnet supported, but you can set WEB3_PROVIDER_URI to whatever node you want on whatever network"

    from web3.auto import w3

    code = w3.eth.getCode(address).hex()[2:]

    return code


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

        self.addr = None
        self.binary = None

    def load(self, this_addr):
        if len(this_addr) > 30:
            self.load_addr(this_addr)
        else:
            self.load_stdin(this_addr)

    def load_stdin(self, hash_id):
        assure_dir_exists("cache_stdin")

        fname = f"cache_stdin/{hash_id}.bin"
        address = hash_id
        self.addr = hash_id
        with open(fname) as f:
            code = f.read()
            self.network = "stdin"

        self.load_binary(code)

    def load_addr(self, address):
        if address == address.lower():
            logger.warning(
                "Address not checksummed. Fixed, but needed to import web3 (+0.6s exec time)"
            )
            from web3 import Web3  # only here, because Web3

            address = Web3.toChecksumAddress(address)

        self.addr = address

        fname = None
        code = None

        dir_name = "cache_code/" + address[:5] + "/"

        assure_dir_exists(dir_name)

        cache_fname = f"{dir_name}{address}.bin"

        if address == address.lower() and os.path.isfile(cache_fname.lower()):
            print(
                "addr not checksummed, but found a checksummed one in cache, using that one"
            )
            cache_fname = cache_fname.lower()

        if os.path.isfile(cache_fname):
            logger.info("Code for %s found in cache...", address)

            with open(cache_fname) as source_file:
                code = source_file.read()
                self.network = "mainnet"

        else:
            logger.info("Fetching code for %s...", address)

            code = ""
            for network in "mainnet", "goerli", "ropsten", "kovan", "rinkeby":
                code = code_fetch(address, network)
                if len(code) > 0:
                    self.network = network
                    break
            else:
                self.network = "none"

            with open(cache_fname, "w+") as f:
                f.write(code)

            fname = cache_fname

        self.load_binary(code)

    def run(self, vm):
        assert self.binary is not None, "Did you run load_*() first?"

        try:
            # decompiles the code, starting from location 0
            # and running VM in a special mode that returns 'funccall'
            # in places where it looks like there is a func call

            trace = vm.run(0)

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

        abi = make_abi(self.hash_targets)
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
