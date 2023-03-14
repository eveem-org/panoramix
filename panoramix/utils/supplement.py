import json
import logging
import lzma
import os
import sys
import time
from pathlib import Path
from zipfile import ZipFile
from typing import Optional
import shelve
from panoramix.utils.helpers import (
    cache_dir,
    cached,
)

"""
    a module for management of bytes4 signatures from the database

     db schema:

     hash - 0x12345678
     name - transferFrom
     folded_name - transferFrom(address,address,uint256)
     cooccurs - comma-dellimeted list of hashes: `0x12312312,0xabababab...`
     params - json: `[
            {
              "type": "address",
              "name": "_from"
            },
            {
              "type": "address",
              "name": "_to"
            },
            {
              "type": "uint256",
              "name": "_value"
            }
          ]`

"""

logger = logging.getLogger(__name__)


def abi_path():
    return cache_dir() / "abi_db.shelve"


def check_supplements():
    if not abi_path().is_file():
        compressed_supplements = Path(__file__).parent.parent / "data" / "abi_dump.xz"
        logger.info("Loading %s into %s...", compressed_supplements, abi_path())
        with lzma.open(compressed_supplements) as inf, shelve.open(
            str(abi_path())
        ) as out:
            for line in inf:
                line = json.loads(line)
                selector, abi = line["selector"], line["abi"]
                out[selector] = abi

        assert abi_path().is_file()

        logger.info("%s is ready.", abi_path())


@cached
def fetch_sig(hash) -> Optional[dict]:
    check_supplements()

    if type(hash) == str:
        hash = int(hash, 16)
    hash = "{:#010x}".format(hash)

    with shelve.open(str(abi_path())) as s:
        return s.get(hash)
