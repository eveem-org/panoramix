import cProfile
import logging
import argparse
import sys

import coloredlogs

from panoramix.decompiler import decompile_address, decompile_bytecode

logger = logging.getLogger(__name__)


def parse_args(args):
    parser = argparse.ArgumentParser(description="EVM decompiler.")
    parser.add_argument(
        "-v",
        default=str(logging.INFO),
        help="log level (INFO, DEBUG...)",
        metavar="LOG_LEVEL",
    )
    parser.add_argument(
        "--profile",
        action="store_true",
        default=False,
        help="Enable profiling of the application. "
        "Dumps the profile data to a 'panoramix.prof' file.",
    )
    parser.add_argument(
        "address_or_bytecode",
        help="An ethereum address, a comma-separated list of ethereum addresses, or `-` to read bytecode from stdin.",
    )
    parser.add_argument(
        "--function",
        default="",
        help="Function name to decompile only this one.",
        required=False,
    )
    parser.add_argument("--verbose", action="store_true")
    parser.add_argument("--explain", action="store_true")

    return parser.parse_args(args)


def print_decompilation(this_addr, args):
    function_name = args.function or None

    if this_addr == "-":
        this_addr = sys.stdin.read().strip()

    if len(this_addr) == 42:
        decompilation = decompile_address(this_addr, function_name)
    else:
        decompilation = decompile_bytecode(this_addr, function_name)

    print(decompilation.text)


def main():
    args = parse_args(sys.argv[1:])

    if args.v.isnumeric():
        coloredlogs.install(level=int(args.v), milliseconds=True)
    elif hasattr(logging, args.v.upper()):
        coloredlogs.install(level=getattr(logging, args.v.upper()), milliseconds=True)
    else:
        raise ValueError("Logging should be DEBUG/INFO/WARNING/ERROR.")

    if "," in args.address_or_bytecode:
        for addr in args.address_or_bytecode.split(","):
            print_decompilation(addr, args)
    elif args.profile:
        with cProfile.Profile() as profile:
            try:
                print_decompilation(args.address_or_bytecode, args)
            finally:
                profile.dump_stats("panoramix.prof")

    else:
        print_decompilation(args.address_or_bytecode, args)


if __name__ == "__main__":
    main()
