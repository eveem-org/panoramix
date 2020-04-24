#
#   This is Panoramix.
#

import json
import logging
import os
import sys
import traceback
from contextlib import redirect_stdout

import coloredlogs
import timeout_decorator

import pano.folder as folder
from pano.contract import Contract
from pano.function import Function
from pano.loader import Loader
from pano.prettify import explain, pprint_repr, pprint_trace, pretty_type
from pano.vm import VM
from pano.whiles import make_whiles
from utils.helpers import C, cache_fname, rewrite_trace

if (sys.version_info[0], sys.version_info[1]) < (3, 8):
    print()
    print(
        f"  Panoramix requires python3.8, not python{sys.version_info[0]}.{sys.version_info[1]}"
    )
    print()
    print("  Sorry about that, but there was no way to do all of this in Python<3.8")
    print()
    # 3.8 requirement is a bit painful, but this was the only way to implement Tilde
    # and Tilde gives a custom pattern matching syntax that makes a ton of code simpler.

    exit()


logger = logging.getLogger(__name__)

if "--verbose" in sys.argv:
    log_level = logging.DEBUG
elif "--silent" in sys.argv:
    log_level = logging.CRITICAL
elif "--errors" in sys.argv:
    log_level = logging.ERROR
else:
    log_level = logging.INFO

logging.getLogger("pano.matcher").setLevel(logging.INFO)

coloredlogs.install(
    level=log_level,
    fmt="%(asctime)s %(name)s %(message)s",
    datefmt="%H:%M:%S",
    field_styles={"asctime": {"color": "white", "faint": True}},
)


VER = "17 Feb 2020"

addr_shortcuts = {
    "kitties": "0x06012c8cf97BEaD5deAe237070F9587f8E7A266d",
    # main contract for testing - most of the common edge cases here
    "mixgenes": "0xf97e0A5b616dfFC913e72455Fde9eA8bBe946a2B",
    # the convoluted one people can't decompile
    "etherdelta": "0x8d12A197cB00D4747a1fe03395095ce2A5CC6819",
    "ledger": "0xf91546835f756DA0c10cFa0CDA95b15577b84aA7",
    "solidstamp": "0x165cfb9ccf8b185e03205ab4118ea6afbdba9203",
    # a basic contract - not too complex, not too simple
    # with some edge cases
    "buggy": "0x6025F65f6b2f93d8eD1efeDc752acfd4bdbCec3E",
    # weird results in approveAndCall
    # and storage getters (allowance) seem badly processed
    "sweeper": "0x53F955c424F1378D67Bb5e05F728476dC75fB4bA",
    # a small contract, useful for testing dynamic memory
    "zrx": "0x4f833a24e1f95d70f028921e27040ca56e09ab0b",
    # fails a lot, because of all the complicated data structures
    "ctf": "0x68cb858247ef5c4a0d0cde9d6f68dce93e49c02a",
    # https://medium.com/consensys-diligence/consensys-diligence-ether-giveaway-1-4985627b7726
    "ctf2": "0xefa51bc7aafe33e6f0e4e44d19eab7595f4cca87",
    # https://medium.com/consensys-diligence/consensys-diligence-ethereum-hacking-challenge-2-bf3dfff639e0
    # selfdestructed, if you see empty results, you need to find the old version
    "unicorn": "0x89205A3A3b2A69De6Dbf7f01ED13B2108B2c43e7",
    # EF's unicorn token. a basic token that has symbol() and name()
    "loops": "0xe2F42B417337fd9fD22631cad54DB8178655Fcd1",
    # many nice kinds of loops
    "ferlan": "0x7b220AC85B7ae8Af1CECCC44e183A862dA2eD517",
    # a ctx with modern solidity, bst dispatch and multiple edge cases
    "ugly": "0x06a6a7aF298129E3a2AB396c9C06F91D3C54aBA8",
    "dao": "0xF835A0247b0063C04EF22006eBe57c5F11977Cc4",
}


"""

    Main decompilation code

"""


def decompile(this_addr, only_func_name=None):

    """

        But the main decompilation process looks like this:

            loader = Loader()
            loader.load(this_addr)

        loader.lines contains disassembled lines now

            loader.run(VM(loader, just_fdests=True))

        After this, loader.func_list contains a list of functions and their locations in the contract.
        Passing VM here is a pretty ugly hack, sorry about it.

            trace = VM(loader).run(target)

        Trace now contains the decompiled code, starting from target location.
        you can do pprint_repr or pprint_logic to see how it looks

            trace = make_whiles(trace)

        This turns gotos into whiles
        then it simplifies the code.
        (should be two functions really)

            functions[hash] = Function(hash, trace)

        Turns trace into a Function class.
        Function class constructor figures out it's kind (e.g. read-only, getter, etc),
        and some other things.

            contract = Contract(addr=this_addr,
                                network=loader.network,
                                ver=VER,
                                problems=problems,
                                functions=functions)

        Contract is a class containing all the contract decompiled functions and some other data.

            contract.postprocess()

        Figures out storage structure (you have to do it for the whole contract at once, not function by function)
        And folds the trace (that is, changes series of ifs into simpler forms)

        Finally...

            loader.disasm() -- contains disassembled version
            contract.json() -- contains json version of the contract

        Decompiled, human-readable version of the contract is done within this .py file,
        starting from `with redirect_stdout...`


        To anyone going into this code:
            - yes, it is chaotic
            - yes, there are way too many interdependencies between some modules
            - this is the first decompiler I've written in my life :)

    """

    if "--fast" not in sys.argv:
        from web3 import Web3  # web3 adds 0.5s to execution time

        this_addr = Web3.toChecksumAddress(this_addr)

    """
        Fetch code from Web3, and disassemble it.

        Loader holds the disassembled line by line code,
        and the list of functions within the contract.
    """

    loader = Loader()
    loader.load(this_addr)
    loader.run(VM(loader, just_fdests=True))

    if len(loader.lines) == 0:
        this_fname = cache_fname(this_addr, "pan")
        f = open(this_fname, "w")
        with redirect_stdout(f):
            print()
            print(C.gray + "#")
            print(f"#  Panoramix {VER} ")
            print("#  Address " + C.end + loader.addr + C.gray)
            print("# ")
            print("#  There seems to be no bytecode for this address. ")
            print("#  It's either not a contract, or it's been destroyed.")
            print("#  ")
            print("#  If you think it's an error, e-mail kolinko@gmail.com ")
            print("# " + C.end)

        f.close()

        if "--silent" not in sys.argv:
            print(open(this_fname).read())

        return

    """

        Main decompilation loop

    """

    problems = {}
    functions = {}

    for (hash, fname, target, stack) in loader.func_list:
        """
            hash contains function hash
            fname contains function name
            target contains line# for the given function
        """

        if only_func_name is not None and not fname.startswith(only_func_name):
            # if user provided a function_name in command line,
            # skip all the functions that are not it
            continue

        logger.info(f"Parsing %s...", fname)
        logger.debug("stack %s", stack)

        try:
            if target > 1 and loader.lines[target][1] == "jumpdest":
                target += 1

            @timeout_decorator.timeout(120, use_signals=True)
            def dec():
                trace = VM(loader).run(target, stack=stack)
                explain("Initial decompiled trace", trace[1:])

                if "--explain" in sys.argv:
                    trace = rewrite_trace(
                        trace, lambda line: [] if type(line) == str else [line]
                    )
                    explain("Without assembly", trace)

                trace = make_whiles(trace)
                explain("final", trace)

                if "--explain" in sys.argv:
                    explain("folded", folder.fold(trace))

                return trace

            trace = dec()

            functions[hash] = Function(hash, trace)

        except Exception as e:
            problems[hash] = fname

            logger.error(f"Problem with %s%s\n%s", fname, C.end, traceback.format_exc())

            if "--silent" not in sys.argv:
                print()
                print()

            if "--strict" in sys.argv:
                raise

    """

        Store decompiled contract into .json

    """

    contract = Contract(
        addr=this_addr,
        network=loader.network,
        ver=VER,
        problems=problems,
        functions=functions,
    )

    contract.postprocess()

    try:
        json_fname = cache_fname(this_addr, "json")
        with open(json_fname, "w") as f:
            f.write(contract.json())
    except Exception:
        # .json is a nice to have, whatever crazy error happens we should
        # still proceed with the rest of decompilation
        logger.error("failed contract serialization")

    asm_name = cache_fname(this_addr, "asm")
    with open(asm_name, "w") as f:
        for l in loader.disasm():
            f.write(l + "\n")

    """

        All the output gets printed to a .pan file in cache dir,
        and then displayed on console

    """

    this_fname = cache_fname(this_addr, "pan")
    pan_fd = open(this_fname, "w")
    with redirect_stdout(pan_fd):

        """
            Print out decompilation header
        """

        assert (
            loader.network != "none"
        )  # otherwise, the code is empty, and we caught it before

        print(C.gray + "#")
        print(f"#  Panoramix {VER} ")
        print("# " + C.end)

        if len(problems) > 0:
            print(C.gray + "#")
            print("#  I failed with these: ")
            for p in problems.values():
                print(f"{C.end}{C.gray}#  - {C.end}{C.fail}{p}{C.end}{C.gray}")
            print("#  All the rest is below.")
            print("#" + C.end)

        print()

        """
            Print out constants & storage
        """

        shown_already = set()

        for func in contract.consts:
            shown_already.add(func.hash)
            print(func.print())

        if shown_already:
            print()

        if len(contract.stor_defs) > 0:
            print(f"{C.green}def {C.end}storage:")

            for s in contract.stor_defs:
                print(pretty_type(s))

            print()

        """
            Print out getters
        """

        for hash, func in functions.items():
            if func.getter is not None:
                shown_already.add(hash)
                print(func.print())

                if "--repr" in sys.argv:
                    print()
                    pprint_repr(func.trace)

                print()

        """
            Print out regular functions
        """

        func_list = list(contract.functions)
        func_list.sort(
            key=lambda f: f.priority()
        )  # sort func list by length, with some caveats

        if any(1 for f in func_list if f.hash not in shown_already):
            if shown_already:
                # otherwise no irregular functions, so this is not needed :)
                print(C.gray + "#\n#  Regular functions\n#" + C.end + "\n")
        else:
            print(
                "\n"
                + C.gray
                + "#\n#  No regular functions. That's it.\n#"
                + C.end
                + "\n\n"
            )

        for func in func_list:
            hash = func.hash

            if hash not in shown_already:
                shown_already.add(hash)

                print(func.print())

                if "--returns" in sys.argv:
                    for r in func.returns:
                        print(r)

                if "--repr" in sys.argv:
                    pprint_repr(func.orig_trace)

                print()

    """

        Wrap up

    """

    pan_fd.close()

    if "--silent" not in sys.argv:
        print("\n")
        print(open(this_fname).read())


def decompile_bulk(addr_list):
    i = 0
    for addr in addr_list:
        i += 1
        print(f"{i}, {addr}")
        decompile(addr)


"""

    Command line initialisation

"""

bulk_list = None
function_name = None

if len(sys.argv) == 1:
    print(
        f"""
    python3 panoramix.py [address|shortcut|stdin] [func_name] [--verbose] [--silent]

        address: {C.gray}e.g. 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d
                 you can provide multiple, separating with comma{C.end}

        shortcut: {C.gray}e.g. kitties, unicorn, solidstamp{C.end}
        stdin: {C.gray}bytecode from stdin{C.end}

        --silent: {C.gray}writes output only to the ./cache_pan/ directory{C.end}

    """
    )

    exit()

if sys.argv[1] == "stdin":
    body_full = sys.stdin.read().strip()
    if not os.path.isdir("cache_stdin"):
        os.mkdir("cache_stdin")

    this_addr = None
    bulk_list = []
    for body in body_full.split(" "):

        addr = hex(abs(hash(body)))

        fname = f"cache_stdin/{addr}.bin"
        bulk_list.append(addr)

        with open(fname, "w") as f:
            f.write(body)

    decompile_bulk(bulk_list)

elif "," in sys.argv[1]:
    decompile_bulk(sys.argv[1].split(","))

else:
    this_addr = sys.argv[1]

    if this_addr.lower() in addr_shortcuts:
        this_addr = addr_shortcuts[this_addr.lower()]

    if len(sys.argv) > 2:
        if not sys.argv[2].startswith("--"):
            function_name = sys.argv[2]
        else:
            function_name = None

    decompile(this_addr, function_name)
