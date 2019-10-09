# coding: tilde
from utils.helpers import COLOR_HEADER, COLOR_BLUE, COLOR_OKGREEN, COLOR_WARNING, FAIL, ENDC, COLOR_BOLD, COLOR_UNDERLINE, COLOR_GREEN, COLOR_GRAY

import logging
import core.arithmetic as arithmetic
from utils.helpers import opcode, padded_hex, pretty_bignum, all_concrete, replace_lines, replace_f
from utils.helpers import clean_color, C, is_array

from core.algebra import lt_op, mul_op, minus_op, ge_zero, safe_ge_zero, sub_op, add_op, apply_mask, safe_le_op, to_bytes

from copy import deepcopy

from core.arithmetic import simplify_bool, is_zero

from core.masks import get_bit, mask_to_type

from utils.helpers import precompiled

from utils.helpers import colorize, to_exp2

from utils.signatures import get_param_name

from functools import partial

from pano.loader import Loader

import sys

logger = logging.getLogger(__name__)

'''

    This module displays expressions and traces in a human readable form.

    It went through very many iterations, so it's a mess by now.

    A lot of it can be easily refactored, so if you're looking for a place to contribute,
    this may be it :)

'''



prev_trace = None
def explain(title, trace):
    global prev_trace

    if '--explain' not in sys.argv:
        return

    if trace == prev_trace:
        return

    print('\n'+C.green_back+f" {title}: "+C.end+'\n')
    pprint_trace(trace)
    prev_trace = trace

def explain_text(title, params):
    global prev_trace
    
    if '--explain' not in sys.argv:
        return

    print('\n'+C.blue_back+f" {title}: "+C.end+'\n')

    for name, val in params:
        print(f' {C.gray}{name}{C.end}: {val}')
    print()

def make_ast(trace):
    def store_to_set(line):
        if line ~ ('store', :size, :off, :idx, :val):
            return ('set', ('stor', size, off, idx), val)
        else:
            return line

    def mask_storage(exp):
        if exp ~ ('stor', :size, :off, :idx):
            return ('mask_shl', size, 0, 0, exp)
        else:
            return exp

    trace = replace_lines(trace, store_to_set)
    trace = replace_f(trace, mask_storage)

    return trace



def format_exp(exp):
    if type(exp) == str:
        return f'"{exp}"'
    if type(exp) == int:
        if exp > 10 ** 6 and exp % 10 ** 6 != 0:
            return hex(exp)
        else:
            return str(exp)
    elif type(exp) != list:
        return str(exp)
    else:
        if len(exp) == 0:
            return COLOR_GRAY + "[]" + ENDC
        if type(opcode(exp)) == list:
            return (
                COLOR_GRAY
                + "["
                + ENDC
                + f"{COLOR_GRAY}, {ENDC}".join([format_exp(e) for e in exp])
                + COLOR_GRAY
                + "]"
                + ENDC
            )
        else:
            return (
                COLOR_GRAY
                + "["
                + ENDC
                + f"{COLOR_GRAY}, {ENDC}".join(
                    [opcode(exp)] + [format_exp(e) for e in exp[1:]]
                )
                + COLOR_GRAY
                + "]"
                + ENDC
            )

def pprint_repr(trace, indent=0):
    for line in trace:

        if opcode(line) == "if":
            cond, if_true, if_false = line[1:]
            print(indent * " ", f"[if, {format_exp(cond)}, [")
            pprint_repr(if_true, indent + 2)
            print(indent * " ", "],[")
            pprint_repr(if_false, indent + 2)
            print(indent * " ", "] ")

        elif opcode(line) == "while":
            cond, tr = line[1], line[2]
            print(indent * " ", f"[while, {format_exp(cond)}, [")
            pprint_repr(tr, indent + 2)
            print(indent * " ", "], ")

        else:
            print(indent * " ", format_exp(line) + f"{COLOR_GRAY}, {ENDC}")

'''
def pprint_repr(exp):
    print(repr(exp))
    return
    print(pretty_repr(exp))
'''

def pretty_repr(exp, indent=0):
    if type(exp) not in (tuple, list):
        return repr(exp)
    elif type(exp) == list:
        res = ', \n'.join([' '*indent + pretty_repr(e, indent) for e in exp])
        res = indent*' '+'['+res[:-3]+']'
        return res
    elif type(exp) == tuple:
        res = ', '.join([pretty_repr(e) for e in exp])
        if len(res) > 40 and exp ~ (:op, :first, *rest):
            indent += len(pretty_repr(op)+', ')+1
            res = pretty_repr(op)+', '+pretty_repr(first, indent)+',\n'
            for r in rest:
                res += indent*' '+pretty_repr(r, indent)+', \n'
            res = res[:-3] # removes ', \n'

        return '('+res+')'
    elif type(exp) == list:
        res = (',\n'+' '*indent).join([pretty_repr(e, indent) for e in exp])
        return f'[{res}]'

#print(pretty_repr(('data', ('mem', ('range', ('add', 32, 'QQ', ('mask_shl', 251, 5, 0, ('add', 31, ('ext_call.return_data', 128, 32)))), 32)), 'yy', ('data', ('mem', ('range', ('add', 32, 'QQ'), ('ext_call.return_data', 128, 32))), ('mem', ('range', ('add', 96, 'QQ', ('mask_shl', 251, 5, 0, ('add', 31, ('ext_call.return_data', 128, 32))), ('ext_call.return_data', 128, 32)), 0))))))
#exit()

def pformat_trace(trace):
    return '\n'.join(pprint_logic(trace)) + "\n\n"

def pprint_trace(trace):
    trace = make_ast(trace)
    pprint_ast(trace)

def pprint_ast(trace):
    empty = True

    for l in pprint_logic(trace):
        print(l)
        empty = False

    if empty:
        print('  stop')
    print()
    print()

def pprint_logic(exp, indent=2):
    INDENT_LEN = 4

    if opcode(exp) == 'while':
        if len(exp) == 5:
            cond, path, jd, vars = exp[1], exp[2], exp[3], exp[4]
        else:
            cond, path = exp[1], exp[2]
            jd, vars = None, []

        for v in vars:
            yield ' '*indent + list(pretty_line(('setvar', v[1],v[2]), add_color=True))[0]

        yield ' '*indent + COLOR_GREEN+ 'while ' + ENDC+prettify(cond, add_color=True, parentheses=False, rem_bool=True) + COLOR_GREEN+':'+ ENDC#+COLOR_GREEN+':  # '+str(jd)+ENDC
        if type(path) != list:
            path = path.trace

        for l in pprint_logic(path, indent + INDENT_LEN):
            yield l

    elif exp ~ ('require', :cond):
        yield ' '*indent + 'require ' + prettify(exp[1], add_color=True, parentheses=False, rem_bool=True) + ''

    elif exp ~ ('if', :cond, :if_true): # one-sided ifs, only after folding
        if len(if_true) == 1 and (first := if_true[0]) and \
            ((first == ('revert', 0)) or (first ~ ('invalid', ...))):
                yield ' '*indent + 'require '+prettify(is_zero(exp[1]), add_color=True, parentheses=False, rem_bool=True)
        else:
            yield ' '*indent + 'if ' + prettify(exp[1], add_color=True, parentheses=False, rem_bool=True) + ':'
            for l in pprint_logic(if_true, indent + INDENT_LEN):
                yield l


    elif exp ~ ('if', :cond, :if_true, :if_false):
        if len(if_false) == 1 and (first := if_false[0]) and \
            ((first == ('revert', 0)) or \
            (first ~ ('invalid', ...))):
                yield ' '*indent + 'require '+prettify(exp[1], add_color=True, parentheses=False, rem_bool=True)

                for l in pprint_logic(exp[2], indent):
                    yield l

        elif len(if_true) == 1 and (first := if_true[0]) and \
            ((first == ('revert', 0)) or \
            (first ~ ('invalid', ...))):
                yield ' '*indent + 'require '+prettify(is_zero(exp[1]), add_color=True, parentheses=False, rem_bool=True)

                for l in pprint_logic(exp[3], indent):
                    yield l

        else:
            yield ' '*indent + 'if ' + prettify(exp[1], add_color=True, parentheses=False, rem_bool=True) + ':'

            for l in pprint_logic(if_true, indent + INDENT_LEN):
                yield l
            '''
            while len(if_false) == 1 and opcode(if_false) == 'if' and len(if_false) == 4:
                first = if_false[0]
                assert first ~ ('if', :c, :i_t, :if_false)

                yield ' '*indent + 'elif ' + prettify(c, add_color=True, parentheses=False, rem_bool=True) + ':'

                for l in pprint_logic(i_t, indent + INDENT_LEN):
                    yield l'''

            yield ' '*indent + 'else:'
            for l in pprint_logic(if_false, indent + INDENT_LEN):
                yield l


    elif type(exp) == list:
        for idx, line in enumerate(exp):
            if idx == len(exp)-1 and indent == 2 and line==('stop', ):
                pass # don't print the last stop
            else:
                for l in pprint_logic(line, indent):
                    yield l

    elif opcode(exp) == 'or' and len(exp)>1:
        yield ' '*indent + 'if'
        for l in pprint_logic(exp[1], indent + INDENT_LEN):
            yield l

        for line in exp[2:]:
            yield ' '*indent + 'or'
            for l in pprint_logic(line, indent + INDENT_LEN):
                yield l

    else:
        for l in pretty_line(exp):
            yield ' '* indent + l

def to_real_int(exp):
    if type(exp) == int and get_bit(exp, 255):
        return -arithmetic.sub(0, exp)
    else:
        return exp

def pretty_line(r, add_color=True):
    col = partial(colorize, add_color=add_color)
    pret = partial(prettify, parentheses=False, add_color=add_color)

    if type(r) is str:
        yield COLOR_GRAY + "# " + r + ENDC

#    elif r ~ ('jumpdest', ...):
#        pass

    elif r ~ ('comment', :text):
        yield COLOR_GRAY + "# " + prettify(text, add_color=False) + ENDC

    elif r ~ ('log', :params, *events):
        # solidstamp and dao cover most of those cases
        res_params = pretty_memory(params, add_color=False)

        for e in events:
            if type(e) != int:
                for e in events[1:]:
                    res_params = res_params + (prettify(e, add_color=False, parentheses=False), )
                events = [events[0]]
                break
                # breaks with more than one proper event


        res_events = tuple(pretty_fname(e, add_color=False, force=True) for e in events)
#        print(res_events)
        res_events = tuple((x[:10] if x[:2] == '0x' else x) for x in res_events)
        for e in res_events:
            if '(' not in e:
                yield col(f"log {e}{':' if len(res_params)>0 else ''} {', '.join(res_params)}", COLOR_GRAY)
            else:
                fname, fparams = e.split('(')

                assert fparams[-1] == ')'
                fparams = fparams[:-1]

                fparams = fparams.split(', ')

                if fparams == [''] or len(res_params) == 0:
                    yield col(f'log {e}', COLOR_GRAY)

                elif len(fparams) == len(res_params):
                    p_list = []
                    try:
                        for idx, ptype, pname in [f"{idx} {p}".split(' ') for idx, p in enumerate(fparams)]:
                            p_list.append((ptype, pname, res_params[int(idx)]))
                    except:
                        logger.warning(f'weird log {e} {fparams}')
                        yield(f'log {e}')
                        return


                    if len(p_list) == 1:
                        yield col(f"log {fname}({p_list[0][0]} {p_list[0][1]}={pret(p_list[0][2], add_color=False, parentheses=False)})", COLOR_GRAY)
                    else:
                        ind = len(f'log   ')
                        first = p_list[0]
                        last = p_list[-1]
                        pline = lambda p: f'{p[0]} {p[1]}={pret(p[2], add_color=False, parentheses=False)}' # spaces around = not pep8 compliant
                                                                    # but without them it was less readable

                        yield col(f"log {fname}(", COLOR_GRAY)#
                        yield col(f"      {pline(first)},", COLOR_GRAY)

                        for p in p_list[1:-1]:
                            yield col(' '*ind + f"{pline(p)},", COLOR_GRAY)

                        yield col(' '*ind + f"{pline(last)})", COLOR_GRAY)
#                elif len(res_params) == 0:
#                        yield col(f'log {e}', COLOR_GRAY)
                else:
                    yield col(f'log {e}:', COLOR_GRAY)
                    ind = ' ' * len(f'log {fname}(')
                    for p in res_params:
                        yield col(ind + p + ',', COLOR_GRAY)
#                        print(repr(len(fparams)), len(res_params))

    elif r ~ ('callcode', :gas, :addr, :wei, :fname, :fparams):
        fname = pretty_fname(fname, add_color=add_color)

        if type(addr) == int:
            addr = hex(addr)
        addr = prettify(addr, add_color = add_color)
        gas = prettify(gas, parentheses = False, add_color = add_color)
        fparams = pretty_memory(fparams, add_color = add_color)

        if fname is not None:

            if type(fname) == str:
                fname = pretty_fname(fname, add_color = add_color)
                yield f"{COLOR_WARNING}codecall{ENDC} {addr}.{fname} with:"

            else:
                yield f"{COLOR_WARNING}codecall{ENDC} {addr} with:"
                yield "   funct " + prettify(fname, add_color=add_color)

        else:
            yield f"{COLOR_WARNING}codecall{ENDC} {addr} with:"

        if wei != 0:
            wei = prettify(wei, parentheses=False, add_color=add_color)
            yield f"   value {wei} {COLOR_GRAY}wei{ENDC}"

        yield f"     gas {gas} {COLOR_GRAY}wei{ENDC}"

        if fparams is not None:
            yield "    args {}".format(', '.join(fparams))

    elif r ~ ('delegatecall', :gas, :addr, :fname, :fparams):
        fname = pretty_fname(fname, add_color=add_color)

        if type(addr) == int:
            addr = hex(addr)
        addr = prettify(addr, add_color = add_color)
        gas = prettify(gas, parentheses = False, add_color = add_color)
        fparams = pretty_memory(fparams, add_color = add_color)

        if fname is not None:

            if type(fname) == str:
                fname = pretty_fname(fname, add_color = add_color)
                yield f"{COLOR_WARNING}delegate{ENDC} {addr}.{fname} with:"

            else:
                yield f"{COLOR_WARNING}delegate{ENDC} {addr} with:"
                yield "   funct " + prettify(fname, add_color=add_color)

        else:
            yield f"{COLOR_WARNING}delegate{ENDC} {addr} with:"


        yield f"     gas {gas} {COLOR_GRAY}wei{ENDC}"

        if fparams is not None:
            yield "    args {}".format(', '.join(fparams))

    elif r ~ ('selfdestruct', :addr):
        yield col('selfdestruct(', COLOR_WARNING)+col(pret(addr, add_color=False, parentheses=False), FAIL)+col(')', COLOR_WARNING)

    elif r ~ ('precompiled', :var_name, :func_name, :params):
        yield "{} = {}({}) {}".format(col(var_name, COLOR_BLUE), func_name, prettify(params, add_color=add_color, parentheses=False),
                        COLOR_GRAY+'# precompiled'+ENDC)

    elif r ~ ('create', :wei, :code):
        yield f"create contract with {wei} wei"
        yield f"                code: {prettify(code)}"

    elif r ~ ('create2', :wei, :code, :salt):
        yield f"create2 contract with {wei} wei"
        yield f"                salt: {prettify(salt)}"
        yield f"                code: {prettify(code)}"


    elif r ~ ('call', :gas, :addr, :wei, :fname, :fparams):

        if type(addr) == int:
            if len(hex(addr)) > 22+2:
                addr = padded_hex(addr, 40) # todo: padded hex
            else:
                addr = hex(addr) # if it's longer, padded hex returns '???'

        addr = pret(addr)
        gas = pretty_gas(gas, wei, add_color)


        if fname is None:
            yield f"call {addr} with:"

        else:
            fname = pretty_fname(fname, add_color=add_color)

            if fname == '0x0':
                yield f"call {addr} with:"

            elif type(fname) == str:
                yield f"call {addr}.{pret(fname)} with:"

            else:
                yield f"call {addr} with:"
                yield f"   funct {pret(fname)}"

        if wei != 0:
            wei = prettify(wei, parentheses=False, add_color=add_color)
            yield f"   value {wei} {COLOR_GRAY}wei{ENDC}"

        yield f"     gas {gas} {COLOR_GRAY}wei{ENDC}"

        if fparams is not None:
            fparams = pretty_memory(fparams, add_color=add_color)
            yield "    args {}".format(', '.join(fparams))

    elif r ~ ('staticcall', :gas, :addr, :wei, :fname, :fparams):

        if type(addr) == int:
            addr = hex(addr)

        addr = prettify(addr, add_color=add_color, parentheses=False)
        gas = pretty_gas(gas, wei, add_color)

        if fname is not None:
            fanme = fname
            fname = pretty_fname(fname, add_color=add_color)

            if fname == '0x0':
                yield f"static call {addr} with:"
            elif type(fname) == str and fname != '0x0':
                yield f"static call {addr}.{pret(fname)} with:"
            else:
                yield f"static call {addr} with:"
                yield f"     funct {pret(fname)}"

        else:
            yield f"static call {addr} with:"

        yield f"        gas {gas} {COLOR_GRAY}wei{ENDC}"

        if fparams is not None:
            fparams = pretty_memory(fparams, add_color=add_color)
            yield "       args {}".format(', '.join(fparams))

    elif r ~ ('label', :name, :setvars):
        yield COLOR_GREEN + f'loop {str(name)} setvars: {str(setvars)}' + ENDC

    elif r ~ ('goto', *rest):
        yield COLOR_GREEN + f'continue {str(rest)}'+ENDC

    elif r ~ ('continue', :jd, :setvars):
        for v in setvars:
            yield str(list(pretty_line(v, add_color=True))[0])
        yield COLOR_GREEN + 'continue ' + ENDC  # +str(jd)+ENDC

    elif r ~ ('setvar', ...):
        yield prettify(r, add_color=add_color)

    elif r ~ ('setmem', ...):
        yield prettify(r, add_color=add_color)

    elif r ~ ('set', :idx, :val):
        if val ~ ('add', int:v, idx):
            assert v != 0

            if v == -1:
                yield prettify(idx, add_color=add_color) + '--'
            elif v == 1:
                yield prettify(idx, add_color=add_color) + '++'

            elif v < 0:
                yield prettify(idx, add_color=add_color) + ' -= ' + prettify(-v, add_color=add_color, parentheses=False)
            else:
                yield prettify(idx, add_color=add_color) + ' += ' + prettify(v, add_color=add_color, parentheses=False)

        elif val ~ ('add', idx, ('mul', -1, :v)):
            yield prettify(idx, add_color=add_color) + ' -= ' + prettify(v, add_color=add_color, parentheses=False)
        elif val ~ ('add', idx, :v):
            yield prettify(idx, add_color=add_color) + ' += ' + prettify(v, add_color=add_color, parentheses=False)
        elif val ~ ('add', ('mul', -1, :v), idx):
            yield prettify(idx, add_color=add_color) + ' -= ' + prettify(v, add_color=add_color, parentheses=False)
        elif val ~ ('add', :v, idx):
            yield prettify(idx, add_color=add_color) + ' += ' + prettify(v, add_color=add_color, parentheses=False)

        else:
            yield prettify(idx, add_color=add_color) + ' = ' + prettify(val, add_color=add_color, parentheses=False)

    elif r ~ ('stop', ...):
        yield 'stop'

    elif r ~ ('undefined', *params):
        yield COLOR_WARNING + '...' + ENDC + COLOR_GRAY + f'  # unusual jump {params}, couldn\'t decompile, sorry' + ENDC

    elif r ~ ('invalid', *rest):
        if len(rest) > 0:
            yield "revert "# + COLOR_GRAY + f"# {rest}" + ENDC
        else:
            yield "revert"

    elif r ~ ('invalid', ...):
        yield "revert " + (COLOR_GRAY + f"# {rest}" + ENDC)

    elif (r ~ ('revert', 0)) or \
         (r ~ ('revert', ('mem', 0, 0))):

        yield "revert"

    elif r ~ (:op, ('mem', ('range', :mem_idx, :mem_len))) and \
              op in ('revert', 'return'):

        if op == 'revert':
            yield 'revert with memory'
        else:
            yield op + ' memory'

        if len ~ ('sub', :mem_until, mem_idx):
            yield f"  from  {pret(mem_idx)}"
            yield f"    to {pret(mem_until)}"
        else:
            yield "  from " + pret(mem_idx)
            yield "   " + col('len', COLOR_WARNING) + " " + pret(mem_len)

    elif r ~ (:op, :param) and op in ('return', 'revert'):

        if op == 'revert':
            op = 'revert with'

        res_mem = pretty_memory(param, add_color=True)
        ret_val = ', '.join(res_mem)

        if len(clean_color(ret_val)) < 120 or opcode(param) != 'data':
            yield f'{op} {ret_val}'
        else:
            # split long returns into lines. e.g. kitties.getKitten, or kitties.tokenMetadata
#            yield str(len(ret_val))
            res_mem = list(res_mem)
            if res_mem[0] == '32':
                res_mem.pop(0)
                res_mem[0] = '32, ' + res_mem[0] # happens often, this is probably an array structure,
                                                 # and sole `32` in first line looks ugly

            yield f'{op} {res_mem[0]}, '
            for idx, l in enumerate(res_mem[1:]):
                yield ' '*len(op) + ' ' + l + (',' if idx != len(res_mem) - 2 else '')

#            assert op == 'revert'
#            yield "{} with {}".format(op, ret_val) # adding 'with' to make it more readable


    elif r ~ ('store', :size, :off, :idx, :val):
        stor_addr = prettify(('stor', size, off, idx), add_color=add_color)
        stor_val = prettify(val, add_color=add_color, parentheses=False)

        yield "{} = {}".format(stor_addr, stor_val)

    elif type(r) == list and len(r) > 1:
        yield "{} {}".format(r[0], ', '.join([prettify(x, True, False, add_color = add_color) for x in r[1:]]))

    elif type(r) == list:
        yield str(r[0])

    else:
        yield str(r)

def pretty_type(t):

    if t ~ ('def', :name, :loc, ('mask', :size, :off)):
        return pretty_type(('def', name, loc, size)) + COLOR_GRAY + (f' offset {off}' if off > 0 else '') + ENDC

    elif t ~ ('def', :name, :loc, :bts):
        if type(loc) == int and loc > 1000:
            loc = hex(loc)
        return f'  {COLOR_GREEN}{name}{ENDC} is {pretty_type(bts)} {COLOR_GRAY}at storage {loc}{ENDC}'

    elif t ~ ('struct', 1):
        return 'struct'

    elif t == 'struct':
        return 'struct'

    elif t ~ ('struct', int:num):
        return f'struct {num} bytes'

    elif t ~ ('array', :bts):
        return f'array of '+pretty_type(bts)

    elif t ~ ('mapping', :bts):
        return f'mapping of '+pretty_type(bts)

    elif type(t) == int:
        return mask_to_type(t, force=True)

    else:
        assert False, f'unknown type {t}'

def pretty_stor(exp, add_color=True):
    col = partial(colorize, color=COLOR_GREEN, add_color=add_color)
    stor = partial(pretty_stor, add_color=add_color)
    pret = partial(prettify, parentheses=False, add_color=add_color)

    if exp ~ ('stor', ('length', :idx)):
        return stor(idx) + col('.length')

    if exp ~ ('loc', :loc):
        return col(f'stor_l{loc}')

    if exp ~ ('name', :name, :loc):
        return col(name)

#    if exp ~ ('stor', (:op, :param)) and op in ('loc', 'name'):
        # with top-level fields, it's just a different stor
        # variable. with lower-level we treat it as a struct
#        return stor((op, param))

    if exp ~ ('stor', :loc):
        # with top-level fields, it's just a different stor
        # variable. with lower-level we treat it as a struct
        return stor(loc)

    if exp ~ ('field', :off, :loc):
        return stor(loc) + col(f'.field_{pret(off, add_color=False)}')

    if exp ~ ('type', :size, :loc):
        if size == 256:
            # prettify removes 256 masks by default, force it
            return col('uint256(', color=COLOR_GRAY) + stor(loc) + col(')', color=COLOR_GRAY)
        else:
            return pret(('mask', size, 0, stor(loc)))

    def pr_idx(idx):
        if idx ~ ('data', *terms):
            return col('][').join([pret(t) for t in terms])
        else:
            return pret(idx)

    if exp ~ ('map', :idx, :var):
        return stor(var) + col('[') + pr_idx(idx) + col(']')

    if exp ~ ('array', ('mul', int:_, :idx), :var):
        exp = ('array', idx, var) # nasty hack to not display storage[2*idx] for storages
                                  # that are structs
                                  # this should be handled in sparser really
#        return stor(var) + col('[') + pr_idx(idx) + col(']')


    if exp ~ ('array', :idx, :var):
        return stor(var) + col('[') + pr_idx(idx) + col(']')

    if exp ~ ('length', :var):
        return stor(var) + col('.length')

    if exp ~ ('stor', :loc):
        return col('stor[') + pret(loc) + col(']')

    if exp ~ ('stor', :size, :off, :loc):
        return pret(('mask', size, off, col('stor[') + pret(loc) + col(']')))

    return col('stor[') + pret(exp) + col(']')


def pretty_num(exp, add_color):
    col = partial(colorize, add_color=True)

    if type(exp) == float:
        if exp - int(exp) == 0:
            exp = int(exp)

    if type(exp) == int and exp > 8**50:
        return hex(exp) # dealing with binary data probably, usually in call code - display in hex

    if type(exp) == int and exp !=0:
        count = 18
        while count >= 9:

            if exp % (10**count) == 0:
                if exp // (10**count) == 1:
                    return f'10^{count}'
                else:
                    return f'{exp // (10**count)} * 10^{count}'

            count -= 1

        count = 6
        if exp % (10**count) == 0:
            if exp // (10**count) == 1:
                return f'10^{count}'
            else:
                return f'{exp // (10**count)} * 10^{count}'

    if type(exp) == int:
        if try_fname(exp, add_color) != None:
            return try_fname(exp, add_color)

        elif type(exp) == int and (exp&2**256-1)<8**30: # if it's larger than 30 bytes, it's probably
                                                          # an address, not a negative number
            return str(to_real_int(exp))

        elif exp>0:
            return hex(exp)

        else:
            return str(exp)

    # print('warn: weird float exp', exp)
    return str(exp)


def prettify(exp, rem_bool=False, parentheses=True, top_level=False, add_color=False):

    col = partial(colorize, add_color=add_color)
    pret = partial(prettify, add_color=add_color, parentheses=False)

    if rem_bool:
        exp = simplify_bool(exp)
        if opcode(exp) == 'bool':
            return prettify(exp, rem_bool=rem_bool, parentheses=parentheses, top_level=top_level, add_color=add_color)

    if type(exp) == int and exp % (24 * 3600) == 0 and exp > 24 * 3600:
        exp = ('mul', exp//3600, 24, 3600)

    if type(exp) == int and exp % 3600 == 0 and exp > 3600:
        exp = ('mul', exp//3600, 3600)
        # also tried return col('seconds(', COLOR_GRAY) + '1 hour' + col(')', COLOR_GRAY)
        # but seemed less intuitive, e.g. 0xf64B584972FE6055a770477670208d737Fff282f calcMaxWithdraw
        # and 3600 every programmer should know, by heart, means 1 hour :)
        #
        # also, not tackling single minutes because too often they are not time related

    if type(exp) in (int, float):
        return pretty_num(exp, add_color)

    if opcode(exp) in precompiled.values():
        return f'{exp[0]}({pret(exp[1])})'

    if exp ~ ('arr', int:num, ('mask_shl', _, _, _, str:s)) \
            and len(s) == num+2:
            return s

    if exp ~ ('param', :name):
        return col(name, COLOR_GREEN)

    if exp ~ ('range', :loc, :size):
        return '{} {} {}'.format(pret(loc),
                                 col('len', COLOR_HEADER),
                                  pret(size))

    if exp ~ ('data', ...):
        return ', '.join(pretty_memory(exp, add_color=add_color))

    if exp ~ ('arr', :l, *terms):
        return col('Array(len=', COLOR_GRAY) + pret(l)+ col(', data=', COLOR_GRAY) + pret(('data', )+terms) + col(')', COLOR_GRAY)

    if exp ~ ('blockhash', :number):
        return f'block.hash({pret(number)})'

    if exp ~ ('extcodehash', :addr):
        return f'ext_code.hash({pret(addr)})'

    if exp ~ ('extcodesize', :addr):
        return f'ext_code.size({pret(addr)})'

    if exp ~ ('extcodecopy', :addr, :loc):
        return f'ext_code.copy({pret(addr)}, {pret(loc)})'


    if exp ~ ('max', *terms):
        return 'max({})'.format(', '.join([pret(e) for e in terms]))

    if exp == 'number':
        return 'block.number'

    if exp == 'calldatasize':
        return 'calldata.size'

    if exp == 'returndatasize':
        return 'return_data.size'

    if exp == 'difficulty':
        return 'block.difficulty'

    if exp == 'gasprice':
        return 'block.gasprice'

    if exp == 'timestamp':
        return 'block.timestamp'

    if exp == 'coinbase':
        return 'block.coinbase'

    if exp == 'gaslimit':
        return 'block.gas_limit'

    if exp == 'callvalue':
        return 'call.value'

    if exp == 'address':
        return 'this.address'

    if exp ~ ('mask_shl', 160, 0, 0, 'caller'):
        return 'caller'

    if exp == 'caller':
        return 'caller'

    if exp ~ ('mask_shl', 160, 0, 0, 'origin'):
        return 'tx.origin'

    if exp ~ ('mulmod', :a, :b, :c):
        return f'mulmod({pret(a)}, {pret(b)}, {pret(c)})' # mulmod should really be replaced by mul & mod in other stages
                                                          # but this is rare enough to ignore for now

    if exp == 'origin':
        return 'tx.origin'

    if exp == 'gas':
        return 'gas_remaining'

    if exp == ('bool', 1):
        return 'True'

    if exp == ('bool', 0):
        return 'False'

    if exp ~ ('code.data', :c_start, :c_len):
        return f'code.data[{pret(c_start)} len {pret(c_len)}]'

    if exp ~ ('balance', :addr):
        return f'eth.balance({pret(addr)})'

    if exp ~ ('sha3', *terms):
        return 'sha3({})'.format(', '.join([pret(e) for e in terms]))

#    if exp ~ ('mask_shl', 251, 5, 0, :val):
#        return pret(('mul', 32, val))

    if (exp ~ ('mask_shl', :size, 5, 0, :val) or
        exp ~ ('mask', :size, 5, :val)) and size > 245:
            if val ~ ('add', 31, :num):
                return f'ceil32({pret(num)})'
            else:
                return f'floor32({pret(val)})'

    if exp ~ ('call.data', ('add', 36, ('param', :p_name)), :size) and \
        size == ('cd', ('add', 4, ('param', p_name))):
        return f"{col(p_name+'[', C.green)}"+'all'+col(']', C.green)

    if exp ~ (:name, :offset, :size) and is_array(name):# in ('call.data', 'ext_call.return_data'):
        if size == 32:
            return name+f'[{pret(offset)}]'
        else:
            return name+f'[{pret(offset)} len {pret(size)}]'

    if exp ~ ('mask_shl', :size, :offset, :shl, ('stor', :s_size, :s_off, :s_idx)) and \
        safe_le_op(s_size, size) and shl == 0:
            return pret(('stor', s_size, s_off, s_idx))

    if exp ~ ('stor', ...):
        return pretty_stor(exp, add_color=add_color)

    if exp ~ ('type', ...):
        return pretty_stor(exp, add_color=add_color)

    if exp ~ ('field', ...):
        return pretty_stor(exp, add_color=add_color)

    if exp ~ ('cd', :num):
        if num == 0:
            return(col('call.func_hash', C.green))
        parsed_exp = get_param_name(exp, add_color=add_color)

        if type(parsed_exp) != str:
            return 'cd['+prettify(parsed_exp[1], add_color=add_color)+']'
        else:
            return parsed_exp

    if exp ~ ('var', int:idx):
        nice_names = ['idx','s','t','u','v','w','x','y','z','a','b','c','d','e','f','g','h'] # 'i','j','k','l','m','n','o','p','q','r',
        if idx < len(nice_names):
            name = nice_names[idx]
        else:
            name = 'var'+str(idx)

        return col(name, COLOR_BLUE)

    if exp ~ ('var', :name):
        return col(str(name), COLOR_BLUE)

    if exp ~ ('mem', ('range', :loc, 32)):
        exp = ('mem', loc)

    if exp ~ ('mem', ('range', :loc, :size)):
            return col('mem[', COLOR_HEADER) + \
                   pret(loc) + \
                   col(' len ', COLOR_HEADER) + \
                   pret(size) + col(']', COLOR_HEADER)

    elif exp ~ ('mem', :idx):
                assert opcode(idx) != 'range'

                return col('mem[', COLOR_HEADER) + \
                       pret(idx) + \
                       col(']', COLOR_HEADER)


    if exp ~ ('setvar', :idx, :val): # shouldn't be pretty line?
        return pret(('var', idx)) + ' = ' + pret(val, parentheses=False)

    if exp ~ ('setmem', :idx, :val): # --,,--
        return pret(('mem', idx)) + ' = ' + \
                pret(val)

    if exp ~ ('mask_shl', :size, :offset, :shl, :val):

        if all_concrete(size, offset, shl) and \
            exp[1] + exp[2] == 256 and exp[2] == -exp[3] and exp[2] < 8:
                # e.g. (Mask(255, 1, eth.balance(this.address)) >> 1
                #           --> eth.balance(this.address) / 2
                # for offsets smaller than 8

            if exp[3] <= 8:
                return pret(('div', exp[4], 2**-exp[3]), parentheses=parentheses)
            else:
                return pret(('shr', exp[3], exp[4]), parentheses=parentheses)

        if (type(exp[1]), type(exp[2]), type(exp[3])) == (int, int, int) and\
            exp[2] == exp[3] and exp[2] < 8:
                # e.g. (Mask(255, 1, eth.balance(this.address)) << x
                #           --> eth.balance(this.address) * 2**x
                # for offsets smaller than 8

            if size + offset != 256 and opcode(val) != 'store': # opcode=store - hotfix for 0x000000000045Ef846Ac1cB7fa62cA926D5701512
                val = ('mask', size + offset, 0, val) # 0 because exp2 == exp3

            if exp[3] == 0:
                return pret(val, parentheses=parentheses)
            elif exp[3] <= 8 and exp[3] >= -8:
                return pret(('mul', val, 2**exp[3]), parentheses=parentheses)
            elif exp[3] > 0:
                return pret(('shl', exp[3], val, ), parentheses=parentheses)
            else:
                return pret(('shr', -exp[3], val, ), parentheses=parentheses)



        if all_concrete(size, offset, shl, val):
            return pret(apply_mask(exp[4], exp[1], exp[2], exp[3]))

        if shl == 0:
            exp = ('mask', size, offset, val)

        elif safe_ge_zero(shl) is not False:

            if all_concrete(size, offset, shl) and \
                 size+shl == 256 and offset == 0 and shl > -8:
                    exp = ('mul', 2**exp[3], exp[4])
            else:
                if type(exp[3]) == int and exp[3] < 7 and exp[3] >= -8:
                    exp = ('mul', 2**exp[3], ('mask', exp[1], exp[2], exp[4]))

                elif type(exp[3]) == int and exp[3] < 0:
                    exp = ('shr', -exp[3], ('mask', exp[1], exp[2], exp[4]))
                else:
                    exp = ('shl', exp[3], ('mask', exp[1], exp[2], exp[4]))

        else:
            exp = ('shr', mul_op(-1, exp[3]), ('mask', exp[1], exp[2], exp[4]))

    if exp ~ ('mask', :size, 0, :val):
        if size == 256:
            return pret(val)

        if type(size) == int:
            if size == 255:
                type_name = 'uint255'
            else:
                type_name = mask_to_type(size)

            if type_name is not None:
                return col(type_name + '(', COLOR_GRAY) + \
                        pret(val) + \
                        col(")", COLOR_GRAY)

    if exp ~ ('bool', :val):
        if opcode(val) in ('lt', 'gt', 'iszero', 'le', 'ge', 'bool'):
            return pret(val, parentheses=parentheses)
        else:
            return "bool("+pret(val)+")"

    if exp ~ ('mask', :size, :offset, :val):
        if type(size) == int and offset == 0 and size < 64:
            return pret(('mod', val, 2**size), parentheses=parentheses)
        else:
            return 'Mask({}, {}, {})'.format(pret(size), pret(offset), pret(val))

#    if opcode(exp) in ('byte', 'bytes8', 'uint16', 'bytes4', 'addr', 'int256'):
#        return prettify('{}({})'.format(opcode(exp).lower(), prettify(exp[1], add_color=add_color)), add_color=add_color)

    opcode_to_arithm = {
        'sub': ' - ', # todo - parentheses?
        'div': ' / ',
        'mul': ' * ',
        'gt': ' > ',
        'lt': ' < ',
        'le': ' <= ',
        'ge': ' >= ',
        'or': ' or ',
        'eq': ' == ',
        'mod': ' % ',
        'shl': ' << ',
        'shr': ' >> ',
        'exp': '^',
        'and': ' and ',
        'sge': ' >=′ ',
        'sle': ' <=′ ',
        'sgt': ' >′ ',
        'slt': ' <′ ',
        'sadd': ' +′ ',
        'smul': ' *′ ',
        'sdiv': ' /′ ',

        'xor': ' xor ',
    }

    def pretty_adds(exp):
        if opcode(exp) != 'add':
            return prettify(exp, add_color = add_color)

        if type(exp[1]) == float:
            real = exp[1]
            if int(real) == real:
                real = int(real) # 32.0 -> 32

            symbolic = exp[2:]
            res = ' + '.join([prettify(x, add_color=add_color) for x in symbolic])
            if real > 0:
                res += ' + ' + prettify(real)
            elif real < 0:
                res += ' - ' + prettify(-real)


        elif type(exp[1]) == int:
            real = to_real_int(exp[1])
            symbolic = exp[2:]
            res = ' + '.join([prettify(x, add_color=add_color) for x in symbolic])
            if real > 0:
                res += ' + ' + prettify(real)
            elif real < 0:
                res += ' - ' + prettify(-real)

        else:
            res = ''
            for x in exp[1:]:
                if res == '':
                    res = prettify(x, add_color=add_color)
                elif opcode(x) == 'mul' and type(x[1]) == int and x[1] < 0:
                    res += ' - ' + prettify(minus_op(x), add_color=add_color)
                else:
                    res += ' + ' + prettify(x, add_color=add_color)

        if parentheses:
            return f'({res})'
        else:
            return res

    if opcode(exp) == 'not':
        return COLOR_BOLD+'!'+ENDC+prettify(exp[1], add_color = add_color)

    if opcode(exp) == 'add':
        return pretty_adds(exp)

    if opcode(exp) == 'mul' and len(exp)==3 and to_exp2(exp[1]) != None and to_exp2(exp[1]) > 32:
        exp = ('shl', to_exp2(exp[1]), exp[2])

    if exp ~ ('mul', -1, :val):
        return "-" + pret(val, parentheses=parentheses)

    if exp ~ ('mul', 1, :val):
        return pret(val, parentheses=parentheses)

    if exp ~ ('mul', 1, *rest):
        return pret(('mul', ) + rest, parentheses=parentheses)

    if exp ~ ('div', :num, 1):
        return pret(num, parentheses=parentheses)

    if exp ~ ('exp', :a, :n):
        return pret(a, parentheses=True) + '^' + pret(n, parentheses=True)

    if opcode(exp) in opcode_to_arithm:

        if opcode(exp) in ['shl', 'shr']:
            exp = exp[0], exp[2], exp[1]

        form = '{}'
        if parentheses and not top_level:
            form = '({})'

        op_form = opcode_to_arithm[opcode(exp)]
        if add_color:
            op_form = COLOR_BOLD + op_form + ENDC


        def fold_ands(exp):
            assert opcode(exp) == 'and'

            res = tuple()
            for e in exp[1:]:
                if opcode(e) == 'and':
                    e = fold_ands(e)
                    res += e[1:]
                else:
                    res += (e, )

            return ('and', ) + res

        if opcode(exp) == 'and':
            exp = fold_ands(exp)
            return form.format(op_form.join(pret(e, rem_bool=True) for e in exp[1:]))
        else:
            return form.format(op_form.join(pret(e) for e in exp[1:]))

    if exp ~ ('iszero', :val):

        if val ~ ('gt', :left, :right):
            return pret(left) + ' <= ' + pret(right)

        if val ~ ('lt', :left, :right):
            return pret(left) + ' >= ' + pret(right)

        if val ~ ('eq', :left, :right):
            if type(left) in (str, int):
                return pret(right) + ' != ' + pret(left)
            else:
                return pret(left) + ' != ' + pret(right)

        return 'not '+pret(val)

    return str(exp)


def pretty_gas(gas, value, add_color):
    if gas ~ ('mul', 2300, ('iszero', _)):
        # should check if _ == value
        return '2300 * is_zero(value)'
    else:
        return prettify(gas, add_color=add_color, parentheses=False)

def try_fname(exp, add_color=False):
    if Loader.find_sig(hex(exp)[:10]):
        return Loader.find_sig(hex(exp)[:10], add_color)

    elif len(hex(exp))>=63 and Loader.find_sig(padded_hex(exp,64)[:10], add_color):# in Loader.signatures: # if three last letters are "0"s, but no more, so there is
                                                                           # a low chance for mistaking a random number for function sig
        return Loader.find_sig(padded_hex(exp,64)[:10], add_color)

    elif len(hex(exp))>=8 and Loader.find_sig(padded_hex(exp,8)[:10], add_color):# in Loader.signatures:
        return Loader.find_sig(padded_hex(exp,8)[:10], add_color)

    else:
        return None

def pretty_fname(exp, add_color=False, force=False):
    if type(exp) == int:
        if try_fname(exp) and 'unknown_' not in try_fname(exp):
            return try_fname(exp, add_color)
        else:
            return hex(exp)

    elif opcode(exp) == 'mem' or force:
        return prettify(exp, add_color=add_color)

    return exp

def pretty_memory(exp, add_color=False):
    if exp is None:
        return tuple()

    if exp == 'mem':
        return prettify(exp, add_color=add_color)

    if opcode(exp) != 'data':
        return (prettify(exp, add_color=add_color), )

    exp = exp[1:]

    if len(exp) == 0:
        return 'empty()'
    assert len(exp) > 0, exp

    res = []

    idx = 0

    def unmask(exp):
        if opcode(exp) == 'mask_shl':
            return exp[4]

        return exp

    # merge things that look like string into a string

    while idx < len(exp):

        if idx == 0 and type(exp[0]) == tuple and exp[0][:4] == ('mask_shl', 32, 224, 0) and type(exp[0][4]) == int:
            # This happens often in Log and Revert, first
            # memory result being an 8-byte identifier.
            # Definitely deserves a more generic solution.
            #
            # example: 0xd883209C4DCd497f24633C627a4E451013424841, sendFoods function
            v = exp[0][4] >> 224
            res.append( pretty_fname(v, add_color) )
            idx += 1
            continue

        el = exp[idx]

        # detect a potential string

        out_str = None

        if unmask(el) == 32 and len(exp)>idx+1:

            length = unmask(exp[idx+1])
            if type(length) == int:
                byte_length = ((length-1) >> 5) +1
                out_str = ''

                if type(length) == int and len(exp) > idx + 1 + byte_length:
                    for i in range(byte_length):
                        if type(unmask(exp[idx+2+i])) == str:
                            out_str += unmask(exp[idx+2+i])[1:-1]
                        elif type(pretty_bignum(unmask(exp[idx+2+i]))) == str:
                            # could also make sure that the length of string is the same
                            # as expected
                            out_str += pretty_bignum(unmask(exp[idx+2+i]))[1:-1]
                        else:
                            out_str = None
                            break

                    if out_str != None:
                        idx = idx + 1 + byte_length
                else:
                    out_str = None
            else:
                out_str = None

        if out_str != None:
            res.append("'"+out_str+"'")
        else:
            res.append(prettify(el, add_color=add_color, parentheses=False))

        idx = idx+1


    return tuple(res)

