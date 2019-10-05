[38;5;8m#
#  Panoramix 4 Oct 2019 
#  Decompiled source of [0m0x7b220AC85B7ae8Af1CECCC44e183A862dA2eD517[38;5;8m
# 
#  Let's make the world open source 
# [0m

[32mdef [0mstorage:
  [32maddressToAbility[0m is mapping of bool [38;5;8mat storage 0[0m
  [32mproxies[0m is array of addr [38;5;8mat storage 1[0m
  [32mstor2[0m is mapping of uint8 [38;5;8mat storage 2[0m
  [32mstor3[0m is mapping of uint8 [38;5;8mat storage 3[0m

[95mdef [0maddressToAbility(address [32m_param1[0m)[95m payable[0m: 
  require calldata.size - 4[1m >=′ [0m32
  return [38;5;8muint256([0m[32maddressToAbility[0m[32m[[0m[32m_param1[0m[32m][0m[38;5;8m)[0m

[95mdef [0morderCancelled(bytes32 [32m_param1[0m)[95m payable[0m: 
  require calldata.size - 4[1m >=′ [0m32
  return bool([32mstor2[0m[32m[[0m[32m_param1[0m[32m][0m)

[95mdef [0mproxies(uint256 [32m_param1[0m)[95m payable[0m: 
  require calldata.size - 4[1m >=′ [0m32
  require [32m_param1[0m[1m < [0m[32mproxies[0m[32m.length[0m
  return [32mproxies[0m[32m[[0m[32m_param1[0m[32m][0m

[95mdef [0morderPerformed(bytes32 [32m_param1[0m)[95m payable[0m: 
  require calldata.size - 4[1m >=′ [0m32
  return bool([32mstor3[0m[32m[[0m[32m_param1[0m[32m][0m)

[38;5;8m#
#  Regular functions
#[0m

[95mdef [0m_fallback()[95m payable[0m: [38;5;8m# default function[0m
  revert

[95mdef [0misAble(address [32m_target[0m, uint256 [32m_abilities[0m)[95m payable[0m: 
  require calldata.size - 4[1m >=′ [0m64
  if not [32m_abilities[0m:
      revert with 0, '', 0
  return ([32m_abilities[0m[1m == [0m[32m_abilities[0m[1m and [0m[38;5;8muint256([0m[32maddressToAbility[0m[32m[[0m[38;5;8maddr([0m[32m_target[0m[38;5;8m)[0m[32m][0m[38;5;8m)[0m)

[95mdef [0mremoveProxy(uint256 [32m_index[0m)[95m payable[0m: 
  require calldata.size - 4[1m >=′ [0m32
  if Mask(1, 1, [38;5;8muint256([0m[32maddressToAbility[0m[32m[[0mcaller[32m][0m[38;5;8m)[0m) != 2:
      revert with 0, '', 0
  require [32m_index[0m[1m < [0m[32mproxies[0m[32m.length[0m
  [32mproxies[0m[32m[[0m[32m_index[0m[32m][0m = 0
  [38;5;8mlog ProxyChange([0m
  [38;5;8m      uint256 index=0,[0m
  [38;5;8m      address proxy=_index)[0m

[95mdef [0maddProxy(address [32m_proxy[0m)[95m payable[0m: 
  require calldata.size - 4[1m >=′ [0m32
  if Mask(1, 1, [38;5;8muint256([0m[32maddressToAbility[0m[32m[[0mcaller[32m][0m[38;5;8m)[0m) != 2:
      revert with 0, '', 0
  [32mproxies[0m[32m.length[0m++
  [32mproxies[0m[32m[[0m[32mproxies[0m[32m.length[0m[32m][0m = [32m_proxy[0m
  [38;5;8mlog ProxyChange([0m
  [38;5;8m      uint256 index=_proxy,[0m
  [38;5;8m      address proxy=proxies.length)[0m

[95mdef [0mgrantAbilities(address [32m_target[0m, uint256 [32m_abilities[0m)[95m payable[0m: 
  require calldata.size - 4[1m >=′ [0m64
  if [38;5;8mbool([0m[32maddressToAbility[0m[32m[[0mcaller[32m][0m[38;5;8m)[0m != 1:
      revert with 0, '', 0
  [38;5;8muint256([0m[32maddressToAbility[0m[32m[[0m[38;5;8maddr([0m[32m_target[0m[38;5;8m)[0m[32m][0m[38;5;8m)[0m = [32m_abilities[0m[1m or [0m[38;5;8muint256([0m[32maddressToAbility[0m[32m[[0m[38;5;8maddr([0m[32m_target[0m[38;5;8m)[0m[32m][0m[38;5;8m)[0m
  [38;5;8mlog GrantAbilities([0m
  [38;5;8m      address target=_target,[0m
  [38;5;8m      uint256 abilities=_abilities)[0m

[95mdef [0mrevokeAbilities(address [32m_target[0m, uint256 [32m_abilities[0m, bool [32m_allowSuperRevoke[0m)[95m payable[0m: 
  require calldata.size - 4[1m >=′ [0m96
  if [38;5;8mbool([0m[32maddressToAbility[0m[32m[[0mcaller[32m][0m[38;5;8m)[0m != 1:
      revert with 0, '', 0
  if not [32m_allowSuperRevoke[0m:
      if [32m_target[0m[1m == [0mcaller:
          if [38;5;8mbool([0m[32m_abilities[0m[38;5;8m)[0m:
              revert with 0, '', 0
  [38;5;8muint256([0m[32maddressToAbility[0m[32m[[0m[38;5;8maddr([0m[32m_target[0m[38;5;8m)[0m[32m][0m[38;5;8m)[0m = [1m![0m[32m_abilities[0m[1m and [0m[38;5;8muint256([0m[32maddressToAbility[0m[32m[[0m[38;5;8maddr([0m[32m_target[0m[38;5;8m)[0m[32m][0m[38;5;8m)[0m
  [38;5;8mlog RevokeAbilities([0m
  [38;5;8m      address target=_target,[0m
  [38;5;8m      uint256 abilities=_abilities)[0m

[95mdef [0misValidSignature(address [32m_signer[0m, bytes32 [32m_claim[0m, tuple [32m_signature[0m)[95m payable[0m: 
  require calldata.size - 4[1m >=′ [0m192
  require calldata.size - 68[1m >=′ [0m128
  require cd[164][1m < [0m3
  require cd[164][1m <= [0m2
  if cd[164]:
      require cd[164][1m <= [0m2
      if cd[164] != 1:
          require cd[164][1m <= [0m2
          if cd[164] != 2:
              revert with 0, '', 0
          else:
              [94msigner[0m = erecover([32m_claim[0m, cd[132][1m << [0m248, [32m_signature[0m, cd[100]) [38;5;8m# precompiled[0m
              if not erecover.result:
                  revert with ext_call.return_data[0 len return_data.size]
              else:
                  return ([32m_signer[0m[1m == [0m[38;5;8maddr([0m[94msigner[0m[38;5;8m)[0m)
      else:
          [94msigner[0m = erecover(sha3(0x19457468657265756d205369676e6564204d65737361, [32m_claim[0m), cd[132][1m << [0m248, [32m_signature[0m, cd[100]) [38;5;8m# precompiled[0m
          if not erecover.result:
              revert with ext_call.return_data[0 len return_data.size]
          else:
              return ([32m_signer[0m[1m == [0m[38;5;8maddr([0m[94msigner[0m[38;5;8m)[0m)
  else:
      [94msigner[0m = erecover(sha3(Mask(224, 32, '\x19Ethereum Signed Message:\n32')[1m >> [0m32, [32m_claim[0m), cd[132][1m << [0m248, [32m_signature[0m, cd[100]) [38;5;8m# precompiled[0m
      if not erecover.result:
          revert with ext_call.return_data[0 len return_data.size]
      else:
          return ([32m_signer[0m[1m == [0m[38;5;8maddr([0m[94msigner[0m[38;5;8m)[0m)

[95mdef [0mgetOrderDataClaim(tuple [32m_orderData[0m)[95m payable[0m: 
  require calldata.size - 4[1m >=′ [0m32
  require [32m_orderData[0m[1m <= [0m18446744073709551615
  require calldata.size + -[32m_orderData[0m - 4[1m >=′ [0m160
  [95mmem[[0m96[95m][0m = [38;5;8maddr([0m[32m_orderData.length[0m[38;5;8m)[0m
  [95mmem[[0m128[95m][0m = [38;5;8maddr([0mcd[([32m_orderData[0m + 36)][38;5;8m)[0m
  require cd[([32m_orderData[0m + 68)][1m <= [0m18446744073709551615
  require calldata.size[1m >′ [0m[32m_orderData[0m + cd[([32m_orderData[0m + 68)] + 35
  require cd[([32m_orderData[0m + cd[([32m_orderData[0m + 68)] + 4)][1m <= [0m18446744073709551615
  require (32[1m * [0mcd[([32m_orderData[0m + cd[([32m_orderData[0m + 68)] + 4)]) + 288[1m >= [0m256[1m and [0m(32[1m * [0mcd[([32m_orderData[0m + cd[([32m_orderData[0m + 68)] + 4)]) + 288[1m <= [0m18446744073709551615
  [95mmem[[0m64[95m][0m = (32[1m * [0mcd[([32m_orderData[0m + cd[([32m_orderData[0m + 68)] + 4)]) + 288
  [95mmem[[0m256[95m][0m = cd[([32m_orderData[0m + cd[([32m_orderData[0m + 68)] + 4)]
  require [32m_orderData[0m + cd[([32m_orderData[0m + 68)] + (192[1m * [0mcd[([32m_orderData[0m + cd[([32m_orderData[0m + 68)] + 4)]) + 36[1m <= [0mcalldata.size
  [94midx[0m = 0
  [94ms[0m = [32m_orderData[0m + cd[([32m_orderData[0m + 68)] + 36
  [94mt[0m = 288
  [32mwhile [0m[94midx[0m[1m < [0mcd[([32m_orderData[0m + cd[([32m_orderData[0m + 68)] + 4)][32m:[0m
      require calldata.size - [94ms[0m[1m >=′ [0m192
      [94m_44[0m = [95mmem[[0m64[95m][0m
      require [95mmem[[0m64[95m][0m + 192[1m >= [0m[95mmem[[0m64[95m][0m[1m and [0m[95mmem[[0m64[95m][0m + 192[1m <= [0m18446744073709551615
      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 192
      require cd[[94ms[0m][1m < [0m2
      [95mmem[[0m[94m_44[0m[95m][0m = cd[[94ms[0m]
      [95mmem[[0m[94m_44[0m + 32[95m][0m = [38;5;8muint32([0mcd[([94ms[0m + 32)][38;5;8m)[0m
      [95mmem[[0m[94m_44[0m + 64[95m][0m = [38;5;8maddr([0mcd[([94ms[0m + 64)][38;5;8m)[0m
      [95mmem[[0m[94m_44[0m + 96[95m][0m = cd[([94ms[0m + 96)]
      [95mmem[[0m[94m_44[0m + 128[95m][0m = [38;5;8maddr([0mcd[([94ms[0m + 128)][38;5;8m)[0m
      [95mmem[[0m[94m_44[0m + 160[95m][0m = cd[([94ms[0m + 160)]
      [95mmem[[0m[94mt[0m[95m][0m = [94m_44[0m
      [94midx[0m = [94midx[0m + 1
      [94ms[0m = [94ms[0m + 192
      [94mt[0m = [94mt[0m + 32
      [32mcontinue [0m
  [95mmem[[0m160[95m][0m = 256
  [95mmem[[0m192[95m][0m = cd[([32m_orderData[0m + 100)]
  [95mmem[[0m224[95m][0m = cd[([32m_orderData[0m + 132)]
  [94m_86[0m = [95mmem[[0m256[95m][0m
  [94midx[0m = 0
  [94ms[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m[94m_86[0m[32m:[0m
      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
      [94m_95[0m = [95mmem[[0m[95mmem[[0m[95mmem[[0m160[95m][0m + (32[1m * [0m[94midx[0m) + 32[95m][0m[95m][0m
      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
      [94m_99[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 32[95m][0m
      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
      [94m_103[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 64[95m][0m
      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
      [94m_107[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 96[95m][0m
      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
      [94m_111[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 128[95m][0m
      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
      [94m_115[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 160[95m][0m
      [94m_116[0m = [95mmem[[0m64[95m][0m
      [95mmem[[0m[95mmem[[0m64[95m][0m + 32[95m][0m = [94ms[0m
      require [94m_95[0m[1m < [0m2
      [95mmem[[0m[95mmem[[0m64[95m][0m + 64[95m][0m = [94m_95[0m[1m << [0m248
      [95mmem[[0m[95mmem[[0m64[95m][0m + 65[95m][0m = [94m_99[0m[1m << [0m224
      [95mmem[[0m[94m_116[0m + 69[95m][0m = [38;5;8maddr([0m[94m_103[0m[38;5;8m)[0m
      [95mmem[[0m[94m_116[0m + 89[95m][0m = [94m_107[0m
      [95mmem[[0m[94m_116[0m + 121[95m][0m = [38;5;8maddr([0m[94m_111[0m[38;5;8m)[0m
      [95mmem[[0m[94m_116[0m + 141[95m][0m = [94m_115[0m
      [94m_122[0m = [95mmem[[0m64[95m][0m
      [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = [94m_116[0m + -[95mmem[[0m64[95m][0m + 141
      [95mmem[[0m64[95m][0m = [94m_116[0m + 173
      [94m_86[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
      [94midx[0m = [94midx[0m + 1
      [94ms[0m = sha3([95mmem[[0m[94m_122[0m + 32[95m len [0m[95mmem[[0m[94m_122[0m[95m][0m[95m][0m)
      [32mcontinue [0m
  [94m_88[0m = [95mmem[[0m128[95m][0m
  [94m_89[0m = [95mmem[[0m192[95m][0m
  [94m_90[0m = [95mmem[[0m224[95m][0m
  [94m_91[0m = [95mmem[[0m64[95m][0m
  [95mmem[[0m[95mmem[[0m64[95m][0m + 32[95m][0m = [38;5;8maddr([0mthis.address[38;5;8m)[0m
  [95mmem[[0m[95mmem[[0m64[95m][0m + 52[95m][0m = [38;5;8maddr([0m[95mmem[[0m96[95m][0m[38;5;8m)[0m
  [95mmem[[0m[95mmem[[0m64[95m][0m + 72[95m][0m = [38;5;8maddr([0m[94m_88[0m[38;5;8m)[0m
  [95mmem[[0m[95mmem[[0m64[95m][0m + 92[95m][0m = _124[1m * [0m[94m_86[0m
  [95mmem[[0m[95mmem[[0m64[95m][0m + 124[95m][0m = [94m_89[0m
  [95mmem[[0m[95mmem[[0m64[95m][0m + 156[95m][0m = [94m_90[0m
  [94m_117[0m = [95mmem[[0m64[95m][0m
  [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 156
  [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 188
  [95mmem[[0m[94m_91[0m + 188[95m][0m = sha3([95mmem[[0m[94m_117[0m + 32[95m len [0m[95mmem[[0m[94m_117[0m[95m][0m[95m][0m)
  return memory
    from [94m_91[0m + 188
     [93mlen[0m 32

[95mdef [0mcancel(tuple [32m_data[0m)[95m payable[0m: 
  require calldata.size - 4[1m >=′ [0m32
  require [32m_data[0m[1m <= [0m18446744073709551615
  require calldata.size + -[32m_data[0m - 4[1m >=′ [0m160
  [95mmem[[0m96[95m][0m = [38;5;8maddr([0m[32m_data.length[0m[38;5;8m)[0m
  [95mmem[[0m128[95m][0m = [38;5;8maddr([0mcd[([32m_data[0m + 36)][38;5;8m)[0m
  require cd[([32m_data[0m + 68)][1m <= [0m18446744073709551615
  require calldata.size[1m >′ [0m[32m_data[0m + cd[([32m_data[0m + 68)] + 35
  require cd[([32m_data[0m + cd[([32m_data[0m + 68)] + 4)][1m <= [0m18446744073709551615
  require (32[1m * [0mcd[([32m_data[0m + cd[([32m_data[0m + 68)] + 4)]) + 288[1m >= [0m256[1m and [0m(32[1m * [0mcd[([32m_data[0m + cd[([32m_data[0m + 68)] + 4)]) + 288[1m <= [0m18446744073709551615
  [95mmem[[0m64[95m][0m = (32[1m * [0mcd[([32m_data[0m + cd[([32m_data[0m + 68)] + 4)]) + 288
  [95mmem[[0m256[95m][0m = cd[([32m_data[0m + cd[([32m_data[0m + 68)] + 4)]
  require [32m_data[0m + cd[([32m_data[0m + 68)] + (192[1m * [0mcd[([32m_data[0m + cd[([32m_data[0m + 68)] + 4)]) + 36[1m <= [0mcalldata.size
  [94midx[0m = 0
  [94ms[0m = [32m_data[0m + cd[([32m_data[0m + 68)] + 36
  [94mt[0m = 288
  [32mwhile [0m[94midx[0m[1m < [0mcd[([32m_data[0m + cd[([32m_data[0m + 68)] + 4)][32m:[0m
      require calldata.size - [94ms[0m[1m >=′ [0m192
      [94m_61[0m = [95mmem[[0m64[95m][0m
      require [95mmem[[0m64[95m][0m + 192[1m >= [0m[95mmem[[0m64[95m][0m[1m and [0m[95mmem[[0m64[95m][0m + 192[1m <= [0m18446744073709551615
      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 192
      require cd[[94ms[0m][1m < [0m2
      [95mmem[[0m[94m_61[0m[95m][0m = cd[[94ms[0m]
      [95mmem[[0m[94m_61[0m + 32[95m][0m = [38;5;8muint32([0mcd[([94ms[0m + 32)][38;5;8m)[0m
      [95mmem[[0m[94m_61[0m + 64[95m][0m = [38;5;8maddr([0mcd[([94ms[0m + 64)][38;5;8m)[0m
      [95mmem[[0m[94m_61[0m + 96[95m][0m = cd[([94ms[0m + 96)]
      [95mmem[[0m[94m_61[0m + 128[95m][0m = [38;5;8maddr([0mcd[([94ms[0m + 128)][38;5;8m)[0m
      [95mmem[[0m[94m_61[0m + 160[95m][0m = cd[([94ms[0m + 160)]
      [95mmem[[0m[94mt[0m[95m][0m = [94m_61[0m
      [94midx[0m = [94midx[0m + 1
      [94ms[0m = [94ms[0m + 192
      [94mt[0m = [94mt[0m + 32
      [32mcontinue [0m
  [95mmem[[0m160[95m][0m = 256
  [95mmem[[0m192[95m][0m = cd[([32m_data[0m + 100)]
  [95mmem[[0m224[95m][0m = cd[([32m_data[0m + 132)]
  [94m_62[0m = [95mmem[[0m96[95m][0m
  [94m_63[0m = [95mmem[[0m64[95m][0m
  [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 64
  [95mmem[[0m[94m_63[0m[95m][0m = 6
  [95mmem[[0m[94m_63[0m + 32[95m][0m = 0x3031353030390000000000000000000000000000000000000000000000000000
  if [38;5;8maddr([0m[94m_62[0m[38;5;8m)[0m != caller:
      revert with 0, '', 0
  [94m_120[0m = [95mmem[[0m256[95m][0m
  [94midx[0m = 0
  [94ms[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m[94m_120[0m[32m:[0m
      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
      [94m_130[0m = [95mmem[[0m[95mmem[[0m[95mmem[[0m160[95m][0m + (32[1m * [0m[94midx[0m) + 32[95m][0m[95m][0m
      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
      [94m_134[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 32[95m][0m
      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
      [94m_138[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 64[95m][0m
      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
      [94m_142[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 96[95m][0m
      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
      [94m_146[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 128[95m][0m
      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
      [94m_150[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 160[95m][0m
      [94m_151[0m = [95mmem[[0m64[95m][0m
      [95mmem[[0m[95mmem[[0m64[95m][0m + 32[95m][0m = [94ms[0m
      require [94m_130[0m[1m < [0m2
      [95mmem[[0m[95mmem[[0m64[95m][0m + 64[95m][0m = [94m_130[0m[1m << [0m248
      [95mmem[[0m[95mmem[[0m64[95m][0m + 65[95m][0m = [94m_134[0m[1m << [0m224
      [95mmem[[0m[94m_151[0m + 69[95m][0m = [38;5;8maddr([0m[94m_138[0m[38;5;8m)[0m
      [95mmem[[0m[94m_151[0m + 89[95m][0m = [94m_142[0m
      [95mmem[[0m[94m_151[0m + 121[95m][0m = [38;5;8maddr([0m[94m_146[0m[38;5;8m)[0m
      [95mmem[[0m[94m_151[0m + 141[95m][0m = [94m_150[0m
      [94m_167[0m = [95mmem[[0m64[95m][0m
      [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = [94m_151[0m + -[95mmem[[0m64[95m][0m + 141
      [95mmem[[0m64[95m][0m = [94m_151[0m + 173
      [94m_120[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
      [94midx[0m = [94midx[0m + 1
      [94ms[0m = sha3([95mmem[[0m[94m_167[0m + 32[95m len [0m[95mmem[[0m[94m_167[0m[95m][0m[95m][0m)
      [32mcontinue [0m
  [94m_122[0m = [95mmem[[0m128[95m][0m
  [94m_123[0m = [95mmem[[0m192[95m][0m
  [94m_124[0m = [95mmem[[0m224[95m][0m
  [94m_125[0m = [95mmem[[0m64[95m][0m
  [95mmem[[0m[95mmem[[0m64[95m][0m + 32[95m][0m = [38;5;8maddr([0mthis.address[38;5;8m)[0m
  [95mmem[[0m[95mmem[[0m64[95m][0m + 52[95m][0m = [38;5;8maddr([0m[95mmem[[0m96[95m][0m[38;5;8m)[0m
  [95mmem[[0m[95mmem[[0m64[95m][0m + 72[95m][0m = [38;5;8maddr([0m[94m_122[0m[38;5;8m)[0m
  [95mmem[[0m[95mmem[[0m64[95m][0m + 92[95m][0m = _169[1m * [0m[94m_120[0m
  [95mmem[[0m[95mmem[[0m64[95m][0m + 124[95m][0m = [94m_123[0m
  [95mmem[[0m[95mmem[[0m64[95m][0m + 156[95m][0m = [94m_124[0m
  [94m_154[0m = [95mmem[[0m64[95m][0m
  [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 156
  [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 188
  [94m_156[0m = sha3([95mmem[[0m[94m_154[0m + 32[95m len [0m[95mmem[[0m[94m_154[0m[95m][0m[95m][0m)
  [95mmem[[0m0[95m][0m = sha3([95mmem[[0m[94m_154[0m + 32[95m len [0m[95mmem[[0m[94m_154[0m[95m][0m[95m][0m)
  [95mmem[[0m[94m_125[0m + 188[95m][0m = 6
  [95mmem[[0m[94m_125[0m + 220[95m][0m = 0x3031353030380000000000000000000000000000000000000000000000000000
  if [32mstor3[0m[32m[[0m[95mmem[[0m0[95m][0m[32m][0m:
      revert with 0, '', 0
  [32mstor2[0m[32m[[0m[94m_156[0m[32m][0m = 1
  [95mmem[[0m[94m_125[0m + 252[95m][0m = [94m_156[0m
  [38;5;8mlog Cancel([0m
  [38;5;8m      address maker=_156,[0m
  [38;5;8m      address taker=mem[108 len 20],[0m
  [38;5;8m      bytes32 claim=mem[140 len 20])[0m

[95mdef [0mperform(tuple [32m_data[0m, tuple [32m_signature[0m)[95m payable[0m: 
  require calldata.size - 4[1m >=′ [0m160
  require [32m_data[0m[1m <= [0m18446744073709551615
  require calldata.size + -[32m_data[0m - 4[1m >=′ [0m160
  [95mmem[[0m96[95m][0m = [38;5;8maddr([0m[32m_data.length[0m[38;5;8m)[0m
  [95mmem[[0m128[95m][0m = [38;5;8maddr([0mcd[([32m_data[0m + 36)][38;5;8m)[0m
  require cd[([32m_data[0m + 68)][1m <= [0m18446744073709551615
  require calldata.size[1m >′ [0m[32m_data[0m + cd[([32m_data[0m + 68)] + 35
  require cd[([32m_data[0m + cd[([32m_data[0m + 68)] + 4)][1m <= [0m18446744073709551615
  require (32[1m * [0mcd[([32m_data[0m + cd[([32m_data[0m + 68)] + 4)]) + 288[1m >= [0m256[1m and [0m(32[1m * [0mcd[([32m_data[0m + cd[([32m_data[0m + 68)] + 4)]) + 288[1m <= [0m18446744073709551615
  [95mmem[[0m64[95m][0m = (32[1m * [0mcd[([32m_data[0m + cd[([32m_data[0m + 68)] + 4)]) + 288
  [95mmem[[0m256[95m][0m = cd[([32m_data[0m + cd[([32m_data[0m + 68)] + 4)]
  require [32m_data[0m + cd[([32m_data[0m + 68)] + (192[1m * [0mcd[([32m_data[0m + cd[([32m_data[0m + 68)] + 4)]) + 36[1m <= [0mcalldata.size
  [94midx[0m = 0
  [94ms[0m = [32m_data[0m + cd[([32m_data[0m + 68)] + 36
  [94mt[0m = 288
  [32mwhile [0m[94midx[0m[1m < [0mcd[([32m_data[0m + cd[([32m_data[0m + 68)] + 4)][32m:[0m
      require calldata.size - [94ms[0m[1m >=′ [0m192
      [94m_440[0m = [95mmem[[0m64[95m][0m
      require [95mmem[[0m64[95m][0m + 192[1m >= [0m[95mmem[[0m64[95m][0m[1m and [0m[95mmem[[0m64[95m][0m + 192[1m <= [0m18446744073709551615
      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 192
      require cd[[94ms[0m][1m < [0m2
      [95mmem[[0m[94m_440[0m[95m][0m = cd[[94ms[0m]
      [95mmem[[0m[94m_440[0m + 32[95m][0m = [38;5;8muint32([0mcd[([94ms[0m + 32)][38;5;8m)[0m
      [95mmem[[0m[94m_440[0m + 64[95m][0m = [38;5;8maddr([0mcd[([94ms[0m + 64)][38;5;8m)[0m
      [95mmem[[0m[94m_440[0m + 96[95m][0m = cd[([94ms[0m + 96)]
      [95mmem[[0m[94m_440[0m + 128[95m][0m = [38;5;8maddr([0mcd[([94ms[0m + 128)][38;5;8m)[0m
      [95mmem[[0m[94m_440[0m + 160[95m][0m = cd[([94ms[0m + 160)]
      [95mmem[[0m[94mt[0m[95m][0m = [94m_440[0m
      [94midx[0m = [94midx[0m + 1
      [94ms[0m = [94ms[0m + 192
      [94mt[0m = [94mt[0m + 32
      [32mcontinue [0m
  [95mmem[[0m160[95m][0m = 256
  [95mmem[[0m192[95m][0m = cd[([32m_data[0m + 100)]
  [95mmem[[0m224[95m][0m = cd[([32m_data[0m + 132)]
  require calldata.size - 36[1m >=′ [0m128
  [94m_441[0m = [95mmem[[0m64[95m][0m
  require [95mmem[[0m64[95m][0m + 128[1m >= [0m[95mmem[[0m64[95m][0m[1m and [0m[95mmem[[0m64[95m][0m + 128[1m <= [0m18446744073709551615
  [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 128
  [95mmem[[0m[94m_441[0m[95m][0m = [32m_signature[0m
  [95mmem[[0m[94m_441[0m + 32[95m][0m = cd[68]
  [95mmem[[0m[94m_441[0m + 64[95m][0m = [38;5;8muint8([0mcd[100][38;5;8m)[0m
  require cd[132][1m < [0m3
  [95mmem[[0m[94m_441[0m + 96[95m][0m = cd[132]
  [94m_442[0m = [95mmem[[0m128[95m][0m
  [94m_443[0m = [95mmem[[0m64[95m][0m
  [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 64
  [95mmem[[0m[94m_443[0m[95m][0m = 6
  [95mmem[[0m[94m_443[0m + 32[95m][0m = 0x3031353030330000000000000000000000000000000000000000000000000000
  if [38;5;8maddr([0m[94m_442[0m[38;5;8m)[0m != caller:
      revert with 0, '', 0
  else:
      [94m_445[0m = [95mmem[[0m64[95m][0m
      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 64
      [95mmem[[0m[94m_445[0m[95m][0m = 6
      [95mmem[[0m[94m_445[0m + 32[95m][0m = 0x3031353030350000000000000000000000000000000000000000000000000000
      if block.timestamp[1m > [0mcd[([32m_data[0m + 132)]:
          revert with 0, '', 0
      else:
          [94m_942[0m = [95mmem[[0m256[95m][0m
          [94midx[0m = 0
          [94ms[0m = 0
          [32mwhile [0m[94midx[0m[1m < [0m[94m_942[0m[32m:[0m
              require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
              [94m_953[0m = [95mmem[[0m[95mmem[[0m[95mmem[[0m160[95m][0m + (32[1m * [0m[94midx[0m) + 32[95m][0m[95m][0m
              require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
              [94m_957[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 32[95m][0m
              require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
              [94m_961[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 64[95m][0m
              require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
              [94m_965[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 96[95m][0m
              require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
              [94m_969[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 128[95m][0m
              require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
              [94m_973[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 160[95m][0m
              [94m_974[0m = [95mmem[[0m64[95m][0m
              [95mmem[[0m[95mmem[[0m64[95m][0m + 32[95m][0m = [94ms[0m
              require [94m_953[0m[1m < [0m2
              [95mmem[[0m[95mmem[[0m64[95m][0m + 64[95m][0m = [94m_953[0m[1m << [0m248
              [95mmem[[0m[95mmem[[0m64[95m][0m + 65[95m][0m = [94m_957[0m[1m << [0m224
              [95mmem[[0m[94m_974[0m + 69[95m][0m = [38;5;8maddr([0m[94m_961[0m[38;5;8m)[0m
              [95mmem[[0m[94m_974[0m + 89[95m][0m = [94m_965[0m
              [95mmem[[0m[94m_974[0m + 121[95m][0m = [38;5;8maddr([0m[94m_969[0m[38;5;8m)[0m
              [95mmem[[0m[94m_974[0m + 141[95m][0m = [94m_973[0m
              [94m_996[0m = [95mmem[[0m64[95m][0m
              [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = [94m_974[0m + -[95mmem[[0m64[95m][0m + 141
              [95mmem[[0m64[95m][0m = [94m_974[0m + 173
              [94m_942[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
              [94midx[0m = [94midx[0m + 1
              [94ms[0m = sha3([95mmem[[0m[94m_996[0m + 32[95m len [0m[95mmem[[0m[94m_996[0m[95m][0m[95m][0m)
              [32mcontinue [0m
          [94m_944[0m = [95mmem[[0m128[95m][0m
          [94m_945[0m = [95mmem[[0m192[95m][0m
          [94m_946[0m = [95mmem[[0m224[95m][0m
          [94m_947[0m = [95mmem[[0m64[95m][0m
          [95mmem[[0m[95mmem[[0m64[95m][0m + 32[95m][0m = [38;5;8maddr([0mthis.address[38;5;8m)[0m
          [95mmem[[0m[95mmem[[0m64[95m][0m + 52[95m][0m = [38;5;8maddr([0m[95mmem[[0m96[95m][0m[38;5;8m)[0m
          [95mmem[[0m[95mmem[[0m64[95m][0m + 72[95m][0m = [38;5;8maddr([0m[94m_944[0m[38;5;8m)[0m
          [95mmem[[0m[95mmem[[0m64[95m][0m + 92[95m][0m = _998[1m * [0m[94m_942[0m
          [95mmem[[0m[95mmem[[0m64[95m][0m + 124[95m][0m = [94m_945[0m
          [95mmem[[0m[95mmem[[0m64[95m][0m + 156[95m][0m = [94m_946[0m
          [94m_979[0m = [95mmem[[0m64[95m][0m
          [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 156
          [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 188
          [94m_981[0m = sha3([95mmem[[0m[94m_979[0m + 32[95m len [0m[95mmem[[0m[94m_979[0m[95m][0m[95m][0m)
          require [95mmem[[0m[94m_441[0m + 96[95m][0m[1m <= [0m2
          if [95mmem[[0m[94m_441[0m + 96[95m][0m:
              require [95mmem[[0m[94m_441[0m + 96[95m][0m[1m <= [0m2
              if [95mmem[[0m[94m_441[0m + 96[95m][0m != 1:
                  require [95mmem[[0m[94m_441[0m + 96[95m][0m[1m <= [0m2
                  if [95mmem[[0m[94m_441[0m + 96[95m][0m != 2:
                      revert with 0, '', 0
                  else:
                      [94m_990[0m = [95mmem[[0m[94m_441[0m + 64[95m][0m
                      [94m_991[0m = [95mmem[[0m[94m_441[0m[95m][0m
                      [94m_992[0m = [95mmem[[0m[94m_441[0m + 32[95m][0m
                      [95mmem[[0m[94m_947[0m + 284[95m][0m = [95mmem[[0m[94m_441[0m[95m][0m
                      [95mmem[[0m[94m_947[0m + 316[95m][0m = [94m_992[0m
                      [94msigner[0m = erecover([94m_981[0m, [94m_990[0m[1m << [0m248, [94m_991[0m, [94m_992[0m) [38;5;8m# precompiled[0m
                      [95mmem[[0m[94m_947[0m + 188[95m][0m = [94msigner[0m
                      if not erecover.result:
                          revert with ext_call.return_data[0 len return_data.size]
                      else:
                          [95mmem[[0m[94m_947[0m + 220[95m][0m = 6
                          [95mmem[[0m[94m_947[0m + 252[95m][0m = 0x3031353030360000000000000000000000000000000000000000000000000000
                          if [95mmem[[0m108[95m len [0m20[95m][0m != [38;5;8maddr([0m[94msigner[0m[38;5;8m)[0m:
                              revert with 0, '', 0
                          else:
                              [95mmem[[0m[94m_947[0m + 284[95m][0m = 6
                              [95mmem[[0m[94m_947[0m + 316[95m][0m = 0x3031353030370000000000000000000000000000000000000000000000000000
                              if [32mstor2[0m[32m[[0m[94m_981[0m[32m][0m:
                                  revert with 0, '', 0
                              else:
                                  [95mmem[[0m64[95m][0m = [94m_947[0m + 412
                                  [95mmem[[0m[94m_947[0m + 348[95m][0m = 6
                                  [95mmem[[0m[94m_947[0m + 380[95m][0m = 0x3031353030380000000000000000000000000000000000000000000000000000
                                  if [32mstor3[0m[32m[[0m[94m_981[0m[32m][0m:
                                      revert with 0, '', 0
                                  else:
                                      [95mmem[[0m0[95m][0m = [94m_981[0m
                                      [95mmem[[0m32[95m][0m = 3
                                      [32mstor3[0m[32m[[0m[94m_981[0m[32m][0m = 1
                                      [94m_1433[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                      [94midx[0m = 0
                                      [32mwhile [0m[94midx[0m[1m < [0m[94m_1433[0m[32m:[0m
                                          require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                          [94m_1458[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 32[95m][0m
                                          require [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 60[95m len [0m4[95m][0m[1m < [0m[32mproxies[0m[32m.length[0m
                                          [95mmem[[0m0[95m][0m = 1
                                          [94m_1470[0m = [95mmem[[0m64[95m][0m
                                          [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 64
                                          [95mmem[[0m[94m_1470[0m[95m][0m = 6
                                          [95mmem[[0m[94m_1470[0m + 32[95m][0m = 0x3031353030320000000000000000000000000000000000000000000000000000
                                          if [32mproxies[0m[32m[[0m[38;5;8muint32([0m[94m_1458[0m[38;5;8m)[0m[32m][0m:
                                              require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                              require [95mmem[[0m[95mmem[[0m[95mmem[[0m160[95m][0m + (32[1m * [0m[94midx[0m) + 32[95m][0m[95m][0m[1m <= [0m1
                                              if [95mmem[[0m[95mmem[[0m[95mmem[[0m160[95m][0m + (32[1m * [0m[94midx[0m) + 32[95m][0m[95m][0m:
                                                  require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                  require [95mmem[[0m[95mmem[[0m[95mmem[[0m160[95m][0m + (32[1m * [0m[94midx[0m) + 32[95m][0m[95m][0m[1m <= [0m1
                                                  if [95mmem[[0m[95mmem[[0m[95mmem[[0m160[95m][0m + (32[1m * [0m[94midx[0m) + 32[95m][0m[95m][0m != 1:
                                                      [94m_1433[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                      [94midx[0m = [94midx[0m + 1
                                                      [32mcontinue [0m
                                                  else:
                                                      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                      [94m_1553[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 96[95m][0m
                                                      if [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 108[95m len [0m8[95m][0m[1m == [0m[95mmem[[0m108[95m len [0m20[95m][0m:
                                                          [94m_1561[0m = [95mmem[[0m64[95m][0m
                                                          [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 64
                                                          [95mmem[[0m[94m_1561[0m[95m][0m = 6
                                                          [95mmem[[0m[94m_1561[0m + 32[95m][0m = 0x3031353030340000000000000000000000000000000000000000000000000000
                                                          require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                          [94m_1580[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 32[95m][0m
                                                          require [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 60[95m len [0m4[95m][0m[1m < [0m[32mproxies[0m[32m.length[0m
                                                          [95mmem[[0m0[95m][0m = 1
                                                          require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                          [94m_1610[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 64[95m][0m
                                                          require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                          [94m_1631[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 128[95m][0m
                                                          require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                          [94m_1658[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 160[95m][0m
                                                          [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 0x239aee0600000000000000000000000000000000000000000000000000000000
                                                          [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = [38;5;8maddr([0m[94m_1610[0m[38;5;8m)[0m
                                                          [95mmem[[0m[95mmem[[0m64[95m][0m + 36[95m][0m = Mask(64, 96, [94m_1553[0m)[1m >> [0m96
                                                          [95mmem[[0m[95mmem[[0m64[95m][0m + 68[95m][0m = [38;5;8maddr([0m[94m_1631[0m[38;5;8m)[0m
                                                          [95mmem[[0m[95mmem[[0m64[95m][0m + 100[95m][0m = [94m_1658[0m
                                                          require ext_code.size([32mproxies[0m[32m[[0m[38;5;8muint32([0m[94m_1580[0m[38;5;8m)[0m[32m][0m)
                                                          call [32mproxies[0m[32m[[0m[38;5;8muint32([0m[94m_1580[0m[38;5;8m)[0m[32m][0m.0x239aee06 with:
                                                               gas gas_remaining [38;5;8mwei[0m
                                                              args [38;5;8maddr([0m[94m_1610[0m[38;5;8m)[0m, Mask(64, 96, [94m_1553[0m)[1m << [0m96, [38;5;8maddr([0m[94m_1631[0m[38;5;8m)[0m, [94m_1658[0m
                                                          if not ext_call.success:
                                                              revert with ext_call.return_data[0 len return_data.size]
                                                          else:
                                                              [94m_1433[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                              [94midx[0m = [94midx[0m + 1
                                                              [32mcontinue [0m
                                                      else:
                                                          [94m_1562[0m = [95mmem[[0m128[95m][0m
                                                          [94m_1569[0m = [95mmem[[0m64[95m][0m
                                                          [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 64
                                                          [95mmem[[0m[94m_1569[0m[95m][0m = 6
                                                          [95mmem[[0m[94m_1569[0m + 32[95m][0m = 0x3031353030340000000000000000000000000000000000000000000000000000
                                                          if Mask(64, 96, [94m_1553[0m)[1m >> [0m96[1m == [0m[38;5;8maddr([0m[94m_1562[0m[38;5;8m)[0m:
                                                              require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                              [94m_1598[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 32[95m][0m
                                                              require [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 60[95m len [0m4[95m][0m[1m < [0m[32mproxies[0m[32m.length[0m
                                                              [95mmem[[0m0[95m][0m = 1
                                                              require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                              [94m_1635[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 64[95m][0m
                                                              require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                              [94m_1661[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 128[95m][0m
                                                              require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                              [94m_1679[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 160[95m][0m
                                                              [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 0x239aee0600000000000000000000000000000000000000000000000000000000
                                                              [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = [38;5;8maddr([0m[94m_1635[0m[38;5;8m)[0m
                                                              [95mmem[[0m[95mmem[[0m64[95m][0m + 36[95m][0m = Mask(64, 96, [94m_1553[0m)[1m >> [0m96
                                                              [95mmem[[0m[95mmem[[0m64[95m][0m + 68[95m][0m = [38;5;8maddr([0m[94m_1661[0m[38;5;8m)[0m
                                                              [95mmem[[0m[95mmem[[0m64[95m][0m + 100[95m][0m = [94m_1679[0m
                                                              require ext_code.size([32mproxies[0m[32m[[0m[38;5;8muint32([0m[94m_1598[0m[38;5;8m)[0m[32m][0m)
                                                              call [32mproxies[0m[32m[[0m[38;5;8muint32([0m[94m_1598[0m[38;5;8m)[0m[32m][0m.0x239aee06 with:
                                                                   gas gas_remaining [38;5;8mwei[0m
                                                                  args [38;5;8maddr([0m[94m_1635[0m[38;5;8m)[0m, Mask(64, 96, [94m_1553[0m)[1m << [0m96, [38;5;8maddr([0m[94m_1661[0m[38;5;8m)[0m, [94m_1679[0m
                                                              if not ext_call.success:
                                                                  revert with ext_call.return_data[0 len return_data.size]
                                                              else:
                                                                  [94m_1433[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                                  [94midx[0m = [94midx[0m + 1
                                                                  [32mcontinue [0m
                                                          else:
                                                              [94m_1583[0m = [95mmem[[0m64[95m][0m
                                                              [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 0x8c379a000000000000000000000000000000000000000000000000000000000
                                                              [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 32
                                                              [95mmem[[0m[95mmem[[0m64[95m][0m + 36[95m][0m = 6
                                                              [94midx[0m = 0
                                                              [32mwhile [0m[94midx[0m[1m < [0m6[32m:[0m
                                                                  [95mmem[[0m[94midx[0m + [94m_1583[0m + 68[95m][0m = [95mmem[[0m[94midx[0m + [94m_1569[0m + 32[95m][0m
                                                                  [94m_1433[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                                  [94midx[0m = [94midx[0m + 32
                                                                  [32mcontinue [0m
                                                              [95mmem[[0m[94m_1583[0m + 74[95m][0m = 0
                                                              revert with memory
                                                                from [95mmem[[0m64[95m][0m
                                                                 [93mlen[0m [94m_1583[0m + -[95mmem[[0m64[95m][0m + 100
                                              else:
                                                  require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                  [94m_1520[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 64[95m][0m
                                                  [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = [95mmem[[0m108[95m len [0m20[95m][0m
                                                  [95mmem[[0m[95mmem[[0m64[95m][0m + 36[95m][0m = 32
                                                  require ext_code.size([38;5;8maddr([0m[94m_1520[0m[38;5;8m)[0m)
                                                  static call [38;5;8maddr([0m[94m_1520[0m[38;5;8m)[0m.isAble([38;5;8maddress[0m target, [38;5;8muint256[0m abilities) with:
                                                          gas gas_remaining [38;5;8mwei[0m
                                                         args [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m, 32
                                                  [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = ext_call.return_data[0]
                                                  if not ext_call.success:
                                                      revert with ext_call.return_data[0 len return_data.size]
                                                  else:
                                                      [94m_1699[0m = [95mmem[[0m64[95m][0m
                                                      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + ceil32(return_data.size)
                                                      require return_data.size[1m >=′ [0m32
                                                      [94m_1702[0m = [95mmem[[0m[94m_1699[0m[95m][0m
                                                      [94m_1711[0m = [95mmem[[0m64[95m][0m
                                                      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 64
                                                      [95mmem[[0m[94m_1711[0m[95m][0m = 6
                                                      [95mmem[[0m[94m_1711[0m + 32[95m][0m = 0x3031353031300000000000000000000000000000000000000000000000000000
                                                      if [94m_1702[0m:
                                                          require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                          [94m_1724[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 32[95m][0m
                                                          require [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 60[95m len [0m4[95m][0m[1m < [0m[32mproxies[0m[32m.length[0m
                                                          [95mmem[[0m0[95m][0m = 1
                                                          require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                          [94m_1739[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 64[95m][0m
                                                          require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                          [94m_1754[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 128[95m][0m
                                                          require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                          [94m_1766[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 160[95m][0m
                                                          require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                          [94m_1778[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 96[95m][0m
                                                          [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 0x46009b0e00000000000000000000000000000000000000000000000000000000
                                                          [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = [38;5;8maddr([0m[94m_1739[0m[38;5;8m)[0m
                                                          [95mmem[[0m[95mmem[[0m64[95m][0m + 36[95m][0m = [38;5;8maddr([0m[94m_1754[0m[38;5;8m)[0m
                                                          [95mmem[[0m[95mmem[[0m64[95m][0m + 68[95m][0m = [94m_1766[0m
                                                          [95mmem[[0m[95mmem[[0m64[95m][0m + 100[95m][0m = [94m_1778[0m
                                                          require ext_code.size([32mproxies[0m[32m[[0m[38;5;8muint32([0m[94m_1724[0m[38;5;8m)[0m[32m][0m)
                                                          call [32mproxies[0m[32m[[0m[38;5;8muint32([0m[94m_1724[0m[38;5;8m)[0m[32m][0m.0x46009b0e with:
                                                               gas gas_remaining [38;5;8mwei[0m
                                                              args [38;5;8maddr([0m[94m_1739[0m[38;5;8m)[0m, [38;5;8maddr([0m[94m_1754[0m[38;5;8m)[0m, [94m_1766[0m, [94m_1778[0m
                                                          if not ext_call.success:
                                                              revert with ext_call.return_data[0 len return_data.size]
                                                          else:
                                                              [94m_1433[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                              [94midx[0m = [94midx[0m + 1
                                                              [32mcontinue [0m
                                                      else:
                                                          [94m_1716[0m = [95mmem[[0m64[95m][0m
                                                          [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 0x8c379a000000000000000000000000000000000000000000000000000000000
                                                          [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 32
                                                          [95mmem[[0m[95mmem[[0m64[95m][0m + 36[95m][0m = 6
                                                          [94midx[0m = 0
                                                          [32mwhile [0m[94midx[0m[1m < [0m6[32m:[0m
                                                              [95mmem[[0m[94midx[0m + [94m_1716[0m + 68[95m][0m = [95mmem[[0m[94midx[0m + [94m_1711[0m + 32[95m][0m
                                                              [94m_1433[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                              [94midx[0m = [94midx[0m + 32
                                                              [32mcontinue [0m
                                                          [95mmem[[0m[94m_1716[0m + 74[95m][0m = 0
                                                          revert with memory
                                                            from [95mmem[[0m64[95m][0m
                                                             [93mlen[0m [94m_1716[0m + -[95mmem[[0m64[95m][0m + 100
                                          else:
                                              [94m_1477[0m = [95mmem[[0m64[95m][0m
                                              [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 0x8c379a000000000000000000000000000000000000000000000000000000000
                                              [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 32
                                              [95mmem[[0m[95mmem[[0m64[95m][0m + 36[95m][0m = 6
                                              [94midx[0m = 0
                                              [32mwhile [0m[94midx[0m[1m < [0m6[32m:[0m
                                                  [95mmem[[0m[94midx[0m + [94m_1477[0m + 68[95m][0m = [95mmem[[0m[94midx[0m + [94m_1470[0m + 32[95m][0m
                                                  [94m_1433[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                  [94midx[0m = [94midx[0m + 32
                                                  [32mcontinue [0m
                                              [95mmem[[0m[94m_1477[0m + 74[95m][0m = 0
                                              revert with memory
                                                from [95mmem[[0m64[95m][0m
                                                 [93mlen[0m [94m_1477[0m + -[95mmem[[0m64[95m][0m + 100
                                      [38;5;8mlog Perform([0m
                                      [38;5;8m      address maker=_981,[0m
                                      [38;5;8m      address taker=mem[108 len 20],[0m
                                      [38;5;8m      bytes32 claim=mem[140 len 20])[0m
                                      stop
              else:
                  [95mmem[[0m[94m_947[0m + 220[95m][0m = 0x19457468657265756d205369676e6564204d6573736167653a0a200000000000
                  [95mmem[[0m[94m_947[0m + 247[95m][0m = [94m_981[0m
                  [95mmem[[0m[94m_947[0m + 188[95m][0m = 59
                  [95mmem[[0m64[95m][0m = [94m_947[0m + 279
                  [94m_1011[0m = [95mmem[[0m[94m_441[0m + 64[95m][0m
                  [94m_1012[0m = [95mmem[[0m[94m_441[0m[95m][0m
                  [94m_1013[0m = [95mmem[[0m[94m_441[0m + 32[95m][0m
                  [95mmem[[0m[94m_947[0m + 375[95m][0m = [95mmem[[0m[94m_441[0m[95m][0m
                  [95mmem[[0m[94m_947[0m + 407[95m][0m = [94m_1013[0m
                  [94msigner[0m = erecover(sha3(0x19457468657265756d205369676e6564204d65737361, [94m_981[0m), [94m_1011[0m[1m << [0m248, [94m_1012[0m, [94m_1013[0m) [38;5;8m# precompiled[0m
                  [95mmem[[0m[94m_947[0m + 279[95m][0m = [94msigner[0m
                  if not erecover.result:
                      revert with ext_call.return_data[0 len return_data.size]
                  else:
                      [95mmem[[0m[94m_947[0m + 311[95m][0m = 6
                      [95mmem[[0m[94m_947[0m + 343[95m][0m = 0x3031353030360000000000000000000000000000000000000000000000000000
                      if [95mmem[[0m108[95m len [0m20[95m][0m != [38;5;8maddr([0m[94msigner[0m[38;5;8m)[0m:
                          revert with 0, '', 0
                      else:
                          [95mmem[[0m[94m_947[0m + 375[95m][0m = 6
                          [95mmem[[0m[94m_947[0m + 407[95m][0m = 0x3031353030370000000000000000000000000000000000000000000000000000
                          if [32mstor2[0m[32m[[0m[94m_981[0m[32m][0m:
                              revert with 0, '', 0
                          else:
                              [95mmem[[0m64[95m][0m = [94m_947[0m + 503
                              [95mmem[[0m[94m_947[0m + 439[95m][0m = 6
                              [95mmem[[0m[94m_947[0m + 471[95m][0m = 0x3031353030380000000000000000000000000000000000000000000000000000
                              if [32mstor3[0m[32m[[0m[94m_981[0m[32m][0m:
                                  revert with 0, '', 0
                              else:
                                  [95mmem[[0m0[95m][0m = [94m_981[0m
                                  [95mmem[[0m32[95m][0m = 3
                                  [32mstor3[0m[32m[[0m[94m_981[0m[32m][0m = 1
                                  [94m_1435[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                  [94midx[0m = 0
                                  [32mwhile [0m[94midx[0m[1m < [0m[94m_1435[0m[32m:[0m
                                      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                      [94m_1463[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 32[95m][0m
                                      require [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 60[95m len [0m4[95m][0m[1m < [0m[32mproxies[0m[32m.length[0m
                                      [95mmem[[0m0[95m][0m = 1
                                      [94m_1472[0m = [95mmem[[0m64[95m][0m
                                      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 64
                                      [95mmem[[0m[94m_1472[0m[95m][0m = 6
                                      [95mmem[[0m[94m_1472[0m + 32[95m][0m = 0x3031353030320000000000000000000000000000000000000000000000000000
                                      if [32mproxies[0m[32m[[0m[38;5;8muint32([0m[94m_1463[0m[38;5;8m)[0m[32m][0m:
                                          require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                          require [95mmem[[0m[95mmem[[0m[95mmem[[0m160[95m][0m + (32[1m * [0m[94midx[0m) + 32[95m][0m[95m][0m[1m <= [0m1
                                          if [95mmem[[0m[95mmem[[0m[95mmem[[0m160[95m][0m + (32[1m * [0m[94midx[0m) + 32[95m][0m[95m][0m:
                                              require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                              require [95mmem[[0m[95mmem[[0m[95mmem[[0m160[95m][0m + (32[1m * [0m[94midx[0m) + 32[95m][0m[95m][0m[1m <= [0m1
                                              if [95mmem[[0m[95mmem[[0m[95mmem[[0m160[95m][0m + (32[1m * [0m[94midx[0m) + 32[95m][0m[95m][0m != 1:
                                                  [94m_1435[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                  [94midx[0m = [94midx[0m + 1
                                                  [32mcontinue [0m
                                              else:
                                                  require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                  [94m_1556[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 96[95m][0m
                                                  if [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 108[95m len [0m8[95m][0m[1m == [0m[95mmem[[0m108[95m len [0m20[95m][0m:
                                                      [94m_1563[0m = [95mmem[[0m64[95m][0m
                                                      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 64
                                                      [95mmem[[0m[94m_1563[0m[95m][0m = 6
                                                      [95mmem[[0m[94m_1563[0m + 32[95m][0m = 0x3031353030340000000000000000000000000000000000000000000000000000
                                                      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                      [94m_1585[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 32[95m][0m
                                                      require [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 60[95m len [0m4[95m][0m[1m < [0m[32mproxies[0m[32m.length[0m
                                                      [95mmem[[0m0[95m][0m = 1
                                                      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                      [94m_1617[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 64[95m][0m
                                                      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                      [94m_1640[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 128[95m][0m
                                                      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                      [94m_1665[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 160[95m][0m
                                                      [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 0x239aee0600000000000000000000000000000000000000000000000000000000
                                                      [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = [38;5;8maddr([0m[94m_1617[0m[38;5;8m)[0m
                                                      [95mmem[[0m[95mmem[[0m64[95m][0m + 36[95m][0m = Mask(64, 96, [94m_1556[0m)[1m >> [0m96
                                                      [95mmem[[0m[95mmem[[0m64[95m][0m + 68[95m][0m = [38;5;8maddr([0m[94m_1640[0m[38;5;8m)[0m
                                                      [95mmem[[0m[95mmem[[0m64[95m][0m + 100[95m][0m = [94m_1665[0m
                                                      require ext_code.size([32mproxies[0m[32m[[0m[38;5;8muint32([0m[94m_1585[0m[38;5;8m)[0m[32m][0m)
                                                      call [32mproxies[0m[32m[[0m[38;5;8muint32([0m[94m_1585[0m[38;5;8m)[0m[32m][0m.0x239aee06 with:
                                                           gas gas_remaining [38;5;8mwei[0m
                                                          args [38;5;8maddr([0m[94m_1617[0m[38;5;8m)[0m, Mask(64, 96, [94m_1556[0m)[1m << [0m96, [38;5;8maddr([0m[94m_1640[0m[38;5;8m)[0m, [94m_1665[0m
                                                      if not ext_call.success:
                                                          revert with ext_call.return_data[0 len return_data.size]
                                                      else:
                                                          [94m_1435[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                          [94midx[0m = [94midx[0m + 1
                                                          [32mcontinue [0m
                                                  else:
                                                      [94m_1564[0m = [95mmem[[0m128[95m][0m
                                                      [94m_1573[0m = [95mmem[[0m64[95m][0m
                                                      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 64
                                                      [95mmem[[0m[94m_1573[0m[95m][0m = 6
                                                      [95mmem[[0m[94m_1573[0m + 32[95m][0m = 0x3031353030340000000000000000000000000000000000000000000000000000
                                                      if Mask(64, 96, [94m_1556[0m)[1m >> [0m96[1m == [0m[38;5;8maddr([0m[94m_1564[0m[38;5;8m)[0m:
                                                          require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                          [94m_1603[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 32[95m][0m
                                                          require [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 60[95m len [0m4[95m][0m[1m < [0m[32mproxies[0m[32m.length[0m
                                                          [95mmem[[0m0[95m][0m = 1
                                                          require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                          [94m_1644[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 64[95m][0m
                                                          require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                          [94m_1668[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 128[95m][0m
                                                          require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                          [94m_1683[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 160[95m][0m
                                                          [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 0x239aee0600000000000000000000000000000000000000000000000000000000
                                                          [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = [38;5;8maddr([0m[94m_1644[0m[38;5;8m)[0m
                                                          [95mmem[[0m[95mmem[[0m64[95m][0m + 36[95m][0m = Mask(64, 96, [94m_1556[0m)[1m >> [0m96
                                                          [95mmem[[0m[95mmem[[0m64[95m][0m + 68[95m][0m = [38;5;8maddr([0m[94m_1668[0m[38;5;8m)[0m
                                                          [95mmem[[0m[95mmem[[0m64[95m][0m + 100[95m][0m = [94m_1683[0m
                                                          require ext_code.size([32mproxies[0m[32m[[0m[38;5;8muint32([0m[94m_1603[0m[38;5;8m)[0m[32m][0m)
                                                          call [32mproxies[0m[32m[[0m[38;5;8muint32([0m[94m_1603[0m[38;5;8m)[0m[32m][0m.0x239aee06 with:
                                                               gas gas_remaining [38;5;8mwei[0m
                                                              args [38;5;8maddr([0m[94m_1644[0m[38;5;8m)[0m, Mask(64, 96, [94m_1556[0m)[1m << [0m96, [38;5;8maddr([0m[94m_1668[0m[38;5;8m)[0m, [94m_1683[0m
                                                          if not ext_call.success:
                                                              revert with ext_call.return_data[0 len return_data.size]
                                                          else:
                                                              [94m_1435[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                              [94midx[0m = [94midx[0m + 1
                                                              [32mcontinue [0m
                                                      else:
                                                          [94m_1588[0m = [95mmem[[0m64[95m][0m
                                                          [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 0x8c379a000000000000000000000000000000000000000000000000000000000
                                                          [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 32
                                                          [95mmem[[0m[95mmem[[0m64[95m][0m + 36[95m][0m = 6
                                                          [94midx[0m = 0
                                                          [32mwhile [0m[94midx[0m[1m < [0m6[32m:[0m
                                                              [95mmem[[0m[94midx[0m + [94m_1588[0m + 68[95m][0m = [95mmem[[0m[94midx[0m + [94m_1573[0m + 32[95m][0m
                                                              [94m_1435[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                              [94midx[0m = [94midx[0m + 32
                                                              [32mcontinue [0m
                                                          [95mmem[[0m[94m_1588[0m + 74[95m][0m = 0
                                                          revert with memory
                                                            from [95mmem[[0m64[95m][0m
                                                             [93mlen[0m [94m_1588[0m + -[95mmem[[0m64[95m][0m + 100
                                          else:
                                              require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                              [94m_1530[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 64[95m][0m
                                              [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = [95mmem[[0m108[95m len [0m20[95m][0m
                                              [95mmem[[0m[95mmem[[0m64[95m][0m + 36[95m][0m = 32
                                              require ext_code.size([38;5;8maddr([0m[94m_1530[0m[38;5;8m)[0m)
                                              static call [38;5;8maddr([0m[94m_1530[0m[38;5;8m)[0m.isAble([38;5;8maddress[0m target, [38;5;8muint256[0m abilities) with:
                                                      gas gas_remaining [38;5;8mwei[0m
                                                     args [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m, 32
                                              [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = ext_call.return_data[0]
                                              if not ext_call.success:
                                                  revert with ext_call.return_data[0 len return_data.size]
                                              else:
                                                  [94m_1700[0m = [95mmem[[0m64[95m][0m
                                                  [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + ceil32(return_data.size)
                                                  require return_data.size[1m >=′ [0m32
                                                  [94m_1703[0m = [95mmem[[0m[94m_1700[0m[95m][0m
                                                  [94m_1712[0m = [95mmem[[0m64[95m][0m
                                                  [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 64
                                                  [95mmem[[0m[94m_1712[0m[95m][0m = 6
                                                  [95mmem[[0m[94m_1712[0m + 32[95m][0m = 0x3031353031300000000000000000000000000000000000000000000000000000
                                                  if [94m_1703[0m:
                                                      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                      [94m_1726[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 32[95m][0m
                                                      require [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 60[95m len [0m4[95m][0m[1m < [0m[32mproxies[0m[32m.length[0m
                                                      [95mmem[[0m0[95m][0m = 1
                                                      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                      [94m_1744[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 64[95m][0m
                                                      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                      [94m_1758[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 128[95m][0m
                                                      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                      [94m_1770[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 160[95m][0m
                                                      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                      [94m_1781[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 96[95m][0m
                                                      [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 0x46009b0e00000000000000000000000000000000000000000000000000000000
                                                      [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = [38;5;8maddr([0m[94m_1744[0m[38;5;8m)[0m
                                                      [95mmem[[0m[95mmem[[0m64[95m][0m + 36[95m][0m = [38;5;8maddr([0m[94m_1758[0m[38;5;8m)[0m
                                                      [95mmem[[0m[95mmem[[0m64[95m][0m + 68[95m][0m = [94m_1770[0m
                                                      [95mmem[[0m[95mmem[[0m64[95m][0m + 100[95m][0m = [94m_1781[0m
                                                      require ext_code.size([32mproxies[0m[32m[[0m[38;5;8muint32([0m[94m_1726[0m[38;5;8m)[0m[32m][0m)
                                                      call [32mproxies[0m[32m[[0m[38;5;8muint32([0m[94m_1726[0m[38;5;8m)[0m[32m][0m.0x46009b0e with:
                                                           gas gas_remaining [38;5;8mwei[0m
                                                          args [38;5;8maddr([0m[94m_1744[0m[38;5;8m)[0m, [38;5;8maddr([0m[94m_1758[0m[38;5;8m)[0m, [94m_1770[0m, [94m_1781[0m
                                                      if not ext_call.success:
                                                          revert with ext_call.return_data[0 len return_data.size]
                                                      else:
                                                          [94m_1435[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                          [94midx[0m = [94midx[0m + 1
                                                          [32mcontinue [0m
                                                  else:
                                                      [94m_1719[0m = [95mmem[[0m64[95m][0m
                                                      [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 0x8c379a000000000000000000000000000000000000000000000000000000000
                                                      [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 32
                                                      [95mmem[[0m[95mmem[[0m64[95m][0m + 36[95m][0m = 6
                                                      [94midx[0m = 0
                                                      [32mwhile [0m[94midx[0m[1m < [0m6[32m:[0m
                                                          [95mmem[[0m[94midx[0m + [94m_1719[0m + 68[95m][0m = [95mmem[[0m[94midx[0m + [94m_1712[0m + 32[95m][0m
                                                          [94m_1435[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                          [94midx[0m = [94midx[0m + 32
                                                          [32mcontinue [0m
                                                      [95mmem[[0m[94m_1719[0m + 74[95m][0m = 0
                                                      revert with memory
                                                        from [95mmem[[0m64[95m][0m
                                                         [93mlen[0m [94m_1719[0m + -[95mmem[[0m64[95m][0m + 100
                                      else:
                                          [94m_1480[0m = [95mmem[[0m64[95m][0m
                                          [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 0x8c379a000000000000000000000000000000000000000000000000000000000
                                          [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 32
                                          [95mmem[[0m[95mmem[[0m64[95m][0m + 36[95m][0m = 6
                                          [94midx[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m6[32m:[0m
                                              [95mmem[[0m[94midx[0m + [94m_1480[0m + 68[95m][0m = [95mmem[[0m[94midx[0m + [94m_1472[0m + 32[95m][0m
                                              [94m_1435[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                              [94midx[0m = [94midx[0m + 32
                                              [32mcontinue [0m
                                          [95mmem[[0m[94m_1480[0m + 74[95m][0m = 0
                                          revert with memory
                                            from [95mmem[[0m64[95m][0m
                                             [93mlen[0m [94m_1480[0m + -[95mmem[[0m64[95m][0m + 100
                                  [38;5;8mlog Perform([0m
                                  [38;5;8m      address maker=_981,[0m
                                  [38;5;8m      address taker=mem[108 len 20],[0m
                                  [38;5;8m      bytes32 claim=mem[140 len 20])[0m
                                  stop
          else:
              [95mmem[[0m[94m_947[0m + 220[95m][0m = '\x19Ethereum Signed Message:\n32'
              [95mmem[[0m[94m_947[0m + 248[95m][0m = [94m_981[0m
              [95mmem[[0m[94m_947[0m + 188[95m][0m = 60
              [95mmem[[0m64[95m][0m = [94m_947[0m + 280
              [94m_1002[0m = [95mmem[[0m[94m_441[0m + 64[95m][0m
              [94m_1003[0m = [95mmem[[0m[94m_441[0m[95m][0m
              [94m_1004[0m = [95mmem[[0m[94m_441[0m + 32[95m][0m
              [95mmem[[0m[94m_947[0m + 376[95m][0m = [95mmem[[0m[94m_441[0m[95m][0m
              [95mmem[[0m[94m_947[0m + 408[95m][0m = [94m_1004[0m
              [94msigner[0m = erecover(sha3(Mask(224, 32, '\x19Ethereum Signed Message:\n32')[1m >> [0m32, [94m_981[0m), [94m_1002[0m[1m << [0m248, [94m_1003[0m, [94m_1004[0m) [38;5;8m# precompiled[0m
              [95mmem[[0m[94m_947[0m + 280[95m][0m = [94msigner[0m
              if not erecover.result:
                  revert with ext_call.return_data[0 len return_data.size]
              else:
                  [95mmem[[0m[94m_947[0m + 312[95m][0m = 6
                  [95mmem[[0m[94m_947[0m + 344[95m][0m = 0x3031353030360000000000000000000000000000000000000000000000000000
                  if [95mmem[[0m108[95m len [0m20[95m][0m != [38;5;8maddr([0m[94msigner[0m[38;5;8m)[0m:
                      revert with 0, '', 0
                  else:
                      [95mmem[[0m[94m_947[0m + 376[95m][0m = 6
                      [95mmem[[0m[94m_947[0m + 408[95m][0m = 0x3031353030370000000000000000000000000000000000000000000000000000
                      if not [32mstor2[0m[32m[[0m[94m_981[0m[32m][0m:
                          [95mmem[[0m64[95m][0m = [94m_947[0m + 504
                          [95mmem[[0m[94m_947[0m + 440[95m][0m = 6
                          [95mmem[[0m[94m_947[0m + 472[95m][0m = 0x3031353030380000000000000000000000000000000000000000000000000000
                          if [32mstor3[0m[32m[[0m[94m_981[0m[32m][0m:
                              revert with 0, '', 0
                          else:
                              [95mmem[[0m0[95m][0m = [94m_981[0m
                              [95mmem[[0m32[95m][0m = 3
                              [32mstor3[0m[32m[[0m[94m_981[0m[32m][0m = 1
                              [94m_1437[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                              [94midx[0m = 0
                              [32mwhile [0m[94midx[0m[1m < [0m[94m_1437[0m[32m:[0m
                                  require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                  [94m_1468[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 32[95m][0m
                                  require [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 60[95m len [0m4[95m][0m[1m < [0m[32mproxies[0m[32m.length[0m
                                  [95mmem[[0m0[95m][0m = 1
                                  [94m_1474[0m = [95mmem[[0m64[95m][0m
                                  [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 64
                                  [95mmem[[0m[94m_1474[0m[95m][0m = 6
                                  [95mmem[[0m[94m_1474[0m + 32[95m][0m = 0x3031353030320000000000000000000000000000000000000000000000000000
                                  if [32mproxies[0m[32m[[0m[38;5;8muint32([0m[94m_1468[0m[38;5;8m)[0m[32m][0m:
                                      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                      require [95mmem[[0m[95mmem[[0m[95mmem[[0m160[95m][0m + (32[1m * [0m[94midx[0m) + 32[95m][0m[95m][0m[1m <= [0m1
                                      if [95mmem[[0m[95mmem[[0m[95mmem[[0m160[95m][0m + (32[1m * [0m[94midx[0m) + 32[95m][0m[95m][0m:
                                          require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                          require [95mmem[[0m[95mmem[[0m[95mmem[[0m160[95m][0m + (32[1m * [0m[94midx[0m) + 32[95m][0m[95m][0m[1m <= [0m1
                                          if [95mmem[[0m[95mmem[[0m[95mmem[[0m160[95m][0m + (32[1m * [0m[94midx[0m) + 32[95m][0m[95m][0m != 1:
                                              [94m_1437[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                              [94midx[0m = [94midx[0m + 1
                                              [32mcontinue [0m
                                          else:
                                              require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                              [94m_1559[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 96[95m][0m
                                              if [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 108[95m len [0m8[95m][0m[1m == [0m[95mmem[[0m108[95m len [0m20[95m][0m:
                                                  [94m_1565[0m = [95mmem[[0m64[95m][0m
                                                  [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 64
                                                  [95mmem[[0m[94m_1565[0m[95m][0m = 6
                                                  [95mmem[[0m[94m_1565[0m + 32[95m][0m = 0x3031353030340000000000000000000000000000000000000000000000000000
                                                  require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                  [94m_1590[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 32[95m][0m
                                                  require [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 60[95m len [0m4[95m][0m[1m < [0m[32mproxies[0m[32m.length[0m
                                                  [95mmem[[0m0[95m][0m = 1
                                                  require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                  [94m_1624[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 64[95m][0m
                                                  require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                  [94m_1649[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 128[95m][0m
                                                  require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                  [94m_1672[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 160[95m][0m
                                                  [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 0x239aee0600000000000000000000000000000000000000000000000000000000
                                                  [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = [38;5;8maddr([0m[94m_1624[0m[38;5;8m)[0m
                                                  [95mmem[[0m[95mmem[[0m64[95m][0m + 36[95m][0m = Mask(64, 96, [94m_1559[0m)[1m >> [0m96
                                                  [95mmem[[0m[95mmem[[0m64[95m][0m + 68[95m][0m = [38;5;8maddr([0m[94m_1649[0m[38;5;8m)[0m
                                                  [95mmem[[0m[95mmem[[0m64[95m][0m + 100[95m][0m = [94m_1672[0m
                                                  require ext_code.size([32mproxies[0m[32m[[0m[38;5;8muint32([0m[94m_1590[0m[38;5;8m)[0m[32m][0m)
                                                  call [32mproxies[0m[32m[[0m[38;5;8muint32([0m[94m_1590[0m[38;5;8m)[0m[32m][0m.0x239aee06 with:
                                                       gas gas_remaining [38;5;8mwei[0m
                                                      args [38;5;8maddr([0m[94m_1624[0m[38;5;8m)[0m, Mask(64, 96, [94m_1559[0m)[1m << [0m96, [38;5;8maddr([0m[94m_1649[0m[38;5;8m)[0m, [94m_1672[0m
                                                  if not ext_call.success:
                                                      revert with ext_call.return_data[0 len return_data.size]
                                                  else:
                                                      [94m_1437[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                      [94midx[0m = [94midx[0m + 1
                                                      [32mcontinue [0m
                                              else:
                                                  [94m_1566[0m = [95mmem[[0m128[95m][0m
                                                  [94m_1577[0m = [95mmem[[0m64[95m][0m
                                                  [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 64
                                                  [95mmem[[0m[94m_1577[0m[95m][0m = 6
                                                  [95mmem[[0m[94m_1577[0m + 32[95m][0m = 0x3031353030340000000000000000000000000000000000000000000000000000
                                                  if Mask(64, 96, [94m_1559[0m)[1m >> [0m96[1m == [0m[38;5;8maddr([0m[94m_1566[0m[38;5;8m)[0m:
                                                      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                      [94m_1608[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 32[95m][0m
                                                      require [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 60[95m len [0m4[95m][0m[1m < [0m[32mproxies[0m[32m.length[0m
                                                      [95mmem[[0m0[95m][0m = 1
                                                      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                      [94m_1653[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 64[95m][0m
                                                      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                      [94m_1675[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 128[95m][0m
                                                      require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                      [94m_1687[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 160[95m][0m
                                                      [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 0x239aee0600000000000000000000000000000000000000000000000000000000
                                                      [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = [38;5;8maddr([0m[94m_1653[0m[38;5;8m)[0m
                                                      [95mmem[[0m[95mmem[[0m64[95m][0m + 36[95m][0m = Mask(64, 96, [94m_1559[0m)[1m >> [0m96
                                                      [95mmem[[0m[95mmem[[0m64[95m][0m + 68[95m][0m = [38;5;8maddr([0m[94m_1675[0m[38;5;8m)[0m
                                                      [95mmem[[0m[95mmem[[0m64[95m][0m + 100[95m][0m = [94m_1687[0m
                                                      require ext_code.size([32mproxies[0m[32m[[0m[38;5;8muint32([0m[94m_1608[0m[38;5;8m)[0m[32m][0m)
                                                      call [32mproxies[0m[32m[[0m[38;5;8muint32([0m[94m_1608[0m[38;5;8m)[0m[32m][0m.0x239aee06 with:
                                                           gas gas_remaining [38;5;8mwei[0m
                                                          args [38;5;8maddr([0m[94m_1653[0m[38;5;8m)[0m, Mask(64, 96, [94m_1559[0m)[1m << [0m96, [38;5;8maddr([0m[94m_1675[0m[38;5;8m)[0m, [94m_1687[0m
                                                      if not ext_call.success:
                                                          revert with ext_call.return_data[0 len return_data.size]
                                                      else:
                                                          [94m_1437[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                          [94midx[0m = [94midx[0m + 1
                                                          [32mcontinue [0m
                                                  else:
                                                      [94m_1593[0m = [95mmem[[0m64[95m][0m
                                                      [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 0x8c379a000000000000000000000000000000000000000000000000000000000
                                                      [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 32
                                                      [95mmem[[0m[95mmem[[0m64[95m][0m + 36[95m][0m = 6
                                                      [94midx[0m = 0
                                                      [32mwhile [0m[94midx[0m[1m < [0m6[32m:[0m
                                                          [95mmem[[0m[94midx[0m + [94m_1593[0m + 68[95m][0m = [95mmem[[0m[94midx[0m + [94m_1577[0m + 32[95m][0m
                                                          [94m_1437[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                          [94midx[0m = [94midx[0m + 32
                                                          [32mcontinue [0m
                                                      [95mmem[[0m[94m_1593[0m + 74[95m][0m = 0
                                                      revert with memory
                                                        from [95mmem[[0m64[95m][0m
                                                         [93mlen[0m [94m_1593[0m + -[95mmem[[0m64[95m][0m + 100
                                      else:
                                          require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                          [94m_1540[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 64[95m][0m
                                          [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = [95mmem[[0m108[95m len [0m20[95m][0m
                                          [95mmem[[0m[95mmem[[0m64[95m][0m + 36[95m][0m = 32
                                          require ext_code.size([38;5;8maddr([0m[94m_1540[0m[38;5;8m)[0m)
                                          static call [38;5;8maddr([0m[94m_1540[0m[38;5;8m)[0m.isAble([38;5;8maddress[0m target, [38;5;8muint256[0m abilities) with:
                                                  gas gas_remaining [38;5;8mwei[0m
                                                 args [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m, 32
                                          [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = ext_call.return_data[0]
                                          if not ext_call.success:
                                              revert with ext_call.return_data[0 len return_data.size]
                                          else:
                                              [94m_1701[0m = [95mmem[[0m64[95m][0m
                                              [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + ceil32(return_data.size)
                                              require return_data.size[1m >=′ [0m32
                                              [94m_1704[0m = [95mmem[[0m[94m_1701[0m[95m][0m
                                              [94m_1713[0m = [95mmem[[0m64[95m][0m
                                              [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 64
                                              [95mmem[[0m[94m_1713[0m[95m][0m = 6
                                              [95mmem[[0m[94m_1713[0m + 32[95m][0m = 0x3031353031300000000000000000000000000000000000000000000000000000
                                              if [94m_1704[0m:
                                                  require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                  [94m_1728[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 32[95m][0m
                                                  require [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 60[95m len [0m4[95m][0m[1m < [0m[32mproxies[0m[32m.length[0m
                                                  [95mmem[[0m0[95m][0m = 1
                                                  require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                  [94m_1749[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 64[95m][0m
                                                  require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                  [94m_1762[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 128[95m][0m
                                                  require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                  [94m_1774[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 160[95m][0m
                                                  require [94midx[0m[1m < [0m[95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                  [94m_1784[0m = [95mmem[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m160[95m][0m + 32[95m][0m + 96[95m][0m
                                                  [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 0x46009b0e00000000000000000000000000000000000000000000000000000000
                                                  [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = [38;5;8maddr([0m[94m_1749[0m[38;5;8m)[0m
                                                  [95mmem[[0m[95mmem[[0m64[95m][0m + 36[95m][0m = [38;5;8maddr([0m[94m_1762[0m[38;5;8m)[0m
                                                  [95mmem[[0m[95mmem[[0m64[95m][0m + 68[95m][0m = [94m_1774[0m
                                                  [95mmem[[0m[95mmem[[0m64[95m][0m + 100[95m][0m = [94m_1784[0m
                                                  require ext_code.size([32mproxies[0m[32m[[0m[38;5;8muint32([0m[94m_1728[0m[38;5;8m)[0m[32m][0m)
                                                  call [32mproxies[0m[32m[[0m[38;5;8muint32([0m[94m_1728[0m[38;5;8m)[0m[32m][0m.0x46009b0e with:
                                                       gas gas_remaining [38;5;8mwei[0m
                                                      args [38;5;8maddr([0m[94m_1749[0m[38;5;8m)[0m, [38;5;8maddr([0m[94m_1762[0m[38;5;8m)[0m, [94m_1774[0m, [94m_1784[0m
                                                  if not ext_call.success:
                                                      revert with ext_call.return_data[0 len return_data.size]
                                                  else:
                                                      [94m_1437[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                      [94midx[0m = [94midx[0m + 1
                                                      [32mcontinue [0m
                                              else:
                                                  [94m_1722[0m = [95mmem[[0m64[95m][0m
                                                  [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 0x8c379a000000000000000000000000000000000000000000000000000000000
                                                  [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 32
                                                  [95mmem[[0m[95mmem[[0m64[95m][0m + 36[95m][0m = 6
                                                  [94midx[0m = 0
                                                  [32mwhile [0m[94midx[0m[1m < [0m6[32m:[0m
                                                      [95mmem[[0m[94midx[0m + [94m_1722[0m + 68[95m][0m = [95mmem[[0m[94midx[0m + [94m_1713[0m + 32[95m][0m
                                                      [94m_1437[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                                      [94midx[0m = [94midx[0m + 32
                                                      [32mcontinue [0m
                                                  [95mmem[[0m[94m_1722[0m + 74[95m][0m = 0
                                                  revert with memory
                                                    from [95mmem[[0m64[95m][0m
                                                     [93mlen[0m [94m_1722[0m + -[95mmem[[0m64[95m][0m + 100
                                  else:
                                      [94m_1483[0m = [95mmem[[0m64[95m][0m
                                      [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = 0x8c379a000000000000000000000000000000000000000000000000000000000
                                      [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 32
                                      [95mmem[[0m[95mmem[[0m64[95m][0m + 36[95m][0m = 6
                                      [94midx[0m = 0
                                      [32mwhile [0m[94midx[0m[1m < [0m6[32m:[0m
                                          [95mmem[[0m[94midx[0m + [94m_1483[0m + 68[95m][0m = [95mmem[[0m[94midx[0m + [94m_1474[0m + 32[95m][0m
                                          [94m_1437[0m = [95mmem[[0m[95mmem[[0m160[95m][0m[95m][0m
                                          [94midx[0m = [94midx[0m + 32
                                          [32mcontinue [0m
                                      [95mmem[[0m[94m_1483[0m + 74[95m][0m = 0
                                      revert with memory
                                        from [95mmem[[0m64[95m][0m
                                         [93mlen[0m [94m_1483[0m + -[95mmem[[0m64[95m][0m + 100
                              [38;5;8mlog Perform([0m
                              [38;5;8m      address maker=_981,[0m
                              [38;5;8m      address taker=mem[108 len 20],[0m
                              [38;5;8m      bytes32 claim=mem[140 len 20])[0m
                              stop
                      else:
                          [94mvar177001[0m = 32
                          revert with 0, '', 0

