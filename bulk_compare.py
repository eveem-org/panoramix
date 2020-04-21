"""

    Half-baked regression testing.

    Run it to decompile a bunch of contracts and compare them with versions stored in the benchmark directory.

    Needs way more work.

"""

from subprocess import call
import urllib.request

from utils.helpers import cache_fname


import coloredlogs
import logging

logger = logging.getLogger(__name__)
log_level = logging.INFO

coloredlogs.install(
    level=log_level,
    fmt="%(asctime)s %(message)s",
    datefmt="%H:%M:%S",
    field_styles={"asctime": {"color": "white", "faint": True}},
)


addr_list = {
    "sweeper": "0x53F955c424F1378D67Bb5e05F728476dC75fB4bA",
    "ctf": "0x68cb858247ef5c4a0d0cde9d6f68dce93e49c02a",
    "unicorn": "0x89205A3A3b2A69De6Dbf7f01ED13B2108B2c43e7",
    "solidstamp": "0x165cfb9ccf8b185e03205ab4118ea6afbdba9203",
    "loops": "0xe2F42B417337fd9fD22631cad54DB8178655Fcd1",
    "kitties": "0x06012c8cf97BEaD5deAe237070F9587f8E7A266d",
    "etherdelta": "0x8d12A197cB00D4747a1fe03395095ce2A5CC6819",
    "ledger": "0xf91546835f756DA0c10cFa0CDA95b15577b84aA7",
    "buggy": "0x6025F65f6b2f93d8eD1efeDc752acfd4bdbCec3E",
    "modern": "0x7b220AC85B7ae8Af1CECCC44e183A862dA2eD517",
    "dao": "0xF835A0247b0063C04EF22006eBe57c5F11977Cc4",
}

print(f"ctx count: {len(addr_list)}")

i = 0

from time import sleep

from filecmp import cmp, clear_cache

for name, addr in addr_list.items():
    i += 1
    logger.info(f"#{i} of {len(addr_list)}: {addr} ({name})")
    call(["python3.8", "panoramix.py", addr, "--silent"])
    sleep(0.1)
    clear_cache()

    if not cmp(cache_fname(addr, "pan"), f"benchmark/{addr}.pan", shallow=False):
        logger.error("comparison fail")
        call(["diff", cache_fname(addr, "pan"), f"benchmark/{addr}.pan"])
    else:
        logger.info("looks good")
