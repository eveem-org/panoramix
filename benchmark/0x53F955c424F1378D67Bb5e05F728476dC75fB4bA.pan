[38;5;8m#
#  Panoramix 4 Oct 2019 
#  Decompiled source of [0m0x53F955c424F1378D67Bb5e05F728476dC75fB4bA[38;5;8m
# 
#  Let's make the world open source 
# [0m

[32mdef [0mstorage:
  [32mstor0[0m is addr [38;5;8mat storage 0[0m[38;5;8m[0m

[95mdef [0m_fallback()[95m payable[0m: [38;5;8m# default function[0m
  stop

[95mdef [0mtokenFallback(address [32m_param1[0m, uint256 [32m_param2[0m, bytes [32m_param3[0m): [38;5;8m# not payable[0m
  stop

[95mdef [0msweep(address [32m_token[0m, uint256 [32m_amount[0m): [38;5;8m# not payable[0m
  require ext_code.size([32mstor0[0m)
  call [32mstor0[0m.sweeperOf([38;5;8maddress[0m token) with:
       gas gas_remaining - 710 [38;5;8mwei[0m
      args [32m_token[0m
  require ext_call.success
  [93mdelegate[0m [38;5;8maddr([0mext_call.return_data[0][38;5;8m)[0m with:
     funct call.data[0 len 4]
       gas gas_remaining - 710 [38;5;8mwei[0m
      args call.data[4 len calldata.size - 4]
  require delegate.return_code
  return bool(delegate.return_data[0])

