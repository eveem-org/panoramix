import cProfile
import logging
import sys

import coloredlogs
import timeout_decorator

from panoramix.decompiler import decompile_address, decompile_bytecode
from panoramix.utils.helpers import C

logger = logging.getLogger(__name__)

if "--verbose" in sys.argv:
    log_level = logging.DEBUG
elif "--silent" in sys.argv:
    log_level = logging.CRITICAL
elif "--errors" in sys.argv:
    log_level = logging.ERROR
else:
    log_level = logging.INFO

logging.getLogger("panoramix.matcher").setLevel(logging.INFO)

coloredlogs.install(
    level=log_level,
    fmt="%(asctime)s %(name)s %(message)s",
    datefmt="%H:%M:%S",
    field_styles={"asctime": {"color": "white", "faint": True}},
)

addr_shortcuts = {
    # main contract for testing - most of the common edge cases here
    "kitties": "0x06012c8cf97BEaD5deAe237070F9587f8E7A266d",
    # the convoluted one people can't decompile
    "mixgenes": "0xf97e0A5b616dfFC913e72455Fde9eA8bBe946a2B",
    "etherdelta": "0x8d12A197cB00D4747a1fe03395095ce2A5CC6819",
    "ledger": "0xf91546835f756DA0c10cFa0CDA95b15577b84aA7",
    # a basic contract - not too complex, not too simple
    # with some edge cases
    "solidstamp": "0x165cfb9ccf8b185e03205ab4118ea6afbdba9203",
    # weird results in approveAndCall
    # and storage getters (allowance) seem badly processed
    "buggy": "0x6025F65f6b2f93d8eD1efeDc752acfd4bdbCec3E",
    # a small contract, useful for testing dynamic memory
    "sweeper": "0x53F955c424F1378D67Bb5e05F728476dC75fB4bA",
    # fails a lot, because of all the complicated data structures
    "zrx": "0x4f833a24e1f95d70f028921e27040ca56e09ab0b",
    # https://medium.com/consensys-diligence/consensys-diligence-ether-giveaway-1-4985627b7726
    "ctf": "0x68cb858247ef5c4a0d0cde9d6f68dce93e49c02a",
    # https://medium.com/consensys-diligence/consensys-diligence-ethereum-hacking-challenge-2-bf3dfff639e0
    # selfdestructed, if you see empty results, you need to find the old version
    "ctf2": "0xefa51bc7aafe33e6f0e4e44d19eab7595f4cca87",
    # EF's unicorn token. a basic token that has symbol() and name()
    "unicorn": "0x89205A3A3b2A69De6Dbf7f01ED13B2108B2c43e7",
    # many nice kinds of loops
    "loops": "0xe2F42B417337fd9fD22631cad54DB8178655Fcd1",
    # a ctx with modern solidity, bst dispatch and multiple edge cases
    "ferlan": "0x7b220AC85B7ae8Af1CECCC44e183A862dA2eD517",
    "ugly": "0x06a6a7aF298129E3a2AB396c9C06F91D3C54aBA8",
    "dao": "0xF835A0247b0063C04EF22006eBe57c5F11977Cc4",
    # Vyper contract, complex but not too much.
    "uniswap": "0x2157A7894439191e520825fe9399aB8655E0f708",
}


def print_decompilation(this_addr):
    if this_addr.lower() in addr_shortcuts:
        this_addr = addr_shortcuts[this_addr.lower()]

    function_name = None
    if len(sys.argv) > 2:
        if not sys.argv[2].startswith("--"):
            function_name = sys.argv[2]

    if this_addr == "-":
        this_addr = sys.stdin.read().strip()

    if len(this_addr) == 42:
        decompilation = decompile_address(this_addr, function_name)
    else:
        decompilation = decompile_bytecode(this_addr, function_name)

    print(decompilation.text)


def main():
    if len(sys.argv) == 1:
        print(
            f"""
        panoramix [address|shortcut|-] [func_name] [--verbose] [--silent] [--profile]

            address: {C.gray}e.g. 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d
                    you can provide multiple, separating with comma{C.end}

            shortcut: {C.gray}e.g. kitties, unicorn, solidstamp{C.end}
            stdin: {C.gray}bytecode from stdin{C.end}

            --silent: {C.gray}writes output only to the ./cache_pan/ directory{C.end}

        """
        )
        exit(1)

    if "," in sys.argv[1]:
        for addr in sys.argv[1].split(","):
            print_decompilation(addr)
    elif "--profile" in sys.argv:
        with cProfile.Profile() as profile:
            print_decompilation(sys.argv[1])
        profile.dump_stats("panoramix.prof")

    else:
        print_decompilation(sys.argv[1])


if __name__ == "__main__":
    main()
