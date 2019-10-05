[38;5;8m#
#  Panoramix 4 Oct 2019 
#  Decompiled source of [0m0x89205A3A3b2A69De6Dbf7f01ED13B2108B2c43e7[38;5;8m
# 
#  Let's make the world open source 
# [0m

[32mdef [0mstorage:
  [32mowner[0m is addr [38;5;8mat storage 0[0m[38;5;8m[0m
  [32mstor0[0m is uint256 [38;5;8mat storage 0[0m[38;5;8m[0m
  [32mname[0m is array of uint256 [38;5;8mat storage 1[0m
  [32msymbol[0m is array of uint256 [38;5;8mat storage 2[0m
  [32mdecimals[0m is uint8 [38;5;8mat storage 3[0m[38;5;8m[0m
  [32mtotalSupply[0m is uint256 [38;5;8mat storage 4[0m[38;5;8m[0m
  [32mbalanceOf[0m is mapping of uint256 [38;5;8mat storage 5[0m
  [32mfrozenAccount[0m is mapping of uint8 [38;5;8mat storage 6[0m
  [32mallowance[0m is mapping of uint256 [38;5;8mat storage 7[0m
  [32mspentAllowance[0m is mapping of uint256 [38;5;8mat storage 8[0m

[95mdef [0mname()[95m payable[0m: 
  return [32mname[0m[32m[[0m0 [95mlen[0m [32mname[0m[32m.length[0m[32m][0m

[95mdef [0mtotalSupply()[95m payable[0m: 
  return [32mtotalSupply[0m

[95mdef [0mdecimals()[95m payable[0m: 
  return [32mdecimals[0m

[95mdef [0mbalanceOf(address [32m_owner[0m)[95m payable[0m: 
  return [32mbalanceOf[0m[32m[[0m[32m_owner[0m[32m][0m

[95mdef [0mowner()[95m payable[0m: 
  return [38;5;8maddr([0m[32mowner[0m[38;5;8m)[0m

[95mdef [0msymbol()[95m payable[0m: 
  return [32msymbol[0m[32m[[0m0 [95mlen[0m [32msymbol[0m[32m.length[0m[32m][0m

[95mdef [0mfrozenAccount(address [32m_param1[0m)[95m payable[0m: 
  return [38;5;8muint8([0m[32mfrozenAccount[0m[32m[[0m[32m_param1[0m[32m][0m[38;5;8m)[0m

[95mdef [0mspentAllowance(address [32m_param1[0m, address [32m_param2[0m)[95m payable[0m: 
  return [32mspentAllowance[0m[32m[[0m[32m_param1[0m[32m][0m[32m[[0m[32m_param2[0m[32m][0m

[95mdef [0mallowance(address [32m_owner[0m, address [32m_spender[0m)[95m payable[0m: 
  return [32mallowance[0m[32m[[0m[32m_owner[0m[32m][0m[32m[[0m[32m_spender[0m[32m][0m

[38;5;8m#
#  Regular functions
#[0m

[95mdef [0m_fallback()[95m payable[0m: [38;5;8m# default function[0m
  revert 

[95mdef [0mapprove(address [32m_spender[0m, uint256 [32m_value[0m)[95m payable[0m: 
  [32mallowance[0m[32m[[0mcaller[32m][0m[32m[[0m[38;5;8maddr([0m[32m_spender[0m[38;5;8m)[0m[32m][0m = [32m_value[0m
  return 0

[95mdef [0mtransferOwnership(address [32m_newOwner[0m)[95m payable[0m: 
  require [38;5;8maddr([0m[32mowner[0m[38;5;8m)[0m[1m == [0mcaller
  [38;5;8muint256([0m[32mstor0[0m[38;5;8m)[0m = [32m_newOwner[0m[1m or [0mMask(96, 160, [38;5;8muint256([0m[32mstor0[0m[38;5;8m)[0m)

[95mdef [0mmintToken(address [32m_target[0m, uint256 [32m_amount[0m)[95m payable[0m: 
  require [38;5;8maddr([0m[32mowner[0m[38;5;8m)[0m[1m == [0mcaller
  [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_target[0m[38;5;8m)[0m[32m][0m += [32m_amount[0m
  [32mtotalSupply[0m += [32m_amount[0m
  [38;5;8mlog Transfer([0m
  [38;5;8m      address from=_amount,[0m
  [38;5;8m      address to=addr(owner),[0m
  [38;5;8m      uint256 value=_target)[0m

[95mdef [0mfreezeAccount(address [32m_target[0m, bool [32m_freeze[0m)[95m payable[0m: 
  require [38;5;8maddr([0m[32mowner[0m[38;5;8m)[0m[1m == [0mcaller
  [38;5;8muint256([0m[32mfrozenAccount[0m[32m[[0m[38;5;8maddr([0m[32m_target[0m[38;5;8m)[0m[32m][0m[38;5;8m)[0m = [32m_freeze[0m[1m or [0mMask(248, 8, [38;5;8muint256([0m[32mfrozenAccount[0m[32m[[0m[38;5;8maddr([0m[32m_target[0m[38;5;8m)[0m[32m][0m[38;5;8m)[0m)
  [38;5;8mlog FrozenFunds([0m
  [38;5;8m      address target=addr(_target),[0m
  [38;5;8m      bool freeze=_freeze)[0m

[95mdef [0mtransfer(address [32m_to[0m, uint256 [32m_value[0m)[95m payable[0m: 
  require [32mbalanceOf[0m[32m[[0mcaller[32m][0m[1m >= [0m[32m_value[0m
  require [32m_value[0m + [32mbalanceOf[0m[32m[[0m[32m_to[0m[32m][0m[1m >= [0m[32mbalanceOf[0m[32m[[0m[32m_to[0m[32m][0m
  require not [38;5;8muint8([0m[32mfrozenAccount[0m[32m[[0mcaller[32m][0m[38;5;8m)[0m
  [32mbalanceOf[0m[32m[[0mcaller[32m][0m -= [32m_value[0m
  [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m += [32m_value[0m
  [38;5;8mlog Transfer([0m
  [38;5;8m      address from=_value,[0m
  [38;5;8m      address to=caller,[0m
  [38;5;8m      uint256 value=_to)[0m

[95mdef [0mtransferFrom(address [32m_from[0m, address [32m_to[0m, uint256 [32m_value[0m)[95m payable[0m: 
  require [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[1m >= [0m[32m_value[0m
  require [32mbalanceOf[0m[32m[[0m[32m_to[0m[32m][0m + [32m_value[0m[1m >= [0m[32mbalanceOf[0m[32m[[0m[32m_to[0m[32m][0m
  require not [38;5;8muint8([0m[32mfrozenAccount[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[38;5;8m)[0m
  require [32m_value[0m + [32mspentAllowance[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m[1m <= [0m[32mallowance[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m
  [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m -= [32m_value[0m
  [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m += [32m_value[0m
  [32mspentAllowance[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m += [32m_value[0m
  [38;5;8mlog Transfer([0m
  [38;5;8m      address from=_value,[0m
  [38;5;8m      address to=caller,[0m
  [38;5;8m      uint256 value=_to)[0m
  return 0

