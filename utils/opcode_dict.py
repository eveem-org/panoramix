'''
    contains opcode_dict and stack_diffs dictionaries

    opcode_dict is used by the loader to disassemble a contract
    stack_diffs is used by vm.apply_stack to test the proper parsing of opcodes

'''

opcode_dict = {
    #
    # Stop and Arithmetic
    #
    0x00: 'stop',
    0x01: 'add',
    0x02: 'mul',
    0x03: 'sub',
    0x04: 'div',
    0x05: 'sdiv',
    0x06: 'mod',
    0x07: 'smod',
    0x08: 'addmod',
    0x09: 'mulmod',
    0x0a: 'exp',
    0x0b: 'signextend',


    #
    # Comparison and Bitwise Logic
    #
    0x10: 'lt',
    0x11: 'gt',
    0x12: 'slt',
    0x13: 'sgt',
    0x14: 'eq',
    0x15: 'iszero',
    0x16: 'and',
    0x17: 'or',
    0x18: 'xor',
    0x19: 'not',
    0x1a: 'byte',
    0x1b: 'shl',
    0x1c: 'shr',
    0x1d: 'sar',


    #
    # Sha3
    #
    0x20: 'sha3',


    #
    # Environment Information
    #
    0x30: 'address',
    0x31: 'balance',
    0x32: 'origin',
    0x33: 'caller',
    0x34: 'callvalue',
    0x35: 'calldataload',
    0x36: 'calldatasize',
    0x37: 'calldatacopy',
    0x38: 'codesize',
    0x39: 'codecopy',
    0x3a: 'gasprice',
    0x3b: 'extcodesize',
    0x3c: 'extcodecopy',
    0x3d: 'returndatasize',
    0x3e: 'returndatacopy',
    0x3f: 'extcodehash',

    #
    # Block Information
    #
    0x40: 'blockhash',
    0x41: 'coinbase',
    0x42: 'timestamp',
    0x43: 'number',
    0x44: 'difficulty',
    0x45: 'gaslimit',
    0x46: 'chainid',
    0x47: 'selfbalance',


    #
    # Stack, Memory, Storage and Flow Operations
    #
    0x50: 'pop',

    0x51: 'mload',
    0x52: 'mstore',
    0x53: 'mstore8',
    0x54: 'sload',
    0x55: 'sstore',
    0x56: 'jump',
    0x57: 'jumpi',
    0x58: 'pc',
    0x59: 'msize',
    0x5a: 'gas',
    0x5b: 'jumpdest',


    #
    # Push Operations
    #
    0x60: 'push1',
    0x61: 'push2',
    0x62: 'push3',
    0x63: 'push4',
    0x64: 'push5',
    0x65: 'push6',
    0x66: 'push7',
    0x67: 'push8',
    0x68: 'push9',
    0x69: 'push10',
    0x6a: 'push11',
    0x6b: 'push12',
    0x6c: 'push13',
    0x6d: 'push14',
    0x6e: 'push15',
    0x6f: 'push16',
    0x70: 'push17',
    0x71: 'push18',
    0x72: 'push19',
    0x73: 'push20',
    0x74: 'push21',
    0x75: 'push22',
    0x76: 'push23',
    0x77: 'push24',
    0x78: 'push25',
    0x79: 'push26',
    0x7a: 'push27',
    0x7b: 'push28',
    0x7c: 'push29',
    0x7d: 'push30',
    0x7e: 'push31',
    0x7f: 'push32',


    #
    # Duplicate Operations
    #
    0x80: 'dup1',
    0x81: 'dup2',
    0x82: 'dup3',
    0x83: 'dup4',
    0x84: 'dup5',
    0x85: 'dup6',
    0x86: 'dup7',
    0x87: 'dup8',
    0x88: 'dup9',
    0x89: 'dup10',
    0x8a: 'dup11',
    0x8b: 'dup12',
    0x8c: 'dup13',
    0x8d: 'dup14',
    0x8e: 'dup15',
    0x8f: 'dup16',


    #
    # Exchange Operations
    #
    0x90: 'swap1',
    0x91: 'swap2',
    0x92: 'swap3',
    0x93: 'swap4',
    0x94: 'swap5',
    0x95: 'swap6',
    0x96: 'swap7',
    0x97: 'swap8',
    0x98: 'swap9',
    0x99: 'swap10',
    0x9a: 'swap11',
    0x9b: 'swap12',
    0x9c: 'swap13',
    0x9d: 'swap14',
    0x9e: 'swap15',
    0x9f: 'swap16',


    #
    # Logging
    #
    0xa0: 'log0',
    0xa1: 'log1',
    0xa2: 'log2',
    0xa3: 'log3',
    0xa4: 'log4',


    #
    # System
    #
    0xf0: 'create',
    0xf1: 'call',
    0xf2: 'callcode',
    0xf3: 'return',
    0xf4: 'delegatecall',
    0xf5: 'create2',
    0xfa: 'staticcall',
    0xfd: 'revert',
    0xfe: 'invalid',
    0xff: 'selfdestruct',

}

# stack_diffs is used when testing if an opcode
# was parsed correctly in vm.apply_stack

stack_diffs = {
  "create": -2,
  "create2": -3,
  "invalid": None,
  "add": -1,
  "addmod": -2,
  "sub": -1,
  "mod": -1,
  "smod": -1,
  "mul": -1,
  "mulmod": -2,
  "div": -1,
  "sdiv": -1,
  "exp": -1,
  "signextend": -1,
  "shl": -1,
  "shr": -1,
  "sar": -1,
  "blockhash": 0,
  "coinbase": 1,
  "selfdestruct": -1,
  "timestamp": 1,
  "number": 1,
  "difficulty": 1,
  "gaslimit": 1,
  "lt": -1,
  "gt": -1,
  "slt": -1,
  "sgt": -1,
  "eq": -1,
  "iszero": 0,
  "and": -1,
  "or": -1,
  "xor": -1,
  "not": 0,
  "byte": -1,
  "balance": 0,
  "origin": 1,
  "address": 1,
  "selfbalance": 1,
  "chainid": 1,
  "call": -6,
  "callcode": -6,
  "delegatecall": -5,
  "staticcall": -5,
  "caller": 1,
  "callvalue": 1,
  "calldataload": 0,
  "calldatasize": 1,
  "calldatacopy": -3,
  "codesize": 1,
  "codecopy": -3,
  "gasprice": 1,
  "extcodesize": 0,
  "extcodehash": 0,
  "extcodecopy": -4,
  "returndatasize": 1,
  "returndatacopy": -3,
  "dup_XX": 1,
  "stop": 0,
  "jump": -1,
  "jumpi": -2,
  "jumpdest": 0,
  "pc": 1,
  "gas": 1,
  "log0": -2,
  "log1": -3,
  "log2": -4,
  "log3": -5,
  "log4": -6,
  "mstore": -2,
  "mstore8": -2,
  "mload": 0,
  "msize": 1,
  "sha3": -1,
  "pop": -1,
  "push_XX": 1,
  "sstore": -2,
  "sload": 0,
  "return": -2,
  "revert": -2,
  "assert_fail": 0,
  "push": 1,
  "dup": 1,
  "swap": 0,
  "push1": 1,
  "push2": 1,
  "push3": 1,
  "push4": 1,
  "push5": 1,
  "push6": 1,
  "push7": 1,
  "push8": 1,
  "push9": 1,
  "push10": 1,
  "push11": 1,
  "push12": 1,
  "push13": 1,
  "push14": 1,
  "push15": 1,
  "push16": 1,
  "push17": 1,
  "push18": 1,
  "push19": 1,
  "push20": 1,
  "push21": 1,
  "push22": 1,
  "push23": 1,
  "push24": 1,
  "push25": 1,
  "push26": 1,
  "push27": 1,
  "push28": 1,
  "push29": 1,
  "push30": 1,
  "push31": 1,
  "push32": 1,
  "dup1": 1,
  "swap1": 0,
  "dup2": 1,
  "swap2": 0,
  "dup3": 1,
  "swap3": 0,
  "dup4": 1,
  "swap4": 0,
  "dup5": 1,
  "swap5": 0,
  "dup6": 1,
  "swap6": 0,
  "dup7": 1,
  "swap7": 0,
  "dup8": 1,
  "swap8": 0,
  "dup9": 1,
  "swap9": 0,
  "dup10": 1,
  "swap10": 0,
  "dup11": 1,
  "swap11": 0,
  "dup12": 1,
  "swap12": 0,
  "dup13": 1,
  "swap13": 0,
  "dup14": 1,
  "swap14": 0,
  "dup15": 1,
  "swap15": 0,
  "dup16": 1,
  "swap16": 0

}
