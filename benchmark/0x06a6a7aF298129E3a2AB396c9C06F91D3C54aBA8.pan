[38;5;8m#
#  Panoramix 4 Oct 2019 
#  Decompiled source of [0m0x06a6a7aF298129E3a2AB396c9C06F91D3C54aBA8[38;5;8m
# 
#  Let's make the world open source 
# [0m

[95mconst [0munknownbdf22c66 = [1m10000[0m

[32mdef [0mstorage:
  [32mownerOf[0m is mapping of addr [38;5;8mat storage 0[0m
  [32mapproved[0m is mapping of addr [38;5;8mat storage 1[0m
  [32mbalanceOf[0m is mapping of uint256 [38;5;8mat storage 2[0m
  [32mstor3[0m is mapping of uint8 [38;5;8mat storage 3[0m
  [32mname[0m is array of uint256 [38;5;8mat storage 4[0m
  [32msymbol[0m is array of uint256 [38;5;8mat storage 5[0m
  [32mtokenOfOwnerByIndex[0m is array of uint256 [38;5;8mat storage 6[0m
  [32mstor7[0m is mapping of uint256 [38;5;8mat storage 7[0m
  [32mtokenByIndex[0m is array of uint256 [38;5;8mat storage 8[0m
  [32mstor9[0m is mapping of uint256 [38;5;8mat storage 9[0m
  [32mtokenURI[0m is array of uint256 [38;5;8mat storage 10[0m
  [32mowner[0m is addr [38;5;8mat storage 11[0m[38;5;8m[0m
  [32mstor12[0m is mapping of uint8 [38;5;8mat storage 12[0m
  [32mtreasurerAddress[0m is addr [38;5;8mat storage 13[0m[38;5;8m[0m
  [32mpaused[0m is uint8 [38;5;8mat storage 13[0m[38;5;8m offset 160[0m
  [32munknown26c1e750[0m is array of struct [38;5;8mat storage 15[0m
  [32mstor16[0m is mapping of struct [38;5;8mat storage 16[0m
  [32mstor17[0m is mapping of uint256 [38;5;8mat storage 17[0m
  [32munknowneb822fe5[0m is mapping of uint256 [38;5;8mat storage 18[0m
  [32munknown414b5064[0m is mapping of uint256 [38;5;8mat storage 19[0m
  [32munknown7c0f0ac9Address[0m is addr [38;5;8mat storage 20[0m[38;5;8m[0m
  [32munknown30f18fb7Address[0m is addr [38;5;8mat storage 21[0m[38;5;8m[0m
  [32msaleAuctionAddress[0m is addr [38;5;8mat storage 22[0m[38;5;8m[0m
  [32munknown35bde22c[0m is mapping of uint256 [38;5;8mat storage 23[0m
  [32munknown64384a99[0m is mapping of uint256 [38;5;8mat storage 24[0m
  [32mpromoCreatedCount[0m is uint256 [38;5;8mat storage 25[0m[38;5;8m[0m
  [32mstor1413[0m is uint256 [38;5;8mat storage 0x1413ff7a3b1d5b6c016c061d48e2c7014700c777a29fcd068fff04265813d5d[0m[38;5;8m[0m

[95mdef [0mpromoCreatedCount(): [38;5;8m# not payable[0m
  return [32mpromoCreatedCount[0m

[95mdef [0mname(): [38;5;8m# not payable[0m
  return [32mname[0m[32m[[0m0 [95mlen[0m [32mname[0m[32m.length[0m[32m][0m

[95mdef [0mgetApproved(uint256 [32m_tokenId[0m): [38;5;8m# not payable[0m
  return [32mapproved[0m[32m[[0m[32m_tokenId[0m[32m][0m

[95mdef [0mtotalSupply(): [38;5;8m# not payable[0m
  return [32mtokenByIndex[0m[32m.length[0m

[95mdef [0munknown26c1e750(uint256 [32m_param1[0m): [38;5;8m# not payable[0m
  require [32m_param1[0m[1m < [0m[32munknown26c1e750[0m[32m.length[0m
  return [32munknown26c1e750[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_0[0m

[95mdef [0mtokenOfOwnerByIndex(address [32m_owner[0m, uint256 [32m_index[0m): [38;5;8m# not payable[0m
  require [32m_owner[0m
  require [32m_index[0m[1m < [0m[32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_owner[0m[38;5;8m)[0m[32m][0m
  require [32m_index[0m[1m < [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_owner[0m[38;5;8m)[0m[32m][0m
  return [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_owner[0m[38;5;8m)[0m[32m][0m[32m[[0m[32m_index[0m[32m][0m

[95mdef [0munknown30f18fb7(): [38;5;8m# not payable[0m
  return [32munknown30f18fb7Address[0m

[95mdef [0munknown35bde22c(addr [32m_param1[0m): [38;5;8m# not payable[0m
  return [32munknown35bde22c[0m[32m[[0m[32m_param1[0m[32m][0m

[95mdef [0munknown414b5064(uint256 [32m_param1[0m): [38;5;8m# not payable[0m
  return [32munknown414b5064[0m[32m[[0m[32m_param1[0m[32m][0m

[95mdef [0mexists(uint256 [32m_tokenId[0m): [38;5;8m# not payable[0m
  return bool([32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m)

[95mdef [0mtokenByIndex(uint256 [32m_index[0m): [38;5;8m# not payable[0m
  require [32m_index[0m[1m < [0m[32mtokenByIndex[0m[32m.length[0m
  return [32mtokenByIndex[0m[32m[[0m[32m_index[0m[32m][0m

[95mdef [0mpaused(): [38;5;8m# not payable[0m
  return bool([32mpaused[0m)

[95mdef [0mownerOf(uint256 [32m_tokenId[0m): [38;5;8m# not payable[0m
  require [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m
  return [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m

[95mdef [0munknown64384a99(addr [32m_param1[0m): [38;5;8m# not payable[0m
  return [32munknown64384a99[0m[32m[[0m[32m_param1[0m[32m][0m

[95mdef [0mbalanceOf(address [32m_owner[0m): [38;5;8m# not payable[0m
  require [32m_owner[0m
  return [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_owner[0m[38;5;8m)[0m[32m][0m

[95mdef [0munknown7c0f0ac9(): [38;5;8m# not payable[0m
  return [32munknown7c0f0ac9Address[0m

[95mdef [0mowner(): [38;5;8m# not payable[0m
  return [32mowner[0m

[95mdef [0msymbol(): [38;5;8m# not payable[0m
  return [32msymbol[0m[32m[[0m0 [95mlen[0m [32msymbol[0m[32m.length[0m[32m][0m

[95mdef [0mwhitelist(address [32m_param1[0m): [38;5;8m# not payable[0m
  return bool([32mstor12[0m[32m[[0m[32m_param1[0m[32m][0m)

[95mdef [0mtokenURI(uint256 [32m_tokenId[0m): [38;5;8m# not payable[0m
  return [32mtokenURI[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m[[0m0 [95mlen[0m [32mtokenURI[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m.length[0m[32m][0m

[95mdef [0msaleAuction(): [38;5;8m# not payable[0m
  return [32msaleAuctionAddress[0m

[95mdef [0misApprovedForAll(address [32m_owner[0m, address [32m_operator[0m): [38;5;8m# not payable[0m
  return bool([32mstor3[0m[32m[[0m[38;5;8maddr([0m[32m_owner[0m[38;5;8m)[0m[32m][0m[32m[[0m[38;5;8maddr([0m[32m_operator[0m[38;5;8m)[0m[32m][0m)

[95mdef [0munknowneb822fe5(uint256 [32m_param1[0m, uint256 [32m_param2[0m): [38;5;8m# not payable[0m
  return [32munknowneb822fe5[0m[32m[[0m[32m_param1[0m[32m][0m[32m[[0m[32m_param2[0m[32m][0m

[95mdef [0mtreasurer(): [38;5;8m# not payable[0m
  return [32mtreasurerAddress[0m

[38;5;8m#
#  Regular functions
#[0m

[95mdef [0m_fallback()[95m payable[0m: [38;5;8m# default function[0m
  require [32mstor12[0m[32m[[0mcaller[32m][0m

[95mdef [0munknown611e68d4(addr [32m_param1[0m): [38;5;8m# not payable[0m
  require caller[1m == [0m[32mowner[0m
  if [32m_param1[0m:
      [32mtreasurerAddress[0m = [32m_param1[0m

[95mdef [0munknownf6d016dc(): [38;5;8m# not payable[0m
  require [32mstor12[0m[32m[[0mcaller[32m][0m
  [32mpromoCreatedCount[0m++
  if 10000[1m <= [0m[32mpromoCreatedCount[0m + 1:
      revert with 0, 'Promo planet limit is reached'

[95mdef [0mtransferOwnership(address [32m_newOwner[0m): [38;5;8m# not payable[0m
  require caller[1m == [0m[32mowner[0m
  require [32m_newOwner[0m
  [38;5;8mlog OwnershipTransferred([0m
  [38;5;8m      address previousOwner=owner,[0m
  [38;5;8m      address newOwner=_newOwner)[0m
  [32mowner[0m = [32m_newOwner[0m

[95mdef [0mwithdrawBalance(): [38;5;8m# not payable[0m
  if [32mtreasurerAddress[0m != caller:
      revert with 0, 'Only treasurer'
  call [32mtreasurerAddress[0m with:
     value eth.balance(this.address) [38;5;8mwei[0m
       gas 2300 * is_zero(value) [38;5;8mwei[0m
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]

[95mdef [0mpause(): [38;5;8m# not payable[0m
  if [32mowner[0m != caller:
      if [32mtreasurerAddress[0m != caller:
          revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'Only owner and treasure have access'
      require caller[1m == [0m[32mowner[0m
  require not [32mpaused[0m
  [32mpaused[0m = 1
  [38;5;8mlog Pause()[0m

[95mdef [0munknown672815c2(uint256 [32m_param1[0m, uint256 [32m_param2[0m): [38;5;8m# not payable[0m
  if [32mstor17[0m[32m[[0m[32m_param1[0m[32m][0m[32m[[0m[32m_param2[0m[32m][0m[1m < [0m1000:
      return (-(100[1m * [0m[32mstor17[0m[32m[[0m[32m_param1[0m[32m][0m[32m[[0m[32m_param2[0m[32m][0m[1m / [0m1000) + 100)
  else:
      return 0

[95mdef [0maddAddressToWhitelist(address [32m_addr[0m): [38;5;8m# not payable[0m
  require caller[1m == [0m[32mowner[0m
  if [32mstor12[0m[32m[[0m[38;5;8maddr([0m[32m_addr[0m[38;5;8m)[0m[32m][0m:
      return 0
  [32mstor12[0m[32m[[0m[38;5;8maddr([0m[32m_addr[0m[38;5;8m)[0m[32m][0m = 1
  [38;5;8mlog WhitelistedAddressAdded(address addr=_addr)[0m
  return 1

[95mdef [0mremoveAddressFromWhitelist(address [32m_addr[0m): [38;5;8m# not payable[0m
  require caller[1m == [0m[32mowner[0m
  if not [32mstor12[0m[32m[[0m[38;5;8maddr([0m[32m_addr[0m[38;5;8m)[0m[32m][0m:
      return 0
  [32mstor12[0m[32m[[0m[38;5;8maddr([0m[32m_addr[0m[38;5;8m)[0m[32m][0m = 0
  [38;5;8mlog WhitelistedAddressRemoved(address addr=_addr)[0m
  return 1

[95mdef [0msetApprovalForAll(address [32m_to[0m, bool [32m_approved[0m): [38;5;8m# not payable[0m
  require [32m_to[0m != caller
  [32mstor3[0m[32m[[0mcaller[32m][0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m = [38;5;8muint8([0m[32m_approved[0m[38;5;8m)[0m
  [38;5;8mlog ApprovalForAll([0m
  [38;5;8m      address owner=_approved,[0m
  [38;5;8m      address operator=caller,[0m
  [38;5;8m      bool approved=_to)[0m

[95mdef [0munknown4bbe9547(addr [32m_param1[0m): [38;5;8m# not payable[0m
  require caller[1m == [0m[32mowner[0m
  require ext_code.size([32m_param1[0m)
  call [32m_param1[0m.0x51f403f with:
       gas gas_remaining [38;5;8mwei[0m
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m32
  if not ext_call.return_data[0]:
      revert with 0, 'Incorrect address param'
  [32munknown7c0f0ac9Address[0m = [32m_param1[0m

[95mdef [0munknown9272eb8b(addr [32m_param1[0m): [38;5;8m# not payable[0m
  require caller[1m == [0m[32mowner[0m
  require ext_code.size([32m_param1[0m)
  call [32m_param1[0m.0x9bd593e3 with:
       gas gas_remaining [38;5;8mwei[0m
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m32
  if not ext_call.return_data[0]:
      revert with 0, 'Incorrect address param'
  [32munknown30f18fb7Address[0m = [32m_param1[0m

[95mdef [0mwithdrawAuctionBalances(): [38;5;8m# not payable[0m
  if [32mowner[0m != caller:
      if [32mtreasurerAddress[0m != caller:
          revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'Only owner and treasure have access'
  require ext_code.size([32msaleAuctionAddress[0m)
  call [32msaleAuctionAddress[0m.withdrawBalance() with:
       gas gas_remaining [38;5;8mwei[0m
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]

[95mdef [0msetSaleAuctionAddress(address [32m_address[0m): [38;5;8m# not payable[0m
  require caller[1m == [0m[32mowner[0m
  require ext_code.size([32m_address[0m)
  call [32m_address[0m.isSaleClockAuction() with:
       gas gas_remaining [38;5;8mwei[0m
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m32
  if not ext_call.return_data[0]:
      revert with 0, 'Incorrect address param'
  [32msaleAuctionAddress[0m = [32m_address[0m

[95mdef [0munpause(): [38;5;8m# not payable[0m
  require caller[1m == [0m[32mowner[0m
  require [32mpaused[0m
  if not [32msaleAuctionAddress[0m:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'SaleClock contract should be defined'
  if not [32munknown7c0f0ac9Address[0m:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'Balance contract should be defined'
  require caller[1m == [0m[32mowner[0m
  require [32mpaused[0m
  [32mpaused[0m = 0
  [38;5;8mlog Unpause()[0m

[95mdef [0mapprove(address [32m_spender[0m, uint256 [32m_value[0m): [38;5;8m# not payable[0m
  require [32mownerOf[0m[32m[[0m[32m_value[0m[32m][0m
  require [32mownerOf[0m[32m[[0m[32m_value[0m[32m][0m != [32m_spender[0m
  if [32mownerOf[0m[32m[[0m[32m_value[0m[32m][0m != caller:
      require [32mstor3[0m[32m[[0m[32mstor0[0m[32m[[0m[32m_value[0m[32m][0m[32m][0m[32m[[0mcaller[32m][0m
  if [32mapproved[0m[32m[[0m[32m_value[0m[32m][0m:
      [32mapproved[0m[32m[[0m[32m_value[0m[32m][0m = [32m_spender[0m
      [38;5;8mlog Approval([0m
      [38;5;8m      address owner=_value,[0m
      [38;5;8m      address spender=ownerOf[_value],[0m
      [38;5;8m      uint256 value=_spender)[0m
  else:
      if [32m_spender[0m:
          [32mapproved[0m[32m[[0m[32m_value[0m[32m][0m = [32m_spender[0m
          [38;5;8mlog Approval([0m
          [38;5;8m      address owner=_value,[0m
          [38;5;8m      address spender=ownerOf[_value],[0m
          [38;5;8m      uint256 value=_spender)[0m

[95mdef [0maddAddressesToWhitelist(address[] [32m_addrs[0m): [38;5;8m# not payable[0m
  [95mmem[[0m128[95m len [0m32[1m * [0m[32m_addrs.length[0m[95m][0m = call.data[[32m_addrs[0m + 36 len 32[1m * [0m[32m_addrs.length[0m]
  require caller[1m == [0m[32mowner[0m
  [94midx[0m = 0
  [94ms[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m[32m_addrs.length[0m[32m:[0m
      require [94midx[0m[1m < [0m[32m_addrs.length[0m
      require caller[1m == [0m[32mowner[0m
      [95mmem[[0m0[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + 140[95m len [0m20[95m][0m
      [95mmem[[0m32[95m][0m = 12
      if [32mstor12[0m[32m[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + 140[95m len [0m20[95m][0m[32m][0m:
          [94midx[0m = [94midx[0m + 1
          [94ms[0m = [94ms[0m
          [32mcontinue [0m
      [95mmem[[0m0[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + 140[95m len [0m20[95m][0m
      [95mmem[[0m32[95m][0m = 12
      [32mstor12[0m[32m[[0m[38;5;8maddr([0m[95mmem[[0m(32[1m * [0m[94midx[0m) + 128[95m][0m[38;5;8m)[0m[32m][0m = 1
      [95mmem[[0m(32[1m * [0m[32m_addrs.length[0m) + 128[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + 140[95m len [0m20[95m][0m
      [38;5;8mlog WhitelistedAddressAdded(address addr=mem[(32 * _addrs.length) + 128])[0m
      [94midx[0m = [94midx[0m + 1
      [94ms[0m = 1
      [32mcontinue [0m
  return bool([94ms[0m)

[95mdef [0mremoveAddressesFromWhitelist(address[] [32m_addrs[0m): [38;5;8m# not payable[0m
  [95mmem[[0m128[95m len [0m32[1m * [0m[32m_addrs.length[0m[95m][0m = call.data[[32m_addrs[0m + 36 len 32[1m * [0m[32m_addrs.length[0m]
  require caller[1m == [0m[32mowner[0m
  [94midx[0m = 0
  [94ms[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m[32m_addrs.length[0m[32m:[0m
      require [94midx[0m[1m < [0m[32m_addrs.length[0m
      require caller[1m == [0m[32mowner[0m
      [95mmem[[0m0[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + 140[95m len [0m20[95m][0m
      [95mmem[[0m32[95m][0m = 12
      if not [32mstor12[0m[32m[[0m[95mmem[[0m(32[1m * [0m[94midx[0m) + 140[95m len [0m20[95m][0m[32m][0m:
          [94midx[0m = [94midx[0m + 1
          [94ms[0m = [94ms[0m
          [32mcontinue [0m
      [95mmem[[0m0[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + 140[95m len [0m20[95m][0m
      [95mmem[[0m32[95m][0m = 12
      [32mstor12[0m[32m[[0m[38;5;8maddr([0m[95mmem[[0m(32[1m * [0m[94midx[0m) + 128[95m][0m[38;5;8m)[0m[32m][0m = 0
      [95mmem[[0m(32[1m * [0m[32m_addrs.length[0m) + 128[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + 140[95m len [0m20[95m][0m
      [38;5;8mlog WhitelistedAddressRemoved(address addr=mem[(32 * _addrs.length) + 128])[0m
      [94midx[0m = [94midx[0m + 1
      [94ms[0m = 1
      [32mcontinue [0m
  return bool([94ms[0m)

[95mdef [0munknownb568ee2b(uint256 [32m_param1[0m): [38;5;8m# not payable[0m
  require [32m_param1[0m[1m < [0m[32munknown26c1e750[0m[32m.length[0m
  [95mmem[[0m2656[95m len [0m160[95m][0m = code.data[17173 len 160]
  [94midx[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [95mmem[[0m(32[1m * [0m[94midx[0m) + 2656[95m][0m = [38;5;8muint8([0m[32munknown26c1e750[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_48[0m[1m / [0m2^(8[1m * [0m[94midx[0m)[38;5;8m)[0m
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  [94midx[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [95mmem[[0m(32[1m * [0m[94midx[0m) + 2816[95m][0m = [38;5;8muint8([0m[32munknown26c1e750[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_88[0m[1m / [0m2^(8[1m * [0m[94midx[0m)[38;5;8m)[0m
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  [95mmem[[0m2976[95m len [0m160[95m][0m = code.data[17173 len 160]
  [94midx[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [95mmem[[0m(32[1m * [0m[94midx[0m) + 2976[95m][0m = [38;5;8muint16([0m[32mstor16[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_88[0m[1m / [0m2^(16[1m * [0m[94midx[0m)[38;5;8m)[0m
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  return [32mstor16[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_0[0m, [95mmem[[0m2656[95m len [0m160[95m][0m, [95mmem[[0m2976[95m len [0m160[95m][0m

[95mdef [0mgetPlanet(uint256 [32m_planetId[0m): [38;5;8m# not payable[0m
  require [32m_planetId[0m[1m < [0m[32munknown26c1e750[0m[32m.length[0m
  [95mmem[[0m2656[95m len [0m160[95m][0m = code.data[17173 len 160]
  [94midx[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [95mmem[[0m(32[1m * [0m[94midx[0m) + 2656[95m][0m = [38;5;8muint8([0m[32munknown26c1e750[0m[32m[[0m[32m_planetId[0m[32m][0m[32m.field_48[0m[1m / [0m2^(8[1m * [0m[94midx[0m)[38;5;8m)[0m
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  [95mmem[[0m2816[95m len [0m160[95m][0m = code.data[17173 len 160]
  [94midx[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [95mmem[[0m(32[1m * [0m[94midx[0m) + 2816[95m][0m = [38;5;8muint8([0m[32munknown26c1e750[0m[32m[[0m[32m_planetId[0m[32m][0m[32m.field_88[0m[1m / [0m2^(8[1m * [0m[94midx[0m)[38;5;8m)[0m
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  [94midx[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [95mmem[[0m(32[1m * [0m[94midx[0m) + 2976[95m][0m = [38;5;8muint16([0m[32mstor16[0m[32m[[0m[32m_planetId[0m[32m][0m[32m.field_88[0m[1m / [0m2^(16[1m * [0m[94midx[0m)[38;5;8m)[0m
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  return [32munknown26c1e750[0m[32m[[0m[32m_planetId[0m[32m][0m[32m.field_144[0m, 
         [32munknown26c1e750[0m[32m[[0m[32m_planetId[0m[32m][0m[32m.field_0[0m,
         [32munknown26c1e750[0m[32m[[0m[32m_planetId[0m[32m][0m[32m.field_128[0m,
         [32munknown26c1e750[0m[32m[[0m[32m_planetId[0m[32m][0m[32m.field_136[0m,
         [95mmem[[0m2656[95m len [0m160[95m][0m,
         [95mmem[[0m2816[95m len [0m160[95m][0m

[95mdef [0mcreateSaleAuction(uint256 [32m_artworkId[0m, uint256 [32m_startingPrice[0m, uint256 [32m_endingPrice[0m, uint256 [32m_duration[0m): [38;5;8m# not payable[0m
  require not [32mpaused[0m
  require ext_code.size([32munknown7c0f0ac9Address[0m)
  call [32munknown7c0f0ac9Address[0m.0x55909f87 with:
       gas gas_remaining [38;5;8mwei[0m
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m32
  if ext_call.return_data[0]:
      require ext_code.size([32msaleAuctionAddress[0m)
      call [32msaleAuctionAddress[0m.0xb7edea3 with:
           gas gas_remaining [38;5;8mwei[0m
          args caller, [32m_artworkId[0m
      if not ext_call.success:
          revert with ext_call.return_data[0 len return_data.size]
  require [32mownerOf[0m[32m[[0m[32m_artworkId[0m[32m][0m
  if [32mownerOf[0m[32m[[0m[32m_artworkId[0m[32m][0m != caller:
      revert with 0, 'Not owner'
  require [32mownerOf[0m[32m[[0m[32m_artworkId[0m[32m][0m
  require [32mownerOf[0m[32m[[0m[32m_artworkId[0m[32m][0m != [32msaleAuctionAddress[0m
  if [32mownerOf[0m[32m[[0m[32m_artworkId[0m[32m][0m != caller:
      require [32mstor3[0m[32m[[0m[32mstor0[0m[32m[[0m[32m_artworkId[0m[32m][0m[32m][0m[32m[[0mcaller[32m][0m
  if [32mapproved[0m[32m[[0m[32m_artworkId[0m[32m][0m:
      [32mapproved[0m[32m[[0m[32m_artworkId[0m[32m][0m = [32msaleAuctionAddress[0m
      [38;5;8mlog Approval([0m
      [38;5;8m      address owner=_artworkId,[0m
      [38;5;8m      address spender=ownerOf[_artworkId],[0m
      [38;5;8m      uint256 value=saleAuctionAddress)[0m
  else:
      if [32msaleAuctionAddress[0m:
          [32mapproved[0m[32m[[0m[32m_artworkId[0m[32m][0m = [32msaleAuctionAddress[0m
          [38;5;8mlog Approval([0m
          [38;5;8m      address owner=_artworkId,[0m
          [38;5;8m      address spender=ownerOf[_artworkId],[0m
          [38;5;8m      uint256 value=saleAuctionAddress)[0m
  require ext_code.size([32msaleAuctionAddress[0m)
  call [32msaleAuctionAddress[0m.createAuction([38;5;8muint256[0m tokenId, [38;5;8muint256[0m startingPrice, [38;5;8muint256[0m endingPrice, [38;5;8muint256[0m duration, [38;5;8maddress[0m seller) with:
       gas gas_remaining [38;5;8mwei[0m
      args 0, [38;5;8muint32([0m[32m_artworkId[0m[38;5;8m)[0m, [32m_startingPrice[0m, [32m_endingPrice[0m, [32m_duration[0m, caller
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]

[95mdef [0mtransferFrom(address [32m_from[0m, address [32m_to[0m, uint256 [32m_value[0m): [38;5;8m# not payable[0m
  require [32mownerOf[0m[32m[[0m[32m_value[0m[32m][0m
  if [32mownerOf[0m[32m[[0m[32m_value[0m[32m][0m != caller:
      if [32mapproved[0m[32m[[0m[32m_value[0m[32m][0m != caller:
          require [32mstor3[0m[32m[[0m[32mstor0[0m[32m[[0m[32m_value[0m[32m][0m[32m][0m[32m[[0mcaller[32m][0m
  require [32m_from[0m
  require [32m_to[0m
  require [32mownerOf[0m[32m[[0m[32m_value[0m[32m][0m
  require [32mownerOf[0m[32m[[0m[32m_value[0m[32m][0m[1m == [0m[32m_from[0m
  if [32mapproved[0m[32m[[0m[32m_value[0m[32m][0m:
      [32mapproved[0m[32m[[0m[32m_value[0m[32m][0m = 0
      [38;5;8mlog Approval([0m
      [38;5;8m      address owner=_value,[0m
      [38;5;8m      address spender=_from,[0m
      [38;5;8m      uint256 value=0)[0m
  require [32mownerOf[0m[32m[[0m[32m_value[0m[32m][0m
  require [32mownerOf[0m[32m[[0m[32m_value[0m[32m][0m[1m == [0m[32m_from[0m
  require 1[1m <= [0m[32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m
  [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m--
  [32mownerOf[0m[32m[[0m[32m_value[0m[32m][0m = 0
  require 1[1m <= [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m
  require [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m - 1[1m < [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m
  require [32mstor7[0m[32m[[0m[32m_value[0m[32m][0m[1m < [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m
  [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor7[0m[32m[[0m[32m_value[0m[32m][0m[32m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m][0m
  require [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m - 1[1m < [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m
  [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m][0m = 0
  [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m--
  if [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[1m > [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m - 1:
      [94midx[0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m - 1
      [32mwhile [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[1m > [0m[94midx[0m[32m:[0m
          [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m = 0
          [94midx[0m = [94midx[0m + 1
          [32mcontinue [0m
  [32mstor7[0m[32m[[0m[32m_value[0m[32m][0m = 0
  [32mstor7[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m][0m[32m][0m = [32mstor7[0m[32m[[0m[32m_value[0m[32m][0m
  require not [32mownerOf[0m[32m[[0m[32m_value[0m[32m][0m
  [32mownerOf[0m[32m[[0m[32m_value[0m[32m][0m = [32m_to[0m
  require [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m + 1[1m >= [0m[32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m
  [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m++
  [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m++
  [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m[32m][0m = [32m_value[0m
  [32mstor7[0m[32m[[0m[32m_value[0m[32m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m
  [38;5;8mlog Transfer([0m
  [38;5;8m      address from=_value,[0m
  [38;5;8m      address to=_from,[0m
  [38;5;8m      uint256 value=_to)[0m

[95mdef [0munknownc58b1bdd(addr [32m_param1[0m, uint256 [32m_param2[0m, uint256 [32m_param3[0m, uint256 [32m_param4[0m, uint256 [32m_param5[0m): [38;5;8m# not payable[0m
  require [32mstor12[0m[32m[[0mcaller[32m][0m
  [95mmem[[0m2656[95m len [0m160[95m][0m = code.data[17173 len 160]
  require ext_code.size([32munknown30f18fb7Address[0m)
  call [32munknown30f18fb7Address[0m.0x570bb139 with:
       gas gas_remaining [38;5;8mwei[0m
      args [32m_param2[0m
  [95mmem[[0m2816[95m len [0m320[95m][0m = ext_call.return_data[0 len 320]
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m320
  [95mmem[[0m2656[95m][0m = [32m_param5[0m
  [95mmem[[0mceil32(return_data.size) + 2816[95m][0m = [32m_param2[0m
  [95mmem[[0mceil32(return_data.size) + 2848[95m][0m = block.timestamp
  [95mmem[[0mceil32(return_data.size) + 2880[95m][0m = block.timestamp
  [95mmem[[0mceil32(return_data.size) + 2912[95m][0m = [32m_param3[0m
  [95mmem[[0mceil32(return_data.size) + 2944[95m][0m = [32m_param4[0m
  [95mmem[[0mceil32(return_data.size) + 2976[95m][0m = 2816
  [95mmem[[0mceil32(return_data.size) + 3008[95m][0m = 2976
  [95mmem[[0mceil32(return_data.size) + 3040[95m][0m = 2656
  [94midx[0m = 0
  [94ms[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [94midx[0m = [94midx[0m + 1
      [94ms[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + 2816[95m][0m[1m or [0m[94ms[0m
      [32mcontinue [0m
  [94midx[0m = 0
  [94ms[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [94m_26[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + 2976[95m][0m
      [94midx[0m = [94midx[0m + 1
      [94ms[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + 2976[95m][0m[1m or [0m[94ms[0m
      [32mcontinue [0m
  [94midx[0m = 0
  [94ms[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [94midx[0m = [94midx[0m + 1
      [94ms[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + 2816[95m][0m[1m or [0m[94ms[0m
      [32mcontinue [0m
  [94midx[0m = 0
  [94ms[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [94m_33[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + 2656[95m][0m
      [94midx[0m = [94midx[0m + 1
      [94ms[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + 2656[95m][0m[1m or [0m[94ms[0m
      [32mcontinue [0m
  [32munknown26c1e750[0m[32m.length[0m++
  [32munknown26c1e750[0m[32m[[0m[32munknown26c1e750[0m[32m.length[0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^40[1m * [0m[94m_26[0m)
  [32munknown26c1e750[0m[32m[[0m[32munknown26c1e750[0m[32m.length[0m[32m][0m[32m.field_168[0m = 0
  [32mstor16[0m[32m[[0m[32mstor15[0m[32m.length[0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_33[0m)
  [32mstor16[0m[32m[[0m[32mstor15[0m[32m.length[0m[32m][0m[32m.field_168[0m = 0
  if [32munknown26c1e750[0m[32m.length[0m[1m >= [0m10^6:
      revert with 0, 'No more planets'
  [38;5;8mlog 0xf54657dd: _param3, _param4, _param2, ext_call.return_data[0 len 160], ext_call.return_data[160 len 160], _param5, _param1, unknown26c1e750.length[0m
  [32mstor17[0m[32m[[0m[32m_param3[0m[32m][0m[32m[[0m[32m_param4[0m[32m][0m++
  if 3[1m == [0m[32m_param2[0m:
      require ext_code.size([32munknown7c0f0ac9Address[0m)
      call [32munknown7c0f0ac9Address[0m.0x7944013a with:
           gas gas_remaining [38;5;8mwei[0m
          args [32m_param3[0m, [32m_param4[0m
      if not ext_call.success:
          revert with ext_call.return_data[0 len return_data.size]
      require return_data.size[1m >= [0m32
      [32munknowneb822fe5[0m[32m[[0mext_call.return_data[0][32m][0m[32m[[0m3[32m][0m++
  if 4[1m == [0m[32m_param2[0m:
      [32mstor1413[0m++
  require [32m_param1[0m
  require not [32mownerOf[0m[32m[[0m[32mstor15[0m[32m.length[0m[32m][0m
  [32mownerOf[0m[32m[[0m[32mstor15[0m[32m.length[0m[32m][0m = [32m_param1[0m
  require [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m + 1[1m >= [0m[32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m
  [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m++
  [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m++
  [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m][0m = [32munknown26c1e750[0m[32m.length[0m
  [32mstor7[0m[32m[[0m[32mstor15[0m[32m.length[0m[32m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m
  [38;5;8mlog Transfer([0m
  [38;5;8m      address from=unknown26c1e750.length,[0m
  [38;5;8m      address to=0,[0m
  [38;5;8m      uint256 value=_param1)[0m
  [32mstor9[0m[32m[[0m[32mstor15[0m[32m.length[0m[32m][0m = [32mtokenByIndex[0m[32m.length[0m
  [32mtokenByIndex[0m[32m.length[0m++
  [32mtokenByIndex[0m[32m[[0m[32mtokenByIndex[0m[32m.length[0m[32m][0m = [32munknown26c1e750[0m[32m.length[0m
  return [32munknown26c1e750[0m[32m.length[0m

[95mdef [0msafeTransferFrom(address [32m_from[0m, address [32m_to[0m, uint256 [32m_tokenId[0m, bytes [32m_data[0m): [38;5;8m# not payable[0m
  require [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m
  if [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m != caller:
      if [32mapproved[0m[32m[[0m[32m_tokenId[0m[32m][0m != caller:
          require [32mstor3[0m[32m[[0m[32mstor0[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m][0m[32m[[0mcaller[32m][0m
  require [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m
  if [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m != caller:
      if [32mapproved[0m[32m[[0m[32m_tokenId[0m[32m][0m != caller:
          require [32mstor3[0m[32m[[0m[32mstor0[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m][0m[32m[[0mcaller[32m][0m
  require [32m_from[0m
  require [32m_to[0m
  require [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m
  require [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m[1m == [0m[32m_from[0m
  if [32mapproved[0m[32m[[0m[32m_tokenId[0m[32m][0m:
      [32mapproved[0m[32m[[0m[32m_tokenId[0m[32m][0m = 0
      [38;5;8mlog Approval([0m
      [38;5;8m      address owner=_tokenId,[0m
      [38;5;8m      address spender=_from,[0m
      [38;5;8m      uint256 value=0)[0m
  require [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m
  require [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m[1m == [0m[32m_from[0m
  require 1[1m <= [0m[32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m
  [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m--
  [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m = 0
  require 1[1m <= [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m
  require [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m - 1[1m < [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m
  require [32mstor7[0m[32m[[0m[32m_tokenId[0m[32m][0m[1m < [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m
  [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor7[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m][0m
  require [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m - 1[1m < [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m
  [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m][0m = 0
  [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m--
  if [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[1m > [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m - 1:
      [94midx[0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m - 1
      [32mwhile [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[1m > [0m[94midx[0m[32m:[0m
          [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m = 0
          [94midx[0m = [94midx[0m + 1
          [32mcontinue [0m
  [32mstor7[0m[32m[[0m[32m_tokenId[0m[32m][0m = 0
  [32mstor7[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m][0m[32m][0m = [32mstor7[0m[32m[[0m[32m_tokenId[0m[32m][0m
  require not [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m
  [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m = [32m_to[0m
  require [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m + 1[1m >= [0m[32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m
  [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m++
  [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m++
  [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m[32m][0m = [32m_tokenId[0m
  [32mstor7[0m[32m[[0m[32m_tokenId[0m[32m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m
  [38;5;8mlog Transfer([0m
  [38;5;8m      address from=_tokenId,[0m
  [38;5;8m      address to=_from,[0m
  [38;5;8m      uint256 value=_to)[0m
  if ext_code.size([32m_to[0m)[1m > [0m0:
      require ext_code.size([32m_to[0m)
      call [32m_to[0m.onERC721Received([38;5;8maddress[0m from, [38;5;8muint256[0m tokenId, [38;5;8mbytes[0m data) with:
           gas gas_remaining [38;5;8mwei[0m
          args [38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m, [32m_tokenId[0m, [38;5;8mArray(len=[0m[32m_data.length[0m[38;5;8m, data=[0m[32m_data[[0mall[32m][0m[38;5;8m)[0m
      if not ext_call.success:
          revert with ext_call.return_data[0 len return_data.size]
      require return_data.size[1m >= [0m32
      require 0xf0b9e5ba00000000000000000000000000000000000000000000000000000000[1m == [0mMask(32, 224, ext_call.return_data[0])

[95mdef [0msafeTransferFrom(address [32m_from[0m, address [32m_to[0m, uint256 [32m_tokenId[0m): [38;5;8m# not payable[0m
  require [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m
  if [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m != caller:
      if [32mapproved[0m[32m[[0m[32m_tokenId[0m[32m][0m != caller:
          require [32mstor3[0m[32m[[0m[32mstor0[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m][0m[32m[[0mcaller[32m][0m
  require [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m
  if [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m != caller:
      if [32mapproved[0m[32m[[0m[32m_tokenId[0m[32m][0m != caller:
          require [32mstor3[0m[32m[[0m[32mstor0[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m][0m[32m[[0mcaller[32m][0m
  require [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m
  if [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m != caller:
      if [32mapproved[0m[32m[[0m[32m_tokenId[0m[32m][0m != caller:
          require [32mstor3[0m[32m[[0m[32mstor0[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m][0m[32m[[0mcaller[32m][0m
  require [32m_from[0m
  require [32m_to[0m
  require [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m
  require [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m[1m == [0m[32m_from[0m
  if [32mapproved[0m[32m[[0m[32m_tokenId[0m[32m][0m:
      [32mapproved[0m[32m[[0m[32m_tokenId[0m[32m][0m = 0
      [38;5;8mlog Approval([0m
      [38;5;8m      address owner=_tokenId,[0m
      [38;5;8m      address spender=_from,[0m
      [38;5;8m      uint256 value=0)[0m
  require [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m
  require [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m[1m == [0m[32m_from[0m
  require 1[1m <= [0m[32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m
  [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m--
  [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m = 0
  require 1[1m <= [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m
  require [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m - 1[1m < [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m
  require [32mstor7[0m[32m[[0m[32m_tokenId[0m[32m][0m[1m < [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m
  [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor7[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m][0m
  require [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m - 1[1m < [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m
  [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m][0m = 0
  [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m--
  if [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[1m > [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m - 1:
      [94midx[0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m - 1
      [32mwhile [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[1m > [0m[94midx[0m[32m:[0m
          [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m = 0
          [94midx[0m = [94midx[0m + 1
          [32mcontinue [0m
  [32mstor7[0m[32m[[0m[32m_tokenId[0m[32m][0m = 0
  [32mstor7[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m[32m][0m[32m][0m = [32mstor7[0m[32m[[0m[32m_tokenId[0m[32m][0m
  require not [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m
  [32mownerOf[0m[32m[[0m[32m_tokenId[0m[32m][0m = [32m_to[0m
  require [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m + 1[1m >= [0m[32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m
  [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m++
  [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m++
  [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m[32m][0m = [32m_tokenId[0m
  [32mstor7[0m[32m[[0m[32m_tokenId[0m[32m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m
  [38;5;8mlog Transfer([0m
  [38;5;8m      address from=_tokenId,[0m
  [38;5;8m      address to=_from,[0m
  [38;5;8m      uint256 value=_to)[0m
  if ext_code.size([32m_to[0m)[1m > [0m0:
      require ext_code.size([32m_to[0m)
      call [32m_to[0m.onERC721Received([38;5;8maddress[0m from, [38;5;8muint256[0m tokenId, [38;5;8mbytes[0m data) with:
           gas gas_remaining [38;5;8mwei[0m
          args [38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m, [32m_tokenId[0m, 96, 0
      if not ext_call.success:
          revert with ext_call.return_data[0 len return_data.size]
      require return_data.size[1m >= [0m32
      require 0xf0b9e5ba00000000000000000000000000000000000000000000000000000000[1m == [0mMask(32, 224, ext_call.return_data[0])

[95mdef [0munknown3e573168(uint256 [32m_param1[0m): [38;5;8m# not payable[0m
  [95mmem[[0m96[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m256[95m][0m = 0
  [95mmem[[0m288[95m][0m = 0
  [95mmem[[0m320[95m][0m = 0
  [95mmem[[0m352[95m][0m = 0
  [95mmem[[0m384[95m][0m = 0
  [95mmem[[0m896[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m416[95m][0m = 896
  [95mmem[[0m1056[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m448[95m][0m = 1056
  [95mmem[[0m1216[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m480[95m][0m = 1216
  [95mmem[[0m1376[95m len [0m160[95m][0m = code.data[17173 len 160]
  require ext_code.size([32munknown7c0f0ac9Address[0m)
  call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
       gas gas_remaining [38;5;8mwei[0m
      args 34
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m32
  [95mmem[[0m2176[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m2336[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m2496[95m len [0m160[95m][0m = code.data[17173 len 160]
  require [32m_param1[0m[1m < [0m[32munknown26c1e750[0m[32m.length[0m
  [95mmem[[0m0[95m][0m = [32m_param1[0m
  [95mmem[[0m32[95m][0m = 16
  [95mmem[[0m1568[95m][0m = [32munknown26c1e750[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_0[0m
  [95mmem[[0m2656[95m len [0m160[95m][0m = code.data[17173 len 160]
  [94midx[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [95mmem[[0m(32[1m * [0m[94midx[0m) + 2656[95m][0m = [38;5;8muint8([0m[32munknown26c1e750[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_48[0m[1m / [0m2^(8[1m * [0m[94midx[0m)[38;5;8m)[0m
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  [95mmem[[0m1696[95m][0m = 2656
  [95mmem[[0m2816[95m len [0m160[95m][0m = code.data[17173 len 160]
  [94midx[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [95mmem[[0m(32[1m * [0m[94midx[0m) + 2816[95m][0m = [38;5;8muint8([0m[32munknown26c1e750[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_88[0m[1m / [0m2^(8[1m * [0m[94midx[0m)[38;5;8m)[0m
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  [95mmem[[0m1728[95m][0m = 2816
  [95mmem[[0m1632[95m][0m = [32munknown26c1e750[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_128[0m
  [95mmem[[0m1664[95m][0m = [32munknown26c1e750[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_136[0m
  [95mmem[[0m1536[95m][0m = [32munknown26c1e750[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_144[0m
  [95mmem[[0m1600[95m][0m = [32mstor16[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_0[0m
  [95mmem[[0m64[95m][0m = 3136
  [95mmem[[0m2976[95m len [0m160[95m][0m = code.data[17173 len 160]
  [94midx[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [95mmem[[0m(32[1m * [0m[94midx[0m) + 2976[95m][0m = [38;5;8muint16([0m[32mstor16[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_88[0m[1m / [0m2^(16[1m * [0m[94midx[0m)[38;5;8m)[0m
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  [95mmem[[0m1760[95m][0m = 2976
  [95mmem[[0m3140[95m][0m = 18
  require ext_code.size([32munknown7c0f0ac9Address[0m)
  call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
       gas gas_remaining [38;5;8mwei[0m
      args 18
  [95mmem[[0m3136[95m][0m = ext_call.return_data[0]
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m32
  [94midx[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      if [95mmem[[0m(32[1m * [0m[94midx[0m) + 2816[95m][0m:
          require [94midx[0m[1m < [0m5
          require [94midx[0m[1m < [0m5
          if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1728[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1728[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
              [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1760[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1728[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1728[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1760[95m][0m[95m][0m
          else:
              [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1760[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1728[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1728[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1760[95m][0m[95m][0m + 1
          if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1760[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1728[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
              require [94midx[0m[1m < [0m5
              [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1760[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1728[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  [95mmem[[0m[95mmem[[0m64[95m][0m[95m len [0m160[95m][0m = [95mmem[[0m[95mmem[[0m1760[95m][0m[95m len [0m160[95m][0m
  return memory
    from [95mmem[[0m64[95m][0m
     [93mlen[0m 160

[95mdef [0minitialize(address [32m_sender[0m): [38;5;8m# not payable[0m
  require caller[1m == [0m[32mowner[0m
  if [32munknown26c1e750[0m[32m.length[0m:
      revert with 0, 'Earth was created'
  require ext_code.size([32munknown7c0f0ac9Address[0m)
  call [32munknown7c0f0ac9Address[0m.0xbe8fb1c1 with:
       gas gas_remaining [38;5;8mwei[0m
      args 20
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m64
  require ext_code.size([32munknown7c0f0ac9Address[0m)
  call [32munknown7c0f0ac9Address[0m.0xe4c5efe9 with:
       gas gas_remaining [38;5;8mwei[0m
      args 21
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m96
  require ext_code.size([32munknown7c0f0ac9Address[0m)
  call [32munknown7c0f0ac9Address[0m.0xe4c5efe9 with:
       gas gas_remaining [38;5;8mwei[0m
      args 22
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m96
  require ext_code.size([32munknown7c0f0ac9Address[0m)
  call [32munknown7c0f0ac9Address[0m.0xe4c5efe9 with:
       gas gas_remaining [38;5;8mwei[0m
      args 24
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m96
  [95mmem[[0m(6[1m * [0mceil32(return_data.size)) + 1824[95m][0m = ext_call.return_data[0]
  [95mmem[[0m(6[1m * [0mceil32(return_data.size)) + 1856[95m][0m = ext_call.return_data[32]
  [95mmem[[0m(6[1m * [0mceil32(return_data.size)) + 1888[95m][0m = ext_call.return_data[64]
  [95mmem[[0m(6[1m * [0mceil32(return_data.size)) + 1920[95m][0m = 0
  [95mmem[[0m(6[1m * [0mceil32(return_data.size)) + 1952[95m][0m = 0
  [95mmem[[0m(6[1m * [0mceil32(return_data.size)) + 1984[95m][0m = ext_call.return_data[0]
  [95mmem[[0m(6[1m * [0mceil32(return_data.size)) + 2016[95m][0m = ext_call.return_data[32]
  [95mmem[[0m(6[1m * [0mceil32(return_data.size)) + 2048[95m][0m = ext_call.return_data[64]
  [95mmem[[0m(6[1m * [0mceil32(return_data.size)) + 2080[95m][0m = 0
  [95mmem[[0m(6[1m * [0mceil32(return_data.size)) + 2112[95m][0m = 0
  [95mmem[[0m(6[1m * [0mceil32(return_data.size)) + 2144[95m][0m = ext_call.return_data[0]
  [95mmem[[0m(6[1m * [0mceil32(return_data.size)) + 2176[95m][0m = ext_call.return_data[32]
  [95mmem[[0m(6[1m * [0mceil32(return_data.size)) + 2208[95m][0m = ext_call.return_data[64]
  [95mmem[[0m(6[1m * [0mceil32(return_data.size)) + 2240[95m][0m = 0
  [95mmem[[0m(6[1m * [0mceil32(return_data.size)) + 2272[95m][0m = 0
  [94midx[0m = 0
  [94ms[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [94midx[0m = [94midx[0m + 1
      [94ms[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + (6[1m * [0mceil32(return_data.size)) + 1824[95m][0m[1m or [0m[94ms[0m
      [32mcontinue [0m
  [94midx[0m = 0
  [94ms[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [94m_47[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + (6[1m * [0mceil32(return_data.size)) + 1984[95m][0m
      [94midx[0m = [94midx[0m + 1
      [94ms[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + (6[1m * [0mceil32(return_data.size)) + 1984[95m][0m[1m or [0m[94ms[0m
      [32mcontinue [0m
  [94midx[0m = 0
  [94ms[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [94midx[0m = [94midx[0m + 1
      [94ms[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + (6[1m * [0mceil32(return_data.size)) + 1824[95m][0m[1m or [0m[94ms[0m
      [32mcontinue [0m
  [94midx[0m = 0
  [94ms[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [94m_54[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + (6[1m * [0mceil32(return_data.size)) + 2144[95m][0m
      [94midx[0m = [94midx[0m + 1
      [94ms[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + (6[1m * [0mceil32(return_data.size)) + 2144[95m][0m[1m or [0m[94ms[0m
      [32mcontinue [0m
  [32munknown26c1e750[0m[32m.length[0m++
  [32munknown26c1e750[0m[32m[[0m[32munknown26c1e750[0m[32m.length[0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^40[1m * [0m[94m_47[0m)
  [32munknown26c1e750[0m[32m[[0m[32munknown26c1e750[0m[32m.length[0m[32m][0m[32m.field_168[0m = 0
  [32mstor16[0m[32m[[0m[32mstor15[0m[32m.length[0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_54[0m)
  [32mstor16[0m[32m[[0m[32mstor15[0m[32m.length[0m[32m][0m[32m.field_168[0m = 0
  if [32munknown26c1e750[0m[32m.length[0m[1m >= [0m10^6:
      revert with 0, 'No more planets'
  [38;5;8mlog 0xf54657dd: ext_call.return_data[0], ext_call.return_data[32], 3, 0, 0, ext_call.return_data[0], _sender, unknown26c1e750.length[0m
  [32mstor17[0m[32m[[0mext_call.return_data[0][32m][0m[32m[[0mext_call.return_data[32][32m][0m++
  require ext_code.size([32munknown7c0f0ac9Address[0m)
  call [32munknown7c0f0ac9Address[0m.0x7944013a with:
       gas gas_remaining [38;5;8mwei[0m
      args ext_call.return_data[0], ext_call.return_data[32]
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m32
  [32munknowneb822fe5[0m[32m[[0mext_call.return_data[0][32m][0m[32m[[0m3[32m][0m++
  require [32m_sender[0m
  require not [32mownerOf[0m[32m[[0m[32mstor15[0m[32m.length[0m[32m][0m
  [32mownerOf[0m[32m[[0m[32mstor15[0m[32m.length[0m[32m][0m = [32m_sender[0m
  require [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_sender[0m[38;5;8m)[0m[32m][0m + 1[1m >= [0m[32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_sender[0m[38;5;8m)[0m[32m][0m
  [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_sender[0m[38;5;8m)[0m[32m][0m++
  [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_sender[0m[38;5;8m)[0m[32m][0m++
  [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_sender[0m[38;5;8m)[0m[32m][0m[32m[[0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_sender[0m[38;5;8m)[0m[32m][0m[32m][0m = [32munknown26c1e750[0m[32m.length[0m
  [32mstor7[0m[32m[[0m[32mstor15[0m[32m.length[0m[32m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_sender[0m[38;5;8m)[0m[32m][0m
  [38;5;8mlog Transfer([0m
  [38;5;8m      address from=unknown26c1e750.length,[0m
  [38;5;8m      address to=0,[0m
  [38;5;8m      uint256 value=_sender)[0m
  [32mstor9[0m[32m[[0m[32mstor15[0m[32m.length[0m[32m][0m = [32mtokenByIndex[0m[32m.length[0m
  [32mtokenByIndex[0m[32m.length[0m++
  [32mtokenByIndex[0m[32m[[0m[32mtokenByIndex[0m[32m.length[0m[32m][0m = [32munknown26c1e750[0m[32m.length[0m

[95mdef [0munknown5a71e6d3(addr [32m_param1[0m): [38;5;8m# not payable[0m
  [95mmem[[0m96[95m][0m = 0
  [95mmem[[0m128[95m][0m = 0
  [95mmem[[0m160[95m][0m = 0
  [95mmem[[0m192[95m][0m = 0
  [95mmem[[0m224[95m][0m = 0
  [95mmem[[0m736[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m256[95m][0m = 736
  [95mmem[[0m896[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m288[95m][0m = 896
  [95mmem[[0m64[95m][0m = 1216
  [95mmem[[0m1056[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m320[95m][0m = 1056
  [95mmem[[0m1220[95m][0m = 34
  require ext_code.size([32munknown7c0f0ac9Address[0m)
  call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
       gas gas_remaining [38;5;8mwei[0m
      args 34
  [95mmem[[0m1216[95m][0m = ext_call.return_data[0]
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m32
  [95mmem[[0m0[95m][0m = [32m_param1[0m
  [95mmem[[0m32[95m][0m = 6
  [94ms[0m = 0
  [94ms[0m = 96
  [94midx[0m = 0
  [94ms[0m = 24[1m * [0m3600[1m * [0m[32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m
  [32mwhile [0m[94midx[0m[1m < [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m:[0m
      [95mmem[[0m32[95m][0m = 6
      require [94midx[0m[1m < [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m
      [95mmem[[0m0[95m][0m = sha3([38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m, 6)
      [94m_56[0m = [95mmem[[0m64[95m][0m
      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 640
      [95mmem[[0m[94m_56[0m[95m][0m = 0
      [95mmem[[0m[94m_56[0m + 32[95m][0m = 0
      [95mmem[[0m[94m_56[0m + 64[95m][0m = 0
      [95mmem[[0m[94m_56[0m + 96[95m][0m = 0
      [95mmem[[0m[94m_56[0m + 128[95m][0m = 0
      [94m_57[0m = [95mmem[[0m64[95m][0m
      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
      [95mmem[[0m[94m_57[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
      [95mmem[[0m[94m_56[0m + 160[95m][0m = [94m_57[0m
      [94m_58[0m = [95mmem[[0m64[95m][0m
      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
      [95mmem[[0m[94m_58[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
      [95mmem[[0m[94m_56[0m + 192[95m][0m = [94m_58[0m
      [94m_59[0m = [95mmem[[0m64[95m][0m
      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
      [95mmem[[0m[94m_59[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
      [95mmem[[0m[94m_56[0m + 224[95m][0m = [94m_59[0m
      require [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[1m < [0m[32munknown26c1e750[0m[32m.length[0m
      [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m
      [95mmem[[0m32[95m][0m = 16
      [95mmem[[0m[94m_56[0m + 32[95m][0m = [32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_0[0m
      [94m_62[0m = [95mmem[[0m64[95m][0m
      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
      [95mmem[[0m[94m_62[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
      [94mt[0m = 0
      [32mwhile [0m[94mt[0m[1m < [0m5[32m:[0m
          [95mmem[[0m(32[1m * [0m[94mt[0m) + [94m_62[0m[95m][0m = [38;5;8muint8([0m[32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_48[0m[1m / [0m2^(8[1m * [0m[94mt[0m)[38;5;8m)[0m
          [94mt[0m = [94mt[0m + 1
          [32mcontinue [0m
      [95mmem[[0m[94m_56[0m + 160[95m][0m = [94m_62[0m
      [94m_63[0m = [95mmem[[0m64[95m][0m
      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
      [95mmem[[0m[94m_63[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
      [94mt[0m = 0
      [32mwhile [0m[94mt[0m[1m < [0m5[32m:[0m
          [95mmem[[0m(32[1m * [0m[94mt[0m) + [94m_63[0m[95m][0m = [38;5;8muint8([0m[32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_88[0m[1m / [0m2^(8[1m * [0m[94mt[0m)[38;5;8m)[0m
          [94mt[0m = [94mt[0m + 1
          [32mcontinue [0m
      [95mmem[[0m[94m_56[0m + 192[95m][0m = [94m_63[0m
      [95mmem[[0m[94m_56[0m + 96[95m][0m = [32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_128[0m
      [95mmem[[0m[94m_56[0m + 128[95m][0m = [32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_136[0m
      [95mmem[[0m[94m_56[0m[95m][0m = [32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_144[0m
      [95mmem[[0m[94m_56[0m + 64[95m][0m = [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_0[0m
      [94m_64[0m = [95mmem[[0m64[95m][0m
      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
      [95mmem[[0m[94m_64[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
      [94mt[0m = 0
      [32mwhile [0m[94mt[0m[1m < [0m5[32m:[0m
          [95mmem[[0m(32[1m * [0m[94mt[0m) + [94m_64[0m[95m][0m = [38;5;8muint16([0m[32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_88[0m[1m / [0m2^(16[1m * [0m[94mt[0m)[38;5;8m)[0m
          [94mt[0m = [94mt[0m + 1
          [32mcontinue [0m
      [95mmem[[0m[94m_56[0m + 224[95m][0m = [94m_64[0m
      [95mmem[[0m0[95m][0m = [32m_param1[0m
      [95mmem[[0m32[95m][0m = 24
      if [95mmem[[0m[94m_56[0m + 64[95m][0m[1m > [0m[32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m:
          [94m_67[0m = [95mmem[[0m[94m_56[0m + 64[95m][0m
          [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 17
          require ext_code.size([32munknown7c0f0ac9Address[0m)
          call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
               gas gas_remaining [38;5;8mwei[0m
              args 17
          [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = ext_call.return_data[0]
          if not ext_call.success:
              revert with ext_call.return_data[0 len return_data.size]
          require return_data.size[1m >= [0m32
          if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_56[0m + 192[95m][0m[95m][0m) - ([94m_67[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_56[0m + 192[95m][0m[95m][0m)[1m % [0m48[1m * [0m24[1m * [0m3600[1m < [0m24[1m * [0m3600:
              [94ms[0m = (block.timestamp[1m * [0mext_call.return_data[0]) - ([94m_67[0m[1m * [0mext_call.return_data[0])
              [94ms[0m = [94m_56[0m
              [94midx[0m = [94midx[0m + 1
              [94ms[0m = (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_64[0m[95m][0m[1m * [0mext_call.return_data[0]) - ([94m_67[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_64[0m[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_56[0m + 192[95m][0m[95m][0m) - ([94m_67[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_56[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([94m_67[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_56[0m + 192[95m][0m[95m][0m) - ([94m_67[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_56[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) + [94ms[0m
              [32mcontinue [0m
          [94ms[0m = (block.timestamp[1m * [0mext_call.return_data[0]) - ([94m_67[0m[1m * [0mext_call.return_data[0])
          [94ms[0m = [94m_56[0m
          [94midx[0m = [94midx[0m + 1
          [94ms[0m = (block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([94m_67[0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_64[0m[95m][0m[1m * [0mext_call.return_data[0]) - ([94m_67[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_64[0m[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_56[0m + 192[95m][0m[95m][0m) - ([94m_67[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_56[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([94m_67[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_56[0m + 192[95m][0m[95m][0m) - ([94m_67[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_56[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) + [94ms[0m
          [32mcontinue [0m
      [95mmem[[0m0[95m][0m = [32m_param1[0m
      [95mmem[[0m32[95m][0m = 24
      [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 17
      require ext_code.size([32munknown7c0f0ac9Address[0m)
      call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
           gas gas_remaining [38;5;8mwei[0m
          args 17
      [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = ext_call.return_data[0]
      if not ext_call.success:
          revert with ext_call.return_data[0 len return_data.size]
      require return_data.size[1m >= [0m32
      if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_56[0m + 192[95m][0m[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_56[0m + 192[95m][0m[95m][0m)[1m % [0m48[1m * [0m24[1m * [0m3600[1m < [0m24[1m * [0m3600:
          [94ms[0m = (block.timestamp[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0])
          [94ms[0m = [94m_56[0m
          [94midx[0m = [94midx[0m + 1
          [94ms[0m = (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_64[0m[95m][0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_64[0m[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_56[0m + 192[95m][0m[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_56[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_56[0m + 192[95m][0m[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_56[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) + [94ms[0m
          [32mcontinue [0m
      [94ms[0m = (block.timestamp[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0])
      [94ms[0m = [94m_56[0m
      [94midx[0m = [94midx[0m + 1
      [94ms[0m = (block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_64[0m[95m][0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_64[0m[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_56[0m + 192[95m][0m[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_56[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_56[0m + 192[95m][0m[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_56[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) + [94ms[0m
      [32mcontinue [0m
  if [94ms[0m[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
      return ([94ms[0m[1m / [0m24[1m * [0m3600)
  return (([94ms[0m[1m / [0m24[1m * [0m3600) + 1)

[95mdef [0munknown8b17b33b(addr [32m_param1[0m, uint256 [32m_param2[0m): [38;5;8m# not payable[0m
  [95mmem[[0m96[95m len [0m64[95m][0m = code.data[17173 len 64]
  [95mmem[[0m160[95m][0m = 0
  [95mmem[[0m192[95m][0m = 0
  [95mmem[[0m224[95m][0m = 0
  [95mmem[[0m256[95m][0m = 0
  [95mmem[[0m288[95m][0m = 0
  [95mmem[[0m800[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m320[95m][0m = 800
  [95mmem[[0m960[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m352[95m][0m = 960
  [95mmem[[0m1120[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m384[95m][0m = 1120
  [95mmem[[0m0[95m][0m = [32m_param1[0m
  [95mmem[[0m32[95m][0m = 6
  [95mmem[[0m1280[95m][0m = 5[1m * [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m
  if not 5[1m * [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m:
      require ext_code.size([32munknown7c0f0ac9Address[0m)
      call [32munknown7c0f0ac9Address[0m.0xccf9bbb6 with:
           gas gas_remaining [38;5;8mwei[0m
          args [32m_param2[0m
      [95mmem[[0m(32[1m * [0m5[1m * [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m) + 1312[95m len [0m64[95m][0m = ext_call.return_data[0 len 64]
      if not ext_call.success:
          revert with ext_call.return_data[0 len return_data.size]
      [95mmem[[0m64[95m][0m = (32[1m * [0m5[1m * [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m) + ceil32(return_data.size) + 1312
      require return_data.size[1m >= [0m64
      [94ms[0m = 0
      [94mt[0m = 0
      [94mt[0m = 160
      [94midx[0m = 0
      [32mwhile [0m[94midx[0m[1m < [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m:[0m
          [95mmem[[0m32[95m][0m = 6
          require [94midx[0m[1m < [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m
          [95mmem[[0m0[95m][0m = sha3([38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m, 6)
          [94m_58[0m = [95mmem[[0m64[95m][0m
          [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 640
          [95mmem[[0m[94m_58[0m[95m][0m = 0
          [95mmem[[0m[94m_58[0m + 32[95m][0m = 0
          [95mmem[[0m[94m_58[0m + 64[95m][0m = 0
          [95mmem[[0m[94m_58[0m + 96[95m][0m = 0
          [95mmem[[0m[94m_58[0m + 128[95m][0m = 0
          [94m_60[0m = [95mmem[[0m64[95m][0m
          [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
          [95mmem[[0m[94m_60[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
          [95mmem[[0m[94m_58[0m + 160[95m][0m = [94m_60[0m
          [94m_62[0m = [95mmem[[0m64[95m][0m
          [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
          [95mmem[[0m[94m_62[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
          [95mmem[[0m[94m_58[0m + 192[95m][0m = [94m_62[0m
          [94m_64[0m = [95mmem[[0m64[95m][0m
          [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
          [95mmem[[0m[94m_64[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
          [95mmem[[0m[94m_58[0m + 224[95m][0m = [94m_64[0m
          require [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[1m < [0m[32munknown26c1e750[0m[32m.length[0m
          [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m
          [95mmem[[0m32[95m][0m = 16
          [95mmem[[0m[94m_58[0m + 32[95m][0m = [32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_0[0m
          [94m_70[0m = [95mmem[[0m64[95m][0m
          [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
          [95mmem[[0m[94m_70[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
          [94mt[0m = 0
          [32mwhile [0m[94mt[0m[1m < [0m5[32m:[0m
              [95mmem[[0m(32[1m * [0m[94mt[0m) + [94m_70[0m[95m][0m = [38;5;8muint8([0m[32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_48[0m[1m / [0m2^(8[1m * [0m[94mt[0m)[38;5;8m)[0m
              [94mt[0m = [94mt[0m + 1
              [32mcontinue [0m
          [95mmem[[0m[94m_58[0m + 160[95m][0m = [94m_70[0m
          [94m_72[0m = [95mmem[[0m64[95m][0m
          [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
          [95mmem[[0m[94m_72[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
          [94mt[0m = 0
          [32mwhile [0m[94mt[0m[1m < [0m5[32m:[0m
              [95mmem[[0m(32[1m * [0m[94mt[0m) + [94m_72[0m[95m][0m = [38;5;8muint8([0m[32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_88[0m[1m / [0m2^(8[1m * [0m[94mt[0m)[38;5;8m)[0m
              [94mt[0m = [94mt[0m + 1
              [32mcontinue [0m
          [95mmem[[0m[94m_58[0m + 192[95m][0m = [94m_72[0m
          [95mmem[[0m[94m_58[0m + 96[95m][0m = [32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_128[0m
          [95mmem[[0m[94m_58[0m + 128[95m][0m = [32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_136[0m
          [95mmem[[0m[94m_58[0m[95m][0m = [32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_144[0m
          [95mmem[[0m[94m_58[0m + 64[95m][0m = [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_0[0m
          [94m_74[0m = [95mmem[[0m64[95m][0m
          [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
          [95mmem[[0m[94m_74[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
          [94mt[0m = 0
          [32mwhile [0m[94mt[0m[1m < [0m5[32m:[0m
              [95mmem[[0m(32[1m * [0m[94mt[0m) + [94m_74[0m[95m][0m = [38;5;8muint16([0m[32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_88[0m[1m / [0m2^(16[1m * [0m[94mt[0m)[38;5;8m)[0m
              [94mt[0m = [94mt[0m + 1
              [32mcontinue [0m
          [95mmem[[0m[94m_58[0m + 224[95m][0m = [94m_74[0m
          [94mu[0m = [94ms[0m
          [94mt[0m = 1
          [94mv[0m = 0
          [32mwhile [0m[94mt[0m[1m < [0m5[32m:[0m
              [94m_84[0m = [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_58[0m + 160[95m][0m[95m][0m
              if not [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_58[0m + 160[95m][0m[95m][0m:
                  [94ms[0m = [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_58[0m + 160[95m][0m[95m][0m
                  [94mt[0m = [94mt[0m
                  [94mt[0m = [94m_58[0m
                  [94midx[0m = [94midx[0m + 1
                  [32mcontinue [0m
              if [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_58[0m + 160[95m][0m[95m][0m[1m < [0mext_call.return_data[0]:
                  [94mu[0m = [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_58[0m + 160[95m][0m[95m][0m
                  [94mt[0m = [94mt[0m + 1
                  [94mv[0m = [94mv[0m
                  [32mcontinue [0m
              if [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_58[0m + 160[95m][0m[95m][0m[1m > [0mext_call.return_data[0] + ext_call.return_data[32] - 1:
                  [94mu[0m = [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_58[0m + 160[95m][0m[95m][0m
                  [94mt[0m = [94mt[0m + 1
                  [94mv[0m = [94mv[0m
                  [32mcontinue [0m
              require [94mv[0m[1m < [0m[95mmem[[0m1280[95m][0m
              [95mmem[[0m(32[1m * [0m[94mv[0m) + 1312[95m][0m = [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_58[0m + 160[95m][0m[95m][0m
              [94mu[0m = [94m_84[0m
              [94mt[0m = [94mt[0m + 1
              [94mv[0m = [94mv[0m + 1
              [32mcontinue [0m
          [94ms[0m = [94mu[0m
          [94mt[0m = [94mt[0m
          [94mt[0m = [94m_58[0m
          [94midx[0m = [94midx[0m + 1
          [32mcontinue [0m
  else:
      [95mmem[[0m1312[95m len [0m32[1m * [0m5[1m * [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[95m][0m = code.data[17173 len 32[1m * [0m5[1m * [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m]
      require ext_code.size([32munknown7c0f0ac9Address[0m)
      call [32munknown7c0f0ac9Address[0m.0xccf9bbb6 with:
           gas gas_remaining [38;5;8mwei[0m
          args [32m_param2[0m
      [95mmem[[0m(32[1m * [0m5[1m * [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m) + 1312[95m len [0m64[95m][0m = ext_call.return_data[0 len 64]
      if not ext_call.success:
          revert with ext_call.return_data[0 len return_data.size]
      [95mmem[[0m64[95m][0m = (32[1m * [0m5[1m * [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m) + ceil32(return_data.size) + 1312
      require return_data.size[1m >= [0m64
      [94ms[0m = 0
      [94mt[0m = 0
      [94mt[0m = 160
      [94midx[0m = 0
      [32mwhile [0m[94midx[0m[1m < [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m:[0m
          [95mmem[[0m32[95m][0m = 6
          require [94midx[0m[1m < [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m
          [95mmem[[0m0[95m][0m = sha3([38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m, 6)
          [94m_59[0m = [95mmem[[0m64[95m][0m
          [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 640
          [95mmem[[0m[94m_59[0m[95m][0m = 0
          [95mmem[[0m[94m_59[0m + 32[95m][0m = 0
          [95mmem[[0m[94m_59[0m + 64[95m][0m = 0
          [95mmem[[0m[94m_59[0m + 96[95m][0m = 0
          [95mmem[[0m[94m_59[0m + 128[95m][0m = 0
          [94m_61[0m = [95mmem[[0m64[95m][0m
          [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
          [95mmem[[0m[94m_61[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
          [95mmem[[0m[94m_59[0m + 160[95m][0m = [94m_61[0m
          [94m_63[0m = [95mmem[[0m64[95m][0m
          [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
          [95mmem[[0m[94m_63[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
          [95mmem[[0m[94m_59[0m + 192[95m][0m = [94m_63[0m
          [94m_65[0m = [95mmem[[0m64[95m][0m
          [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
          [95mmem[[0m[94m_65[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
          [95mmem[[0m[94m_59[0m + 224[95m][0m = [94m_65[0m
          require [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[1m < [0m[32munknown26c1e750[0m[32m.length[0m
          [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m
          [95mmem[[0m32[95m][0m = 16
          [95mmem[[0m[94m_59[0m + 32[95m][0m = [32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_0[0m
          [94m_71[0m = [95mmem[[0m64[95m][0m
          [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
          [95mmem[[0m[94m_71[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
          [94mt[0m = 0
          [32mwhile [0m[94mt[0m[1m < [0m5[32m:[0m
              [95mmem[[0m(32[1m * [0m[94mt[0m) + [94m_71[0m[95m][0m = [38;5;8muint8([0m[32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_48[0m[1m / [0m2^(8[1m * [0m[94mt[0m)[38;5;8m)[0m
              [94mt[0m = [94mt[0m + 1
              [32mcontinue [0m
          [95mmem[[0m[94m_59[0m + 160[95m][0m = [94m_71[0m
          [94m_73[0m = [95mmem[[0m64[95m][0m
          [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
          [95mmem[[0m[94m_73[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
          [94mt[0m = 0
          [32mwhile [0m[94mt[0m[1m < [0m5[32m:[0m
              [95mmem[[0m(32[1m * [0m[94mt[0m) + [94m_73[0m[95m][0m = [38;5;8muint8([0m[32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_88[0m[1m / [0m2^(8[1m * [0m[94mt[0m)[38;5;8m)[0m
              [94mt[0m = [94mt[0m + 1
              [32mcontinue [0m
          [95mmem[[0m[94m_59[0m + 192[95m][0m = [94m_73[0m
          [95mmem[[0m[94m_59[0m + 96[95m][0m = [32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_128[0m
          [95mmem[[0m[94m_59[0m + 128[95m][0m = [32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_136[0m
          [95mmem[[0m[94m_59[0m[95m][0m = [32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_144[0m
          [95mmem[[0m[94m_59[0m + 64[95m][0m = [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_0[0m
          [94m_75[0m = [95mmem[[0m64[95m][0m
          [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
          [95mmem[[0m[94m_75[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
          [94mt[0m = 0
          [32mwhile [0m[94mt[0m[1m < [0m5[32m:[0m
              [95mmem[[0m(32[1m * [0m[94mt[0m) + [94m_75[0m[95m][0m = [38;5;8muint16([0m[32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_88[0m[1m / [0m2^(16[1m * [0m[94mt[0m)[38;5;8m)[0m
              [94mt[0m = [94mt[0m + 1
              [32mcontinue [0m
          [95mmem[[0m[94m_59[0m + 224[95m][0m = [94m_75[0m
          [94mu[0m = [94ms[0m
          [94mt[0m = 1
          [94mv[0m = 0
          [32mwhile [0m[94mt[0m[1m < [0m5[32m:[0m
              [94m_85[0m = [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_59[0m + 160[95m][0m[95m][0m
              if not [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_59[0m + 160[95m][0m[95m][0m:
                  [94ms[0m = [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_59[0m + 160[95m][0m[95m][0m
                  [94mt[0m = [94mt[0m
                  [94mt[0m = [94m_59[0m
                  [94midx[0m = [94midx[0m + 1
                  [32mcontinue [0m
              if [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_59[0m + 160[95m][0m[95m][0m[1m < [0mext_call.return_data[0]:
                  [94mu[0m = [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_59[0m + 160[95m][0m[95m][0m
                  [94mt[0m = [94mt[0m + 1
                  [94mv[0m = [94mv[0m
                  [32mcontinue [0m
              if [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_59[0m + 160[95m][0m[95m][0m[1m > [0mext_call.return_data[0] + ext_call.return_data[32] - 1:
                  [94mu[0m = [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_59[0m + 160[95m][0m[95m][0m
                  [94mt[0m = [94mt[0m + 1
                  [94mv[0m = [94mv[0m
                  [32mcontinue [0m
              require [94mv[0m[1m < [0m[95mmem[[0m1280[95m][0m
              [95mmem[[0m(32[1m * [0m[94mv[0m) + 1312[95m][0m = [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_59[0m + 160[95m][0m[95m][0m
              [94mu[0m = [94m_85[0m
              [94mt[0m = [94mt[0m + 1
              [94mv[0m = [94mv[0m + 1
              [32mcontinue [0m
          [94ms[0m = [94mu[0m
          [94mt[0m = [94mt[0m
          [94mt[0m = [94m_59[0m
          [94midx[0m = [94midx[0m + 1
          [32mcontinue [0m
  return -1

[95mdef [0munknownf97fd58a(addr [32m_param1[0m, uint256 [32m_param2[0m): [38;5;8m# not payable[0m
  [95mmem[[0m96[95m][0m = 0
  [95mmem[[0m128[95m][0m = 0
  [95mmem[[0m160[95m][0m = 0
  [95mmem[[0m192[95m][0m = 0
  [95mmem[[0m224[95m][0m = 0
  [95mmem[[0m736[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m256[95m][0m = 736
  [95mmem[[0m896[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m288[95m][0m = 896
  [95mmem[[0m64[95m][0m = 1216
  [95mmem[[0m1056[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m320[95m][0m = 1056
  require [32mstor12[0m[32m[[0mcaller[32m][0m
  if [32m_param2[0m[1m <= [0m[32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m:
      [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m = 0
      [32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m = block.timestamp
      stop
  [95mmem[[0m1220[95m][0m = 34
  require ext_code.size([32munknown7c0f0ac9Address[0m)
  call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
       gas gas_remaining [38;5;8mwei[0m
      args 34
  [95mmem[[0m1216[95m][0m = ext_call.return_data[0]
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m32
  [95mmem[[0m0[95m][0m = [32m_param1[0m
  [95mmem[[0m32[95m][0m = 6
  [94ms[0m = 0
  [94ms[0m = 96
  [94midx[0m = 0
  [94ms[0m = 24[1m * [0m3600[1m * [0m[32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m
  [32mwhile [0m[94midx[0m[1m < [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m:[0m
      [95mmem[[0m32[95m][0m = 6
      require [94midx[0m[1m < [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m
      [95mmem[[0m0[95m][0m = sha3([38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m, 6)
      [94m_64[0m = [95mmem[[0m64[95m][0m
      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 640
      [95mmem[[0m[94m_64[0m[95m][0m = 0
      [95mmem[[0m[94m_64[0m + 32[95m][0m = 0
      [95mmem[[0m[94m_64[0m + 64[95m][0m = 0
      [95mmem[[0m[94m_64[0m + 96[95m][0m = 0
      [95mmem[[0m[94m_64[0m + 128[95m][0m = 0
      [94m_65[0m = [95mmem[[0m64[95m][0m
      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
      [95mmem[[0m[94m_65[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
      [95mmem[[0m[94m_64[0m + 160[95m][0m = [94m_65[0m
      [94m_66[0m = [95mmem[[0m64[95m][0m
      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
      [95mmem[[0m[94m_66[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
      [95mmem[[0m[94m_64[0m + 192[95m][0m = [94m_66[0m
      [94m_67[0m = [95mmem[[0m64[95m][0m
      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
      [95mmem[[0m[94m_67[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
      [95mmem[[0m[94m_64[0m + 224[95m][0m = [94m_67[0m
      require [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[1m < [0m[32munknown26c1e750[0m[32m.length[0m
      [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m
      [95mmem[[0m32[95m][0m = 16
      [95mmem[[0m[94m_64[0m + 32[95m][0m = [32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_0[0m
      [94m_70[0m = [95mmem[[0m64[95m][0m
      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
      [95mmem[[0m[94m_70[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
      [94mt[0m = 0
      [32mwhile [0m[94mt[0m[1m < [0m5[32m:[0m
          [95mmem[[0m(32[1m * [0m[94mt[0m) + [94m_70[0m[95m][0m = [38;5;8muint8([0m[32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_48[0m[1m / [0m2^(8[1m * [0m[94mt[0m)[38;5;8m)[0m
          [94mt[0m = [94mt[0m + 1
          [32mcontinue [0m
      [95mmem[[0m[94m_64[0m + 160[95m][0m = [94m_70[0m
      [94m_71[0m = [95mmem[[0m64[95m][0m
      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
      [95mmem[[0m[94m_71[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
      [94mt[0m = 0
      [32mwhile [0m[94mt[0m[1m < [0m5[32m:[0m
          [95mmem[[0m(32[1m * [0m[94mt[0m) + [94m_71[0m[95m][0m = [38;5;8muint8([0m[32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_88[0m[1m / [0m2^(8[1m * [0m[94mt[0m)[38;5;8m)[0m
          [94mt[0m = [94mt[0m + 1
          [32mcontinue [0m
      [95mmem[[0m[94m_64[0m + 192[95m][0m = [94m_71[0m
      [95mmem[[0m[94m_64[0m + 96[95m][0m = [32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_128[0m
      [95mmem[[0m[94m_64[0m + 128[95m][0m = [32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_136[0m
      [95mmem[[0m[94m_64[0m[95m][0m = [32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_144[0m
      [95mmem[[0m[94m_64[0m + 64[95m][0m = [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_0[0m
      [94m_72[0m = [95mmem[[0m64[95m][0m
      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
      [95mmem[[0m[94m_72[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
      [94mt[0m = 0
      [32mwhile [0m[94mt[0m[1m < [0m5[32m:[0m
          [95mmem[[0m(32[1m * [0m[94mt[0m) + [94m_72[0m[95m][0m = [38;5;8muint16([0m[32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[32m[[0m[94midx[0m[32m][0m[32m][0m[32m.field_88[0m[1m / [0m2^(16[1m * [0m[94mt[0m)[38;5;8m)[0m
          [94mt[0m = [94mt[0m + 1
          [32mcontinue [0m
      [95mmem[[0m[94m_64[0m + 224[95m][0m = [94m_72[0m
      [95mmem[[0m0[95m][0m = [32m_param1[0m
      [95mmem[[0m32[95m][0m = 24
      if [95mmem[[0m[94m_64[0m + 64[95m][0m[1m > [0m[32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m:
          [94m_75[0m = [95mmem[[0m[94m_64[0m + 64[95m][0m
          [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 17
          require ext_code.size([32munknown7c0f0ac9Address[0m)
          call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
               gas gas_remaining [38;5;8mwei[0m
              args 17
          [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = ext_call.return_data[0]
          if not ext_call.success:
              revert with ext_call.return_data[0 len return_data.size]
          require return_data.size[1m >= [0m32
          if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m) - ([94m_75[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m)[1m % [0m48[1m * [0m24[1m * [0m3600[1m < [0m24[1m * [0m3600:
              if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_72[0m[95m][0m[1m * [0mext_call.return_data[0]) - ([94m_75[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_72[0m[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m) - ([94m_75[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([94m_75[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m) - ([94m_75[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) + [94ms[0m[1m < [0m24[1m * [0m3600[1m * [0m[32m_param2[0m:
                  [94ms[0m = (block.timestamp[1m * [0mext_call.return_data[0]) - ([94m_75[0m[1m * [0mext_call.return_data[0])
                  [94ms[0m = [94m_64[0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_72[0m[95m][0m[1m * [0mext_call.return_data[0]) - ([94m_75[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_72[0m[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m) - ([94m_75[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([94m_75[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m) - ([94m_75[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) + [94ms[0m
                  [32mcontinue [0m
          else:
              if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([94m_75[0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_72[0m[95m][0m[1m * [0mext_call.return_data[0]) - ([94m_75[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_72[0m[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m) - ([94m_75[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([94m_75[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m) - ([94m_75[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) + [94ms[0m[1m < [0m24[1m * [0m3600[1m * [0m[32m_param2[0m:
                  [94ms[0m = (block.timestamp[1m * [0mext_call.return_data[0]) - ([94m_75[0m[1m * [0mext_call.return_data[0])
                  [94ms[0m = [94m_64[0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = (block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([94m_75[0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_72[0m[95m][0m[1m * [0mext_call.return_data[0]) - ([94m_75[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_72[0m[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m) - ([94m_75[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([94m_75[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m) - ([94m_75[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) + [94ms[0m
                  [32mcontinue [0m
      else:
          [95mmem[[0m0[95m][0m = [32m_param1[0m
          [95mmem[[0m32[95m][0m = 24
          [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 17
          require ext_code.size([32munknown7c0f0ac9Address[0m)
          call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
               gas gas_remaining [38;5;8mwei[0m
              args 17
          [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = ext_call.return_data[0]
          if not ext_call.success:
              revert with ext_call.return_data[0 len return_data.size]
          require return_data.size[1m >= [0m32
          if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m)[1m % [0m48[1m * [0m24[1m * [0m3600[1m < [0m24[1m * [0m3600:
              if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_72[0m[95m][0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_72[0m[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) + [94ms[0m[1m < [0m24[1m * [0m3600[1m * [0m[32m_param2[0m:
                  [94ms[0m = (block.timestamp[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0])
                  [94ms[0m = [94m_64[0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_72[0m[95m][0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_72[0m[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) + [94ms[0m
                  [32mcontinue [0m
          else:
              if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_72[0m[95m][0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_72[0m[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) + [94ms[0m[1m < [0m24[1m * [0m3600[1m * [0m[32m_param2[0m:
                  [94ms[0m = (block.timestamp[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0])
                  [94ms[0m = [94m_64[0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = (block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_72[0m[95m][0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[94m_72[0m[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_64[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) + [94ms[0m
                  [32mcontinue [0m
      [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m = 0
      [32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m = block.timestamp
      stop
  revert with 0, 'NotEnoughKnowledge'

[95mdef [0munknownaac0b776(addr [32m_param1[0m, uint256 [32m_param2[0m): [38;5;8m# not payable[0m
  [95mmem[[0m96[95m][0m = 0
  [95mmem[[0m128[95m][0m = 0
  [95mmem[[0m160[95m][0m = 0
  [95mmem[[0m192[95m][0m = 0
  [95mmem[[0m224[95m][0m = 0
  [95mmem[[0m736[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m256[95m][0m = 736
  [95mmem[[0m896[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m288[95m][0m = 896
  [95mmem[[0m1056[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m320[95m][0m = 1056
  require [32mstor12[0m[32m[[0mcaller[32m][0m
  [95mmem[[0m1856[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m2016[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m2176[95m len [0m160[95m][0m = code.data[17173 len 160]
  require [32m_param2[0m[1m < [0m[32munknown26c1e750[0m[32m.length[0m
  [95mmem[[0m1248[95m][0m = [32munknown26c1e750[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m
  [95mmem[[0m2336[95m len [0m160[95m][0m = code.data[17173 len 160]
  [94midx[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [95mmem[[0m(32[1m * [0m[94midx[0m) + 2336[95m][0m = [38;5;8muint8([0m[32munknown26c1e750[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_48[0m[1m / [0m2^(8[1m * [0m[94midx[0m)[38;5;8m)[0m
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  [95mmem[[0m1376[95m][0m = 2336
  [95mmem[[0m2496[95m len [0m160[95m][0m = code.data[17173 len 160]
  [94midx[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [95mmem[[0m(32[1m * [0m[94midx[0m) + 2496[95m][0m = [38;5;8muint8([0m[32munknown26c1e750[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_88[0m[1m / [0m2^(8[1m * [0m[94midx[0m)[38;5;8m)[0m
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  [95mmem[[0m1408[95m][0m = 2496
  [95mmem[[0m1312[95m][0m = [32munknown26c1e750[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_128[0m
  [95mmem[[0m1344[95m][0m = [32munknown26c1e750[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_136[0m
  [95mmem[[0m1216[95m][0m = [32munknown26c1e750[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_144[0m
  [95mmem[[0m1280[95m][0m = [32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m
  [95mmem[[0m2656[95m len [0m160[95m][0m = code.data[17173 len 160]
  [94midx[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [95mmem[[0m(32[1m * [0m[94midx[0m) + 2656[95m][0m = [38;5;8muint16([0m[32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_88[0m[1m / [0m2^(16[1m * [0m[94midx[0m)[38;5;8m)[0m
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  [95mmem[[0m1440[95m][0m = 2656
  [95mmem[[0m2816[95m][0m = 0
  [95mmem[[0m2848[95m][0m = 0
  [95mmem[[0m2880[95m][0m = 0
  [95mmem[[0m2912[95m][0m = 0
  [95mmem[[0m2944[95m][0m = 0
  [95mmem[[0m3456[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m2976[95m][0m = 3456
  [95mmem[[0m3616[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m3008[95m][0m = 3616
  [95mmem[[0m64[95m][0m = 3936
  [95mmem[[0m3776[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m3040[95m][0m = 3776
  require ext_code.size([32munknown7c0f0ac9Address[0m)
  call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
       gas gas_remaining [38;5;8mwei[0m
      args 34
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m32
  require ext_code.size([32munknown7c0f0ac9Address[0m)
  call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
       gas gas_remaining [38;5;8mwei[0m
      args 17
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m32
  [95mmem[[0m0[95m][0m = [32m_param1[0m
  [95mmem[[0m32[95m][0m = 23
  if [32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m > [0m[32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m:
      if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m % [0m48[1m * [0m24[1m * [0m3600[1m < [0m24[1m * [0m3600:
          if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
              [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m += (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600
              [95mmem[[0m3940[95m][0m = 18
              require ext_code.size([32munknown7c0f0ac9Address[0m)
              call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                   gas gas_remaining [38;5;8mwei[0m
                  args 18
              [95mmem[[0m3936[95m][0m = ext_call.return_data[0]
              if not ext_call.success:
                  revert with ext_call.return_data[0 len return_data.size]
              require return_data.size[1m >= [0m32
              [94midx[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m:
                      require [94midx[0m[1m < [0m5
                      require [94midx[0m[1m < [0m5
                      if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                      else:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m + 1
                      if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                          require [94midx[0m[1m < [0m5
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                  [94midx[0m = [94midx[0m + 1
                  [32mcontinue [0m
              [95mmem[[0m1280[95m][0m = block.timestamp
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1376[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94m_431[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_431[0m)
          else:
              [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600) + [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m + 1
              [95mmem[[0m3940[95m][0m = 18
              require ext_code.size([32munknown7c0f0ac9Address[0m)
              call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                   gas gas_remaining [38;5;8mwei[0m
                  args 18
              [95mmem[[0m3936[95m][0m = ext_call.return_data[0]
              if not ext_call.success:
                  revert with ext_call.return_data[0 len return_data.size]
              require return_data.size[1m >= [0m32
              [94midx[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m:
                      require [94midx[0m[1m < [0m5
                      require [94midx[0m[1m < [0m5
                      if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                      else:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m + 1
                      if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                          require [94midx[0m[1m < [0m5
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                  [94midx[0m = [94midx[0m + 1
                  [32mcontinue [0m
              [95mmem[[0m1280[95m][0m = block.timestamp
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1376[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94m_432[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_432[0m)
      else:
          if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
              [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m += (block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600
              [95mmem[[0m3940[95m][0m = 18
              require ext_code.size([32munknown7c0f0ac9Address[0m)
              call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                   gas gas_remaining [38;5;8mwei[0m
                  args 18
              [95mmem[[0m3936[95m][0m = ext_call.return_data[0]
              if not ext_call.success:
                  revert with ext_call.return_data[0 len return_data.size]
              require return_data.size[1m >= [0m32
              [94midx[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m:
                      require [94midx[0m[1m < [0m5
                      require [94midx[0m[1m < [0m5
                      if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                      else:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m + 1
                      if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                          require [94midx[0m[1m < [0m5
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                  [94midx[0m = [94midx[0m + 1
                  [32mcontinue [0m
              [95mmem[[0m1280[95m][0m = block.timestamp
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1376[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94m_433[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_433[0m)
          else:
              [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600) + [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m + 1
              [95mmem[[0m3940[95m][0m = 18
              require ext_code.size([32munknown7c0f0ac9Address[0m)
              call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                   gas gas_remaining [38;5;8mwei[0m
                  args 18
              [95mmem[[0m3936[95m][0m = ext_call.return_data[0]
              if not ext_call.success:
                  revert with ext_call.return_data[0 len return_data.size]
              require return_data.size[1m >= [0m32
              [94midx[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m:
                      require [94midx[0m[1m < [0m5
                      require [94midx[0m[1m < [0m5
                      if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                      else:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m + 1
                      if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                          require [94midx[0m[1m < [0m5
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                  [94midx[0m = [94midx[0m + 1
                  [32mcontinue [0m
              [95mmem[[0m1280[95m][0m = block.timestamp
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1376[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94m_434[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_434[0m)
  else:
      if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m % [0m48[1m * [0m24[1m * [0m3600[1m < [0m24[1m * [0m3600:
          if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
              [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m += (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600
              [95mmem[[0m3940[95m][0m = 18
              require ext_code.size([32munknown7c0f0ac9Address[0m)
              call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                   gas gas_remaining [38;5;8mwei[0m
                  args 18
              [95mmem[[0m3936[95m][0m = ext_call.return_data[0]
              if not ext_call.success:
                  revert with ext_call.return_data[0 len return_data.size]
              require return_data.size[1m >= [0m32
              [94midx[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m:
                      require [94midx[0m[1m < [0m5
                      require [94midx[0m[1m < [0m5
                      if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                      else:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m + 1
                      if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                          require [94midx[0m[1m < [0m5
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                  [94midx[0m = [94midx[0m + 1
                  [32mcontinue [0m
              [95mmem[[0m1280[95m][0m = block.timestamp
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1376[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94m_435[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_435[0m)
          else:
              [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600) + [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m + 1
              [95mmem[[0m3940[95m][0m = 18
              require ext_code.size([32munknown7c0f0ac9Address[0m)
              call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                   gas gas_remaining [38;5;8mwei[0m
                  args 18
              [95mmem[[0m3936[95m][0m = ext_call.return_data[0]
              if not ext_call.success:
                  revert with ext_call.return_data[0 len return_data.size]
              require return_data.size[1m >= [0m32
              [94midx[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m:
                      require [94midx[0m[1m < [0m5
                      require [94midx[0m[1m < [0m5
                      if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                      else:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m + 1
                      if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                          require [94midx[0m[1m < [0m5
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                  [94midx[0m = [94midx[0m + 1
                  [32mcontinue [0m
              [95mmem[[0m1280[95m][0m = block.timestamp
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1376[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94m_436[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_436[0m)
      else:
          if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
              [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m += (block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600
              [95mmem[[0m3940[95m][0m = 18
              require ext_code.size([32munknown7c0f0ac9Address[0m)
              call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                   gas gas_remaining [38;5;8mwei[0m
                  args 18
              [95mmem[[0m3936[95m][0m = ext_call.return_data[0]
              if not ext_call.success:
                  revert with ext_call.return_data[0 len return_data.size]
              require return_data.size[1m >= [0m32
              [94midx[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m:
                      require [94midx[0m[1m < [0m5
                      require [94midx[0m[1m < [0m5
                      if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                      else:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m + 1
                      if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                          require [94midx[0m[1m < [0m5
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                  [94midx[0m = [94midx[0m + 1
                  [32mcontinue [0m
              [95mmem[[0m1280[95m][0m = block.timestamp
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1376[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94m_437[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_437[0m)
          else:
              [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600) + [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m + 1
              [95mmem[[0m3940[95m][0m = 18
              require ext_code.size([32munknown7c0f0ac9Address[0m)
              call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                   gas gas_remaining [38;5;8mwei[0m
                  args 18
              [95mmem[[0m3936[95m][0m = ext_call.return_data[0]
              if not ext_call.success:
                  revert with ext_call.return_data[0 len return_data.size]
              require return_data.size[1m >= [0m32
              [94midx[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m:
                      require [94midx[0m[1m < [0m5
                      require [94midx[0m[1m < [0m5
                      if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                      else:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m + 1
                      if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                          require [94midx[0m[1m < [0m5
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                  [94midx[0m = [94midx[0m + 1
                  [32mcontinue [0m
              [95mmem[[0m1280[95m][0m = block.timestamp
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1376[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94m_438[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_438[0m)
  [32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_168[0m = 0

[95mdef [0munknown189052f1(addr [32m_param1[0m, uint256 [32m_param2[0m, uint256 [32m_param3[0m, uint256 [32m_param4[0m): [38;5;8m# not payable[0m
  [95mmem[[0m96[95m][0m = 0
  [95mmem[[0m128[95m][0m = 0
  [95mmem[[0m160[95m][0m = 0
  [95mmem[[0m192[95m][0m = 0
  [95mmem[[0m224[95m][0m = 0
  [95mmem[[0m736[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m256[95m][0m = 736
  [95mmem[[0m896[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m288[95m][0m = 896
  [95mmem[[0m1056[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m320[95m][0m = 1056
  require [32mstor12[0m[32m[[0mcaller[32m][0m
  if not [32m_param1[0m:
      revert with 0, 'Owner param should be defined'
  if [32m_param4[0m[1m <= [0m0:
      revert with 0, 'ResourceValue param should be bigger that zero'
  [95mmem[[0m1856[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m2016[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m2176[95m len [0m160[95m][0m = code.data[17173 len 160]
  require [32m_param2[0m[1m < [0m[32munknown26c1e750[0m[32m.length[0m
  [95mmem[[0m1248[95m][0m = [32munknown26c1e750[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m
  [95mmem[[0m2336[95m len [0m160[95m][0m = code.data[17173 len 160]
  [94midx[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [95mmem[[0m(32[1m * [0m[94midx[0m) + 2336[95m][0m = [38;5;8muint8([0m[32munknown26c1e750[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_48[0m[1m / [0m2^(8[1m * [0m[94midx[0m)[38;5;8m)[0m
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  [95mmem[[0m1376[95m][0m = 2336
  [95mmem[[0m2496[95m len [0m160[95m][0m = code.data[17173 len 160]
  [94midx[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [95mmem[[0m(32[1m * [0m[94midx[0m) + 2496[95m][0m = [38;5;8muint8([0m[32munknown26c1e750[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_88[0m[1m / [0m2^(8[1m * [0m[94midx[0m)[38;5;8m)[0m
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  [95mmem[[0m1408[95m][0m = 2496
  [95mmem[[0m1312[95m][0m = [32munknown26c1e750[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_128[0m
  [95mmem[[0m1344[95m][0m = [32munknown26c1e750[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_136[0m
  [95mmem[[0m1216[95m][0m = [32munknown26c1e750[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_144[0m
  [95mmem[[0m1280[95m][0m = [32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m
  [95mmem[[0m2656[95m len [0m160[95m][0m = code.data[17173 len 160]
  [94midx[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      [95mmem[[0m(32[1m * [0m[94midx[0m) + 2656[95m][0m = [38;5;8muint16([0m[32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_88[0m[1m / [0m2^(16[1m * [0m[94midx[0m)[38;5;8m)[0m
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  [95mmem[[0m1440[95m][0m = 2656
  [95mmem[[0m2816[95m][0m = 0
  [95mmem[[0m2848[95m][0m = 0
  [95mmem[[0m2880[95m][0m = 0
  [95mmem[[0m2912[95m][0m = 0
  [95mmem[[0m2944[95m][0m = 0
  [95mmem[[0m3456[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m2976[95m][0m = 3456
  [95mmem[[0m3616[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m3008[95m][0m = 3616
  [95mmem[[0m64[95m][0m = 3936
  [95mmem[[0m3776[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m3040[95m][0m = 3776
  require ext_code.size([32munknown7c0f0ac9Address[0m)
  call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
       gas gas_remaining [38;5;8mwei[0m
      args 34
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m32
  require ext_code.size([32munknown7c0f0ac9Address[0m)
  call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
       gas gas_remaining [38;5;8mwei[0m
      args 17
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m32
  [95mmem[[0m0[95m][0m = [32m_param1[0m
  [95mmem[[0m32[95m][0m = 23
  if [32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m > [0m[32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m:
      if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m % [0m48[1m * [0m24[1m * [0m3600[1m < [0m24[1m * [0m3600:
          if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
              [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m += (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600
              [95mmem[[0m3940[95m][0m = 18
              require ext_code.size([32munknown7c0f0ac9Address[0m)
              call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                   gas gas_remaining [38;5;8mwei[0m
                  args 18
              [95mmem[[0m3936[95m][0m = ext_call.return_data[0]
              if not ext_call.success:
                  revert with ext_call.return_data[0 len return_data.size]
              require return_data.size[1m >= [0m32
              [94midx[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m:
                      require [94midx[0m[1m < [0m5
                      require [94midx[0m[1m < [0m5
                      if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                      else:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m + 1
                      if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                          require [94midx[0m[1m < [0m5
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                  [94midx[0m = [94midx[0m + 1
                  [32mcontinue [0m
              require [32m_param3[0m[1m < [0m5
              if [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m < [0m[32m_param4[0m:
                  revert with 0, 'Resource current should be bigger that ResourceValue'
              require [32m_param3[0m[1m < [0m5
              [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m - [32m_param4[0m
              [95mmem[[0m1280[95m][0m = block.timestamp
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1376[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94m_483[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_483[0m)
          else:
              [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600) + [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m + 1
              [95mmem[[0m3940[95m][0m = 18
              require ext_code.size([32munknown7c0f0ac9Address[0m)
              call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                   gas gas_remaining [38;5;8mwei[0m
                  args 18
              [95mmem[[0m3936[95m][0m = ext_call.return_data[0]
              if not ext_call.success:
                  revert with ext_call.return_data[0 len return_data.size]
              require return_data.size[1m >= [0m32
              [94midx[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m:
                      require [94midx[0m[1m < [0m5
                      require [94midx[0m[1m < [0m5
                      if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                      else:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m + 1
                      if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                          require [94midx[0m[1m < [0m5
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                  [94midx[0m = [94midx[0m + 1
                  [32mcontinue [0m
              require [32m_param3[0m[1m < [0m5
              if [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m < [0m[32m_param4[0m:
                  revert with 0, 'Resource current should be bigger that ResourceValue'
              require [32m_param3[0m[1m < [0m5
              [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m - [32m_param4[0m
              [95mmem[[0m1280[95m][0m = block.timestamp
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1376[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94m_484[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_484[0m)
      else:
          if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
              [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m += (block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600
              [95mmem[[0m3940[95m][0m = 18
              require ext_code.size([32munknown7c0f0ac9Address[0m)
              call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                   gas gas_remaining [38;5;8mwei[0m
                  args 18
              [95mmem[[0m3936[95m][0m = ext_call.return_data[0]
              if not ext_call.success:
                  revert with ext_call.return_data[0 len return_data.size]
              require return_data.size[1m >= [0m32
              [94midx[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m:
                      require [94midx[0m[1m < [0m5
                      require [94midx[0m[1m < [0m5
                      if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                      else:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m + 1
                      if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                          require [94midx[0m[1m < [0m5
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                  [94midx[0m = [94midx[0m + 1
                  [32mcontinue [0m
              require [32m_param3[0m[1m < [0m5
              if [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m < [0m[32m_param4[0m:
                  revert with 0, 'Resource current should be bigger that ResourceValue'
              require [32m_param3[0m[1m < [0m5
              [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m - [32m_param4[0m
              [95mmem[[0m1280[95m][0m = block.timestamp
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1376[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94m_485[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_485[0m)
          else:
              [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600) + [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m + 1
              [95mmem[[0m3940[95m][0m = 18
              require ext_code.size([32munknown7c0f0ac9Address[0m)
              call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                   gas gas_remaining [38;5;8mwei[0m
                  args 18
              [95mmem[[0m3936[95m][0m = ext_call.return_data[0]
              if not ext_call.success:
                  revert with ext_call.return_data[0 len return_data.size]
              require return_data.size[1m >= [0m32
              [94midx[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m:
                      require [94midx[0m[1m < [0m5
                      require [94midx[0m[1m < [0m5
                      if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                      else:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m + 1
                      if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                          require [94midx[0m[1m < [0m5
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                  [94midx[0m = [94midx[0m + 1
                  [32mcontinue [0m
              require [32m_param3[0m[1m < [0m5
              if [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m < [0m[32m_param4[0m:
                  revert with 0, 'Resource current should be bigger that ResourceValue'
              require [32m_param3[0m[1m < [0m5
              [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m - [32m_param4[0m
              [95mmem[[0m1280[95m][0m = block.timestamp
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1376[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94m_486[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_486[0m)
  else:
      if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m % [0m48[1m * [0m24[1m * [0m3600[1m < [0m24[1m * [0m3600:
          if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
              [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m += (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600
              [95mmem[[0m3940[95m][0m = 18
              require ext_code.size([32munknown7c0f0ac9Address[0m)
              call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                   gas gas_remaining [38;5;8mwei[0m
                  args 18
              [95mmem[[0m3936[95m][0m = ext_call.return_data[0]
              if not ext_call.success:
                  revert with ext_call.return_data[0 len return_data.size]
              require return_data.size[1m >= [0m32
              [94midx[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m:
                      require [94midx[0m[1m < [0m5
                      require [94midx[0m[1m < [0m5
                      if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                      else:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m + 1
                      if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                          require [94midx[0m[1m < [0m5
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                  [94midx[0m = [94midx[0m + 1
                  [32mcontinue [0m
              require [32m_param3[0m[1m < [0m5
              if [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m < [0m[32m_param4[0m:
                  revert with 0, 'Resource current should be bigger that ResourceValue'
              require [32m_param3[0m[1m < [0m5
              [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m - [32m_param4[0m
              [95mmem[[0m1280[95m][0m = block.timestamp
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1376[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94m_487[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_487[0m)
          else:
              [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600) + [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m + 1
              [95mmem[[0m3940[95m][0m = 18
              require ext_code.size([32munknown7c0f0ac9Address[0m)
              call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                   gas gas_remaining [38;5;8mwei[0m
                  args 18
              [95mmem[[0m3936[95m][0m = ext_call.return_data[0]
              if not ext_call.success:
                  revert with ext_call.return_data[0 len return_data.size]
              require return_data.size[1m >= [0m32
              [94midx[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m:
                      require [94midx[0m[1m < [0m5
                      require [94midx[0m[1m < [0m5
                      if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                      else:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m + 1
                      if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                          require [94midx[0m[1m < [0m5
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                  [94midx[0m = [94midx[0m + 1
                  [32mcontinue [0m
              require [32m_param3[0m[1m < [0m5
              if [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m < [0m[32m_param4[0m:
                  revert with 0, 'Resource current should be bigger that ResourceValue'
              require [32m_param3[0m[1m < [0m5
              [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m - [32m_param4[0m
              [95mmem[[0m1280[95m][0m = block.timestamp
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1376[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94m_488[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_488[0m)
      else:
          if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
              [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m += (block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600
              [95mmem[[0m3940[95m][0m = 18
              require ext_code.size([32munknown7c0f0ac9Address[0m)
              call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                   gas gas_remaining [38;5;8mwei[0m
                  args 18
              [95mmem[[0m3936[95m][0m = ext_call.return_data[0]
              if not ext_call.success:
                  revert with ext_call.return_data[0 len return_data.size]
              require return_data.size[1m >= [0m32
              [94midx[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m:
                      require [94midx[0m[1m < [0m5
                      require [94midx[0m[1m < [0m5
                      if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                      else:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m + 1
                      if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                          require [94midx[0m[1m < [0m5
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                  [94midx[0m = [94midx[0m + 1
                  [32mcontinue [0m
              require [32m_param3[0m[1m < [0m5
              if [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m < [0m[32m_param4[0m:
                  revert with 0, 'Resource current should be bigger that ResourceValue'
              require [32m_param3[0m[1m < [0m5
              [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m - [32m_param4[0m
              [95mmem[[0m1280[95m][0m = block.timestamp
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1376[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94m_489[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_489[0m)
          else:
              [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2656[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m2496[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600) + [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0m[32m_param1[0m[38;5;8m)[0m[32m][0m + 1
              [95mmem[[0m3940[95m][0m = 18
              require ext_code.size([32munknown7c0f0ac9Address[0m)
              call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                   gas gas_remaining [38;5;8mwei[0m
                  args 18
              [95mmem[[0m3936[95m][0m = ext_call.return_data[0]
              if not ext_call.success:
                  revert with ext_call.return_data[0 len return_data.size]
              require return_data.size[1m >= [0m32
              [94midx[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m:
                      require [94midx[0m[1m < [0m5
                      require [94midx[0m[1m < [0m5
                      if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                      else:
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m) - ([32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m + 1
                      if [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                          require [94midx[0m[1m < [0m5
                          [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1408[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                  [94midx[0m = [94midx[0m + 1
                  [32mcontinue [0m
              require [32m_param3[0m[1m < [0m5
              if [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m < [0m[32m_param4[0m:
                  revert with 0, 'Resource current should be bigger that ResourceValue'
              require [32m_param3[0m[1m < [0m5
              [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[32m_param3[0m) + [95mmem[[0m1440[95m][0m[95m][0m - [32m_param4[0m
              [95mmem[[0m1280[95m][0m = block.timestamp
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1376[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [94midx[0m = 0
              [94ms[0m = 0
              [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                  [94m_490[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m
                  [94midx[0m = [94midx[0m + 1
                  [94ms[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m1440[95m][0m[95m][0m[1m or [0m[94ms[0m
                  [32mcontinue [0m
              [32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_490[0m)
  [32mstor16[0m[32m[[0m[32m_param2[0m[32m][0m[32m.field_168[0m = 0

[95mdef [0munknowncd216f0e(): [38;5;8m# not payable[0m
  [95mmem[[0m96[95m][0m = 0
  [95mmem[[0m128[95m][0m = 0
  [95mmem[[0m160[95m][0m = 0
  [95mmem[[0m192[95m][0m = 0
  [95mmem[[0m224[95m][0m = 0
  [95mmem[[0m736[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m256[95m][0m = 736
  [95mmem[[0m896[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m288[95m][0m = 896
  [95mmem[[0m64[95m][0m = 1216
  [95mmem[[0m1056[95m len [0m160[95m][0m = code.data[17173 len 160]
  [95mmem[[0m320[95m][0m = 1056
  require [32mstor12[0m[32m[[0mcaller[32m][0m
  [95mmem[[0m0[95m][0m = [38;5;8maddr([0mcd[4][38;5;8m)[0m
  [95mmem[[0m32[95m][0m = 6
  [94ms[0m = 0
  [94ms[0m = 0
  [94midx[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
      if cd[((32[1m * [0m[94midx[0m) + 196)]:
          [94mt[0m = 0
          [94mt[0m = 0
          [94mt[0m = 96
          [94mt[0m = 0
          [94ms[0m = 0
          [32mwhile [0m[94ms[0m[1m < [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m:[0m
              if not cd[((32[1m * [0m[94midx[0m) + 196)]:
                  if cd[((32[1m * [0m[94midx[0m) + 196)][1m > [0m0:
                      revert with 0, 'NotEnoughResources'
                  [94ms[0m = cd[((32[1m * [0m[94midx[0m) + 196)]
                  [94ms[0m = cd[((32[1m * [0m[94midx[0m) + 36)]
                  [94midx[0m = [94midx[0m + 1
                  [32mcontinue [0m
              [95mmem[[0m32[95m][0m = 6
              require [94ms[0m[1m < [0m[32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m
              [95mmem[[0m0[95m][0m = sha3([38;5;8maddr([0mcd[4][38;5;8m)[0m, 6)
              [94m_493[0m = [95mmem[[0m64[95m][0m
              [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 640
              [95mmem[[0m[94m_493[0m[95m][0m = 0
              [95mmem[[0m[94m_493[0m + 32[95m][0m = 0
              [95mmem[[0m[94m_493[0m + 64[95m][0m = 0
              [95mmem[[0m[94m_493[0m + 96[95m][0m = 0
              [95mmem[[0m[94m_493[0m + 128[95m][0m = 0
              [94m_494[0m = [95mmem[[0m64[95m][0m
              [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
              [95mmem[[0m[94m_494[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
              [95mmem[[0m[94m_493[0m + 160[95m][0m = [94m_494[0m
              [94m_495[0m = [95mmem[[0m64[95m][0m
              [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
              [95mmem[[0m[94m_495[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
              [95mmem[[0m[94m_493[0m + 192[95m][0m = [94m_495[0m
              [94m_496[0m = [95mmem[[0m64[95m][0m
              [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
              [95mmem[[0m[94m_496[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
              [95mmem[[0m[94m_493[0m + 224[95m][0m = [94m_496[0m
              require [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[1m < [0m[32munknown26c1e750[0m[32m.length[0m
              [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
              [95mmem[[0m32[95m][0m = 16
              [95mmem[[0m[94m_493[0m + 32[95m][0m = [32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m
              [94m_499[0m = [95mmem[[0m64[95m][0m
              [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
              [95mmem[[0m[94m_499[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
              [94mt[0m = 0
              [32mwhile [0m[94mt[0m[1m < [0m5[32m:[0m
                  [95mmem[[0m(32[1m * [0m[94mt[0m) + [94m_499[0m[95m][0m = [38;5;8muint8([0m[32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_48[0m[1m / [0m2^(8[1m * [0m[94mt[0m)[38;5;8m)[0m
                  [94mt[0m = [94mt[0m + 1
                  [32mcontinue [0m
              [95mmem[[0m[94m_493[0m + 160[95m][0m = [94m_499[0m
              [94m_500[0m = [95mmem[[0m64[95m][0m
              [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
              [95mmem[[0m[94m_500[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
              [94mt[0m = 0
              [32mwhile [0m[94mt[0m[1m < [0m5[32m:[0m
                  [95mmem[[0m(32[1m * [0m[94mt[0m) + [94m_500[0m[95m][0m = [38;5;8muint8([0m[32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_88[0m[1m / [0m2^(8[1m * [0m[94mt[0m)[38;5;8m)[0m
                  [94mt[0m = [94mt[0m + 1
                  [32mcontinue [0m
              [95mmem[[0m[94m_493[0m + 192[95m][0m = [94m_500[0m
              [95mmem[[0m[94m_493[0m + 96[95m][0m = [32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_128[0m
              [95mmem[[0m[94m_493[0m + 128[95m][0m = [32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_136[0m
              [95mmem[[0m[94m_493[0m[95m][0m = [32munknown26c1e750[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_144[0m
              [95mmem[[0m[94m_493[0m + 64[95m][0m = [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m
              [94m_501[0m = [95mmem[[0m64[95m][0m
              [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
              [95mmem[[0m[94m_501[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
              [94mt[0m = 0
              [32mwhile [0m[94mt[0m[1m < [0m5[32m:[0m
                  [95mmem[[0m(32[1m * [0m[94mt[0m) + [94m_501[0m[95m][0m = [38;5;8muint16([0m[32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_88[0m[1m / [0m2^(16[1m * [0m[94mt[0m)[38;5;8m)[0m
                  [94mt[0m = [94mt[0m + 1
                  [32mcontinue [0m
              [95mmem[[0m[94m_493[0m + 224[95m][0m = [94m_501[0m
              [94mt[0m = 0
              [32mwhile [0m[94mt[0m[1m < [0m5[32m:[0m
                  if cd[((32[1m * [0m[94midx[0m) + 36)] != [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m:
                      [94mt[0m = [94mt[0m + 1
                      [32mcontinue [0m
                  if [94mt[0m != 9999:
                      [94m_730[0m = [95mmem[[0m64[95m][0m
                      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 640
                      [95mmem[[0m[94m_730[0m[95m][0m = 0
                      [95mmem[[0m[94m_730[0m + 32[95m][0m = 0
                      [95mmem[[0m[94m_730[0m + 64[95m][0m = 0
                      [95mmem[[0m[94m_730[0m + 96[95m][0m = 0
                      [95mmem[[0m[94m_730[0m + 128[95m][0m = 0
                      [94m_731[0m = [95mmem[[0m64[95m][0m
                      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
                      [95mmem[[0m[94m_731[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
                      [95mmem[[0m[94m_730[0m + 160[95m][0m = [94m_731[0m
                      [94m_732[0m = [95mmem[[0m64[95m][0m
                      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
                      [95mmem[[0m[94m_732[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
                      [95mmem[[0m[94m_730[0m + 192[95m][0m = [94m_732[0m
                      [94m_733[0m = [95mmem[[0m64[95m][0m
                      [95mmem[[0m64[95m][0m = [95mmem[[0m64[95m][0m + 160
                      [95mmem[[0m[94m_733[0m[95m len [0m160[95m][0m = code.data[17173 len 160]
                      [95mmem[[0m[94m_730[0m + 224[95m][0m = [94m_733[0m
                      [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 34
                      require ext_code.size([32munknown7c0f0ac9Address[0m)
                      call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                           gas gas_remaining [38;5;8mwei[0m
                          args 34
                      [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = ext_call.return_data[0]
                      if not ext_call.success:
                          revert with ext_call.return_data[0 len return_data.size]
                      require return_data.size[1m >= [0m32
                      [95mmem[[0m0[95m][0m = [38;5;8maddr([0mcd[4][38;5;8m)[0m
                      [95mmem[[0m32[95m][0m = 24
                      if [95mmem[[0m[94m_493[0m + 64[95m][0m[1m > [0m[32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m:
                          [94m_740[0m = [95mmem[[0m[94m_493[0m + 64[95m][0m
                          [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 17
                          require ext_code.size([32munknown7c0f0ac9Address[0m)
                          call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                               gas gas_remaining [38;5;8mwei[0m
                              args 17
                          [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = ext_call.return_data[0]
                          if not ext_call.success:
                              revert with ext_call.return_data[0 len return_data.size]
                          require return_data.size[1m >= [0m32
                          [94m_752[0m = [95mmem[[0m[95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m
                          if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m % [0m48[1m * [0m24[1m * [0m3600[1m < [0m24[1m * [0m3600:
                              [94m_755[0m = [95mmem[[0m[95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                              [95mmem[[0m0[95m][0m = [38;5;8maddr([0mcd[4][38;5;8m)[0m
                              [95mmem[[0m32[95m][0m = 23
                              if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m * [0mext_call.return_data[0]) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                                  [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m += (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_755[0m[1m * [0mext_call.return_data[0]) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m[94m_755[0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_752[0m) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m[94m_752[0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_752[0m) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m[94m_752[0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600
                                  [94m_763[0m = [95mmem[[0m[94m_493[0m + 64[95m][0m
                                  [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 18
                                  require ext_code.size([32munknown7c0f0ac9Address[0m)
                                  call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                                       gas gas_remaining [38;5;8mwei[0m
                                      args 18
                                  [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = ext_call.return_data[0]
                                  if not ext_call.success:
                                      revert with ext_call.return_data[0 len return_data.size]
                                  require return_data.size[1m >= [0m32
                                  [94mu[0m = 0
                                  [32mwhile [0m[94mu[0m[1m < [0m5[32m:[0m
                                      if [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m:
                                          require [94mu[0m[1m < [0m5
                                          require [94mu[0m[1m < [0m5
                                          if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_763[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_763[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                          else:
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_763[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m + 1
                                          if [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                                              require [94mu[0m[1m < [0m5
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                                      [94mu[0m = [94mu[0m + 1
                                      [32mcontinue [0m
                                  require [94mt[0m[1m < [0m5
                                  if [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m <= [0m0:
                                      [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                      [94midx[0m = 0
                                      [94mu[0m = 0
                                      [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                          [94midx[0m = [94midx[0m + 1
                                          [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                          [32mcontinue [0m
                                      [94midx[0m = 0
                                      [94mu[0m = 0
                                      [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                          [94m_1314[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                          [94midx[0m = [94midx[0m + 1
                                          [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                          [32mcontinue [0m
                                      [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                      [95mmem[[0m32[95m][0m = 16
                                      [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1314[0m)
                                  else:
                                      require [94mt[0m[1m < [0m5
                                      require [94mt[0m[1m < [0m5
                                      if [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m < [0mcd[((32[1m * [0m[94midx[0m) + 196)]:
                                          [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = 0
                                          [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94m_1315[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                          [95mmem[[0m32[95m][0m = 16
                                          [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1315[0m)
                                      else:
                                          [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m - cd[((32[1m * [0m[94midx[0m) + 196)]
                                          [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94m_1316[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                          [95mmem[[0m32[95m][0m = 16
                                          [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1316[0m)
                              else:
                                  [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_755[0m[1m * [0mext_call.return_data[0]) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m[94m_755[0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_752[0m) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m[94m_752[0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_752[0m) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m[94m_752[0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600) + [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m + 1
                                  [94m_765[0m = [95mmem[[0m[94m_493[0m + 64[95m][0m
                                  [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 18
                                  require ext_code.size([32munknown7c0f0ac9Address[0m)
                                  call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                                       gas gas_remaining [38;5;8mwei[0m
                                      args 18
                                  [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = ext_call.return_data[0]
                                  if not ext_call.success:
                                      revert with ext_call.return_data[0 len return_data.size]
                                  require return_data.size[1m >= [0m32
                                  [94mu[0m = 0
                                  [32mwhile [0m[94mu[0m[1m < [0m5[32m:[0m
                                      if [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m:
                                          require [94mu[0m[1m < [0m5
                                          require [94mu[0m[1m < [0m5
                                          if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_765[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_765[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                          else:
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_765[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m + 1
                                          if [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                                              require [94mu[0m[1m < [0m5
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                                      [94mu[0m = [94mu[0m + 1
                                      [32mcontinue [0m
                                  require [94mt[0m[1m < [0m5
                                  if [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m <= [0m0:
                                      [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                      [94midx[0m = 0
                                      [94mu[0m = 0
                                      [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                          [94midx[0m = [94midx[0m + 1
                                          [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                          [32mcontinue [0m
                                      [94midx[0m = 0
                                      [94mu[0m = 0
                                      [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                          [94m_1317[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                          [94midx[0m = [94midx[0m + 1
                                          [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                          [32mcontinue [0m
                                      [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                      [95mmem[[0m32[95m][0m = 16
                                      [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1317[0m)
                                  else:
                                      require [94mt[0m[1m < [0m5
                                      require [94mt[0m[1m < [0m5
                                      if [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m < [0mcd[((32[1m * [0m[94midx[0m) + 196)]:
                                          [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = 0
                                          [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94m_1318[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                          [95mmem[[0m32[95m][0m = 16
                                          [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1318[0m)
                                      else:
                                          [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m - cd[((32[1m * [0m[94midx[0m) + 196)]
                                          [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94m_1319[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                          [95mmem[[0m32[95m][0m = 16
                                          [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1319[0m)
                          else:
                              [94m_757[0m = [95mmem[[0m[95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                              [95mmem[[0m0[95m][0m = [38;5;8maddr([0mcd[4][38;5;8m)[0m
                              [95mmem[[0m32[95m][0m = 23
                              if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m * [0mext_call.return_data[0]) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                                  [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m += (block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_757[0m[1m * [0mext_call.return_data[0]) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m[94m_757[0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_752[0m) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m[94m_752[0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_752[0m) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m[94m_752[0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600
                                  [94m_767[0m = [95mmem[[0m[94m_493[0m + 64[95m][0m
                                  [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 18
                                  require ext_code.size([32munknown7c0f0ac9Address[0m)
                                  call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                                       gas gas_remaining [38;5;8mwei[0m
                                      args 18
                                  [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = ext_call.return_data[0]
                                  if not ext_call.success:
                                      revert with ext_call.return_data[0 len return_data.size]
                                  require return_data.size[1m >= [0m32
                                  [94mu[0m = 0
                                  [32mwhile [0m[94mu[0m[1m < [0m5[32m:[0m
                                      if [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m:
                                          require [94mu[0m[1m < [0m5
                                          require [94mu[0m[1m < [0m5
                                          if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_767[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_767[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                          else:
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_767[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m + 1
                                          if [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                                              require [94mu[0m[1m < [0m5
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                                      [94mu[0m = [94mu[0m + 1
                                      [32mcontinue [0m
                                  require [94mt[0m[1m < [0m5
                                  if [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m <= [0m0:
                                      [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                      [94midx[0m = 0
                                      [94mu[0m = 0
                                      [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                          [94midx[0m = [94midx[0m + 1
                                          [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                          [32mcontinue [0m
                                      [94midx[0m = 0
                                      [94mu[0m = 0
                                      [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                          [94m_1320[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                          [94midx[0m = [94midx[0m + 1
                                          [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                          [32mcontinue [0m
                                      [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                      [95mmem[[0m32[95m][0m = 16
                                      [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1320[0m)
                                  else:
                                      require [94mt[0m[1m < [0m5
                                      require [94mt[0m[1m < [0m5
                                      if [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m < [0mcd[((32[1m * [0m[94midx[0m) + 196)]:
                                          [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = 0
                                          [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94m_1321[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                          [95mmem[[0m32[95m][0m = 16
                                          [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1321[0m)
                                      else:
                                          [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m - cd[((32[1m * [0m[94midx[0m) + 196)]
                                          [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94m_1322[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                          [95mmem[[0m32[95m][0m = 16
                                          [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1322[0m)
                              else:
                                  [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_757[0m[1m * [0mext_call.return_data[0]) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m[94m_757[0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_752[0m) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m[94m_752[0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_752[0m) - ([94m_740[0m[1m * [0mext_call.return_data[0][1m * [0m[94m_752[0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600) + [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m + 1
                                  [94m_769[0m = [95mmem[[0m[94m_493[0m + 64[95m][0m
                                  [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 18
                                  require ext_code.size([32munknown7c0f0ac9Address[0m)
                                  call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                                       gas gas_remaining [38;5;8mwei[0m
                                      args 18
                                  [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = ext_call.return_data[0]
                                  if not ext_call.success:
                                      revert with ext_call.return_data[0 len return_data.size]
                                  require return_data.size[1m >= [0m32
                                  [94mu[0m = 0
                                  [32mwhile [0m[94mu[0m[1m < [0m5[32m:[0m
                                      if [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m:
                                          require [94mu[0m[1m < [0m5
                                          require [94mu[0m[1m < [0m5
                                          if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_769[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_769[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                          else:
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_769[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m + 1
                                          if [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                                              require [94mu[0m[1m < [0m5
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                                      [94mu[0m = [94mu[0m + 1
                                      [32mcontinue [0m
                                  require [94mt[0m[1m < [0m5
                                  if [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m <= [0m0:
                                      [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                      [94midx[0m = 0
                                      [94mu[0m = 0
                                      [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                          [94midx[0m = [94midx[0m + 1
                                          [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                          [32mcontinue [0m
                                      [94midx[0m = 0
                                      [94mu[0m = 0
                                      [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                          [94m_1323[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                          [94midx[0m = [94midx[0m + 1
                                          [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                          [32mcontinue [0m
                                      [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                      [95mmem[[0m32[95m][0m = 16
                                      [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1323[0m)
                                  else:
                                      require [94mt[0m[1m < [0m5
                                      require [94mt[0m[1m < [0m5
                                      if [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m < [0mcd[((32[1m * [0m[94midx[0m) + 196)]:
                                          [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = 0
                                          [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94m_1324[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                          [95mmem[[0m32[95m][0m = 16
                                          [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1324[0m)
                                      else:
                                          [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m - cd[((32[1m * [0m[94midx[0m) + 196)]
                                          [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94m_1325[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                          [95mmem[[0m32[95m][0m = 16
                                          [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1325[0m)
                      else:
                          [95mmem[[0m0[95m][0m = [38;5;8maddr([0mcd[4][38;5;8m)[0m
                          [95mmem[[0m32[95m][0m = 24
                          [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 17
                          require ext_code.size([32munknown7c0f0ac9Address[0m)
                          call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                               gas gas_remaining [38;5;8mwei[0m
                              args 17
                          [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = ext_call.return_data[0]
                          if not ext_call.success:
                              revert with ext_call.return_data[0 len return_data.size]
                          require return_data.size[1m >= [0m32
                          [94m_753[0m = [95mmem[[0m[95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m
                          if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m % [0m48[1m * [0m24[1m * [0m3600[1m < [0m24[1m * [0m3600:
                              [94m_759[0m = [95mmem[[0m[95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                              [95mmem[[0m0[95m][0m = [38;5;8maddr([0mcd[4][38;5;8m)[0m
                              [95mmem[[0m32[95m][0m = 23
                              if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                                  [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m += (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_759[0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[94m_759[0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_753[0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[94m_753[0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_753[0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[94m_753[0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600
                                  [94m_771[0m = [95mmem[[0m[94m_493[0m + 64[95m][0m
                                  [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 18
                                  require ext_code.size([32munknown7c0f0ac9Address[0m)
                                  call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                                       gas gas_remaining [38;5;8mwei[0m
                                      args 18
                                  [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = ext_call.return_data[0]
                                  if not ext_call.success:
                                      revert with ext_call.return_data[0 len return_data.size]
                                  require return_data.size[1m >= [0m32
                                  [94mu[0m = 0
                                  [32mwhile [0m[94mu[0m[1m < [0m5[32m:[0m
                                      if [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m:
                                          require [94mu[0m[1m < [0m5
                                          require [94mu[0m[1m < [0m5
                                          if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_771[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_771[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                          else:
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_771[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m + 1
                                          if [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                                              require [94mu[0m[1m < [0m5
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                                      [94mu[0m = [94mu[0m + 1
                                      [32mcontinue [0m
                                  require [94mt[0m[1m < [0m5
                                  if [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m <= [0m0:
                                      [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                      [94midx[0m = 0
                                      [94mu[0m = 0
                                      [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                          [94midx[0m = [94midx[0m + 1
                                          [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                          [32mcontinue [0m
                                      [94midx[0m = 0
                                      [94mu[0m = 0
                                      [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                          [94m_1326[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                          [94midx[0m = [94midx[0m + 1
                                          [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                          [32mcontinue [0m
                                      [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                      [95mmem[[0m32[95m][0m = 16
                                      [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1326[0m)
                                  else:
                                      require [94mt[0m[1m < [0m5
                                      require [94mt[0m[1m < [0m5
                                      if [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m < [0mcd[((32[1m * [0m[94midx[0m) + 196)]:
                                          [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = 0
                                          [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94m_1327[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                          [95mmem[[0m32[95m][0m = 16
                                          [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1327[0m)
                                      else:
                                          [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m - cd[((32[1m * [0m[94midx[0m) + 196)]
                                          [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94m_1328[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                          [95mmem[[0m32[95m][0m = 16
                                          [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1328[0m)
                              else:
                                  [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_759[0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[94m_759[0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_753[0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[94m_753[0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_753[0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[94m_753[0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600) + [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m + 1
                                  [94m_773[0m = [95mmem[[0m[94m_493[0m + 64[95m][0m
                                  [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 18
                                  require ext_code.size([32munknown7c0f0ac9Address[0m)
                                  call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                                       gas gas_remaining [38;5;8mwei[0m
                                      args 18
                                  [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = ext_call.return_data[0]
                                  if not ext_call.success:
                                      revert with ext_call.return_data[0 len return_data.size]
                                  require return_data.size[1m >= [0m32
                                  [94mu[0m = 0
                                  [32mwhile [0m[94mu[0m[1m < [0m5[32m:[0m
                                      if [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m:
                                          require [94mu[0m[1m < [0m5
                                          require [94mu[0m[1m < [0m5
                                          if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_773[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_773[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                          else:
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_773[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m + 1
                                          if [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                                              require [94mu[0m[1m < [0m5
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                                      [94mu[0m = [94mu[0m + 1
                                      [32mcontinue [0m
                                  require [94mt[0m[1m < [0m5
                                  if [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m <= [0m0:
                                      [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                      [94midx[0m = 0
                                      [94mu[0m = 0
                                      [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                          [94midx[0m = [94midx[0m + 1
                                          [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                          [32mcontinue [0m
                                      [94midx[0m = 0
                                      [94mu[0m = 0
                                      [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                          [94m_1329[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                          [94midx[0m = [94midx[0m + 1
                                          [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                          [32mcontinue [0m
                                      [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                      [95mmem[[0m32[95m][0m = 16
                                      [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1329[0m)
                                  else:
                                      require [94mt[0m[1m < [0m5
                                      require [94mt[0m[1m < [0m5
                                      if [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m < [0mcd[((32[1m * [0m[94midx[0m) + 196)]:
                                          [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = 0
                                          [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94m_1330[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                          [95mmem[[0m32[95m][0m = 16
                                          [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1330[0m)
                                      else:
                                          [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m - cd[((32[1m * [0m[94midx[0m) + 196)]
                                          [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94m_1331[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                          [95mmem[[0m32[95m][0m = 16
                                          [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1331[0m)
                          else:
                              [94m_761[0m = [95mmem[[0m[95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                              [95mmem[[0m0[95m][0m = [38;5;8maddr([0mcd[4][38;5;8m)[0m
                              [95mmem[[0m32[95m][0m = 23
                              if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m[95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                                  [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m += (block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_761[0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[94m_761[0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_753[0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[94m_753[0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_753[0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[94m_753[0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600
                                  [94m_775[0m = [95mmem[[0m[94m_493[0m + 64[95m][0m
                                  [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 18
                                  require ext_code.size([32munknown7c0f0ac9Address[0m)
                                  call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                                       gas gas_remaining [38;5;8mwei[0m
                                      args 18
                                  [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = ext_call.return_data[0]
                                  if not ext_call.success:
                                      revert with ext_call.return_data[0 len return_data.size]
                                  require return_data.size[1m >= [0m32
                                  [94mu[0m = 0
                                  [32mwhile [0m[94mu[0m[1m < [0m5[32m:[0m
                                      if [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m:
                                          require [94mu[0m[1m < [0m5
                                          require [94mu[0m[1m < [0m5
                                          if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_775[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_775[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                          else:
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_775[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m + 1
                                          if [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                                              require [94mu[0m[1m < [0m5
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                                      [94mu[0m = [94mu[0m + 1
                                      [32mcontinue [0m
                                  require [94mt[0m[1m < [0m5
                                  if [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m <= [0m0:
                                      [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                      [94midx[0m = 0
                                      [94mu[0m = 0
                                      [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                          [94midx[0m = [94midx[0m + 1
                                          [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                          [32mcontinue [0m
                                      [94midx[0m = 0
                                      [94mu[0m = 0
                                      [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                          [94m_1332[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                          [94midx[0m = [94midx[0m + 1
                                          [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                          [32mcontinue [0m
                                      [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                      [95mmem[[0m32[95m][0m = 16
                                      [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1332[0m)
                                  else:
                                      require [94mt[0m[1m < [0m5
                                      require [94mt[0m[1m < [0m5
                                      if [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m < [0mcd[((32[1m * [0m[94midx[0m) + 196)]:
                                          [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = 0
                                          [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94m_1333[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                          [95mmem[[0m32[95m][0m = 16
                                          [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1333[0m)
                                      else:
                                          [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m - cd[((32[1m * [0m[94midx[0m) + 196)]
                                          [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94m_1334[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                          [95mmem[[0m32[95m][0m = 16
                                          [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1334[0m)
                              else:
                                  [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_761[0m[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[94m_761[0m[1m * [0mext_call.return_data[0]) + (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_753[0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[94m_753[0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0]) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m(block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[94m_753[0m) - ([32munknown64384a99[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[1m * [0mext_call.return_data[0][1m * [0m[94m_753[0m)[1m / [0m48[1m * [0m24[1m * [0m3600[1m * [0mext_call.return_data[0])[1m / [0m24[1m * [0m3600) + [32munknown35bde22c[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m + 1
                                  [94m_777[0m = [95mmem[[0m[94m_493[0m + 64[95m][0m
                                  [95mmem[[0m[95mmem[[0m64[95m][0m + 4[95m][0m = 18
                                  require ext_code.size([32munknown7c0f0ac9Address[0m)
                                  call [32munknown7c0f0ac9Address[0m.0x64c66395 with:
                                       gas gas_remaining [38;5;8mwei[0m
                                      args 18
                                  [95mmem[[0m[95mmem[[0m64[95m][0m[95m][0m = ext_call.return_data[0]
                                  if not ext_call.success:
                                      revert with ext_call.return_data[0 len return_data.size]
                                  require return_data.size[1m >= [0m32
                                  [94mu[0m = 0
                                  [32mwhile [0m[94mu[0m[1m < [0m5[32m:[0m
                                      if [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m:
                                          require [94mu[0m[1m < [0m5
                                          require [94mu[0m[1m < [0m5
                                          if (block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_777[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m % [0m24[1m * [0m3600[1m < [0m12[1m * [0m3600:
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_777[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                          else:
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = ((block.timestamp[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m) - ([94m_777[0m[1m * [0mext_call.return_data[0][1m * [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m)[1m / [0m24[1m * [0m3600) + [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m + 1
                                          if [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m > [0m[95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m[1m * [0mext_call.return_data[0]:
                                              require [94mu[0m[1m < [0m5
                                              [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94mu[0m) + [95mmem[[0m[94m_493[0m + 192[95m][0m[95m][0m[1m * [0mext_call.return_data[0]
                                      [94mu[0m = [94mu[0m + 1
                                      [32mcontinue [0m
                                  require [94mt[0m[1m < [0m5
                                  if [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m <= [0m0:
                                      [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                      [94midx[0m = 0
                                      [94mu[0m = 0
                                      [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                          [94midx[0m = [94midx[0m + 1
                                          [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                          [32mcontinue [0m
                                      [94midx[0m = 0
                                      [94mu[0m = 0
                                      [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                          [94m_1335[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                          [94midx[0m = [94midx[0m + 1
                                          [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                          [32mcontinue [0m
                                      [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                      [95mmem[[0m32[95m][0m = 16
                                      [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1335[0m)
                                  else:
                                      require [94mt[0m[1m < [0m5
                                      require [94mt[0m[1m < [0m5
                                      if [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m < [0mcd[((32[1m * [0m[94midx[0m) + 196)]:
                                          [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = 0
                                          [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94m_1336[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                          [95mmem[[0m32[95m][0m = 16
                                          [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1336[0m)
                                      else:
                                          [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m = [95mmem[[0m(32[1m * [0m[94mt[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m - cd[((32[1m * [0m[94midx[0m) + 196)]
                                          [95mmem[[0m[94m_493[0m + 64[95m][0m = block.timestamp
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(8[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 160[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [94midx[0m = 0
                                          [94mu[0m = 0
                                          [32mwhile [0m[94midx[0m[1m < [0m5[32m:[0m
                                              [94m_1337[0m = [95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m
                                              [94midx[0m = [94midx[0m + 1
                                              [94mu[0m = 2^(16[1m * [0m[94midx[0m)[1m * [0m[95mmem[[0m(32[1m * [0m[94midx[0m) + [95mmem[[0m[94m_493[0m + 224[95m][0m[95m][0m[1m or [0m[94mu[0m
                                              [32mcontinue [0m
                                          [95mmem[[0m0[95m][0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                                          [95mmem[[0m32[95m][0m = 16
                                          [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_0[0m = Mask(168, 0, 5[1m * [0m2^80[1m * [0m[94m_1337[0m)
                      [32mstor16[0m[32m[[0m[32mstor6[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m[32m][0m[32m.field_168[0m = 0
                  [94mt[0m = [94mt[0m
                  [94mt[0m = [94mt[0m
                  [94mt[0m = [94m_493[0m
                  [94mt[0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
                  [94ms[0m = [94ms[0m + 1
                  [32mcontinue [0m
              [94mt[0m = [94mt[0m
              [94mt[0m = 9999
              [94mt[0m = [94m_493[0m
              [94mt[0m = [32mtokenOfOwnerByIndex[0m[32m[[0m[38;5;8maddr([0mcd[4][38;5;8m)[0m[32m][0m[32m[[0m[94ms[0m[32m][0m
              [94ms[0m = [94ms[0m + 1
              [32mcontinue [0m
          if cd[((32[1m * [0m[94midx[0m) + 196)][1m > [0m0:
              revert with 0, 'NotEnoughResources'
      [94ms[0m = cd[((32[1m * [0m[94midx[0m) + 196)]
      [94ms[0m = cd[((32[1m * [0m[94midx[0m) + 36)]
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m

