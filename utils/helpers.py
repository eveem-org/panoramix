# coding: tilde
import string

from copy import deepcopy, copy
from .profiler import *

import os
import re


COLOR_HEADER = '\033[95m'
COLOR_BLUE = '\033[94m'
COLOR_OKGREEN = '\033[92m'
COLOR_WARNING = '\033[93m'
FAIL = '\033[91m'
ENDC = '\033[;1m'
COLOR_BOLD = '\033[1m'
COLOR_UNDERLINE = '\033[4m'
COLOR_GREEN = '\033[32m'
COLOR_GRAY = '\033[38;5;8m'
COLOR_ASM = '\033[38;5;33m'

'''
    slowly refactoring into low-caps names,
    the issue is that some names (e.g. `fail`) may
    cause conflicts, but then they happen so often that
    it's still better for readability than shutting them in
    a namespace

'''


colors = {
    # code_ANSI  #code_html_rgb
    "\033[95m": "235, 97, 247",  # COLOR_HEADER
    "\033[91m": "236, 89, 58",  # fail
    "\033[38;5;8m": "111, 110, 111",  # gray
    "\033[32m": "107, 194, 76",  # green
    "\033[93m": "239, 236, 84",  # warning
    "\033[92m": "119, 232, 81",  # okgreen
    "\033[94m": "184, 90, 190",  # "blue"
}

def convert(text):

    for asci, html in colors.items():
        text = text.replace(asci, '<span style="color:rgb(' + html + ')">')

    text = text.replace("\033[1m", '<span style="font-weight:bold">')

    text = re.sub(
        r"»#(.*)\n", '<span style="color:rgb(111, 110, 111)">#\\1</span>\n', text
    )

    text = text.replace("»", "&raquo;")

    text = text.replace("\033[0m", "</span>")

    return text



class C():
#    asm = '\033[38;5;33m'
    header = '\033[95m'
    blue = '\033[94m'
    okgreen = '\033[92m'
    warning = '\033[93m'
    red = '\033[91m'
    bold = '\033[1m'
    underline = '\033[4m'
    green = '\033[32m'
    gray = '\033[38;5;8m'
    endc = '\033[0m'
    fail = '\033[91m'
    end = endc

    green_back = '\033[42;1m\033[38;5;0m'
    blue_back = '\033[43;1m\033[38;5;0m'


    def asm(s):
        return '\033[38;5;33m' + s + C.endc

    every = set([header, blue, okgreen, warning, red, bold, underline, green, gray, endc])

def color(exp, color, add_color=True):
    if add_color:
        if exp == "":
            return ''

        return color + exp + C.endc
    else:
        return str(exp)

colorize = color # alias, refactoring this into `col` slowly, but such a short name = conflicts?

def clean_color(s):
    for c in C.every:
        s = s.replace(c, '')

    return s

precompiled = {
    1: "erecover", # msg_hash =, v = , r = , s =
    2: "sha256hash",
    3: "ripemd160hash",
    #4: "memcpy", -- handled separately
    5: "bigModExp",
    6: "bn256Add",
    7: "bn256ScalarMul",
    8: "bn256Pairing",
}

precompiled_var_names = {
    1: "signer",
    2: "hash",
    3: "hash",
    #4: "memcpy", -- handled separately
    5: "mod_exp",
    6: "bn_add",
    7: "bn_scalar_mul",
    8: "bn_pairing",
}


def cache_fname(addr, ext, dir='cache_pan'):
    dir_name = dir + '/' + addr[:5] + '/'

    if not os.path.isdir(dir):
        os.mkdir(dir)

    if not os.path.isdir(dir_name):
        os.mkdir(dir_name)

    return dir_name + addr + '.' + ext

def before_after(func):

    def wrapper(*args):
        res = func(*args)

        print('in', args)
        print(func.__name__)
        print('out', res)
        return res

    return wrapper

cached_dict = {}
def cached(func):
    name = func.__name__

    if name not in cached_dict:
        cached_dict[name] = {}

    def wrapper(*args):
        try:
            if args in cached_dict[name]:
                return cached_dict[name][args]
        except:
            pass

        ret = func(*args)
        try:
            cached_dict[name][args] = ret
        except:
            pass

        return ret

    return wrapper

ARRAY_OPCODES = ['call.data', 'ext_call.return_data', 'delegate.return_data', 'callcode.return_data', 'staticcall.return_data', 'code.data']

def assure_dir_exists(dir_name):
    if dir_name[-1:] == '/':
        dir_name = dir_name[:-1]

    dir_so_far = ''
    for d in dir_name.split('/'):
        dir_so_far += d + '/' 
        if not os.path.isdir(dir_so_far):
            os.mkdir(dir_so_far)

    assert os.path.isdir(dir_name), dir_name

def is_array(op):
    return op in ARRAY_OPCODES

# car/cdr convention borrowed from functional languages. shorter than 'first', 'rest'
def car(exp):
    if type(exp) in (tuple, list) and len(exp) > 0:
        return exp[0]
    else:
        return None

def cdr(exp):
    if type(exp) in (tuple, list) and len(exp) > 0:
        return exp[1:]
    else:
        return None


def rewrite_trace(trace, f):
    res = []

    for line in trace:
        if opcode(line) != 'if':
            res.extend(f(line))
        else:
            cond, if_true, if_false = line[1:]
            res.append(('if', cond, rewrite_trace(if_true, f), rewrite_trace(if_false, f)))

    return res


def rewrite_trace_full(trace, f):
    res = []

    for line in trace:
        if line ~ ('if', :cond, :if_true, :if_false):
            if_true = rewrite_trace_full(if_true, f)
            if_false = rewrite_trace_full(if_false, f)
            res.append(('if', cond, if_true, if_false))

        elif line ~ ('while', :cond, :tr, :jds, :setvars):
            tr = rewrite_trace_full(tr, f)
            res.append(('while', cond, tr, jds, setvars))

        else:
            res.extend(f(line))

    return res

def rewrite_trace_multiline(trace, f, number):
    res = []
    idx = 0

    while idx < len(trace):
        if idx + number <= len(trace):
            if (r2 := f(trace[idx:idx+number])) is not None:
                res.extend(r2)
                idx += number
                continue

        line = trace[idx]

        if line ~ ('if', :cond, :if_true, :if_false):
            if_true = rewrite_trace_multiline(if_true, f, number)
            if_false = rewrite_trace_multiline(if_false, f, number)
            res.append(('if', cond, if_true, if_false))

        elif line ~ ('while', :cond, :tr, :jds, :setvars):
            tr = rewrite_trace_multiline(tr, f, number)
            res.append(('while', cond, tr, jds, setvars))

        else:
            res.append(line)

        idx += 1

    return res

test_trace = [
                'a','b','c','d'
        ]
def test_f(lines):
    if lines == ['b','c']:
        return ['q','w','e']

assert rewrite_trace_multiline(test_trace, test_f, 2) == ['a','q','w','e','d']

def rewrite_trace_ifs(trace, f):
    res = []

    for line in trace:
        if line ~ ('if', :cond, :if_true, :if_false):
            new_lines = f(line)
            if new_lines == [line]:
                if_true = rewrite_trace_ifs(if_true, f)
                if_false = rewrite_trace_ifs(if_false, f)
                res.append(('if', cond, if_true, if_false))
            else:
                res.extend(rewrite_trace_ifs(new_lines, f))

        elif line ~ ('while', :cond, :tr, :jds, :setvars):
            tr = rewrite_trace_ifs(tr, f)
            res.append(('while', cond, tr, jds, setvars))

        else:
            res.extend(f(line))

    return res

def print_cached():
    print(repr(cached_dict))

class EasyCopy:

    def __init__(self):
        self.value = None

    def __copy__(self):
        cls = self.__class__
        result = cls.__new__(cls)
        result.__dict__.update(self.__dict__)
        return result

    def __deepcopy__(self, memo):
        cls = self.__class__
        result = cls.__new__(cls)
        memo[id(self)] = result
        for k, v in self.__dict__.items():
            setattr(result, k, deepcopy(v, memo))
        return result

    def light_copy(self):
        cls = self.__class__
        result = cls.__new__(cls)
        for k, v in self.__dict__.items():
            setattr(result, k, copy(v))
        return result

def get_op(exp, op, default=None):
    # finds the first expression within expression that has a given opcode,
    # or returns None

    if opcode(exp) == op:
        return exp

    if type(exp) in (list, tuple):
        for e in exp[1:]:
            if x := get_op(e, op, default):
                return x

    return default

def find_op_list(exp, op, default=None):
    # finds a list of expressions with a given opcode

    if opcode(exp) == op:
        return [exp]

    res = []

    if type(exp) in (list, tuple):
        for e in exp:
            res.extend(find_op_list(e, op, default))

    return res

def replace_lines(trace, f):
    res = []

    for line in trace:
        if line ~ ('while', :cond, :path, :jds, :setvars):
            cond = f(cond)
            path = replace_lines(path, f)
            setvars = f(setvars)

            res.append(('while', cond, path, jds, setvars))

        elif line ~ ('if', :cond, :if_true, :if_false):
            res.append(('if', f(cond), replace_lines(if_true, f), replace_lines(if_false, f)))

        else:
            res.append(f(line))

    return res


def walk_trace(trace, f):
    res = []
    for line in trace:
        if type(line) == list:
            res += walk_trace(line, f)
            continue

        res += f(line)
        if opcode(line) == 'if':
            if_true, if_false = line[2], line[3]
            res += walk_trace(if_true, f)
            res += walk_trace(if_false, f)

    return res


def all_concrete(*args):
    for a in args:
        if type(a) not in (int, float):
            return False
    return True

def cleanup_mul_1(exp):
    if type(exp) == list:
        return [cleanup_mul_1(e) for e in exp]

    if type(exp) != tuple:
        return exp

    if exp[:2] == ('mul', 1) and len(exp) == 3:
        return exp[2]

    return tuple(cleanup_mul_1(e) for e in exp)

def pretty_bignum(num):
    if type(num) != int:
        return num

    if num == 0x19457468657265756d205369676e6564204d6573736167653a0a333200000000:
        return "'\\x19Ethereum Signed Message:\\n32'" # common, todo correct parsing of RLP encoding
                                                  # https://ethereum.stackexchange.com/questions/33349/unable-to-reproduce-keccak256-hello-world-hash-within-evm
                                                  # https://github.com/ethereum/go-ethereum/issues/14794
                                                  # found in EtherDelta
    s = '' # todo: mask?
    orig_num = num
    while num>0:
        ch = chr(num % 0x100)
        if ch not in (string.printable+string.whitespace) and num % 0x100 != 0:
            return orig_num
        if num % 0x100 != 0:
            s = ch + s
        num = num // 0x100

    return f"'{s}'"

def parse_data(value):
    # converts binary data into a human-readable form

    if len(value) == 32*2+2:
        value = int(value, 16)

        if value > 10**9 and value // 10**9 != 0:
            value = hex(value)
        else:
            value = nice_int(value)

        return value

    else:
        value = value[2:]

        out = []
        while len(value) > 0:
            out.append(int('0x'+value[:32*2], 16))
            value = value[32*2:]

        out2 = []
        for o in out:
            if o > 10**9 and o // 10**9 != 0:
                out2.append(hex(o))
            else:
                out2.append(o)

        if len(out2) == 3 and out2[0] == 32 and \
            out2[2][-64+out2[1]*2:] == '0'*(64-out2[1]*2):
                out2 = pretty_bignum(int(out2[2][:out2[1]*2+2],16))

        return str(out2)

def to_exp2(num): # checks if num is a power of 2, and if so, returns to which power
    if type(num) != int:
        return None

    if num < 0: # speed optimisation
        return None

    for i in range(256):
        if num == 2 ** i:
            return i

    return None


def opcode(exp):
    if type(exp) != tuple or len(exp)==0:
        return None
    else:
        return exp[0]

def padded_hex(given_int, given_len):
    if given_int >= 0:
        hex_result = hex(given_int)[2:] # remove '0x' from beginning of str
    else:
        hex_result = hex(given_int)[3:] # remove '0x' from beginning of str

    num_hex_chars = len(hex_result)
    extra_zeros = '0' * (given_len - num_hex_chars) # may not get used..

    return ('0x' + hex_result if num_hex_chars == given_len else
            '?' * given_len if num_hex_chars > given_len else
            '0x' + extra_zeros + hex_result if num_hex_chars < given_len else
            None)

def find_f_set(exp, f):
    ret = f(exp)

    if type(exp) in (list, tuple):
        for e in exp:
            ret = ret.union(find_f_set(e, f))

    return ret


def find_f_list(exp, f, default=None):
    ret = f(exp) or []

    if type(exp) in (list, tuple):
        for e in exp:
            ret.extend(find_f_list(e, f))

    return ret

def find_f(exp, f, default=None):
    if f(exp) is not None:
        return f(exp)

    if type(exp) in (list, tuple):
        for e in exp:
            x = find_f(e, f)
            if x is not None:
                return x

        return default

    return default

def tuplify(exp):
    if type(exp) != list:
        return exp

    return tuple(tuplify(e) for e in exp)

assert tuplify(['mul', 1, ['qwe', 10]]) == ('mul', 1, ('qwe', 10))

def hashable(v):
    """Determine whether `v` can be hashed."""
    try:
        hash(v)
    except TypeError:
        return False
    return True

assert hashable((1,2,[1,3])) == False
assert hashable((1,2,(1,3))) == True

def contains(exp, what):
    if exp == what:
        return True

    elif type(exp) in (list, tuple):
        for e in exp:
            if contains(e, what):
                return True

    return False


def replace_f(in_exp, f):
    if type(in_exp) not in (tuple, list):
        in_exp = f(in_exp)
        return in_exp

    keep_type = type(in_exp)
    res = keep_type(replace_f(e, f) for e in in_exp)

    return f(res)

def replace(in_exp, what, by_what):
    if in_exp == what:
        return by_what

    if type(in_exp) not in (tuple, list):
        return in_exp

    res = tuple()
    for e in in_exp:
        res += (replace(e, what, by_what), )

    if type(in_exp) == list:
        res = list(res)

    return res

def replace_f_stop(in_exp, f):
    """Like replace_f, but the function returns None when no replacement needs
       to be made. If it returns something we replace it and stop."""
    modified_in_exp = f(in_exp)
    if modified_in_exp is not None:
        return modified_in_exp

    if type(in_exp) not in (tuple, list):
        return in_exp

    res = tuple()
    for e in in_exp:
        res += (replace_f_stop(e, f), )

    if type(in_exp) == list:
        res = list(res)

    return res

