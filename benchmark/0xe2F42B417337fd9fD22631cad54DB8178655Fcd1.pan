[38;5;8m#
#  Panoramix 4 Oct 2019 
#  Decompiled source of [0m0xe2F42B417337fd9fD22631cad54DB8178655Fcd1[38;5;8m
# 
#  Let's make the world open source 
# [0m

[32mdef [0mstorage:
  [32msigners[0m is array of addr [38;5;8mat storage 0[0m
  [32msafeMode[0m is uint8 [38;5;8mat storage 1[0m[38;5;8m[0m
  [32mstor2[0m is array of uint256 [38;5;8mat storage 2[0m
  [32mstor12[0m is addr [38;5;8mat storage 12[0m[38;5;8m[0m
  [32mstor13[0m is addr [38;5;8mat storage 13[0m[38;5;8m[0m

[95mdef [0msigners(uint256 [32m_param1[0m): [38;5;8m# not payable[0m
  require [32m_param1[0m[1m < [0m[32msigners[0m[32m.length[0m
  return [32msigners[0m[32m[[0m[32m_param1[0m[32m][0m

[95mdef [0msafeMode(): [38;5;8m# not payable[0m
  return bool([32msafeMode[0m)

[38;5;8m#
#  Regular functions
#[0m

[95mdef [0m_fallback()[95m payable[0m: [38;5;8m# default function[0m
  if call.value[1m > [0m0:
      [38;5;8mlog Deposited([0m
      [38;5;8m      address from=caller,[0m
      [38;5;8m      uint256 value=call.value,[0m
      [38;5;8m      bytes data=Array(len=calldata.size, data=call.data[0 len calldata.size]))[0m

[95mdef [0misSigner(address [32m_account[0m): [38;5;8m# not payable[0m
  [94midx[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m[32msigners[0m[32m.length[0m[32m:[0m
      [95mmem[[0m0[95m][0m = 0
      if [32msigners[0m[32m[[0m[94midx[0m[32m][0m != [32m_account[0m:
          [94midx[0m = [94midx[0m + 1
          [32mcontinue [0m
      return 1
  return 0

[95mdef [0mactivateSafeMode(): [38;5;8m# not payable[0m
  require 0[1m < [0m[32msigners[0m[32m.length[0m
  [94midx[0m = 0
  [32mwhile [0m[32msigners[0m[32m[[0m[94midx[0m[32m][0m != caller[32m:[0m
      require [94midx[0m + 1[1m < [0m[32msigners[0m[32m.length[0m
      [95mmem[[0m0[95m][0m = 0
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  [32msafeMode[0m = 1
  [38;5;8mlog SafeModeActivated(address msgSender=caller)[0m

[95mdef [0mgetNextSequenceId(): [38;5;8m# not payable[0m
  [94midx[0m = 0
  [94ms[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m10[32m:[0m
      if [32mstor2[0m[32m[[0m[94midx[0m[32m][0m[1m <= [0m[94ms[0m:
          [94midx[0m = [94midx[0m + 1
          [94ms[0m = [94ms[0m
          [32mcontinue [0m
      require [94midx[0m[1m < [0m10
      [94midx[0m = [94midx[0m + 1
      [94ms[0m = [32mstor2[0m[32m[[0m[94midx[0m[32m][0m
      [32mcontinue [0m
  return ([94ms[0m + 1)

[95mdef [0mcreateForwarder(): [38;5;8m# not payable[0m
  require ext_code.size([32mstor12[0m)
  call [32mstor12[0m.createProxy([38;5;8maddress[0m masterCopy, [38;5;8mbytes[0m data) with:
       gas gas_remaining - 710 [38;5;8mwei[0m
      args [32mstor13[0m, 64, 0
  require ext_call.success
  require ext_code.size([38;5;8maddr([0mext_call.return_data[0][38;5;8m)[0m)
  call [38;5;8maddr([0mext_call.return_data[0][38;5;8m)[0m.initialize() with:
       gas gas_remaining - 710 [38;5;8mwei[0m
  require ext_call.success
  [38;5;8mlog ForwarderCreated(address to=addr(ext_call.return_data[0]))[0m
  return [38;5;8maddr([0mext_call.return_data[0][38;5;8m)[0m

[95mdef [0mflushForwarderTokens(address [32m_forwarderAddress[0m, address [32m_tokenContractAddress[0m): [38;5;8m# not payable[0m
  require 0[1m < [0m[32msigners[0m[32m.length[0m
  [94midx[0m = 0
  [32mwhile [0m[32msigners[0m[32m[[0m[94midx[0m[32m][0m != caller[32m:[0m
      require [94midx[0m + 1[1m < [0m[32msigners[0m[32m.length[0m
      [95mmem[[0m0[95m][0m = 0
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  require ext_code.size([32m_forwarderAddress[0m)
  call [32m_forwarderAddress[0m.flushTokens([38;5;8maddress[0m tokenContractAddress) with:
       gas gas_remaining - 710 [38;5;8mwei[0m
      args [32m_tokenContractAddress[0m
  require ext_call.success

[95mdef [0msendMultiSigToken(address [32m_toAddress[0m, uint256 [32m_value[0m, address [32m_tokenContractAddress[0m, uint256 [32m_expireTime[0m, uint256 [32m_sequenceId[0m, bytes [32m_signature[0m): [38;5;8m# not payable[0m
  [95mmem[[0m128[95m len [0m[32m_signature.length[0m[95m][0m = [32m_signature[[0mall[32m][0m
  require 0[1m < [0m[32msigners[0m[32m.length[0m
  [94midx[0m = 0
  [32mwhile [0m[32msigners[0m[32m[[0m[94midx[0m[32m][0m != caller[32m:[0m
      require [94midx[0m + 1[1m < [0m[32msigners[0m[32m.length[0m
      [95mmem[[0m0[95m][0m = 0
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  [95mmem[[0mceil32([32m_signature.length[0m) + 128[95m][0m = 'ERC20'
  [95mmem[[0mceil32([32m_signature.length[0m) + 133[95m][0m = [38;5;8maddr([0m[32m_toAddress[0m[38;5;8m)[0m
  [95mmem[[0mceil32([32m_signature.length[0m) + 153[95m][0m = [32m_value[0m
  [95mmem[[0mceil32([32m_signature.length[0m) + 185[95m][0m = [38;5;8maddr([0m[32m_tokenContractAddress[0m[38;5;8m)[0m
  require [32m_signature.length[0m[1m == [0m65
  if [95mmem[[0m192[95m len [0m1[95m][0m[1m >= [0m27:
      [94msigner[0m = erecover(sha3('ERC20', [32m_toAddress[0m, [32m_value[0m, [32m_tokenContractAddress[0m, [32m_expireTime[0m, [32m_sequenceId[0m), [95mmem[[0m161[95m][0m[1m << [0m248, [95mmem[[0m128[95m][0m, [95mmem[[0m160[95m][0m) [38;5;8m# precompiled[0m
  else:
      [94msigner[0m = erecover(sha3('ERC20', [32m_toAddress[0m, [32m_value[0m, [32m_tokenContractAddress[0m, [32m_expireTime[0m, [32m_sequenceId[0m), [95mmem[[0m192[95m len [0m1[95m][0m + 27[1m << [0m248, [95mmem[[0m128[95m][0m, [95mmem[[0m160[95m][0m) [38;5;8m# precompiled[0m
  require erecover.result
  if [32msafeMode[0m:
      require 0[1m < [0m[32msigners[0m[32m.length[0m
      [94midx[0m = 0
      [32mwhile [0m[32msigners[0m[32m[[0m[94midx[0m[32m][0m != [32m_toAddress[0m[32m:[0m
          require [94midx[0m + 1[1m < [0m[32msigners[0m[32m.length[0m
          [95mmem[[0m0[95m][0m = 0
          [94midx[0m = [94midx[0m + 1
          [32mcontinue [0m
  require [32m_expireTime[0m[1m >= [0mblock.timestamp
  require 0[1m < [0m[32msigners[0m[32m.length[0m
  [94midx[0m = 0
  [32mwhile [0m[32msigners[0m[32m[[0m[94midx[0m[32m][0m != caller[32m:[0m
      require [94midx[0m + 1[1m < [0m[32msigners[0m[32m.length[0m
      [95mmem[[0m0[95m][0m = 0
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  [94midx[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m10[32m:[0m
      require [32mstor2[0m[32m[[0m[94midx[0m[32m][0m != [32m_sequenceId[0m
      require [94midx[0m[1m < [0m10
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  require [32m_sequenceId[0m[1m >= [0m[32mstor2[0m[32m.length[0m
  require [32m_sequenceId[0m[1m <= [0m[32mstor2[0m[32m.length[0m + 10000
  [32mstor2[0m[32m.length[0m = [32m_sequenceId[0m
  require 0[1m < [0m[32msigners[0m[32m.length[0m
  [94midx[0m = 0
  [32mwhile [0m[32msigners[0m[32m[[0m[94midx[0m[32m][0m != [38;5;8maddr([0m[94msigner[0m[38;5;8m)[0m[32m:[0m
      require [94midx[0m + 1[1m < [0m[32msigners[0m[32m.length[0m
      [95mmem[[0m0[95m][0m = 0
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  require [38;5;8maddr([0m[94msigner[0m[38;5;8m)[0m != caller
  require ext_code.size([32m_tokenContractAddress[0m)
  call [32m_tokenContractAddress[0m.transfer([38;5;8maddress[0m to, [38;5;8muint256[0m value) with:
       gas gas_remaining - 710 [38;5;8mwei[0m
      args [38;5;8maddr([0m[32m_toAddress[0m[38;5;8m)[0m, [32m_value[0m
  require ext_call.success
  require ext_call.return_data[0]

[95mdef [0msendMultiSig(address [32m_toAddress[0m, uint256 [32m_value[0m, bytes [32m_data[0m, uint256 [32m_expireTime[0m, uint256 [32m_sequenceId[0m, bytes [32m_signature[0m): [38;5;8m# not payable[0m
  [95mmem[[0m128[95m len [0m[32m_data.length[0m[95m][0m = [32m_data[[0mall[32m][0m
  [95mmem[[0mceil32([32m_data.length[0m) + 128[95m][0m = [32m_signature.length[0m
  [95mmem[[0mceil32([32m_data.length[0m) + 160[95m len [0m[32m_signature.length[0m[95m][0m = [32m_signature[[0mall[32m][0m
  require 0[1m < [0m[32msigners[0m[32m.length[0m
  [94midx[0m = 0
  [32mwhile [0m[32msigners[0m[32m[[0m[94midx[0m[32m][0m != caller[32m:[0m
      require [94midx[0m + 1[1m < [0m[32msigners[0m[32m.length[0m
      [95mmem[[0m0[95m][0m = 0
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 160[95m][0m = 'ETHER'
  [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 165[95m][0m = [38;5;8maddr([0m[32m_toAddress[0m[38;5;8m)[0m
  [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 185[95m][0m = [32m_value[0m
  [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 217[95m len [0mfloor32([32m_data.length[0m)[95m][0m = call.data[[32m_data[0m + 36 len floor32([32m_data.length[0m)]
  [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + floor32([32m_data.length[0m) + -([32m_data.length[0m[1m % [0m32) + 249[95m len [0m[32m_data.length[0m[1m % [0m32[95m][0m = [95mmem[[0mfloor32([32m_data.length[0m) + -([32m_data.length[0m[1m % [0m32) + 160[95m len [0m[32m_data.length[0m[1m % [0m32[95m][0m
  [95mmem[[0m[32m_data.length[0m + ceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 217[95m][0m = [32m_expireTime[0m
  [95mmem[[0m[32m_data.length[0m + ceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 249[95m][0m = [32m_sequenceId[0m
  [94m_66[0m = sha3('ETHER', [32m_toAddress[0m, [32m_value[0m, call.data[[32m_data[0m + 36 len floor32([32m_data.length[0m)], [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + floor32([32m_data.length[0m) + 217[95m len [0m([32m_data.length[0m[1m % [0m32) + 32[95m][0m, [32m_sequenceId[0m, None)
  require [32m_signature.length[0m[1m == [0m65
  [94m_70[0m = [95mmem[[0mceil32([32m_data.length[0m) + 192[95m][0m
  [94m_71[0m = [95mmem[[0mceil32([32m_data.length[0m) + 193[95m][0m
  [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 192[95m][0m = sha3('ETHER', [32m_toAddress[0m, [32m_value[0m, call.data[[32m_data[0m + 36 len floor32([32m_data.length[0m)], [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + floor32([32m_data.length[0m) + 217[95m len [0m([32m_data.length[0m[1m % [0m32) + 32[95m][0m, [32m_sequenceId[0m, None)
  if [95mmem[[0mceil32([32m_data.length[0m) + 224[95m len [0m1[95m][0m[1m >= [0m27:
      [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 224[95m][0m = [38;5;8muint8([0m[94m_71[0m[38;5;8m)[0m
      [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 256[95m][0m = [95mmem[[0mceil32([32m_data.length[0m) + 160[95m][0m
      [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 288[95m][0m = [94m_70[0m
      [94msigner[0m = erecover([94m_66[0m, [94m_71[0m[1m << [0m248, [95mmem[[0mceil32([32m_data.length[0m) + 160[95m][0m, [94m_70[0m) [38;5;8m# precompiled[0m
      require erecover.result
      if [32msafeMode[0m:
          require 0[1m < [0m[32msigners[0m[32m.length[0m
          [94midx[0m = 0
          [32mwhile [0m[32msigners[0m[32m[[0m[94midx[0m[32m][0m != [32m_toAddress[0m[32m:[0m
              require [94midx[0m + 1[1m < [0m[32msigners[0m[32m.length[0m
              [95mmem[[0m0[95m][0m = 0
              [94midx[0m = [94midx[0m + 1
              [32mcontinue [0m
      require [32m_expireTime[0m[1m >= [0mblock.timestamp
      require 0[1m < [0m[32msigners[0m[32m.length[0m
      [94midx[0m = 0
      [32mwhile [0m[32msigners[0m[32m[[0m[94midx[0m[32m][0m != caller[32m:[0m
          require [94midx[0m + 1[1m < [0m[32msigners[0m[32m.length[0m
          [95mmem[[0m0[95m][0m = 0
          [94midx[0m = [94midx[0m + 1
          [32mcontinue [0m
      [94midx[0m = 0
      [32mwhile [0m[94midx[0m[1m < [0m10[32m:[0m
          require [32mstor2[0m[32m[[0m[94midx[0m[32m][0m != [32m_sequenceId[0m
          require [94midx[0m[1m < [0m10
          [94midx[0m = [94midx[0m + 1
          [32mcontinue [0m
      require [32m_sequenceId[0m[1m >= [0m[32mstor2[0m[32m.length[0m
      require [32m_sequenceId[0m[1m <= [0m[32mstor2[0m[32m.length[0m + 10000
      [32mstor2[0m[32m.length[0m = [32m_sequenceId[0m
      require 0[1m < [0m[32msigners[0m[32m.length[0m
      [94midx[0m = 0
      [32mwhile [0m[32msigners[0m[32m[[0m[94midx[0m[32m][0m != [38;5;8maddr([0m[94msigner[0m[38;5;8m)[0m[32m:[0m
          require [94midx[0m + 1[1m < [0m[32msigners[0m[32m.length[0m
          [95mmem[[0m0[95m][0m = 0
          [94midx[0m = [94midx[0m + 1
          [32mcontinue [0m
      require [38;5;8maddr([0m[94msigner[0m[38;5;8m)[0m != caller
      [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 192[95m len [0mceil32([32m_data.length[0m)[95m][0m = [32m_data[[0mall[32m][0m, [95mmem[[0m[32m_data.length[0m + 128[95m len [0mceil32([32m_data.length[0m) - [32m_data.length[0m[95m][0m
  else:
      [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 224[95m][0m = [38;5;8muint8([0m[38;5;8muint8([0m[94m_71[0m[38;5;8m)[0m + 27[38;5;8m)[0m
      [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 256[95m][0m = [95mmem[[0mceil32([32m_data.length[0m) + 160[95m][0m
      [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 288[95m][0m = [94m_70[0m
      [94msigner[0m = erecover([94m_66[0m, [38;5;8muint8([0m[94m_71[0m[38;5;8m)[0m + 27[1m << [0m248, [95mmem[[0mceil32([32m_data.length[0m) + 160[95m][0m, [94m_70[0m) [38;5;8m# precompiled[0m
      require erecover.result
      if not [32msafeMode[0m:
          require [32m_expireTime[0m[1m >= [0mblock.timestamp
          require 0[1m < [0m[32msigners[0m[32m.length[0m
          [94midx[0m = 0
          [32mwhile [0m[32msigners[0m[32m[[0m[94midx[0m[32m][0m != caller[32m:[0m
              require [94midx[0m + 1[1m < [0m[32msigners[0m[32m.length[0m
              [95mmem[[0m0[95m][0m = 0
              [94midx[0m = [94midx[0m + 1
              [32mcontinue [0m
          [94midx[0m = 0
          [32mwhile [0m[94midx[0m[1m < [0m10[32m:[0m
              require [32mstor2[0m[32m[[0m[94midx[0m[32m][0m != [32m_sequenceId[0m
              require [94midx[0m[1m < [0m10
              [94midx[0m = [94midx[0m + 1
              [32mcontinue [0m
          require [32m_sequenceId[0m[1m >= [0m[32mstor2[0m[32m.length[0m
          require [32m_sequenceId[0m[1m <= [0m[32mstor2[0m[32m.length[0m + 10000
          [32mstor2[0m[32m.length[0m = [32m_sequenceId[0m
          require 0[1m < [0m[32msigners[0m[32m.length[0m
          [94midx[0m = 0
          [32mwhile [0m[32msigners[0m[32m[[0m[94midx[0m[32m][0m != [38;5;8maddr([0m[94msigner[0m[38;5;8m)[0m[32m:[0m
              require [94midx[0m + 1[1m < [0m[32msigners[0m[32m.length[0m
              [95mmem[[0m0[95m][0m = 0
              [94midx[0m = [94midx[0m + 1
              [32mcontinue [0m
          require [38;5;8maddr([0m[94msigner[0m[38;5;8m)[0m != caller
          [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 192[95m len [0mceil32([32m_data.length[0m)[95m][0m = [32m_data[[0mall[32m][0m, [95mmem[[0m[32m_data.length[0m + 128[95m len [0mceil32([32m_data.length[0m) - [32m_data.length[0m[95m][0m
          [94mvar58001[0m = ceil32([32m_data.length[0m)
      else:
          require 0[1m < [0m[32msigners[0m[32m.length[0m
          [94midx[0m = 0
          [32mwhile [0m[32msigners[0m[32m[[0m[94midx[0m[32m][0m != [32m_toAddress[0m[32m:[0m
              require [94midx[0m + 1[1m < [0m[32msigners[0m[32m.length[0m
              [95mmem[[0m0[95m][0m = 0
              [94midx[0m = [94midx[0m + 1
              [32mcontinue [0m
          require [32m_expireTime[0m[1m >= [0mblock.timestamp
          require 0[1m < [0m[32msigners[0m[32m.length[0m
          [94midx[0m = 0
          [32mwhile [0m[32msigners[0m[32m[[0m[94midx[0m[32m][0m != caller[32m:[0m
              require [94midx[0m + 1[1m < [0m[32msigners[0m[32m.length[0m
              [95mmem[[0m0[95m][0m = 0
              [94midx[0m = [94midx[0m + 1
              [32mcontinue [0m
          [94midx[0m = 0
          [32mwhile [0m[94midx[0m[1m < [0m10[32m:[0m
              require [32mstor2[0m[32m[[0m[94midx[0m[32m][0m != [32m_sequenceId[0m
              require [94midx[0m[1m < [0m10
              [94midx[0m = [94midx[0m + 1
              [32mcontinue [0m
          require [32m_sequenceId[0m[1m >= [0m[32mstor2[0m[32m.length[0m
          require [32m_sequenceId[0m[1m <= [0m[32mstor2[0m[32m.length[0m + 10000
          [32mstor2[0m[32m.length[0m = [32m_sequenceId[0m
          require 0[1m < [0m[32msigners[0m[32m.length[0m
          [94midx[0m = 0
          [32mwhile [0m[32msigners[0m[32m[[0m[94midx[0m[32m][0m != [38;5;8maddr([0m[94msigner[0m[38;5;8m)[0m[32m:[0m
              require [94midx[0m + 1[1m < [0m[32msigners[0m[32m.length[0m
              [95mmem[[0m0[95m][0m = 0
              [94midx[0m = [94midx[0m + 1
              [32mcontinue [0m
          require [38;5;8maddr([0m[94msigner[0m[38;5;8m)[0m != caller
          [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 192[95m len [0mceil32([32m_data.length[0m)[95m][0m = [32m_data[[0mall[32m][0m, [95mmem[[0m[32m_data.length[0m + 128[95m len [0mceil32([32m_data.length[0m) - [32m_data.length[0m[95m][0m
  if not [32m_data.length[0m[1m % [0m32:
      call [32m_toAddress[0m.[95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 192[95m len [0m4[95m][0m with:
         value [32m_value[0m [38;5;8mwei[0m
           gas gas_remaining - 34710 [38;5;8mwei[0m
          args [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 196[95m len [0m[32m_data.length[0m - 4[95m][0m
  else:
      [95mmem[[0mfloor32([32m_data.length[0m) + ceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 192[95m][0m = [95mmem[[0mfloor32([32m_data.length[0m) + ceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + -([32m_data.length[0m[1m % [0m32) + 224[95m len [0m[32m_data.length[0m[1m % [0m32[95m][0m
      call [32m_toAddress[0m.[95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 192[95m len [0m4[95m][0m with:
         value [32m_value[0m [38;5;8mwei[0m
           gas gas_remaining - 34710 [38;5;8mwei[0m
          args [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 196[95m len [0mfloor32([32m_data.length[0m) + 28[95m][0m
  require ext_call.success
  [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 192[95m][0m = caller
  [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 224[95m][0m = [38;5;8maddr([0m[94msigner[0m[38;5;8m)[0m
  [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 256[95m][0m = [94m_66[0m
  [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 288[95m][0m = [32m_toAddress[0m
  [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 320[95m][0m = [32m_value[0m
  [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 352[95m][0m = 192
  [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 384[95m][0m = [32m_data.length[0m
  [95mmem[[0mceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 416[95m len [0mceil32([32m_data.length[0m)[95m][0m = [32m_data[[0mall[32m][0m, [95mmem[[0m[32m_data.length[0m + 128[95m len [0mceil32([32m_data.length[0m) - [32m_data.length[0m[95m][0m
  if not [32m_data.length[0m[1m % [0m32:
      [38;5;8mlog Transacted(address msgSender, address otherSigner, bytes32 operation, address toAddress, uint256 value, bytes data):[0m
      [38;5;8m               mem[ceil32(_data.length) + ceil32(_signature.length) + 192 len _data.length + 25],[0m
      [38;5;8m               _expireTime,[0m
      [38;5;8m               _sequenceId,[0m
      [38;5;8m               mem[ceil32(_data.length) + ceil32(_signature.length) + _data.length + 281 len 135],[0m
  else:
      [95mmem[[0mfloor32([32m_data.length[0m) + ceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + 416[95m][0m = [95mmem[[0mfloor32([32m_data.length[0m) + ceil32([32m_data.length[0m) + ceil32([32m_signature.length[0m) + -([32m_data.length[0m[1m % [0m32) + 448[95m len [0m[32m_data.length[0m[1m % [0m32[95m][0m
      [38;5;8mlog Transacted(address msgSender, address otherSigner, bytes32 operation, address toAddress, uint256 value, bytes data):[0m
      [38;5;8m               mem[ceil32(_data.length) + ceil32(_signature.length) + 192 len _data.length + 25],[0m
      [38;5;8m               _expireTime,[0m
      [38;5;8m               _sequenceId,[0m
      [38;5;8m               mem[ceil32(_data.length) + ceil32(_signature.length) + _data.length + 281 len -(_data.length % 32) + 167],[0m

