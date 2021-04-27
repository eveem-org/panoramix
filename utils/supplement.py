import sqlite3
import json
from zipfile import ZipFile
import urllib.request
import sys
import time
import os

from .helpers import opcode, padded_hex, cached
from .helpers import (
    COLOR_HEADER,
    COLOR_BLUE,
    COLOR_OKGREEN,
    COLOR_WARNING,
    FAIL,
    ENDC,
    COLOR_BOLD,
    COLOR_UNDERLINE,
    COLOR_GREEN,
    COLOR_GRAY,
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

conn = None


def check_supplements():
    if not os.path.isfile("supplement.db"):
        print(COLOR_OKGREEN + "Hello, is this your first Panoramix run?" + ENDC)
        print()
        print("I need to fetch the signatures database from the web")
        print("This will be done just once.")
        print()
        fetch_db()

    assert os.path.isfile("supplement.db")

    if not os.path.isfile("supp2.db"):
        print("creating supp2.db...")
        c = sqlite3.connect("supplement.db").cursor()
        d_conn = sqlite3.connect("supp2.db")
        d = d_conn.cursor()

        d.execute(
            "create table functions (hash integer, name text, folded_name text, params text, primary KEY(hash))"
        )

        c.execute("SELECT hash, name, folded_name, params from functions group by hash")
        results = c.fetchall()

        for r in results:
            insert_row = int(r[0], 16), r[1], r[2], r[3]
            d.execute("INSERT INTO functions VALUES (?, ?, ?, ?)", insert_row)

        d_conn.commit()
        d_conn.close()
        print("done.")

    assert os.path.isfile("supp2.db")


def _cursor():
    global conn

    check_supplements()

    if conn is None:
        conn = sqlite3.connect("supplement.db")

    try:
        c = conn.cursor()
    except:
        # fails in multi-threading, this should help
        conn = sqlite3.connect("supplement.db")
        return conn.cursor()

    return c


conn2 = None


def _cursor2():
    global conn2

    check_supplements()

    if conn2 is None:
        conn2 = sqlite3.connect("supp2.db")

    try:
        c = conn2.cursor()
    except:
        # fails in multi-threading, this should help
        conn2 = sqlite3.connect("supp2.db")
        return conn2.cursor()

    return c


@cached
def fetch_sigs(hash):
    c = _cursor()
    c.execute("SELECT * from functions where hash=?", (hash,))

    results = c.fetchall()

    res = []
    for row in results:
        res.append(
            {
                "hash": row[0],
                "name": row[1],
                "folded_name": row[2],
                "params": json.loads(row[3]),
                "cooccurs": row[4].split(","),
            }
        )

    return res


@cached
def fetch_sig(hash):
    if type(hash) == str:
        hash = int(hash, 16)

    c = _cursor2()
    c.execute(
        f"SELECT hash, name, folded_name, params from functions where hash={hash}"
    )

    results = c.fetchall()
    if len(results) == 0:
        return None

    row = results[0]

    return {
        "hash": padded_hex(row[0], 8),
        "name": row[1],
        "folded_name": row[2],
        "params": json.loads(row[3]),
    }


def fetch_db():
    def reporthook(count, block_size, total_size):
        # https://blog.shichao.io/2012/10/04/progress_speed_indicator_for_urlretrieve_in_python.html
        global start_time
        if count == 0:
            start_time = time.time()
            return

        duration = time.time() - start_time
        progress_size = int(count * block_size)
        speed = int(progress_size / (1024 * duration))
        percent = min(int((count * block_size * 100) / total_size), 100)
        sys.stdout.write(
            "\r%d of 27 MB, %d KB/s, %d seconds passed..."
            % (progress_size / (1024 * 1024), speed, duration)
        )
        sys.stdout.flush()

    print("fetching supplement.zip...")
    url = "http://eveem.org/static/supplement.zip"
    urllib.request.urlretrieve(url, "tmp.supplement.db.zip", reporthook)
    print("")
    print("unzipping into supplement.db...")
    with ZipFile("tmp.supplement.db.zip") as myzip:
        with myzip.open("supplement.db") as myfile:
            with open("supplement.db", "wb") as file:
                file.write(myfile.read())

    os.remove("tmp.supplement.db.zip")
    print("done.")


"""
    
    Abi crawler and parser. used to refill supplement.py with new ABI/func definitions.
    It's used by scripts that are not a part of panoramix repo.

    The function is here, so people wanting to parse ABIs on their own can use parse_insert_abi
    implementation as a reference. It handles some unobvious edge-cases, like arrays of tuples.

"""


def crawl_abis_from_cache():
    # imports here, because this is not used as a part of a regular panoramix run,
    # and we don't want to import stuff unnecessarily.

    import json

    import os
    import urllib
    import urllib.request

    import time

    import re

    import sqlite3

    import sys

    try:
        from web3 import Web3
    except:
        print(
            "install web3:\n\t`pip install web3`"
        )  # the only dependency in the project :D

    conn = sqlite3.connect("supplement.db")
    cursor = conn.cursor()

    conn2 = sqlite3.connect("supp2.db")
    cursor2 = conn2.cursor()

    def parse_insert_abi(abi):
        def parse_inputs(func_inputs):
            inputs = []
            params = []
            param_counter = 0
            for r in func_inputs:
                param_counter += 1
                type_ = r["type"]

                name_ = r["name"]
                if len(name_) == 0:
                    name_ = "param" + str(param_counter)

                if name_[0] != "_":
                    name_ = "_" + name_

                params.append({"type": r["type"], "name": name_})

                if "tuple" not in type_:
                    inputs.append(type_)
                else:
                    type_ = f"({parse_inputs(r['components'])[0]})" + type_[5:]
                    inputs.append(type_)

            return ",".join(inputs), params

        output = {}

        for func in abi:
            if func["type"] in ["constructor", "fallback"]:
                continue

            inputs, params = parse_inputs(func["inputs"])

            fname = f"{func['name']}({inputs})"

            sha3 = Web3.sha3(text=fname).hex()[:10]

            if sha3 in output:
                print("double declaration for the same hash! {}".format(fname))
                continue

            output[sha3] = {
                "name": func["name"],
                "folded_name": fname,
                "params": params,
            }

        for sha3, row in output.items():
            row["cooccurs"] = list(output.keys())
            insert_row = (
                sha3,
                row["name"],
                row["folded_name"],
                json.dumps(row["params"]),
                ",".join(row["cooccurs"]),
            )

            insert_row2 = (
                int(sha3, 16),
                row["name"],
                row["folded_name"],
                json.dumps(row["params"]),
            )

            test_hash, test_cooccurs = insert_row[0], insert_row[4]

            cursor.execute(
                "SELECT * from functions where hash=? and cooccurs=?",
                (test_hash, test_cooccurs),
            )
            results = cursor.fetchall()
            if len(results) == 0:
                print("inserting", sha3, row["folded_name"])
                cursor.execute(
                    "INSERT INTO functions VALUES (?, ?, ?, ?, ?)", insert_row
                )
                conn.commit()

            cursor2.execute("SELECT * from functions where hash=?", (insert_row2[0],))
            results = cursor2.fetchall()
            if len(results) == 0:
                print("inserting2", sha3, row["folded_name"])
                cursor2.execute(
                    "INSERT INTO functions VALUES (?, ?, ?, ?)", insert_row2
                )

                conn2.commit()

    def crawl_cache():
        idx = 0

        path = "./cache_abis/"

        if not os.path.isdir(path):
            print(
                "dir cache_abis doesn't exist. it should be there and it should contain abi files"
            )
            return

        for fname in os.listdir(path):
            address = fname[:-4]
            fname = path + fname

            idx += 1
            print(idx, address)

            with open(fname) as f:
                abi = json.loads(f.read())
                parse_insert_abi(abi)

    crawl_cache()
