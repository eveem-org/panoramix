# Palkeoramix decompiler. 

def storage:
  owner is addr at storage 0
  allowance is mapping of uint256 at storage 1
  balanceOf is uint256 at storage 2
  totalSupply is uint256 at storage 3
  name is array of uint256 at storage 4
  symbol is array of uint256 at storage 5
  decimals is uint8 at storage 6
  unknowna7835badAddress is addr at storage 6 offset 8

def name() payable: 
  return name[0 len name.length]

def totalSupply() payable: 
  return totalSupply

def decimals() payable: 
  return decimals

def balanceOf(address _owner) payable: 
  require calldata.size - 4 >= 32
  if not _owner:
      revert with 0, 'ERC20: zero address'
  return balanceOf

def owner() payable: 
  return owner

def symbol() payable: 
  return symbol[0 len symbol.length]

def unknowna7835bad() payable: 
  return unknowna7835badAddress

def allowance(address _owner, address _spender) payable: 
  require calldata.size - 4 >= 64
  return allowance[addr(_owner)][addr(_spender)]

#
#  Regular functions
#

def _fallback() payable: # default function
  revert

def unknown5d4ef8a6(addr _param1) payable: 
  require calldata.size - 4 >= 32
  if owner != caller:
      revert with 0, 'Ownable: caller is not the owner'
  unknowna7835badAddress = _param1

def renounceOwnership() payable: 
  if owner != caller:
      revert with 0, 'Ownable: caller is not the owner'
  log OwnershipTransferred(
        address previousOwner=owner,
        address newOwner=0)
  owner = 0

def transferOwnership(address _newOwner) payable: 
  require calldata.size - 4 >= 32
  if owner != caller:
      revert with 0, 'Ownable: caller is not the owner'
  if not _newOwner:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  38,
                  0x734f776e61626c653a206e6577206f776e657220697320746865207a65726f20616464726573,
                  mem[202 len 26]
  log OwnershipTransferred(
        address previousOwner=owner,
        address newOwner=_newOwner)
  owner = _newOwner

def unknownd43a632f() payable: 
  require calldata.size - 4 >= 32
  require cd <= 4294967296
  require cd <= calldata.size
  require ('cd', 4).length <= 4294967296 and cd * ('cd', 4).length) + 36 <= calldata.size
  if owner != caller:
      revert with 0, 'Ownable: caller is not the owner'
  idx = 0
  while idx < ('cd', 4).length:
      mem[96] = balanceOf
      log Transfer(
            address from=balanceOf,
            address to=unknowna7835badAddress,
            uint256 tokens=addr(cd[((32 * idx) + cd
      idx = idx + 1
      continue 

def transfer(address _to, uint256 _value) payable: 
  require calldata.size - 4 >= 64
  if not caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  37,
                  0x6545524332303a207472616e736665722066726f6d20746865207a65726f20616464726573,
                  mem[201 len 27]
  if not _to:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  35,
                  0xfe45524332303a207472616e7366657220746f20746865207a65726f20616464726573,
                  mem[199 len 29]
  log Transfer(
        address from=_value,
        address to=caller,
        uint256 tokens=_to)
  return 1

def approve(address _spender, uint256 _value) payable: 
  require calldata.size - 4 >= 64
  if not caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  36,
                  0x7345524332303a20617070726f76652066726f6d20746865207a65726f20616464726573,
                  mem[200 len 28]
  if not _spender:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  34,
                  0x7345524332303a20617070726f766520746f20746865207a65726f20616464726573,
                  mem[198 len 30]
  allowance[caller][addr(_spender)] = _value
  log Approval(
        address tokenOwner=_value,
        address spender=caller,
        uint256 tokens=_spender)
  return 1

def decreaseAllowance(address _spender, uint256 _subtractedValue) payable: 
  require calldata.size - 4 >= 64
  if _subtractedValue > allowance[caller][addr(_spender)]:
      revert with 0, 
                  32,
                  37,
                  0x7345524332303a2064656372656173656420616c6c6f77616e63652062656c6f77207a6572,
                  mem[165 len 27],
                  mem[219 len 5]
  if not caller:
      revert with 0, 32, 36, 0x7345524332303a20617070726f76652066726f6d20746865207a65726f20616464726573, mem[296 len 28]
  if not _spender:
      revert with 0, 32, 34, 0x7345524332303a20617070726f766520746f20746865207a65726f20616464726573, mem[294 len 30]
  allowance[caller][addr(_spender)] -= _subtractedValue
  log Approval(
        address tokenOwner=(allowance[caller][addr(_spender)] - _subtractedValue),
        address spender=caller,
        uint256 tokens=_spender)
  return 1

def increaseAllowance(address _spender, uint256 _addedValue) payable: 
  require calldata.size - 4 >= 64
  if allowance[caller][addr(_spender)] + _addedValue < allowance[caller][addr(_spender)]:
      revert with 0, 'SafeMath: addition overflow'
  if not caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  36,
                  0x7345524332303a20617070726f76652066726f6d20746865207a65726f20616464726573,
                  mem[200 len 28]
  if not _spender:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  34,
                  0x7345524332303a20617070726f766520746f20746865207a65726f20616464726573,
                  mem[198 len 30]
  allowance[caller][addr(_spender)] += _addedValue
  log Approval(
        address tokenOwner=(allowance[caller][addr(_spender)] + _addedValue),
        address spender=caller,
        uint256 tokens=_spender)
  return 1

def transferFrom(address _from, address _to, uint256 _value) payable: 
  require calldata.size - 4 >= 96
  if not _from:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  37,
                  0x6545524332303a207472616e736665722066726f6d20746865207a65726f20616464726573,
                  mem[201 len 27]
  if not _to:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  35,
                  0xfe45524332303a207472616e7366657220746f20746865207a65726f20616464726573,
                  mem[199 len 29]
  log Transfer(
        address from=_value,
        address to=_from,
        uint256 tokens=_to)
  if _value > allowance[addr(_from)][caller]:
      revert with 0, 
                  32,
                  40,
                  0x7345524332303a207472616e7366657220616d6f756e74206578636565647320616c6c6f77616e63,
                  mem[168 len 24],
                  mem[216 len 8]
  if not _from:
      revert with 0, 32, 36, 0x7345524332303a20617070726f76652066726f6d20746865207a65726f20616464726573, mem[296 len 28]
  if not caller:
      revert with 0, 32, 34, 0x7345524332303a20617070726f766520746f20746865207a65726f20616464726573, mem[294 len 30]
  allowance[addr(_from)][caller] -= _value
  log Approval(
        address tokenOwner=(allowance[addr(_from)][caller] - _value),
        address spender=_from,
        uint256 tokens=caller)
  return 1
