"""
    
    A helper script that takes all the binary code from cache_code,
    and decompiles all of it, saving results into cache_pan

    It uses multi-processing.

    This is useful with testing new changes to the decompiler. Run the decompilation
    on a few hundred contracts and look for any serious bugs / weird results.

    I also use it to decompile all the contracts with a new Eveem release.
    Just fetch all the bytecodes into cache_code (e.g. from BigQuery), and then run
    it through all of them. The strongest AWS instance can handle ~100 processes,
    and after ~24h it should have all the bytecodes decompiled.

    It would be rather easy to optimise this with some kind of a database and
    bytecode deduplication, but it would make the code more complex and dependency-ridden.

"""

import json

from subprocess import call

from queue import Queue

import sys

import threading
import time
import logging

import os

from various import addr_list, random_addresses

logging.basicConfig(
    level=logging.DEBUG, format="(%(threadName)-9s) %(message)s",
)

stuff = []

path = "cache_code/"

"""
uncomment to decompile all contracts in cache_code

for dname in os.listdir(path):
    if not os.path.isdir(path+dname):
        continue

    for fname in os.listdir(path+dname):
        addr = fname[:-4]
        full_fname = path+dname+'/'+fname
        
        if os.stat(full_fname).st_size > 0:
            stuff.append(addr)
"""

stuff = random_addresses  # or addr_list for more complex examples

print("binaries found:", len(stuff))

if len(sys.argv) < 3:
    print("bulk_decompile start_loc end_loc num_threads [--force]")
    exit()


def queued(q):
    while True:
        addr = q.get()
        if addr == "die":
            logging.debug("end of queue")
            break

        logging.debug("addr: %s" % addr)

        call(["python3.8", "panoramix.py", addr])  # , '--upload'])


stuff = sorted(stuff)

if __name__ == "__main__":

    queue = Queue()

    threads = []

    for i in range(int(sys.argv[3])):
        t = threading.Thread(target=queued, name="thread_" + str(i), args=[queue])
        t.start()
        threads.append(t)

    mini_queue = []

    for addr in stuff[int(sys.argv[1]) : int(sys.argv[2])]:
        if "--force" not in sys.argv and os.path.isfile(
            "cache_pan/" + addr[:5] + "/" + addr + ".pan"
        ):
            print("skipping " + addr)
            continue

        mini_queue.append(addr)
        if len(mini_queue) > 10:
            queue.put(",".join(mini_queue))
            mini_queue = []

    queue.put(",".join(mini_queue))

    for i in range(int(sys.argv[3])):
        queue.put("die")

    print("waiting for threads..")
