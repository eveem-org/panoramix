[38;5;8m#
#  Panoramix 4 Oct 2019 
#  Decompiled source of [0m0xf91546835f756DA0c10cFa0CDA95b15577b84aA7[38;5;8m
# 
#  Let's make the world open source 
# [0m

[95mconst [0mNAME = [1m'Ledger Channel'[0m
[95mconst [0mVERSION = [1m'0.0.1'[0m

[32mdef [0mstorage:
  [32mnumChannels[0m is uint256 [38;5;8mat storage 0[0m[38;5;8m[0m
  [32mvirtualChannels[0m is mapping of struct [38;5;8mat storage 1[0m
  [32mchannels[0m is array of struct [38;5;8mat storage 2[0m

[95mdef [0mvirtualChannels(bytes32 [32m_param1[0m): [38;5;8m# not payable[0m
  return bool([32mvirtualChannels[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_0[0m), 
         bool([32mvirtualChannels[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_8[0m),
         [32mvirtualChannels[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_256[0m,
         [32mvirtualChannels[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_512[0m,
         [32mvirtualChannels[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_768[0m,
         [32mvirtualChannels[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_1024[0m,
         [32mvirtualChannels[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_1280[0m,
         [32mvirtualChannels[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_1536[0m,
         [32mvirtualChannels[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_3328[0m

[95mdef [0mnumChannels(): [38;5;8m# not payable[0m
  return [32mnumChannels[0m

[95mdef [0mChannels(bytes32 [32m_param1[0m): [38;5;8m# not payable[0m
  return [32mchannels[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_3072[0m, 
         [32mchannels[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_3328[0m,
         [32mchannels[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_3584[0m,
         [32mchannels[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_3840[0m,
         [32mchannels[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_4096[0m,
         bool([32mchannels[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_4352[0m),
         bool([32mchannels[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_4360[0m),
         [32mchannels[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_4608[0m,
         [32mchannels[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_4864[0m

[38;5;8m#
#  Regular functions
#[0m

[95mdef [0m_fallback()[95m payable[0m: [38;5;8m# default function[0m
  revert

[95mdef [0mjoinChannel(bytes32 [32m_lcID[0m, uint256[2] [32m_balances[0m)[95m payable[0m: 
  require not [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4352[0m
  require caller[1m == [0m[32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_256[0m
  if call.data[36]:
      if call.data[36] != call.value:
          revert with 0, 'state balance does not match sent value'
      [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_768[0m = call.value
  if call.data[68]:
      require ext_code.size([32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m)
      call [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m.transferFrom([38;5;8maddress[0m from, [38;5;8maddress[0m to, [38;5;8muint256[0m value) with:
           gas gas_remaining [38;5;8mwei[0m
          args caller, this.address, call.data[68]
      if not ext_call.success:
          revert with ext_call.return_data[0 len return_data.size]
      require return_data.size[1m >= [0m32
      if not ext_call.return_data[0]:
          revert with 0, 'joinChannel: token transfer failure'
      [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1792[0m = call.data[68]
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2560[0m += call.data[36]
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2816[0m += call.data[68]
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4352[0m = 1
  [32mnumChannels[0m++
  [38;5;8mlog DidLCJoin([0m
  [38;5;8m      bytes32 channelId=call.data[36],[0m
  [38;5;8m      uint256 ethBalanceI=call.data[68],[0m
  [38;5;8m      uint256 tokenBalanceI=_lcID)[0m

[95mdef [0mgetVirtualChannel(bytes32 [32m_id[0m): [38;5;8m# not payable[0m
  [94midx[0m = 1344
  [94ms[0m = 7
  [32mwhile [0m1408[1m > [0m[94midx[0m + 32[32m:[0m
      [95mmem[[0m[94midx[0m + 32[95m][0m = [32mvirtualChannels[0m[32m[[0m[32m_id[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m.field_256[0m
      [94midx[0m = [94midx[0m + 32
      [94ms[0m = [94ms[0m + 1
      [32mcontinue [0m
  [94midx[0m = 1408
  [94ms[0m = 9
  [32mwhile [0m1472[1m > [0m[94midx[0m + 32[32m:[0m
      [95mmem[[0m[94midx[0m + 32[95m][0m = [32mvirtualChannels[0m[32m[[0m[32m_id[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m.field_256[0m
      [94midx[0m = [94midx[0m + 32
      [94ms[0m = [94ms[0m + 1
      [32mcontinue [0m
  [94midx[0m = 1472
  [94ms[0m = 11
  [32mwhile [0m1536[1m > [0m[94midx[0m + 32[32m:[0m
      [95mmem[[0m[94midx[0m + 32[95m][0m = [32mvirtualChannels[0m[32m[[0m[32m_id[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m.field_256[0m
      [94midx[0m = [94midx[0m + 32
      [94ms[0m = [94ms[0m + 1
      [32mcontinue [0m
  return bool([32mvirtualChannels[0m[32m[[0m[32m_id[0m[32m][0m[32m.field_0[0m), 
         bool([32mvirtualChannels[0m[32m[[0m[32m_id[0m[32m][0m[32m.field_8[0m),
         [32mvirtualChannels[0m[32m[[0m[32m_id[0m[32m][0m[32m.field_256[0m,
         [32mvirtualChannels[0m[32m[[0m[32m_id[0m[32m][0m[32m.field_512[0m,
         [32mvirtualChannels[0m[32m[[0m[32m_id[0m[32m][0m[32m.field_768[0m,
         [32mvirtualChannels[0m[32m[[0m[32m_id[0m[32m][0m[32m.field_1024[0m,
         [32mvirtualChannels[0m[32m[[0m[32m_id[0m[32m][0m[32m.field_1280[0m,
         [32mvirtualChannels[0m[32m[[0m[32m_id[0m[32m][0m[32m.field_1536[0m,
         [95mmem[[0m1376[95m][0m[1m >> [0m256,
         [32mvirtualChannels[0m[32m[[0m[32m_id[0m[32m][0m[32m.field_2304[0m,
         [95mmem[[0m1440[95m][0m,
         [95mmem[[0m1504[95m][0m[1m >> [0m256

[95mdef [0mgetChannel(bytes32 [32m_id[0m): [38;5;8m# not payable[0m
  [94midx[0m = 1952
  [94ms[0m = 0
  [32mwhile [0m2016[1m > [0m[94midx[0m + 32[32m:[0m
      [95mmem[[0m[94midx[0m + 32[95m][0m = [32mchannels[0m[32m[[0m[32m_id[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m.field_256[0m
      [94midx[0m = [94midx[0m + 32
      [94ms[0m = [94ms[0m + 1
      [32mcontinue [0m
  [94midx[0m = 2016
  [94ms[0m = 2
  [32mwhile [0m2144[1m > [0m[94midx[0m + 32[32m:[0m
      [95mmem[[0m[94midx[0m + 32[95m][0m = [32mchannels[0m[32m[[0m[32m_id[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m.field_256[0m
      [94midx[0m = [94midx[0m + 32
      [94ms[0m = [94ms[0m + 1
      [32mcontinue [0m
  [94midx[0m = 2144
  [94ms[0m = 6
  [32mwhile [0m2272[1m > [0m[94midx[0m + 32[32m:[0m
      [95mmem[[0m[94midx[0m + 32[95m][0m = [32mchannels[0m[32m[[0m[32m_id[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m.field_256[0m
      [94midx[0m = [94midx[0m + 32
      [94ms[0m = [94ms[0m + 1
      [32mcontinue [0m
  [94midx[0m = 2272
  [94ms[0m = 10
  [32mwhile [0m2336[1m > [0m[94midx[0m + 32[32m:[0m
      [95mmem[[0m[94midx[0m + 32[95m][0m = [32mchannels[0m[32m[[0m[32m_id[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m.field_256[0m
      [94midx[0m = [94midx[0m + 32
      [94ms[0m = [94ms[0m + 1
      [32mcontinue [0m
  return [32mchannels[0m[32m[[0m[32m_id[0m[32m][0m[32m.field_0[0m, 
         [95mmem[[0m1984[95m][0m,
         [95mmem[[0m2048[95m len [0m96[95m][0m[1m >> [0m768,
         [32mchannels[0m[32m[[0m[32m_id[0m[32m][0m[32m.field_1536[0m,
         [95mmem[[0m2176[95m len [0m96[95m][0m,
         [95mmem[[0m2304[95m][0m[1m >> [0m256,
         [32mchannels[0m[32m[[0m[32m_id[0m[32m][0m[32m.field_3072[0m,
         [32mchannels[0m[32m[[0m[32m_id[0m[32m][0m[32m.field_3328[0m,
         [32mchannels[0m[32m[[0m[32m_id[0m[32m][0m[32m.field_3584[0m,
         [32mchannels[0m[32m[[0m[32m_id[0m[32m][0m[32m.field_3840[0m,
         [32mchannels[0m[32m[[0m[32m_id[0m[32m][0m[32m.field_4096[0m,
         bool([32mchannels[0m[32m[[0m[32m_id[0m[32m][0m[32m.field_4352[0m),
         bool([32mchannels[0m[32m[[0m[32m_id[0m[32m][0m[32m.field_4360[0m),
         [32mchannels[0m[32m[[0m[32m_id[0m[32m][0m[32m.field_4608[0m

[95mdef [0mcloseVirtualChannel(bytes32 [32m_lcID[0m, bytes32 [32m_vcID[0m): [38;5;8m# not payable[0m
  if not [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4352[0m:
      revert with 0, 'LC is closed.'
  if not [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_8[0m:
      revert with 0, 'VC is not in settlement state.'
  if block.timestamp[1m <= [0m[32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_768[0m:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'Update vc timeout has not elapsed.'
  if [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_0[0m:
      revert with 0, 'VC is already closed'
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4608[0m--
  [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_0[0m = 1
  if [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m[1m == [0m[32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_1024[0m:
      [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_512[0m += [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_1792[0m
      [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_768[0m += [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_2048[0m
      [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1536[0m += [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_2304[0m
      [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1792[0m += [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_2560[0m
  else:
      if [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m[1m == [0m[32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_1280[0m:
          [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_512[0m += [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_2048[0m
          [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_768[0m += [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_1792[0m
          [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1536[0m += [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_2560[0m
          [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1792[0m += [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_2304[0m
  [38;5;8mlog DidVCClose([0m
  [38;5;8m      bytes32 lcId=virtualChannels[_vcID].field_2304,[0m
  [38;5;8m      bytes32 vcId=virtualChannels[_vcID].field_2560,[0m
  [38;5;8m      uint256 balanceA=_lcID,[0m
  [38;5;8m      uint256 balanceB=_vcID)[0m

[95mdef [0mcreateChannel(bytes32 [32m_lcID[0m, address [32m_partyI[0m, uint256 [32m_confirmTime[0m, address [32m_token[0m, uint256[2] [32m_balances[0m)[95m payable[0m: 
  [95mmem[[0m96[95m len [0m64[95m][0m = call.data[132 len 64]
  if [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m:
      revert with 0, 'Channel has already been created.'
  if not [32m_partyI[0m:
      revert with 0, 'No partyI address provided to LC creation'
  if 0[1m > [0mcall.data[132]:
      revert with 0, 'Balances cannot be negative'
  if 0[1m > [0mcall.data[164]:
      revert with 0, 'Balances cannot be negative'
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m = caller
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_256[0m = [32m_partyI[0m
  if call.data[132]:
      if call.data[132] != call.value:
          revert with 0, 'Eth balance does not match sent value'
      [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_512[0m = call.value
  if call.data[164]:
      [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m = [32m_token[0m
      require ext_code.size([32m_token[0m)
      call [32m_token[0m.transferFrom([38;5;8maddress[0m from, [38;5;8maddress[0m to, [38;5;8muint256[0m value) with:
           gas gas_remaining [38;5;8mwei[0m
          args caller, this.address, call.data[164]
      [95mmem[[0m160[95m][0m = ext_call.return_data[0]
      if not ext_call.success:
          revert with ext_call.return_data[0 len return_data.size]
      require return_data.size[1m >= [0m32
      if not ext_call.return_data[0]:
          revert with 0, 'CreateChannel: token transfer failure'
      [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1536[0m = call.data[164]
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_3072[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_3328[0m = [32m_confirmTime[0m
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_3840[0m = [32m_confirmTime[0m + block.timestamp
  [94ms[0m = 10
  [94midx[0m = 96
  [32mwhile [0m160[1m > [0m[94midx[0m[32m:[0m
      [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m.field_0[0m = [95mmem[[0m[94midx[0m[95m][0m
      [94ms[0m = [94ms[0m + 1
      [94midx[0m = [94midx[0m + 32
      [32mcontinue [0m
  [94midx[0m = 12
  [32mwhile [0m12[1m > [0m[94midx[0m[32m:[0m
      [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m.field_0[0m = 0
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  [38;5;8mlog DidLCOpen([0m
  [38;5;8m      bytes32 channelId=call.data[132],[0m
  [38;5;8m      address partyA=addr(_token),[0m
  [38;5;8m      address partyI=call.data[164],[0m
  [38;5;8m      uint256 ethBalanceA=channels[_lcID].field_3840,[0m
  [38;5;8m      address token=_lcID,[0m
  [38;5;8m      uint256 tokenBalanceA=caller,[0m
  [38;5;8m      uint256 LCopenTimeout=_partyI)[0m

[95mdef [0mdeposit(bytes32 [32m_lcID[0m, address [32m_recipient[0m, uint256 [32m_balance[0m, bool [32m_isToken[0m)[95m payable[0m: 
  if bool([32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4352[0m) != 1:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'Tried adding funds to a closed channel'
  if [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m != [32m_recipient[0m:
      require [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_256[0m[1m == [0m[32m_recipient[0m
  if [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m[1m == [0m[32m_recipient[0m:
      if not [32m_isToken[0m:
          if [32m_balance[0m != call.value:
              revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'state balance does not match sent value'
          [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1024[0m += call.value
      else:
          require ext_code.size([32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m)
          call [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m.transferFrom([38;5;8maddress[0m from, [38;5;8maddress[0m to, [38;5;8muint256[0m value) with:
               gas gas_remaining [38;5;8mwei[0m
              args caller, this.address, [32m_balance[0m
          if not ext_call.success:
              revert with ext_call.return_data[0 len return_data.size]
          require return_data.size[1m >= [0m32
          if not ext_call.return_data[0]:
              revert with 0, 'deposit: token transfer failure'
          [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2048[0m += [32m_balance[0m
  if [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_256[0m[1m == [0m[32m_recipient[0m:
      if not [32m_isToken[0m:
          if [32m_balance[0m != call.value:
              revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'state balance does not match sent value'
          [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1280[0m += call.value
      else:
          require ext_code.size([32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m)
          call [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m.transferFrom([38;5;8maddress[0m from, [38;5;8maddress[0m to, [38;5;8muint256[0m value) with:
               gas gas_remaining [38;5;8mwei[0m
              args caller, this.address, [32m_balance[0m
          if not ext_call.success:
              revert with ext_call.return_data[0 len return_data.size]
          require return_data.size[1m >= [0m32
          if not ext_call.return_data[0]:
              revert with 0, 'deposit: token transfer failure'
          [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2304[0m += [32m_balance[0m
  [38;5;8mlog DidLCDeposit([0m
  [38;5;8m      bytes32 channelId=_balance,[0m
  [38;5;8m      address recipient=_isToken,[0m
  [38;5;8m      uint256 deposit=_lcID,[0m
  [38;5;8m      bool isToken=_recipient)[0m

[95mdef [0mLCOpenTimeout(bytes32 [32m_lcID[0m): [38;5;8m# not payable[0m
  require caller[1m == [0m[32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m
  require not [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4352[0m
  require block.timestamp[1m > [0m[32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_3840[0m
  if [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2560[0m:
      call [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m with:
         value [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_512[0m [38;5;8mwei[0m
           gas 2300 * is_zero(value) [38;5;8mwei[0m
      if not ext_call.success:
          revert with ext_call.return_data[0 len return_data.size]
  if [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2816[0m:
      require ext_code.size([32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m)
      call [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m.transfer([38;5;8maddress[0m to, [38;5;8muint256[0m value) with:
           gas gas_remaining [38;5;8mwei[0m
          args [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m, [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1536[0m
      if not ext_call.success:
          revert with ext_call.return_data[0 len return_data.size]
      require return_data.size[1m >= [0m32
      if not ext_call.return_data[0]:
          revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'CreateChannel: token transfer failure'
  [38;5;8mlog DidLCClose([0m
  [38;5;8m      bytes32 channelId=0,[0m
  [38;5;8m      uint256 sequence=channels[_lcID].field_512,[0m
  [38;5;8m      uint256 ethBalanceA=channels[_lcID].field_1536,[0m
  [38;5;8m      uint256 tokenBalanceA=0,[0m
  [38;5;8m      uint256 ethBalanceI=0,[0m
  [38;5;8m      uint256 tokenBalanceI=_lcID)[0m
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_256[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_512[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_768[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1024[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1280[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1536[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1792[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2048[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2304[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2560[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2816[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_3072[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_3328[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_3584[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_3840[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4096[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4352[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4608[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m = 0

[95mdef [0msettleVC(bytes32 [32m_lcID[0m, bytes32 [32m_vcID[0m, uint256 [32m_updateSeq[0m, address [32m_partyA[0m, address [32m_partyB[0m, uint256[4] [32m_updateBal[0m, string [32m_sigA[0m): [38;5;8m# not payable[0m
  if not [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4352[0m:
      revert with 0, 'LC is closed.'
  if [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_0[0m:
      revert with 0, 'VC is closed.'
  if [32m_updateSeq[0m[1m <= [0m[32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_256[0m:
      revert with 0, 'VC sequence is higher than update sequence.'
  if [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_2048[0m[1m >= [0mcall.data[196]:
      revert with 0, 'State updates may only increase recipient balance.'
  if [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_2560[0m[1m >= [0mcall.data[260]:
      revert with 0, 'State updates may only increase recipient balance.'
  if call.data[164] + call.data[196] != [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_2816[0m:
      revert with 0, 'Incorrect balances for bonded amount'
  if call.data[260] + call.data[228] != [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_3072[0m:
      revert with 0, 'Incorrect balances for bonded amount'
  require block.timestamp[1m > [0m[32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4096[0m
  require ext_code.size(0xcb107c7d2a93e638b20342f46b10b9b6d81377bf)
  [93mdelegate[0m 0xcb107c7d2a93e638b20342f46b10b9b6d81377bf.0xdca95419 with:
       gas gas_remaining [38;5;8mwei[0m
      args sha3([32m_vcID[0m, [32m_updateSeq[0m, [32m_partyA[0m, [32m_partyB[0m, [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_2816[0m, [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_3072[0m, call.data[164], call.data[196], call.data[228], call.data[260 len 24], call.data[284 len 8]), [38;5;8mArray(len=[0m[32m('cd', 292).length[0m[38;5;8m, data=[0mcall.data[cd[292] + 36 len [32m('cd', 292).length[0m][38;5;8m)[0m
  if not delegate.return_code:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m32
  require [38;5;8maddr([0mdelegate.return_data[0][38;5;8m)[0m[1m == [0m[32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_1024[0m
  [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_512[0m = caller
  [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_256[0m = [32m_updateSeq[0m
  [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_1792[0m = call.data[164]
  [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_2048[0m = call.data[196]
  [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_2304[0m = call.data[228]
  [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_2560[0m = call.data[260]
  [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_768[0m = [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_3328[0m + block.timestamp
  [38;5;8mlog DidVCSettle([0m
  [38;5;8m      bytes32 lcId=_updateSeq,[0m
  [38;5;8m      bytes32 vcId=call.data[164],[0m
  [38;5;8m      uint256 updateSeq=call.data[196],[0m
  [38;5;8m      uint256 updateBalA=caller,[0m
  [38;5;8m      uint256 updateBalB=virtualChannels[_vcID].field_768,[0m
  [38;5;8m      address challenger=_lcID,[0m
  [38;5;8m      uint256 updateVCtimeout=_vcID)[0m

[95mdef [0mupdateLCstate(bytes32 [32m_lcID[0m, uint256[6] [32m_updateParams[0m, bytes32 [32m_VCroot[0m, string [32m_sigA[0m, string [32m_sigI[0m): [38;5;8m# not payable[0m
  require [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4352[0m
  require [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_3072[0m[1m < [0mcall.data[36]
  require [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_768[0m + [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_512[0m[1m >= [0mcall.data[132] + call.data[100]
  require [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1792[0m + [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1536[0m[1m >= [0mcall.data[196] + call.data[164]
  if 1[1m == [0mbool([32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4360[0m):
      require block.timestamp[1m < [0m[32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4096[0m
  require ext_code.size(0xcb107c7d2a93e638b20342f46b10b9b6d81377bf)
  [93mdelegate[0m 0xcb107c7d2a93e638b20342f46b10b9b6d81377bf.0xdca95419 with:
       gas gas_remaining [38;5;8mwei[0m
      args sha3([32m_lcID[0m, 0, call.data[36], call.data[68], cd[228], [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m, [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_256[0m, call.data[100], call.data[132], call.data[164], call.data[196 len 23], call.data[219 len 9]), [38;5;8mArray(len=[0m[32m('cd', 260).length[0m[38;5;8m, data=[0mcall.data[cd[260] + 36 len [32m('cd', 260).length[0m][38;5;8m)[0m
  if not delegate.return_code:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m32
  require [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m[1m == [0m[38;5;8maddr([0mdelegate.return_data[0][38;5;8m)[0m
  require ext_code.size(0xcb107c7d2a93e638b20342f46b10b9b6d81377bf)
  [93mdelegate[0m 0xcb107c7d2a93e638b20342f46b10b9b6d81377bf.0xdca95419 with:
       gas gas_remaining [38;5;8mwei[0m
      args sha3([32m_lcID[0m, 0, call.data[36], call.data[68], cd[228], [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m, [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_256[0m, call.data[100], call.data[132], call.data[164], call.data[196 len 23], call.data[219 len 9]), [38;5;8mArray(len=[0m[32m('cd', 292).length[0m[38;5;8m, data=[0mcall.data[cd[292] + 36 len [32m('cd', 292).length[0m][38;5;8m)[0m
  if not delegate.return_code:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m32
  require [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_256[0m[1m == [0m[38;5;8maddr([0mdelegate.return_data[0][38;5;8m)[0m
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_3072[0m = call.data[36]
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4608[0m = call.data[68]
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_512[0m = call.data[100]
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_768[0m = call.data[132]
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1536[0m = call.data[164]
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1792[0m = call.data[196]
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_3584[0m = cd[228]
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4360[0m = 1
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4096[0m = block.timestamp + [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_3328[0m
  [38;5;8mlog DidLCUpdateState([0m
  [38;5;8m      bytes32 channelId=call.data[36],[0m
  [38;5;8m      uint256 sequence=call.data[68],[0m
  [38;5;8m      uint256 numOpenVc=call.data[100],[0m
  [38;5;8m      uint256 ethBalanceA=call.data[132],[0m
  [38;5;8m      uint256 tokenBalanceA=call.data[164],[0m
  [38;5;8m      uint256 ethBalanceI=call.data[196],[0m
  [38;5;8m      uint256 tokenBalanceI=cd[228],[0m
  [38;5;8m      bytes32 vcRoot=channels[_lcID].field_4096,[0m
  [38;5;8m      uint256 updateLCtimeout=_lcID)[0m

[95mdef [0mconsensusCloseChannel(bytes32 [32m_lcID[0m, uint256 [32m_sequence[0m, uint256[4] [32m_balances[0m, string [32m_sigA[0m, string [32m_sigI[0m): [38;5;8m# not payable[0m
  require 1[1m == [0mbool([32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4352[0m)
  require [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1280[0m + [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1024[0m + [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2560[0m[1m == [0mcall.data[100] + call.data[68]
  require [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2048[0m + [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2816[0m + [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2304[0m[1m == [0mcall.data[132] + call.data[164]
  require ext_code.size(0xcb107c7d2a93e638b20342f46b10b9b6d81377bf)
  [93mdelegate[0m 0xcb107c7d2a93e638b20342f46b10b9b6d81377bf.0xdca95419 with:
       gas gas_remaining [38;5;8mwei[0m
      args sha3([32m_lcID[0m, 0, [32m_sequence[0m, 0, 0, [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m, [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_256[0m, call.data[68], call.data[100], call.data[132], call.data[164 len 23], call.data[187 len 9]), [38;5;8mArray(len=[0m[32m('cd', 196).length[0m[38;5;8m, data=[0mcall.data[cd[196] + 36 len [32m('cd', 196).length[0m][38;5;8m)[0m
  if not delegate.return_code:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m32
  require [38;5;8maddr([0mdelegate.return_data[0][38;5;8m)[0m[1m == [0m[32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m
  require ext_code.size(0xcb107c7d2a93e638b20342f46b10b9b6d81377bf)
  [93mdelegate[0m 0xcb107c7d2a93e638b20342f46b10b9b6d81377bf.0xdca95419 with:
       gas gas_remaining [38;5;8mwei[0m
      args sha3([32m_lcID[0m, 0, [32m_sequence[0m, 0, 0, [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m, [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_256[0m, call.data[68], call.data[100], call.data[132], call.data[164 len 23], call.data[187 len 9]), [38;5;8mArray(len=[0m[32m('cd', 228).length[0m[38;5;8m, data=[0mcall.data[cd[228] + 36 len [32m('cd', 228).length[0m][38;5;8m)[0m
  if not delegate.return_code:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m32
  require [38;5;8maddr([0mdelegate.return_data[0][38;5;8m)[0m[1m == [0m[32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_256[0m
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4352[0m = 0
  if call.data[68]:
      call [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m with:
         value call.data[68] [38;5;8mwei[0m
           gas 2300 * is_zero(value) [38;5;8mwei[0m
      if not ext_call.success:
          revert with ext_call.return_data[0 len return_data.size]
      call [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_256[0m with:
         value call.data[100] [38;5;8mwei[0m
           gas 2300 * is_zero(value) [38;5;8mwei[0m
  else:
      if call.data[100]:
          call [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m with:
             value call.data[68] [38;5;8mwei[0m
               gas 2300 * is_zero(value) [38;5;8mwei[0m
          if not ext_call.success:
              revert with ext_call.return_data[0 len return_data.size]
          call [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_256[0m with:
             value call.data[100] [38;5;8mwei[0m
               gas 2300 * is_zero(value) [38;5;8mwei[0m
  if call.data[132]:
      require ext_code.size([32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m)
      call [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m.transfer([38;5;8maddress[0m to, [38;5;8muint256[0m value) with:
           gas gas_remaining [38;5;8mwei[0m
          args [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m, call.data[132]
      if not ext_call.success:
          revert with ext_call.return_data[0 len return_data.size]
      require return_data.size[1m >= [0m32
      if not ext_call.return_data[0]:
          revert with 0, 'happyCloseChannel: token transfer failure'
      require ext_code.size([32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m)
      call [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m.transfer([38;5;8maddress[0m to, [38;5;8muint256[0m value) with:
           gas gas_remaining [38;5;8mwei[0m
          args [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_256[0m, call.data[164]
      if not ext_call.success:
          revert with ext_call.return_data[0 len return_data.size]
      require return_data.size[1m >= [0m32
      if not ext_call.return_data[0]:
          revert with 0, 'happyCloseChannel: token transfer failure'
  else:
      if call.data[164]:
          require ext_code.size([32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m)
          call [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m.transfer([38;5;8maddress[0m to, [38;5;8muint256[0m value) with:
               gas gas_remaining [38;5;8mwei[0m
              args [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m, call.data[132]
          if not ext_call.success:
              revert with ext_call.return_data[0 len return_data.size]
          require return_data.size[1m >= [0m32
          if not ext_call.return_data[0]:
              revert with 0, 'happyCloseChannel: token transfer failure'
          require ext_code.size([32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m)
          call [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m.transfer([38;5;8maddress[0m to, [38;5;8muint256[0m value) with:
               gas gas_remaining [38;5;8mwei[0m
              args [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_256[0m, call.data[164]
          if not ext_call.success:
              revert with ext_call.return_data[0 len return_data.size]
          require return_data.size[1m >= [0m32
          if not ext_call.return_data[0]:
              revert with 0, 'happyCloseChannel: token transfer failure'
  [32mnumChannels[0m--
  [38;5;8mlog DidLCClose([0m
  [38;5;8m      bytes32 channelId=_sequence,[0m
  [38;5;8m      uint256 sequence=call.data[68],[0m
  [38;5;8m      uint256 ethBalanceA=call.data[100],[0m
  [38;5;8m      uint256 tokenBalanceA=call.data[132],[0m
  [38;5;8m      uint256 ethBalanceI=call.data[164],[0m
  [38;5;8m      uint256 tokenBalanceI=_lcID)[0m

[95mdef [0mbyzantineCloseChannel(bytes32 [32m_lcID[0m): [38;5;8m# not payable[0m
  if not [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4352[0m:
      revert with 0, 'Channel is not open'
  require 1[1m == [0mbool([32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4360[0m)
  require not [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4608[0m
  if block.timestamp[1m <= [0m[32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4096[0m:
      revert with 0, 'LC timeout over.'
  if [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_512[0m + [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_768[0m[1m >= [0m[32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2560[0m + [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1024[0m + [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1280[0m:
      require [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2560[0m + [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1024[0m + [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1280[0m[1m == [0m[32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_512[0m + [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_768[0m
  else:
      [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_512[0m += [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1024[0m
      [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_768[0m += [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1280[0m
  if [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1536[0m + [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1792[0m[1m >= [0m[32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2816[0m + [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2048[0m + [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2304[0m:
      require [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2816[0m + [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2048[0m + [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2304[0m[1m == [0m[32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1536[0m + [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1792[0m
  else:
      [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1536[0m += [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2048[0m
      [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1792[0m += [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_2304[0m
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_512[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_768[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1536[0m = 0
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1792[0m = 0
  if [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_512[0m:
      call [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m with:
         value [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_512[0m [38;5;8mwei[0m
           gas 2300 * is_zero(value) [38;5;8mwei[0m
      if not ext_call.success:
          revert with ext_call.return_data[0 len return_data.size]
      call [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_256[0m with:
         value [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_768[0m [38;5;8mwei[0m
           gas 2300 * is_zero(value) [38;5;8mwei[0m
  else:
      if [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_768[0m:
          call [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m with:
             value [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_512[0m [38;5;8mwei[0m
               gas 2300 * is_zero(value) [38;5;8mwei[0m
          if not ext_call.success:
              revert with ext_call.return_data[0 len return_data.size]
          call [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_256[0m with:
             value [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_768[0m [38;5;8mwei[0m
               gas 2300 * is_zero(value) [38;5;8mwei[0m
  if [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1536[0m:
      require ext_code.size([32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m)
      call [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m.transfer([38;5;8maddress[0m to, [38;5;8muint256[0m value) with:
           gas gas_remaining [38;5;8mwei[0m
          args [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m, [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1536[0m
      if not ext_call.success:
          revert with ext_call.return_data[0 len return_data.size]
      require return_data.size[1m >= [0m32
      if not ext_call.return_data[0]:
          revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'byzantineCloseChannel: token transfer failure'
      require ext_code.size([32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m)
      call [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m.transfer([38;5;8maddress[0m to, [38;5;8muint256[0m value) with:
           gas gas_remaining [38;5;8mwei[0m
          args [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_256[0m, [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1792[0m
      if not ext_call.success:
          revert with ext_call.return_data[0 len return_data.size]
      require return_data.size[1m >= [0m32
      if not ext_call.return_data[0]:
          revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'byzantineCloseChannel: token transfer failure'
  else:
      if [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1792[0m:
          require ext_code.size([32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m)
          call [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m.transfer([38;5;8maddress[0m to, [38;5;8muint256[0m value) with:
               gas gas_remaining [38;5;8mwei[0m
              args [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_0[0m, [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1536[0m
          if not ext_call.success:
              revert with ext_call.return_data[0 len return_data.size]
          require return_data.size[1m >= [0m32
          if not ext_call.return_data[0]:
              revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'byzantineCloseChannel: token transfer failure'
          require ext_code.size([32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m)
          call [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4864[0m.transfer([38;5;8maddress[0m to, [38;5;8muint256[0m value) with:
               gas gas_remaining [38;5;8mwei[0m
              args [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_256[0m, [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_1792[0m
          if not ext_call.success:
              revert with ext_call.return_data[0 len return_data.size]
          require return_data.size[1m >= [0m32
          if not ext_call.return_data[0]:
              revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'byzantineCloseChannel: token transfer failure'
  [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4352[0m = 0
  [32mnumChannels[0m--
  [38;5;8mlog DidLCClose([0m
  [38;5;8m      bytes32 channelId=channels[_lcID].field_3072,[0m
  [38;5;8m      uint256 sequence=channels[_lcID].field_512,[0m
  [38;5;8m      uint256 ethBalanceA=channels[_lcID].field_768,[0m
  [38;5;8m      uint256 tokenBalanceA=channels[_lcID].field_1536,[0m
  [38;5;8m      uint256 ethBalanceI=channels[_lcID].field_1792,[0m
  [38;5;8m      uint256 tokenBalanceI=_lcID)[0m

[95mdef [0minitVCstate(bytes32 [32m_lcID[0m, bytes32 [32m_vcID[0m, bytes [32m_proof[0m, address [32m_partyA[0m, address [32m_partyB[0m, uint256[2] [32m_bond[0m, uint256[4] [32m_balances[0m, string [32m_sigA[0m): [38;5;8m# not payable[0m
  [95mmem[[0m96[95m][0m = [32m_proof.length[0m
  [95mmem[[0m128[95m len [0m[32m_proof.length[0m[95m][0m = [32m_proof[[0mall[32m][0m
  [95mmem[[0mceil32([32m_proof.length[0m) + 128[95m len [0m64[95m][0m = call.data[164 len 64]
  [95mmem[[0mceil32([32m_proof.length[0m) + 192[95m len [0m128[95m][0m = call.data[228 len 128]
  [95mmem[[0mceil32([32m_proof.length[0m) + 320[95m][0m = [32m('cd', 356).length[0m
  [95mmem[[0mceil32([32m_proof.length[0m) + 352[95m len [0m[32m('cd', 356).length[0m[95m][0m = call.data[cd[356] + 36 len [32m('cd', 356).length[0m]
  if not [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4352[0m:
      revert with 0, 'LC is closed.'
  if [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_0[0m:
      revert with 0, 'VC is closed.'
  if block.timestamp[1m <= [0m[32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_4096[0m:
      revert with 0, 'LC timeout not over.'
  require not [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_768[0m
  [95mmem[[0mceil32([32m_proof.length[0m) + ceil32([32m('cd', 356).length[0m) + 384[95m][0m = [32m_vcID[0m
  [95mmem[[0mceil32([32m_proof.length[0m) + ceil32([32m('cd', 356).length[0m) + 416[95m][0m = 0
  [95mmem[[0mceil32([32m_proof.length[0m) + ceil32([32m('cd', 356).length[0m) + 448[95m][0m = [38;5;8maddr([0m[32m_partyA[0m[38;5;8m)[0m
  [95mmem[[0mceil32([32m_proof.length[0m) + ceil32([32m('cd', 356).length[0m) + 468[95m][0m = [38;5;8maddr([0m[32m_partyB[0m[38;5;8m)[0m
  [95mmem[[0mceil32([32m_proof.length[0m) + ceil32([32m('cd', 356).length[0m) + 488[95m][0m = call.data[164]
  [95mmem[[0mceil32([32m_proof.length[0m) + ceil32([32m('cd', 356).length[0m) + 520[95m][0m = call.data[196]
  [95mmem[[0mceil32([32m_proof.length[0m) + ceil32([32m('cd', 356).length[0m) + 552[95m][0m = call.data[228]
  [95mmem[[0mceil32([32m_proof.length[0m) + ceil32([32m('cd', 356).length[0m) + 584[95m][0m = call.data[260]
  [95mmem[[0mceil32([32m_proof.length[0m) + ceil32([32m('cd', 356).length[0m) + 616[95m][0m = call.data[292]
  [95mmem[[0mceil32([32m_proof.length[0m) + ceil32([32m('cd', 356).length[0m) + 648[95m][0m = call.data[324]
  [95mmem[[0mceil32([32m_proof.length[0m) + ceil32([32m('cd', 356).length[0m) + 352[95m][0m = 296
  [95mmem[[0m64[95m][0m = ceil32([32m_proof.length[0m) + ceil32([32m('cd', 356).length[0m) + 680
  [95mmem[[0mceil32([32m_proof.length[0m) + ceil32([32m('cd', 356).length[0m) + 680[95m len [0m288[95m][0m = [32m_vcID[0m, 0, [32m_partyA[0m, [32m_partyB[0m, call.data[164], call.data[196], call.data[228], call.data[260], call.data[292], call.data[324 len 24]
  [95mmem[[0mceil32([32m_proof.length[0m) + ceil32([32m('cd', 356).length[0m) + 968[95m len [0m8[95m][0m = call.data[348 len 8]
  [95mmem[[0mceil32([32m_proof.length[0m) + ceil32([32m('cd', 356).length[0m) + 684[95m][0m = sha3([32m_vcID[0m, 0, [32m_partyA[0m, [32m_partyB[0m, call.data[164], call.data[196], call.data[228], call.data[260], call.data[292], call.data[324 len 24], call.data[348 len 8])
  [95mmem[[0mceil32([32m_proof.length[0m) + ceil32([32m('cd', 356).length[0m) + 716[95m][0m = 64
  [95mmem[[0mceil32([32m_proof.length[0m) + ceil32([32m('cd', 356).length[0m) + 748[95m][0m = [32m('cd', 356).length[0m
  [95mmem[[0mceil32([32m_proof.length[0m) + ceil32([32m('cd', 356).length[0m) + 780[95m len [0mceil32([32m('cd', 356).length[0m)[95m][0m = call.data[cd[356] + 36 len [32m('cd', 356).length[0m], [95mmem[[0mceil32([32m_proof.length[0m) + [32m('cd', 356).length[0m + 352[95m len [0mceil32([32m('cd', 356).length[0m) - [32m('cd', 356).length[0m[95m][0m
  require ext_code.size(0xcb107c7d2a93e638b20342f46b10b9b6d81377bf)
  [93mdelegate[0m 0xcb107c7d2a93e638b20342f46b10b9b6d81377bf.0xdca95419 with:
       gas gas_remaining [38;5;8mwei[0m
      args sha3([32m_vcID[0m, 0, [32m_partyA[0m, [32m_partyB[0m, call.data[164], call.data[196], call.data[228], call.data[260], call.data[292], call.data[324 len 24], call.data[348 len 8]), [38;5;8mArray(len=[0m[32m('cd', 356).length[0m[38;5;8m, data=[0mcall.data[cd[356] + 36 len [32m('cd', 356).length[0m][38;5;8m)[0m
  [95mmem[[0mceil32([32m_proof.length[0m) + ceil32([32m('cd', 356).length[0m) + 680[95m][0m = delegate.return_data[0]
  if not delegate.return_code:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m32
  require [38;5;8maddr([0mdelegate.return_data[0][38;5;8m)[0m[1m == [0m[32m_partyA[0m
  [95mmem[[0m0[95m][0m = [32m_lcID[0m
  [95mmem[[0m32[95m][0m = 2
  [94midx[0m = 64
  [94ms[0m = 0
  [94mt[0m = 0
  [32mwhile [0m[94midx[0m[1m <= [0m[32m_proof.length[0m[32m:[0m
      [94m_280[0m = [95mmem[[0m[94midx[0m + 96[95m][0m
      if [94mt[0m + sha3([32m_vcID[0m, 0, [32m_partyA[0m, [32m_partyB[0m, call.data[164], call.data[196], call.data[228], call.data[260], call.data[292], call.data[324 len 24], call.data[348 len 8])[1m >= [0m[95mmem[[0m[94midx[0m + 96[95m][0m:
          [94m_282[0m = [95mmem[[0m64[95m][0m
          [95mmem[[0m[95mmem[[0m64[95m][0m + 32[95m][0m = [95mmem[[0m[94midx[0m + 96[95m][0m
          [95mmem[[0m[95mmem[[0m64[95m][0m + 64[95m][0m = [94mt[0m + sha3([32m_vcID[0m, 0, [32m_partyA[0m, [32m_partyB[0m, call.data[164], call.data[196], call.data[228], call.data[260], call.data[292], call.data[324 len 24], call.data[348 len 8])
          [94m_283[0m = [95mmem[[0m64[95m][0m
          [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 64
          [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 96
          [94m_284[0m = [95mmem[[0m[94m_283[0m[95m][0m
          [94mt[0m = [94m_283[0m + 32
          [94mv[0m = [94m_282[0m + 96
          [94mu[0m = [95mmem[[0m[94m_283[0m[95m][0m
          [32mwhile [0m[94mu[0m + sha3([32m_vcID[0m, 0, [32m_partyA[0m, [32m_partyB[0m, call.data[164], call.data[196], call.data[228], call.data[260], call.data[292], call.data[324 len 24], call.data[348 len 8])[1m >= [0m32[32m:[0m
              [95mmem[[0m[94mv[0m[95m][0m = [95mmem[[0m[94mt[0m[95m][0m
              [94mt[0m = [94mt[0m + 32
              [94mv[0m = [94mv[0m + 32
              [94mu[0m = [94mu[0m - 32
              [32mcontinue [0m
          [95mmem[[0m[94m_282[0m + floor32([95mmem[[0m[94m_283[0m[95m][0m) + 96[95m][0m = [95mmem[[0m[94m_283[0m + floor32([95mmem[[0m[94m_283[0m[95m][0m) + -([95mmem[[0m[94m_283[0m[95m][0m[1m % [0m32) + 64[95m len [0m[95mmem[[0m[94m_283[0m[95m][0m[1m % [0m32[95m][0m[1m or [0mMask(8[1m * [0m-([95mmem[[0m[94m_283[0m[95m][0m[1m % [0m32) + 32, -(8[1m * [0m-([95mmem[[0m[94m_283[0m[95m][0m[1m % [0m32) + 32) + 256, [95mmem[[0m[94m_282[0m + floor32([95mmem[[0m[94m_283[0m[95m][0m) + 96[95m][0m)
          [94mt[0m = [94mt[0m + 32
          [94mv[0m = [94m_280[0m
          [94mu[0m = sha3([95mmem[[0m[95mmem[[0m64[95m][0m[95m len [0m[94m_284[0m + [94m_282[0m + -[95mmem[[0m64[95m][0m + 96[95m][0m)
          [32mcontinue [0m
      [94m_285[0m = [95mmem[[0m64[95m][0m
      [95mmem[[0m[95mmem[[0m64[95m][0m + 32[95m][0m = [94mt[0m + sha3([32m_vcID[0m, 0, [32m_partyA[0m, [32m_partyB[0m, call.data[164], call.data[196], call.data[228], call.data[260], call.data[292], call.data[324 len 24], call.data[348 len 8])
      [95mmem[[0m[95mmem[[0m64[95m][0m + 64[95m][0m = [94m_280[0m
      [94m_286[0m = [95mmem[[0m64[95m][0m
      [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 64
      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 96
      [94m_287[0m = [95mmem[[0m[94m_286[0m[95m][0m
      [94mt[0m = [94m_286[0m + 32
      [94mv[0m = [94m_285[0m + 96
      [94mu[0m = [95mmem[[0m[94m_286[0m[95m][0m
      [32mwhile [0m[94mu[0m + sha3([32m_vcID[0m, 0, [32m_partyA[0m, [32m_partyB[0m, call.data[164], call.data[196], call.data[228], call.data[260], call.data[292], call.data[324 len 24], call.data[348 len 8])[1m >= [0m32[32m:[0m
          [95mmem[[0m[94mv[0m[95m][0m = [95mmem[[0m[94mt[0m[95m][0m
          [94mt[0m = [94mt[0m + 32
          [94mv[0m = [94mv[0m + 32
          [94mu[0m = [94mu[0m - 32
          [32mcontinue [0m
      [95mmem[[0m[94m_285[0m + floor32([95mmem[[0m[94m_286[0m[95m][0m) + 96[95m][0m = [95mmem[[0m[94m_286[0m + floor32([95mmem[[0m[94m_286[0m[95m][0m) + -([95mmem[[0m[94m_286[0m[95m][0m[1m % [0m32) + 64[95m len [0m[95mmem[[0m[94m_286[0m[95m][0m[1m % [0m32[95m][0m[1m or [0mMask(8[1m * [0m-([95mmem[[0m[94m_286[0m[95m][0m[1m % [0m32) + 32, -(8[1m * [0m-([95mmem[[0m[94m_286[0m[95m][0m[1m % [0m32) + 32) + 256, [95mmem[[0m[94m_285[0m + floor32([95mmem[[0m[94m_286[0m[95m][0m) + 96[95m][0m)
      [94mt[0m = [94mt[0m + 32
      [94mv[0m = [94m_280[0m
      [94mu[0m = sha3([95mmem[[0m[95mmem[[0m64[95m][0m[95m len [0m[94m_287[0m + [94m_285[0m + -[95mmem[[0m64[95m][0m + 96[95m][0m)
      [32mcontinue [0m
  require 1[1m == [0m[94mt[0m[1m == [0m[32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_3584[0m
  [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_1024[0m = [32m_partyA[0m
  [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_1280[0m = [32m_partyB[0m
  [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_256[0m = 0
  [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_1792[0m = [95mmem[[0mceil32([32m_proof.length[0m) + 192[95m][0m
  [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_2048[0m = [95mmem[[0mceil32([32m_proof.length[0m) + 224[95m][0m
  [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_2304[0m = [95mmem[[0mceil32([32m_proof.length[0m) + 256[95m][0m
  [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_2560[0m = [95mmem[[0mceil32([32m_proof.length[0m) + 288[95m][0m
  [94ms[0m = 11
  [94midx[0m = ceil32([32m_proof.length[0m) + 128
  [32mwhile [0mceil32([32m_proof.length[0m) + 192[1m > [0m[94midx[0m[32m:[0m
      [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m.field_0[0m = [95mmem[[0m[94midx[0m[95m][0m
      [94ms[0m = [94ms[0m + 1
      [94midx[0m = [94midx[0m + 32
      [32mcontinue [0m
  [94midx[0m = 13
  [32mwhile [0m13[1m > [0m[94midx[0m[32m:[0m
      [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m.field_0[0m = 0
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  [95mmem[[0m0[95m][0m = [32m_vcID[0m
  [95mmem[[0m32[95m][0m = 1
  [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_768[0m = [32mchannels[0m[32m[[0m[32m_lcID[0m[32m][0m[32m.field_3328[0m + block.timestamp
  [32mvirtualChannels[0m[32m[[0m[32m_vcID[0m[32m][0m[32m.field_8[0m = 1
  [94m_394[0m = [95mmem[[0mceil32([32m_proof.length[0m) + 192[95m][0m
  [94m_395[0m = [95mmem[[0mceil32([32m_proof.length[0m) + 224[95m][0m
  [94m_396[0m = [95mmem[[0m64[95m][0m
  [95mmem[[0m[95mmem[[0m64[95m][0m + 32[95m][0m = 0
  [95mmem[[0m[95mmem[[0m64[95m][0m + 64[95m][0m = [32m_partyA[0m
  [95mmem[[0m[95mmem[[0m64[95m][0m + 96[95m][0m = [32m_partyB[0m
  [95mmem[[0m[95mmem[[0m64[95m][0m + 128[95m][0m = [94m_394[0m
  [95mmem[[0m[95mmem[[0m64[95m][0m + 160[95m][0m = [94m_395[0m
  [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 192
  [95mmem[[0m[94m_396[0m + 192[95m][0m = [95mmem[[0m96[95m][0m
  [95mmem[[0m[94m_396[0m + 224[95m len [0mceil32([95mmem[[0m96[95m][0m)[95m][0m = [95mmem[[0m128[95m len [0mceil32([95mmem[[0m96[95m][0m)[95m][0m
  if not [95mmem[[0m96[95m][0m[1m % [0m32:
      [38;5;8mlog DidVCInit(bytes32 lcId, bytes32 vcId, bytes proof, uint256 sequence, address partyA, address partyB, uint256 balanceA, uint256 balanceB):[0m
      [38;5;8m              mem[mem[64] len mem[96] + _396 + -mem[64] + 224],[0m
      [38;5;8m              _lcID,[0m
      [38;5;8m              _vcID,[0m
  else:
      [95mmem[[0mfloor32([95mmem[[0m96[95m][0m) + [94m_396[0m + 224[95m][0m = [95mmem[[0mfloor32([95mmem[[0m96[95m][0m) + [94m_396[0m + -([95mmem[[0m96[95m][0m[1m % [0m32) + 256[95m len [0m[95mmem[[0m96[95m][0m[1m % [0m32[95m][0m
      [38;5;8mlog DidVCInit(bytes32 lcId, bytes32 vcId, bytes proof, uint256 sequence, address partyA, address partyB, uint256 balanceA, uint256 balanceB):[0m
      [38;5;8m              mem[mem[64] len floor32(mem[96]) + _396 + -mem[64] + 256],[0m
      [38;5;8m              _lcID,[0m
      [38;5;8m              _vcID,[0m

