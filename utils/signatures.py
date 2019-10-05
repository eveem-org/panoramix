# coding: tilde

from .profiler import checkpoint

import json
from .helpers import opcode, colorize, cleanup_mul_1

from .helpers import COLOR_HEADER, COLOR_BLUE, COLOR_OKGREEN, COLOR_WARNING, FAIL, ENDC, COLOR_BOLD, COLOR_UNDERLINE, COLOR_GREEN, COLOR_GRAY
import hashlib
import os.path

from .supplement import fetch_sigs

import sys

_current_hash = None
_abi = None
_func = None

def set_func_params_if_none(params):
    if 'params' not in _func:
        res = []
        for t, n in params.values():
            res.append({'type':t, 'name':n})

        _func['params'] = res

def set_func(hash):
    global _func
    global _abi
    global _current_fname

    _current_hash = hash
    assert _abi is not None
    _func = _abi[hash]

def get_param_name(cd, add_color=False, func=None):
    global _func
    global _abi
    global _current_hash
    assert cd ~ ('cd', :loc)

    if _abi is None:
        return cd

    if _func is None:
        return cd

    if 'params' not in _func:
        return cd

    if type(loc) != int:
        cd = cleanup_mul_1(cd)

        if loc ~ ('add', 4, ('param', :point_loc)):
            return colorize(point_loc + '.length', COLOR_GREEN, add_color)

        if loc ~ ('add', 4, ('cd', :point_loc)):
            return colorize(str(get_param_name(('cd',point_loc))) + '.length', COLOR_GREEN, add_color)

        elif loc ~ ('add', int:offset, ('cd', :point_loc)):
            return colorize(str(get_param_name(('cd',point_loc))) + f'[{(offset - 36)//32}]', COLOR_GREEN, add_color)
            
        else:
            return cd

    if (loc-4) % 32 != 0: # unusual parameter
        return cd #

    num = (cd[1]-4) // 32
    if num >= len(_func['params']):
        return cd

    assert num<len(_func['params']), str(cd)+' // '+str(func['params'])

    if _func['params'][num]['name'][-1] == '_':
        new_name = _func['params'][num]['name'][:-1]
    else:
        new_name = _func['params'][num]['name']

    return colorize(_func['params'][num]['name'], COLOR_GREEN, add_color)

def get_abi_name(hash):
    a = _abi[hash]
    if 'params' in a:
        return '{}({})'.format(a['name'],','.join([x['type'] for x in a['params']]))

def get_func_params(hash):
    a = _abi[hash]
    if 'params' in a:
        return a['params']
    else:
        return []

def get_func_name(hash, add_color=False):
    a = _abi[hash]
    if 'params' in a:
        return '{}({})'.format(a['name'],', '.join([x['type']+' '+colorize(x['name'][:-1] if x['name'][-1]=='_' else x['name'],COLOR_GREEN,add_color) for x in a['params']]))
    else:
        return a['folded_name']

def match_score(func, hashes):
    # returns % score of this function's 

    score_a = 0

    for h in hashes:
        if h in func['cooccurs']:
            score_a += 1

    score_a = 10*score_a/len(hashes)

    score_b = 0

    for h in func['cooccurs']:
        if h in hashes:
            score_b += 1

    score_b = score_b/len(func['cooccurs'])

    score_c = 0 if 'param' in str(func['params']) else 100

    return score_a+score_b+score_c

def make_abi(hash_targets):
    global _abi


    hash_name = str(list(hash_targets.keys())).encode('utf-8')
    hash_name = hashlib.sha256(hash_name).hexdigest()

    
    dir_name = 'cache_pabi/'+hash_name[:3]+'/' #:3, because there's not '0x' at the beginning

    if not os.path.isdir('cache_pabi'):
        os.mkdir('cache_pabi')

    if not os.path.isdir(dir_name):
        os.mkdir(dir_name)

    cache_fname = dir_name+hash_name+".pabi"


    if os.path.isfile(cache_fname):
        with open(cache_fname) as f:
            _abi = json.loads(f.read())

        return _abi

    if '--silent' not in sys.argv:
        print("cache for PABI not found, generating...")

    hashes = list(hash_targets.keys())

    result = {}

    for h, target in hash_targets.items():

        res = {
            'fname': "unknown"+h[2:]+"()",
            'folded_name': "unknown"+h[2:]+"(?)"
        }

        if "0x" not in h: # assuming index is a name - e.g. for _fallback()

            res['fname'] = h
            res['folded_name'] = h
        
        else:

            sigs = fetch_sigs(h)


            if len(sigs) > 0:
                candidates = []
                best_score = 0

                for f in sigs:
                    score = match_score(f, hashes)
                    if score>best_score:
                        res = {'name':f['name'],
                                'folded_name':f['folded_name'],
                                'params':f['params'],}

        res['target'] = target

        result[h] = res

    _abi = result

    with open(cache_fname, 'w+') as f:
        f.write(json.dumps(result, indent = 2))

    return result

