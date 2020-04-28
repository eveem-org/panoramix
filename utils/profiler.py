try:
    from time import perf_counter_ns

    def time_ns():
        return perf_counter_ns()


except:
    # python < 3.7
    from time import perf_counter

    def time_ns():
        return int(perf_counter() * (1000000))


import sys
import logging

logger = logging.getLogger(__name__)

"""
    a simplified line by line profiler

    usage:

        ...
        checkpoint_start() #1
        ...
        checkpoint('name1') #2
        ...
        checkpoint('name2') #3

    saves information how much cummulative time
    passed between #1 and #2 (name1), and #2 and #3 (name2)

    use log_checkpoints to show results

    func_caller is useful, when you want to differenciate by function
    caller

    usage:
        
    def some_func():
        checkpoint_start()
        STUFF
        checkpoint('name'+func_caller())

    def func_a():
        some_func()

    def func_b():
        some_func()

    log_checkpoints()
    shows time spent in some_func, split by the time
    when it was called by func_a and func_b

"""

results = {}
last_checkpoint = ""
last_ns = time_ns()


def checkpoint(name):
    global results
    global last_ns

    new_ns = time_ns()

    if name in results:
        results[name] += new_ns - last_ns
    else:
        results[name] = new_ns - last_ns

    last_ns = new_ns


def checkpoint_start():
    global last_ns
    last_ns = time_ns()


def log_checkpoints():
    return
    for name, elapsed in results.items():
        logger.info(f"Profiler: {name}\t\t- {elapsed / 1000000000}")

    for name, elapsed in counters.items():
        logger.info(f"Profiler: {name}\t\t- {elapsed}")


print_checkpoints = log_checkpoints

counters = {}


def count(x):
    if x in counters:
        counters[x] += 1
    else:
        counters[x] = 1


def func_caller(depth=1):
    # returns caller of a function
    # useful when you want to differenciate checkpoints by who the function caller is
    return sys._getframe(2 + depth).f_code.co_name
