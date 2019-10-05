[38;5;8m#
#  Panoramix 4 Oct 2019 
#  Decompiled source of [0m0xF835A0247b0063C04EF22006eBe57c5F11977Cc4[38;5;8m
# 
#  Let's make the world open source 
# [0m

[32mdef [0mstorage:
  [32mstor0[0m is uint256 [38;5;8mat storage 0[0m[38;5;8m[0m
  [32mowner[0m is addr [38;5;8mat storage 0[0m[38;5;8m[0m
  [32mstor1[0m is uint256 [38;5;8mat storage 1[0m[38;5;8m[0m
  [32mcuratorAddress[0m is addr [38;5;8mat storage 1[0m[38;5;8m[0m
  [32mdaoAddress[0m is addr [38;5;8mat storage 2[0m[38;5;8m[0m
  [32mstor2[0m is uint256 [38;5;8mat storage 2[0m[38;5;8m[0m
  [32mcounter[0m is uint256 [38;5;8mat storage 3[0m[38;5;8m[0m
  [32munknown371fa854[0m is uint256 [38;5;8mat storage 4[0m[38;5;8m[0m
  [32munknown26f5a8c9[0m is uint256 [38;5;8mat storage 5[0m[38;5;8m[0m
  [32mstor6[0m is uint256 [38;5;8mat storage 6[0m[38;5;8m[0m
  [32mnextAddress[0m is addr [38;5;8mat storage 6[0m[38;5;8m[0m
  [32munknown5970c915Address[0m is addr [38;5;8mat storage 7[0m[38;5;8m[0m
  [32mstor7[0m is uint256 [38;5;8mat storage 7[0m[38;5;8m[0m

[95mdef [0munknown26f5a8c9()[95m payable[0m: 
  return [32munknown26f5a8c9[0m

[95mdef [0munknown371fa854()[95m payable[0m: 
  return [32munknown371fa854[0m

[95mdef [0mdao()[95m payable[0m: 
  return [38;5;8maddr([0m[32mdaoAddress[0m[38;5;8m)[0m

[95mdef [0mnext()[95m payable[0m: 
  return [38;5;8maddr([0m[32mnextAddress[0m[38;5;8m)[0m

[95mdef [0munknown5970c915()[95m payable[0m: 
  return [38;5;8maddr([0m[32munknown5970c915Address[0m[38;5;8m)[0m

[95mdef [0mcounter()[95m payable[0m: 
  return [32mcounter[0m

[95mdef [0mowner()[95m payable[0m: 
  return [38;5;8maddr([0m[32mowner[0m[38;5;8m)[0m

[95mdef [0mcurator()[95m payable[0m: 
  return [38;5;8maddr([0m[32mcuratorAddress[0m[38;5;8m)[0m

[38;5;8m#
#  Regular functions
#[0m

[95mdef [0munknown7f9f519f(uint256 [32m_param1[0m)[95m payable[0m: 
  require caller[1m == [0m[38;5;8maddr([0m[32mowner[0m[38;5;8m)[0m
  [32munknown26f5a8c9[0m = [32m_param1[0m
  [38;5;8mlog 0xbab6859b: _param1[0m
  return 1

[95mdef [0msetOwner(address [32m_owner[0m)[95m payable[0m: 
  require caller[1m == [0m[38;5;8maddr([0m[32mowner[0m[38;5;8m)[0m
  [38;5;8mlog NewOwner(address owner=_owner_)[0m
  [38;5;8muint256([0m[32mstor0[0m[38;5;8m)[0m = [32m_owner_[0m[1m or [0mMask(96, 160, [38;5;8muint256([0m[32mstor0[0m[38;5;8m)[0m)
  return 1

[95mdef [0msetDao(address [32m_newDaoAddress[0m)[95m payable[0m: 
  require caller[1m == [0m[38;5;8maddr([0m[32mowner[0m[38;5;8m)[0m
  [38;5;8muint256([0m[32mstor2[0m[38;5;8m)[0m = [32m_newDaoAddress[0m[1m or [0mMask(96, 160, [38;5;8muint256([0m[32mstor2[0m[38;5;8m)[0m)
  [38;5;8mlog 0xce6a5015: _newDaoAddress[0m
  return 1

[95mdef [0mvote(uint256 [32m_proposalNumber[0m, bool [32m_supportsProposal[0m)[95m payable[0m: 
  require caller[1m == [0m[38;5;8maddr([0m[32mowner[0m[38;5;8m)[0m
  call [38;5;8maddr([0m[32mdaoAddress[0m[38;5;8m)[0m.vote([38;5;8muint256[0m proposalNumber, [38;5;8mbool[0m supportsProposal) with:
       gas gas_remaining - 25050 [38;5;8mwei[0m
      args [32m_proposalNumber[0m, [32m_supportsProposal[0m
  require ext_call.success
  [38;5;8mlog 0x8bfa1f40: _proposalNumber, _supportsProposal[0m
  return 1

[95mdef [0mtransfer(address [32m_to[0m, uint256 [32m_value[0m)[95m payable[0m: 
  require caller[1m == [0m[38;5;8maddr([0m[32mowner[0m[38;5;8m)[0m
  call [38;5;8maddr([0m[32mdaoAddress[0m[38;5;8m)[0m.transfer([38;5;8maddress[0m to, [38;5;8muint256[0m value) with:
       gas gas_remaining - 25050 [38;5;8mwei[0m
      args [38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m, [32m_value[0m
  require ext_call.success
  [38;5;8mlog Transfer([0m
  [38;5;8m      address to=addr(_to),[0m
  [38;5;8m      uint256 value=_value)[0m
  return 1

[95mdef [0munknown625e847d()[95m payable[0m: 
  require caller[1m == [0m[38;5;8maddr([0m[32mowner[0m[38;5;8m)[0m
  [32mcounter[0m = 1
  call [38;5;8maddr([0m[32munknown5970c915Address[0m[38;5;8m)[0m with:
     value eth.balance(this.address) [38;5;8mwei[0m
       gas 0 [38;5;8mwei[0m
  call [38;5;8maddr([0m[32mdaoAddress[0m[38;5;8m)[0m.splitDAO([38;5;8muint256[0m proposalID, [38;5;8maddress[0m newCurator) with:
       gas gas_remaining - 25050 [38;5;8mwei[0m
      args [32munknown371fa854[0m, [38;5;8maddr([0m[32mcuratorAddress[0m[38;5;8m)[0m
  require ext_call.success
  return 1

[95mdef [0munknownc4463c80(uint256 [32m_param1[0m, uint256 [32m_param2[0m, uint256 [32m_param3[0m, uint256 [32m_param4[0m, uint256 [32m_param5[0m)[95m payable[0m: 
  require caller[1m == [0m[38;5;8maddr([0m[32mowner[0m[38;5;8m)[0m
  [38;5;8muint256([0m[32mstor6[0m[38;5;8m)[0m = [32m_param3[0m[1m or [0mMask(96, 160, [38;5;8muint256([0m[32mstor6[0m[38;5;8m)[0m)
  [32mcounter[0m = 1
  [38;5;8muint256([0m[32mstor1[0m[38;5;8m)[0m = [32m_param2[0m[1m or [0mMask(96, 160, [38;5;8muint256([0m[32mstor1[0m[38;5;8m)[0m)
  [32munknown371fa854[0m = [32m_param1[0m
  [32munknown26f5a8c9[0m = [32m_param4[0m
  [38;5;8muint256([0m[32mstor7[0m[38;5;8m)[0m = [32m_param5[0m[1m or [0mMask(96, 160, [38;5;8muint256([0m[32mstor7[0m[38;5;8m)[0m)
  call [38;5;8maddr([0m[32m_param5[0m[38;5;8m)[0m with:
     value eth.balance(this.address) [38;5;8mwei[0m
       gas 0 [38;5;8mwei[0m
  call [38;5;8maddr([0m[32mdaoAddress[0m[38;5;8m)[0m.splitDAO([38;5;8muint256[0m proposalID, [38;5;8maddress[0m newCurator) with:
       gas gas_remaining - 25050 [38;5;8mwei[0m
      args [32munknown371fa854[0m, [38;5;8maddr([0m[32mcuratorAddress[0m[38;5;8m)[0m
  require ext_call.success
  [38;5;8mlog 0xa1ab7317: unknown371fa854, addr(nextAddress)[0m
  return 1

[95mdef [0m_fallback()[95m payable[0m: [38;5;8m# default function[0m
  call [38;5;8maddr([0m[32mdaoAddress[0m[38;5;8m)[0m.rewardAccount() with:
       gas gas_remaining - 25050 [38;5;8mwei[0m
  require ext_call.success
  if ext_call.return_data[12 len 20] != caller:
      [38;5;8mlog 0xa6af7265: ext_call.return_data[0], caller, 15, 'constuctor fail'[0m
  else:
      if [32mcounter[0m[1m <= [0m[32munknown26f5a8c9[0m - 1:
          [32mcounter[0m++
          call [38;5;8maddr([0m[32mdaoAddress[0m[38;5;8m)[0m.splitDAO([38;5;8muint256[0m proposalID, [38;5;8maddress[0m newCurator) with:
               gas gas_remaining - 25050 [38;5;8mwei[0m
              args [32munknown371fa854[0m, [38;5;8maddr([0m[32mcuratorAddress[0m[38;5;8m)[0m
          require ext_call.success
      else:
          call [38;5;8maddr([0m[32mdaoAddress[0m[38;5;8m)[0m.balanceOf([38;5;8maddress[0m owner) with:
               gas gas_remaining - 25050 [38;5;8mwei[0m
              args this.address
          require ext_call.success
          call [38;5;8maddr([0m[32mdaoAddress[0m[38;5;8m)[0m.transfer([38;5;8maddress[0m to, [38;5;8muint256[0m value) with:
               gas gas_remaining - 25050 [38;5;8mwei[0m
              args [38;5;8maddr([0m[32mnextAddress[0m[38;5;8m)[0m, ext_call.return_data[0]
          [32mcounter[0m = 1
  return 1

