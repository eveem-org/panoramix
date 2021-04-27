# coding: tilde
import json

import pano.sparser as sparser

from .sparser import get_loc, get_name

from .function import Function

from pano.prettify import pprint_trace, pretty_stor, pprint_ast, prettify

from utils.helpers import replace_f, tuplify, COLOR_GREEN, ENDC, replace_lines, find_f_list, to_exp2

import pano.folder as folder
import logging

logger = logging.getLogger(__name__)

def deserialize(trace):
    res = []
    for line in trace:
        line_t = tuple(line)

        if line_t ~ ('while', :cond, :path, :lid, :setvars):
            cond = tuplify(cond)
            setvars = tuplify(setvars)
            assert type(lid) == str

            path = deserialize(path)
            res.append(('while', cond, path, lid, setvars))

        elif line_t ~ ('if', :cond, :if_true, :if_false):
            cond = tuplify(cond)
            if_true = deserialize(if_true)
            if_false = deserialize(if_false)
            res.append(('if', cond, if_true, if_false))

        else:
            res.append(tuplify(line))

    return res


class Contract():

    def __init__(self, addr, network, functions, problems, ver):
        self.addr = addr
        self.network = network
        self.ver = ver
        self.problems = problems
        self.functions = []
        for func in functions.values():
            self.functions.append(func)

        self.stor_defs = {}

    def json(self):
        return json.dumps({
                'addr': self.addr,
                'network': self.network,
                'ver': self.ver,
                'problems': self.problems,
                'stor_defs': self.stor_defs,
                'functions': [f.serialize() for f in self.functions],
            })

    def load(self, data):
        self.addr = data['addr']
        self.network = data['network']
        self.ver = data['ver']
        self.problems = data['problems']
        self.functions = []
        self.stor_defs = data['stor_defs'] if 'stor_defs' in data else {}

        for func in data['functions']:
            self.functions.append(Function(hash=func['hash'],
                                           trace=deserialize(func['trace'])))

        return self

    def postprocess(self):
        try:
            self.stor_defs = sparser.rewrite_functions(self.functions)
        except Exception:
            # this is critical, because it causes full contract to display very
            # badly, and cannot be limited in scope to just one affected function
            logger.exception('Storage postprocessing failed. This is very bad!')
            self.stor_defs = {}

        for func in self.functions:
            def replace_names(exp):
                if (exp ~ ('cd', int:idx)) and idx in func.params:
                    return ('param', func.params[idx][1])
                return exp

            func.trace = replace_f(func.trace, replace_names)

        # const list, sort by putting all-caps consts at the end - looks way better this way
        self.consts = [f for f in self.functions if f.const and f.name.upper() != f.name] + \
                      [f for f in self.functions if f.const and f.name.upper() == f.name]

        self.make_asts()

    def make_asts(self):
        '''
            we need to do ast creation from the contract, not function level,
            because some simplifications (type/field removal) require insight to all the functions,
            not just a single one
        '''

        for func in self.functions:
            func.ast = self.make_ast(func.trace)

        def find_stor_masks(exp):
            if exp ~ ('type', ...):
                return [exp]
            else:
                return []

        mlist = set(find_f_list([f.ast for f in self.functions], find_stor_masks))

        def cleanup(exp):

            if exp ~ ('field', 0, ('stor', ('length', :idx))):
                return ('stor', ('length', idx))

            if exp ~ ('type', 256, ('field', 0, ('stor', ('length', :idx)))):
                return ('stor', ('length', idx))

            if exp ~ ('type', 256, ('stor', ('length', :idx))):
                return ('stor', ('length', idx))

            if exp ~ ('type', :e_type, ('field', :e_field, ('stor', ('name', :e_name, :loc)))):
                for m in mlist:
                    if get_name(m) == e_name:
                        assert get_loc(m) == loc # otherwise, two locs with the same name?

                        assert m ~ ('type', :m_type, ('field', :m_field, _))
                        if m_field != e_field or m_type != e_type:
                            return exp
                else:
                    return ('stor', ('name', e_name, loc))


            elif exp ~ ('type', :e_type, :stor):
                e_loc = get_loc(stor)

                for m in mlist:
                    if m ~ ('type', 256, ('field', 0, ('stor', ('length', _)))):
                        continue

                    if get_loc(m) == e_loc:
                        assert m ~ ('type', :m_type, _)
                        if m_type != e_type:
                            return exp
                else:
                    return stor

            elif exp ~ ('field', :e_off, :stor):
                e_loc = get_loc(stor)

                for m in mlist:
                    if m ~ ('type', 256, ('field', 0, ('stor', ('length', _)))):
                        continue

                    if get_loc(m) == e_loc:
                        assert m ~ ('type', _, ('field', :m_off, _))
                        if m_off != e_off:
                            return exp
                else:
                    return stor

            else:
                return exp

        for f in self.functions:
            f.ast = replace_f(f.ast, cleanup)


    def make_ast(self, trace):
        trace = folder.fold(trace)

        def store_to_set(line):
            if line ~ ('store', :size, :off, :idx, :val):
                return ('set', ('stor', size, off, idx), val)
            else:
                return line

        def loc_to_name(exp):
            if exp ~ ('loc', int:num):
                if num < 1000:
                    return ('name', 'stor' + str(num), num)
                else:
                    return ('name', 'stor' + hex(num)[2:6].upper(), num)

            if exp ~ ('loc', :num):
                return ('name', 'stor' + prettify(num, add_color=False, parentheses=True), num)
            else:
                return exp

        def arr_rem_mul(exp):
            if exp ~ ('array', ('mask_shl', :size, :off, int:shl, :idx), :loc):
                r = 2 ** shl
                e_loc = get_loc(loc)

                for s in self.stor_defs:
                    assert s ~ ('def', _, :d_loc, :d_def)
                    if s ~ ('def', _, e_loc, ('array', ('struct', r))):
                        return ('array', ('mask_shl', size, off, 0, idx), loc)

#                exit()


            elif exp ~ ('array', ('mul', int:r, :idx), :loc):
                e_loc = get_loc(loc)

                for s in self.stor_defs:
                    assert s ~ ('def', _, :d_loc, :d_def)
                    if s ~ ('def', _, e_loc, ('array', ('struct', r))):
                        return ('array', idx, loc)
            return exp


        def mask_storage(exp):
            if exp ~ ('stor', :size, :off, :idx):
                if isinstance(off, int) and  off < 0:
                    off = 0
                return ('type', size, ('field', off, ('stor', idx)))
            else:
                return exp

        def other_1(exp):
            if exp ~ ('mask_shl', int:size, 256-size, size-256, str:val) and \
                size + 16 == len(val) * 8 and len(val)>0 and val[0] == val[-1] == "'": # +16 because '' in strings
                    return val
            else:
                return exp

        def other_2(exp):
            if exp ~ ('if', ('eq', :a, :b), :if_true) and \
                if_true == [('return', ('eq', a, b))]:
                return ('if', ('eq', a, b), [('return', ('bool', 1))])

            elif exp ~ ('mask_shl', 160, 0, 0, str:e) and \
                e in ('address','coinbase', 'caller', 'origin',):
                    return e

            elif exp ~ ('mask_shl', int:size, int:off, -off, :e) and \
                off in range(1, 9) and size+off in [8,16,32,64,128,256]:
                    return ('div', ('mask', size+off, 0, e), 2**off)

            elif exp == ('mask_shl', 32, 224, 0, ('cd', 0)):
                return ('cd', 0)

            elif exp ~ ('mask_shl', 160, 0, 96, :val):
                # nasty hack for stuff like 0xF8DFaC6CAe56736FD2a05e45108490C6Cb40147D approve
                return ('mask_shl', 160, 0, 0, val)

            else:
                return exp

        trace = replace_f(trace, store_to_set)
        trace = replace_f(trace, loc_to_name)
        trace = replace_f(trace, arr_rem_mul)
        trace = replace_f(trace, mask_storage)
        trace = replace_f(trace, other_1)
        trace = replace_f(trace, other_2)
        return trace

