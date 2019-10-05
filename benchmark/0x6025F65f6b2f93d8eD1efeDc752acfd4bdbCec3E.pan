[38;5;8m#
#  Panoramix 4 Oct 2019 
#  Decompiled source of [0m0x6025F65f6b2f93d8eD1efeDc752acfd4bdbCec3E[38;5;8m
# 
#  Let's make the world open source 
# [0m

[32mdef [0mstorage:
  [32mbalanceOf[0m is mapping of uint256 [38;5;8mat storage 0[0m
  [32mallowance[0m is mapping of uint256 [38;5;8mat storage 1[0m
  [32mtotalSupply[0m is uint256 [38;5;8mat storage 2[0m[38;5;8m[0m
  [32mname[0m is array of uint256 [38;5;8mat storage 3[0m
  [32mdecimals[0m is uint8 [38;5;8mat storage 4[0m[38;5;8m[0m
  [32msymbol[0m is array of uint256 [38;5;8mat storage 5[0m
  [32mversion[0m is array of uint256 [38;5;8mat storage 6[0m

[95mdef [0mname()[95m payable[0m: 
  return [32mname[0m[32m[[0m0 [95mlen[0m [32mname[0m[32m.length[0m[32m][0m

[95mdef [0mtotalSupply()[95m payable[0m: 
  return [32mtotalSupply[0m

[95mdef [0mdecimals()[95m payable[0m: 
  return [32mdecimals[0m

[95mdef [0mversion()[95m payable[0m: 
  return [32mversion[0m[32m[[0m0 [95mlen[0m [32mversion[0m[32m.length[0m[32m][0m

[95mdef [0mbalanceOf(address [32m_owner[0m)[95m payable[0m: 
  return [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_owner[0m[38;5;8m)[0m[32m][0m

[95mdef [0msymbol()[95m payable[0m: 
  return [32msymbol[0m[32m[[0m0 [95mlen[0m [32msymbol[0m[32m.length[0m[32m][0m

[95mdef [0mallowance(address [32m_owner[0m, address [32m_spender[0m)[95m payable[0m: 
  return [32mallowance[0m[32m[[0m[38;5;8maddr([0m[32m_owner[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_spender[0m[38;5;8m)[0m[32m][0m

[38;5;8m#
#  Regular functions
#[0m

[95mdef [0m_fallback()[95m payable[0m: [38;5;8m# default function[0m
  revert 

[95mdef [0mapprove(address [32m_spender[0m, uint256 [32m_value[0m)[95m payable[0m: 
  [32mallowance[0m[32m[[0mcaller[32m][0m[32m[[0m[38;5;8maddr([0m[32m_spender[0m[38;5;8m)[0m[32m][0m = [32m_value[0m
  [38;5;8mlog Approval([0m
  [38;5;8m      address owner=_value,[0m
  [38;5;8m      address spender=caller,[0m
  [38;5;8m      uint256 value=_spender)[0m
  return 1

[95mdef [0mtransfer(address [32m_to[0m, uint256 [32m_value[0m)[95m payable[0m: 
  if [32mbalanceOf[0m[32m[[0mcaller[32m][0m[1m < [0m[32m_value[0m:
      return 0
  if [32m_value[0m[1m <= [0m0:
      return 0
  [32mbalanceOf[0m[32m[[0mcaller[32m][0m -= [32m_value[0m
  [32mbalanceOf[0m[32m[[0m[32m_to[0m[32m][0m += [32m_value[0m
  [38;5;8mlog Transfer([0m
  [38;5;8m      address from=_value,[0m
  [38;5;8m      address to=caller,[0m
  [38;5;8m      uint256 value=_to)[0m
  return 1

[95mdef [0mtransferFrom(address [32m_from[0m, address [32m_to[0m, uint256 [32m_value[0m)[95m payable[0m: 
  if [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[1m < [0m[32m_value[0m:
      return 0
  if [32mallowance[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m[1m < [0m[32m_value[0m:
      return 0
  if [32m_value[0m[1m <= [0m0:
      return 0
  [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m += [32m_value[0m
  [32mbalanceOf[0m[32m[[0m[32m_from[0m[32m][0m -= [32m_value[0m
  [32mallowance[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m -= [32m_value[0m
  [38;5;8mlog Transfer([0m
  [38;5;8m      address from=_value,[0m
  [38;5;8m      address to=_from,[0m
  [38;5;8m      uint256 value=_to)[0m
  return 1

[95mdef [0mapproveAndCall(address [32m_spender[0m, uint256 [32m_value[0m, bytes [32m_data[0m)[95m payable[0m: 
  [32mallowance[0m[32m[[0mcaller[32m][0m[32m[[0m[38;5;8maddr([0m[32m_spender[0m[38;5;8m)[0m[32m][0m = [32m_value[0m
  [38;5;8mlog Approval([0m
  [38;5;8m      address owner=_value,[0m
  [38;5;8m      address spender=caller,[0m
  [38;5;8m      uint256 value=_spender)[0m
  [95mmem[[0mceil32([32m_data.length[0m) + 228[95m len [0m[32m_data.length[0m[95m][0m = [32m_data[[0mall[32m][0m
  if not [32m_data.length[0m[1m % [0m32:
      call [32m_spender[0m with:
         funct Mask(32, 224, sha3('receiveApproval(address,uint256,', 'address,bytes)'))[1m >> [0m224
           gas gas_remaining - 25050 [38;5;8mwei[0m
          args caller, [32m_value[0m, [38;5;8maddr([0mthis.address[38;5;8m)[0m, [32m_data[[0mall[32m][0m
  else:
      [95mmem[[0mfloor32([32m_data.length[0m) + ceil32([32m_data.length[0m) + 228[95m][0m = [95mmem[[0mfloor32([32m_data.length[0m) + ceil32([32m_data.length[0m) + -([32m_data.length[0m[1m % [0m32) + 260[95m len [0m[32m_data.length[0m[1m % [0m32[95m][0m
      call [32m_spender[0m with:
         funct Mask(32, 224, sha3('receiveApproval(address,uint256,', 'address,bytes)'))[1m >> [0m224
           gas gas_remaining - 25050 [38;5;8mwei[0m
          args caller, [32m_value[0m, [38;5;8maddr([0mthis.address[38;5;8m)[0m, [32m_data[[0mall[32m][0m, [95mmem[[0mceil32([32m_data.length[0m) + [32m_data.length[0m + 228[95m len [0m-([32m_data.length[0m[1m % [0m32) + 32[95m][0m
  require ext_call.success
  return 1

