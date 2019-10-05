[38;5;8m#
#  Panoramix 4 Oct 2019 
#  Decompiled source of [0m0x8d12A197cB00D4747a1fe03395095ce2A5CC6819[38;5;8m
# 
#  Let's make the world open source 
# [0m

[32mdef [0mstorage:
  [32madminAddress[0m is addr [38;5;8mat storage 0[0m[38;5;8m[0m
  [32mfeeAccount[0m is addr [38;5;8mat storage 1[0m[38;5;8m[0m
  [32maccountLevelsAddr[0m is addr [38;5;8mat storage 2[0m[38;5;8m[0m
  [32mfeeMake[0m is uint256 [38;5;8mat storage 3[0m[38;5;8m[0m
  [32mfeeTake[0m is uint256 [38;5;8mat storage 4[0m[38;5;8m[0m
  [32mfeeRebate[0m is uint256 [38;5;8mat storage 5[0m[38;5;8m[0m
  [32mtokens[0m is mapping of uint256 [38;5;8mat storage 6[0m
  [32mstor7[0m is mapping of uint8 [38;5;8mat storage 7[0m
  [32morderFills[0m is mapping of uint256 [38;5;8mat storage 8[0m

[95mdef [0morderFills(address [32m_param1[0m, bytes32 [32m_param2[0m): [38;5;8m# not payable[0m
  return [32morderFills[0m[32m[[0m[32m_param1[0m[32m][0m[32m[[0m[32m_param2[0m[32m][0m

[95mdef [0mamountFilled(address [32m_tokenGet[0m, uint256 [32m_amountGet[0m, address [32m_tokenGive[0m, uint256 [32m_amountGive[0m, uint256 [32m_expires[0m, uint256 [32m_nonce[0m, address [32m_user[0m, uint8 [32m_v[0m, bytes32 [32m_r[0m, bytes32 [32m_s[0m): [38;5;8m# not payable[0m
  [94mhash[0m = sha256hash([38;5;8maddr([0mthis.address[38;5;8m)[0m, 0, [38;5;8muint64([0m[32m_amountGet[0m[38;5;8m)[0m, [32m_tokenGive[0m, [32m_amountGive[0m, [32m_expires[0m, [32m_nonce[0m) [38;5;8m# precompiled[0m
  require sha256hash.result
  return [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m

[95mdef [0mtokens(address [32m_param1[0m, address [32m_param2[0m): [38;5;8m# not payable[0m
  return [32mtokens[0m[32m[[0m[32m_param1[0m[32m][0m[32m[[0m[32m_param2[0m[32m][0m

[95mdef [0mfeeMake(): [38;5;8m# not payable[0m
  return [32mfeeMake[0m

[95mdef [0mfeeAccount(): [38;5;8m# not payable[0m
  return [32mfeeAccount[0m

[95mdef [0mfeeRebate(): [38;5;8m# not payable[0m
  return [32mfeeRebate[0m

[95mdef [0morders(address [32m_param1[0m, bytes32 [32m_param2[0m): [38;5;8m# not payable[0m
  return bool([32mstor7[0m[32m[[0m[32m_param1[0m[32m][0m[32m[[0m[32m_param2[0m[32m][0m)

[95mdef [0mfeeTake(): [38;5;8m# not payable[0m
  return [32mfeeTake[0m

[95mdef [0maccountLevelsAddr(): [38;5;8m# not payable[0m
  return [32maccountLevelsAddr[0m

[95mdef [0mbalanceOf(address [32m_token[0m, address [32m_user[0m): [38;5;8m# not payable[0m
  return [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_token[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m

[95mdef [0madmin(): [38;5;8m# not payable[0m
  return [32madminAddress[0m

[38;5;8m#
#  Regular functions
#[0m

[95mdef [0m_fallback(): [38;5;8m# not payable, default function[0m
  revert 

[95mdef [0mchangeAdmin(address [32m_who[0m): [38;5;8m# not payable[0m
  require [32madminAddress[0m[1m == [0mcaller
  [32madminAddress[0m = [32m_who[0m

[95mdef [0mchangeFeeAccount(address [32m_newWallet[0m): [38;5;8m# not payable[0m
  require [32madminAddress[0m[1m == [0mcaller
  [32mfeeAccount[0m = [32m_newWallet[0m

[95mdef [0mchangeAccountLevelsAddr(address [32m_accountLevelsAddr[0m): [38;5;8m# not payable[0m
  require [32madminAddress[0m[1m == [0mcaller
  [32maccountLevelsAddr[0m = [32m_accountLevelsAddr_[0m

[95mdef [0mchangeFeeMake(uint256 [32m_feeMake[0m): [38;5;8m# not payable[0m
  require [32madminAddress[0m[1m == [0mcaller
  require [32m_feeMake_[0m[1m <= [0m[32mfeeMake[0m
  [32mfeeMake[0m = [32m_feeMake_[0m

[95mdef [0mchangeFeeTake(uint256 [32m_newFee[0m): [38;5;8m# not payable[0m
  require [32madminAddress[0m[1m == [0mcaller
  require [32m_newFee[0m[1m <= [0m[32mfeeTake[0m
  require [32m_newFee[0m[1m >= [0m[32mfeeRebate[0m
  [32mfeeTake[0m = [32m_newFee[0m

[95mdef [0mchangeFeeRebate(uint256 [32m_feeRebate[0m): [38;5;8m# not payable[0m
  require [32madminAddress[0m[1m == [0mcaller
  require [32m_feeRebate_[0m[1m >= [0m[32mfeeRebate[0m
  require [32m_feeRebate_[0m[1m <= [0m[32mfeeTake[0m
  [32mfeeRebate[0m = [32m_feeRebate_[0m

[95mdef [0mdeposit()[95m payable[0m: 
  require call.value + [32mtokens[0m[32m[[0m0[32m][0m[32m[[0mcaller[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m0[32m][0m[32m[[0mcaller[32m][0m
  require call.value + [32mtokens[0m[32m[[0m0[32m][0m[32m[[0mcaller[32m][0m[1m >= [0mcall.value
  [32mtokens[0m[32m[[0m0[32m][0m[32m[[0mcaller[32m][0m += call.value
  [38;5;8mlog Deposit([0m
  [38;5;8m      address token=0,[0m
  [38;5;8m      address user=caller,[0m
  [38;5;8m      uint256 amount=call.value,[0m
  [38;5;8m      uint256 balance=call.value + tokens[0][caller])[0m

[95mdef [0mwithdraw(uint256 [32m_amount[0m): [38;5;8m# not payable[0m
  require [32mtokens[0m[32m[[0m0[32m][0m[32m[[0mcaller[32m][0m[1m >= [0m[32m_amount[0m
  require [32m_amount[0m[1m <= [0m[32mtokens[0m[32m[[0m0[32m][0m[32m[[0mcaller[32m][0m
  [32mtokens[0m[32m[[0m0[32m][0m[32m[[0mcaller[32m][0m -= [32m_amount[0m
  call caller with:
     value [32m_amount[0m [38;5;8mwei[0m
       gas gas_remaining - 34050 [38;5;8mwei[0m
  require ext_call.success
  [38;5;8mlog Withdraw([0m
  [38;5;8m      address token=0,[0m
  [38;5;8m      address user=caller,[0m
  [38;5;8m      uint256 amount=_amount,[0m
  [38;5;8m      uint256 balance=tokens[0][caller])[0m

[95mdef [0morder(address [32m_tokenGet[0m, uint256 [32m_amountGet[0m, address [32m_tokenGive[0m, uint256 [32m_amountGive[0m, uint256 [32m_expires[0m, uint256 [32m_nonce[0m): [38;5;8m# not payable[0m
  [94mhash[0m = sha256hash([38;5;8maddr([0mthis.address[38;5;8m)[0m, 0, [38;5;8muint64([0m[32m_amountGet[0m[38;5;8m)[0m, [32m_tokenGive[0m, [32m_amountGive[0m, [32m_expires[0m, [32m_nonce[0m) [38;5;8m# precompiled[0m
  require sha256hash.result
  [32mstor7[0m[32m[[0mcaller[32m][0m[32m[[0m[94mhash[0m[32m][0m = 1
  [38;5;8mlog Order([0m
  [38;5;8m      address tokenGet=_tokenGet,[0m
  [38;5;8m      uint256 amountGet=0,[0m
  [38;5;8m      address tokenGive=addr(_tokenGive),[0m
  [38;5;8m      uint256 amountGive=_amountGive,[0m
  [38;5;8m      uint256 expires=_expires,[0m
  [38;5;8m      uint256 nonce=_nonce,[0m
  [38;5;8m      address user=caller)[0m

[95mdef [0mwithdrawToken(address [32m_token[0m, uint256 [32m_amount[0m): [38;5;8m# not payable[0m
  require [32m_token[0m
  require [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_token[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m[1m >= [0m[32m_amount[0m
  require [32m_amount[0m[1m <= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_token[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m
  [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_token[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m -= [32m_amount[0m
  require ext_code.size([32m_token[0m)
  call [32m_token[0m.transfer([38;5;8maddress[0m to, [38;5;8muint256[0m value) with:
       gas gas_remaining - 50 [38;5;8mwei[0m
      args caller, [32m_amount[0m
  require ext_call.success
  require ext_call.return_data[0]
  [38;5;8mlog Withdraw([0m
  [38;5;8m      address token=addr(_token),[0m
  [38;5;8m      address user=caller,[0m
  [38;5;8m      uint256 amount=_amount,[0m
  [38;5;8m      uint256 balance=tokens[addr(_token)][caller])[0m

[95mdef [0mdepositToken(address [32m_token[0m, uint256 [32m_amount[0m): [38;5;8m# not payable[0m
  require [32m_token[0m
  require ext_code.size([32m_token[0m)
  call [32m_token[0m.transferFrom([38;5;8maddress[0m from, [38;5;8maddress[0m to, [38;5;8muint256[0m value) with:
       gas gas_remaining - 50 [38;5;8mwei[0m
      args caller, [38;5;8maddr([0mthis.address[38;5;8m)[0m, [32m_amount[0m
  require ext_call.success
  require ext_call.return_data[0]
  require [32m_amount[0m + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_token[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_token[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m
  require [32m_amount[0m + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_token[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m[1m >= [0m[32m_amount[0m
  [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_token[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m += [32m_amount[0m
  [38;5;8mlog Deposit([0m
  [38;5;8m      address token=addr(_token),[0m
  [38;5;8m      address user=caller,[0m
  [38;5;8m      uint256 amount=_amount,[0m
  [38;5;8m      uint256 balance=_amount + tokens[addr(_token)][caller])[0m

[95mdef [0mcancelOrder(address [32m_tokenGet[0m, uint256 [32m_amountGet[0m, address [32m_tokenGive[0m, uint256 [32m_amountGive[0m, uint256 [32m_expires[0m, uint256 [32m_nonce[0m, uint8 [32m_v[0m, bytes32 [32m_r[0m, bytes32 [32m_s[0m): [38;5;8m# not payable[0m
  [94mhash[0m = sha256hash([38;5;8maddr([0mthis.address[38;5;8m)[0m, 0, [38;5;8muint64([0m[32m_amountGet[0m[38;5;8m)[0m, [32m_tokenGive[0m, [32m_amountGive[0m, [32m_expires[0m, [32m_nonce[0m) [38;5;8m# precompiled[0m
  require sha256hash.result
  if [32mstor7[0m[32m[[0mcaller[32m][0m[32m[[0m[94mhash[0m[32m][0m:
      [32morderFills[0m[32m[[0mcaller[32m][0m[32m[[0m[94mhash[0m[32m][0m = [32m_amountGet[0m
      [38;5;8mlog Cancel([0m
      [38;5;8m      address tokenGet=_tokenGet,[0m
      [38;5;8m      uint256 amountGet=0,[0m
      [38;5;8m      address tokenGive=addr(_tokenGive),[0m
      [38;5;8m      uint256 amountGive=_amountGive,[0m
      [38;5;8m      uint256 expires=_expires,[0m
      [38;5;8m      uint256 nonce=_nonce,[0m
      [38;5;8m      address user=caller,[0m
      [38;5;8m      uint8 v=_v << 248,[0m
      [38;5;8m      bytes32 r=_r,[0m
      [38;5;8m      bytes32 s=_s)[0m
  else:
      [94msigner[0m = erecover(sha3(Mask(224, 32, '\x19Ethereum Signed Message:\n32')[1m >> [0m32, [94mhash[0m), [32m_v[0m[1m << [0m248, [32m_r[0m, [32m_s[0m) [38;5;8m# precompiled[0m
      require erecover.result
      require [38;5;8maddr([0m[94msigner[0m[38;5;8m)[0m[1m == [0mcaller
      [32morderFills[0m[32m[[0mcaller[32m][0m[32m[[0m[94mhash[0m[32m][0m = [32m_amountGet[0m
      [38;5;8mlog Cancel([0m
      [38;5;8m      address tokenGet=addr(_tokenGet),[0m
      [38;5;8m      uint256 amountGet=_amountGet,[0m
      [38;5;8m      address tokenGive=addr(_tokenGive),[0m
      [38;5;8m      uint256 amountGive=_amountGive,[0m
      [38;5;8m      uint256 expires=_expires,[0m
      [38;5;8m      uint256 nonce=_nonce,[0m
      [38;5;8m      address user=caller,[0m
      [38;5;8m      uint8 v=_v << 248,[0m
      [38;5;8m      bytes32 r=_r,[0m
      [38;5;8m      bytes32 s=_s)[0m

[95mdef [0mavailableVolume(address [32m_tokenGet[0m, uint256 [32m_amountGet[0m, address [32m_tokenGive[0m, uint256 [32m_amountGive[0m, uint256 [32m_expires[0m, uint256 [32m_nonce[0m, address [32m_user[0m, uint8 [32m_v[0m, bytes32 [32m_r[0m, bytes32 [32m_s[0m): [38;5;8m# not payable[0m
  [94mhash[0m = sha256hash([38;5;8maddr([0mthis.address[38;5;8m)[0m, 0, [38;5;8muint64([0m[32m_amountGet[0m[38;5;8m)[0m, [32m_tokenGive[0m, [32m_amountGive[0m, [32m_expires[0m, [32m_nonce[0m) [38;5;8m# precompiled[0m
  require sha256hash.result
  if not [32mstor7[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m:
      [94msigner[0m = erecover(sha3(Mask(224, 32, '\x19Ethereum Signed Message:\n32')[1m >> [0m32, [94mhash[0m), [32m_v[0m[1m << [0m248, [32m_r[0m, [32m_s[0m) [38;5;8m# precompiled[0m
      require erecover.result
      if [38;5;8maddr([0m[94msigner[0m[38;5;8m)[0m != [32m_user[0m:
          return 0
  if block.number[1m > [0m[32m_expires[0m:
      return 0
  require [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m[1m <= [0m[32m_amountGet[0m
  if [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m:
      require [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m
      require [32m_amountGet[0m[1m * [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[1m / [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[1m == [0m[32m_amountGet[0m
  require [32m_amountGive[0m
  if [32m_amountGet[0m - [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m[1m >= [0m[32m_amountGet[0m[1m * [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[1m / [0m[32m_amountGive[0m:
      return ([32m_amountGet[0m[1m * [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[1m / [0m[32m_amountGive[0m)
  return ([32m_amountGet[0m - [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m)

[95mdef [0mtestTrade(address [32m_tokenGet[0m, uint256 [32m_amountGet[0m, address [32m_tokenGive[0m, uint256 [32m_amountGive[0m, uint256 [32m_expires[0m, uint256 [32m_nonce[0m, address [32m_user[0m, uint8 [32m_v[0m, bytes32 [32m_r[0m, bytes32 [32m_s[0m, uint256 [32m_amount[0m, address [32m_sender[0m): [38;5;8m# not payable[0m
  if [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_sender[0m[38;5;8m)[0m[32m][0m[1m >= [0m[32m_amount[0m:
      [94mhash[0m = sha256hash([38;5;8maddr([0mthis.address[38;5;8m)[0m, 0, [38;5;8muint64([0m[32m_amountGet[0m[38;5;8m)[0m, [32m_tokenGive[0m, [32m_amountGive[0m, [32m_expires[0m, [32m_nonce[0m) [38;5;8m# precompiled[0m
      require sha256hash.result
      if [32mstor7[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m:
          if block.number[1m > [0m[32m_expires[0m:
              if 0[1m >= [0m[32m_amount[0m:
                  return 1
          else:
              require [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m[1m <= [0m[32m_amountGet[0m
              if [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m:
                  require [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m
                  require [32m_amountGet[0m[1m * [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[1m / [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[1m == [0m[32m_amountGet[0m
              require [32m_amountGive[0m
              if [32m_amountGet[0m - [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m[1m >= [0m[32m_amountGet[0m[1m * [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[1m / [0m[32m_amountGive[0m:
                  if [32m_amountGet[0m[1m * [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[1m / [0m[32m_amountGive[0m[1m >= [0m[32m_amount[0m:
                      return 1
              else:
                  if [32m_amountGet[0m - [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m[1m >= [0m[32m_amount[0m:
                      return 1
      else:
          [94msigner[0m = erecover(sha3(Mask(224, 32, '\x19Ethereum Signed Message:\n32')[1m >> [0m32, [94mhash[0m), [32m_v[0m[1m << [0m248, [32m_r[0m, [32m_s[0m) [38;5;8m# precompiled[0m
          require erecover.result
          if [38;5;8maddr([0m[94msigner[0m[38;5;8m)[0m != [32m_user[0m:
              if 0[1m >= [0m[32m_amount[0m:
                  return 1
          else:
              if block.number[1m > [0m[32m_expires[0m:
                  if 0[1m >= [0m[32m_amount[0m:
                      return 1
              else:
                  require [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m[1m <= [0m[32m_amountGet[0m
                  if [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m:
                      require [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m
                      require [32m_amountGet[0m[1m * [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[1m / [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[1m == [0m[32m_amountGet[0m
                  require [32m_amountGive[0m
                  if [32m_amountGet[0m - [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m[1m >= [0m[32m_amountGet[0m[1m * [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[1m / [0m[32m_amountGive[0m:
                      if [32m_amountGet[0m[1m * [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[1m / [0m[32m_amountGive[0m[1m >= [0m[32m_amount[0m:
                          return 1
                  else:
                      if [32m_amountGet[0m - [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m[1m >= [0m[32m_amount[0m:
                          return 1
      return 0
  else:
      return 0

[95mdef [0mtrade(address [32m_tokenGet[0m, uint256 [32m_amountGet[0m, address [32m_tokenGive[0m, uint256 [32m_amountGive[0m, uint256 [32m_expires[0m, uint256 [32m_nonce[0m, address [32m_user[0m, uint8 [32m_v[0m, bytes32 [32m_r[0m, bytes32 [32m_s[0m, uint256 [32m_amount[0m): [38;5;8m# not payable[0m
  [94mhash[0m = sha256hash([38;5;8maddr([0mthis.address[38;5;8m)[0m, 0, [38;5;8muint64([0m[32m_amountGet[0m[38;5;8m)[0m, [32m_tokenGive[0m, [32m_amountGive[0m, [32m_expires[0m, [32m_nonce[0m) [38;5;8m# precompiled[0m
  require sha256hash.result
  if [32mstor7[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m:
      require block.number[1m <= [0m[32m_expires[0m
      require [32m_amount[0m + [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m[1m >= [0m[32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m
      require [32m_amount[0m + [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m[1m >= [0m[32m_amount[0m
      require [32m_amount[0m + [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m[1m <= [0m[32m_amountGet[0m
      if [32m_amount[0m:
          require [32m_amount[0m
          require [32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m[32m_amount[0m[1m == [0m[32mfeeMake[0m
      if [32m_amount[0m:
          require [32m_amount[0m
          require [32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m[32m_amount[0m[1m == [0m[32mfeeTake[0m
      if not [32maccountLevelsAddr[0m:
          require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32m_amount[0m
          require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
          require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m <= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m
          [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m = [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m - ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) - [32m_amount[0m
          require [32m_amount[0m[1m >= [0m[32m_amount[0m
          require [32m_amount[0m[1m >= [0m0
          require [32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18[1m <= [0m[32m_amount[0m
          require [32m_amount[0m - ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m
          require [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m[1m >= [0m0
          [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m = [32m_amount[0m - ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m
          require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)[1m >= [0m[32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
          require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)[1m >= [0m[32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
          require 0[1m <= [0m([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)
          require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m
          require [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m[1m >= [0m0
          [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m = ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m
      else:
          require ext_code.size([32maccountLevelsAddr[0m)
          call [32maccountLevelsAddr[0m.accountLevel([38;5;8maddress[0m user) with:
               gas gas_remaining - 50 [38;5;8mwei[0m
              args [32m_user[0m
          require ext_call.success
          if ext_call.return_data[0] != 1:
              require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32m_amount[0m
              require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
              require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m <= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m
              [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m = [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m - ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) - [32m_amount[0m
              if ext_call.return_data[0] != 2:
                  require [32m_amount[0m[1m >= [0m[32m_amount[0m
                  require [32m_amount[0m[1m >= [0m0
                  require [32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18[1m <= [0m[32m_amount[0m
                  require [32m_amount[0m - ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m
                  require [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m[1m >= [0m0
                  [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m = [32m_amount[0m - ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)[1m >= [0m[32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)[1m >= [0m[32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  require 0[1m <= [0m([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m
                  require [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m[1m >= [0m0
                  [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m = ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m
              else:
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32m_amount[0m
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  require [32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18[1m <= [0m([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m - ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m
                  require [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m[1m >= [0m0
                  [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m = ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m - ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)[1m >= [0m[32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)[1m >= [0m[32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  require [32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18[1m <= [0m([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)
                  require ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m
                  require ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m[1m >= [0m[32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m += [32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
          else:
              if [32m_amount[0m:
                  require [32m_amount[0m
                  require [32mfeeRebate[0m[1m * [0m[32m_amount[0m[1m / [0m[32m_amount[0m[1m == [0m[32mfeeRebate[0m
              require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32m_amount[0m
              require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
              require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m <= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m
              [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m = [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m - ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) - [32m_amount[0m
              if ext_call.return_data[0] != 2:
                  require ([32mfeeRebate[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32m_amount[0m
                  require ([32mfeeRebate[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32mfeeRebate[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  require [32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18[1m <= [0m([32mfeeRebate[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m
                  require ([32mfeeRebate[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m - ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m
                  require [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m[1m >= [0m0
                  [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m = ([32mfeeRebate[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m - ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)[1m >= [0m[32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)[1m >= [0m[32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  require [32mfeeRebate[0m[1m * [0m[32m_amount[0m[1m / [0m10^18[1m <= [0m([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) - ([32mfeeRebate[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m
                  require [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m[1m >= [0m0
                  [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m = ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) - ([32mfeeRebate[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m
              else:
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32m_amount[0m
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  require [32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18[1m <= [0m([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m - ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m
                  require [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m[1m >= [0m0
                  [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m = ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m - ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)[1m >= [0m[32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)[1m >= [0m[32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  require [32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18[1m <= [0m([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)
                  require ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m
                  require ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m[1m >= [0m[32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m += [32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
      if [32m_amountGive[0m:
          require [32m_amountGive[0m
          require [32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGive[0m[1m == [0m[32m_amount[0m
      require [32m_amountGet[0m
      require [32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGet[0m[1m <= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m
      [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m -= [32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGet[0m
      if [32m_amountGive[0m:
          require [32m_amountGive[0m
          require [32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGive[0m[1m == [0m[32m_amount[0m
      require [32m_amountGet[0m
      require ([32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGet[0m) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m
      require ([32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGet[0m) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m[1m >= [0m[32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGet[0m
      [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m = ([32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGet[0m) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m
      require [32m_amount[0m + [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m[1m >= [0m[32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m
      require [32m_amount[0m + [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m[1m >= [0m[32m_amount[0m
      [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m += [32m_amount[0m
      require [32m_amountGet[0m
      [38;5;8mlog Trade([0m
      [38;5;8m      address tokenGet=_tokenGet,[0m
      [38;5;8m      uint256 amountGet=0,[0m
      [38;5;8m      address tokenGive=addr(_tokenGive),[0m
      [38;5;8m      uint256 amountGive=_amount * _amountGive / _amountGet,[0m
      [38;5;8m      address get=addr(_user),[0m
      [38;5;8m      address give=caller)[0m
  else:
      [94msigner[0m = erecover(sha3(Mask(224, 32, '\x19Ethereum Signed Message:\n32')[1m >> [0m32, [94mhash[0m), [32m_v[0m[1m << [0m248, [32m_r[0m, [32m_s[0m) [38;5;8m# precompiled[0m
      require erecover.result
      require [38;5;8maddr([0m[94msigner[0m[38;5;8m)[0m[1m == [0m[32m_user[0m
      require block.number[1m <= [0m[32m_expires[0m
      require [32m_amount[0m + [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m[1m >= [0m[32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m
      require [32m_amount[0m + [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m[1m >= [0m[32m_amount[0m
      require [32m_amount[0m + [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m[1m <= [0m[32m_amountGet[0m
      if [32m_amount[0m:
          require [32m_amount[0m
          require [32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m[32m_amount[0m[1m == [0m[32mfeeMake[0m
      if [32m_amount[0m:
          require [32m_amount[0m
          require [32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m[32m_amount[0m[1m == [0m[32mfeeTake[0m
      if not [32maccountLevelsAddr[0m:
          require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32m_amount[0m
          require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
          require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m <= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m
          [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m = [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m - ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) - [32m_amount[0m
          require [32m_amount[0m[1m >= [0m[32m_amount[0m
          require [32m_amount[0m[1m >= [0m0
          require [32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18[1m <= [0m[32m_amount[0m
          require [32m_amount[0m - ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m
          require [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m[1m >= [0m0
          [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m = [32m_amount[0m - ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m
          require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)[1m >= [0m[32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
          require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)[1m >= [0m[32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
          require 0[1m <= [0m([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)
          require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m
          require [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m[1m >= [0m0
          [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m = ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m
          if [32m_amountGive[0m:
              require [32m_amountGive[0m
              require [32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGive[0m[1m == [0m[32m_amount[0m
          require [32m_amountGet[0m
          require [32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGet[0m[1m <= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m
          [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m -= [32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGet[0m
          if [32m_amountGive[0m:
              require [32m_amountGive[0m
              require [32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGive[0m[1m == [0m[32m_amount[0m
          require [32m_amountGet[0m
          require ([32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGet[0m) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m
          require ([32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGet[0m) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m[1m >= [0m[32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGet[0m
          [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m = ([32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGet[0m) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m
          require [32m_amount[0m + [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m[1m >= [0m[32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m
          require [32m_amount[0m + [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m[1m >= [0m[32m_amount[0m
          [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m += [32m_amount[0m
          require [32m_amountGet[0m
          [38;5;8mlog Trade([0m
          [38;5;8m      address tokenGet=addr(_tokenGet),[0m
          [38;5;8m      uint256 amountGet=_amount,[0m
          [38;5;8m      address tokenGive=addr(_tokenGive),[0m
          [38;5;8m      uint256 amountGive=_amount * _amountGive / _amountGet,[0m
          [38;5;8m      address get=addr(_user),[0m
          [38;5;8m      address give=caller)[0m
      else:
          require ext_code.size([32maccountLevelsAddr[0m)
          call [32maccountLevelsAddr[0m.accountLevel([38;5;8maddress[0m user) with:
               gas gas_remaining - 50 [38;5;8mwei[0m
              args [32m_user[0m
          require ext_call.success
          if ext_call.return_data[0] != 1:
              require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32m_amount[0m
              require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
              require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m <= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m
              [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m = [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m - ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) - [32m_amount[0m
              if ext_call.return_data[0] != 2:
                  require [32m_amount[0m[1m >= [0m[32m_amount[0m
                  require [32m_amount[0m[1m >= [0m0
                  require [32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18[1m <= [0m[32m_amount[0m
                  require [32m_amount[0m - ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m
                  require [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m[1m >= [0m0
                  [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m = [32m_amount[0m - ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)[1m >= [0m[32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)[1m >= [0m[32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  require 0[1m <= [0m([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m
                  require [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m[1m >= [0m0
                  [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m = ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m
              else:
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32m_amount[0m
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  require [32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18[1m <= [0m([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m - ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m
                  require [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m[1m >= [0m0
                  [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m = ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m - ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)[1m >= [0m[32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)[1m >= [0m[32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  require [32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18[1m <= [0m([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)
                  require ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m
                  require ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m[1m >= [0m[32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m += [32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
          else:
              if [32m_amount[0m:
                  require [32m_amount[0m
                  require [32mfeeRebate[0m[1m * [0m[32m_amount[0m[1m / [0m[32m_amount[0m[1m == [0m[32mfeeRebate[0m
              require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32m_amount[0m
              require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
              require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m <= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m
              [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m = [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m - ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) - [32m_amount[0m
              if ext_call.return_data[0] != 2:
                  require ([32mfeeRebate[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32m_amount[0m
                  require ([32mfeeRebate[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32mfeeRebate[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  require [32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18[1m <= [0m([32mfeeRebate[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m
                  require ([32mfeeRebate[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m - ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m
                  require [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m[1m >= [0m0
                  [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m = ([32mfeeRebate[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m - ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)[1m >= [0m[32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)[1m >= [0m[32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  require [32mfeeRebate[0m[1m * [0m[32m_amount[0m[1m / [0m10^18[1m <= [0m([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) - ([32mfeeRebate[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m
                  require [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m[1m >= [0m0
                  [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m = ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) - ([32mfeeRebate[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m
              else:
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32m_amount[0m
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m[1m >= [0m[32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  require [32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18[1m <= [0m([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m - ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m
                  require [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m[1m >= [0m0
                  [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m = ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32m_amount[0m - ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_user[0m[32m][0m
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)[1m >= [0m[32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  require ([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)[1m >= [0m[32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  require [32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18[1m <= [0m([32mfeeTake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18)
                  require ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m
                  require ([32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m[1m >= [0m[32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
                  [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGet[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor1[0m[32m][0m += [32mfeeMake[0m[1m * [0m[32m_amount[0m[1m / [0m10^18
          if [32m_amountGive[0m:
              require [32m_amountGive[0m
              require [32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGive[0m[1m == [0m[32m_amount[0m
          require [32m_amountGet[0m
          require [32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGet[0m[1m <= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m
          [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m -= [32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGet[0m
          if [32m_amountGive[0m:
              require [32m_amountGive[0m
              require [32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGive[0m[1m == [0m[32m_amount[0m
          require [32m_amountGet[0m
          require ([32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGet[0m) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m[1m >= [0m[32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m
          require ([32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGet[0m) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m[1m >= [0m[32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGet[0m
          [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m = ([32m_amount[0m[1m * [0m[32m_amountGive[0m[1m / [0m[32m_amountGet[0m) + [32mtokens[0m[32m[[0m[38;5;8maddr([0m[32m_tokenGive[0m[38;5;8m)[0m[32m][0m[32m[[0mcaller[32m][0m
          require [32m_amount[0m + [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m[1m >= [0m[32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m
          require [32m_amount[0m + [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m[1m >= [0m[32m_amount[0m
          [32morderFills[0m[32m[[0m[38;5;8maddr([0m[32m_user[0m[38;5;8m)[0m[32m][0m[32m[[0m[94mhash[0m[32m][0m += [32m_amount[0m
          require [32m_amountGet[0m
          [38;5;8mlog Trade([0m
          [38;5;8m      address tokenGet=_tokenGet,[0m
          [38;5;8m      uint256 amountGet=0,[0m
          [38;5;8m      address tokenGive=addr(_tokenGive),[0m
          [38;5;8m      uint256 amountGive=_amount * _amountGive / _amountGet,[0m
          [38;5;8m      address get=addr(_user),[0m
          [38;5;8m      address give=caller)[0m

