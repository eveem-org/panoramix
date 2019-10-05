[38;5;8m#
#  Panoramix 4 Oct 2019 
#  Decompiled source of [0m0x06012c8cf97BEaD5deAe237070F9587f8E7A266d[38;5;8m
# 
#  Let's make the world open source 
# [0m

[95mconst [0mname = [1m'CryptoKitties'[0m
[95mconst [0msymbol = [1m'CK'[0m
[95mconst [0mGEN0_STARTING_PRICE = [1m10^16[0m
[95mconst [0mGEN0_AUCTION_DURATION = [1m(24 * 3600)[0m
[95mconst [0mGEN0_CREATION_LIMIT = [1m45000[0m
[95mconst [0mPROMO_CREATION_LIMIT = [1m5000[0m

[32mdef [0mstorage:
  [32mceoAddress[0m is addr [38;5;8mat storage 0[0m[38;5;8m[0m
  [32mcfoAddress[0m is addr [38;5;8mat storage 1[0m[38;5;8m[0m
  [32mcooAddress[0m is addr [38;5;8mat storage 2[0m[38;5;8m[0m
  [32mpaused[0m is uint8 [38;5;8mat storage 2[0m[38;5;8m offset 160[0m
  [32mcooldowns[0m is array of uint32 [38;5;8mat storage 3[0m
  [32msecondsPerBlock[0m is uint256 [38;5;8mat storage 5[0m[38;5;8m[0m
  [32mkitty[0m is array of struct [38;5;8mat storage 6[0m
  [32mkittyIndexToOwner[0m is mapping of addr [38;5;8mat storage 7[0m
  [32mbalanceOf[0m is mapping of uint256 [38;5;8mat storage 8[0m
  [32mkittyIndexToApproved[0m is mapping of addr [38;5;8mat storage 9[0m
  [32msireAllowedTo[0m is mapping of addr [38;5;8mat storage 10[0m
  [32msaleAuctionAddress[0m is addr [38;5;8mat storage 11[0m[38;5;8m[0m
  [32msiringAuctionAddress[0m is addr [38;5;8mat storage 12[0m[38;5;8m[0m
  [32merc721MetadataAddress[0m is addr [38;5;8mat storage 13[0m[38;5;8m[0m
  [32mautoBirthFee[0m is uint256 [38;5;8mat storage 14[0m[38;5;8m[0m
  [32mpregnantKitties[0m is uint256 [38;5;8mat storage 15[0m[38;5;8m[0m
  [32mgeneScienceAddress[0m is addr [38;5;8mat storage 16[0m[38;5;8m[0m
  [32mpromoCreatedCount[0m is uint256 [38;5;8mat storage 17[0m[38;5;8m[0m
  [32mgen0CreatedCount[0m is uint256 [38;5;8mat storage 18[0m[38;5;8m[0m
  [32mnewContractAddress[0m is addr [38;5;8mat storage 19[0m[38;5;8m[0m

[95mdef [0mcfoAddress(): [38;5;8m# not payable[0m
  return [32mcfoAddress[0m

[95mdef [0mpromoCreatedCount(): [38;5;8m# not payable[0m
  return [32mpromoCreatedCount[0m

[95mdef [0mceoAddress(): [38;5;8m# not payable[0m
  return [32mceoAddress[0m

[95mdef [0mpregnantKitties(): [38;5;8m# not payable[0m
  return [32mpregnantKitties[0m

[95mdef [0misPregnant(uint256 [32m_horseId[0m): [38;5;8m# not payable[0m
  require [32m_horseId[0m[1m > [0m0
  require [32m_horseId[0m[1m < [0m[32mkitty[0m[32m.length[0m
  return bool([32mkitty[0m[32m[[0m[32m_horseId[0m[32m][0m[32m.field_448[0m)

[95mdef [0msiringAuction(): [38;5;8m# not payable[0m
  return [32msiringAuctionAddress[0m

[95mdef [0msireAllowedToAddress(uint256 [32m_param1[0m): [38;5;8m# not payable[0m
  return [32msireAllowedTo[0m[32m[[0m[32m_param1[0m[32m][0m

[95mdef [0mkittyIndexToApproved(uint256 [32m_param1[0m): [38;5;8m# not payable[0m
  return [32mkittyIndexToApproved[0m[32m[[0m[32m_param1[0m[32m][0m

[95mdef [0mpaused(): [38;5;8m# not payable[0m
  return bool([32mpaused[0m)

[95mdef [0mownerOf(uint256 [32m_tokenId[0m): [38;5;8m# not payable[0m
  require [32mkittyIndexToOwner[0m[32m[[0m[32m_tokenId[0m[32m][0m
  return [32mkittyIndexToOwner[0m[32m[[0m[32m_tokenId[0m[32m][0m

[95mdef [0mnewContractAddress(): [38;5;8m# not payable[0m
  return [32mnewContractAddress[0m

[95mdef [0mbalanceOf(address [32m_tokenOwner[0m): [38;5;8m# not payable[0m
  return [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_tokenOwner[0m[38;5;8m)[0m[32m][0m

[95mdef [0msecondsPerBlock(): [38;5;8m# not payable[0m
  return [32msecondsPerBlock[0m

[95mdef [0mcooldowns(uint256 [32m_param1[0m): [38;5;8m# not payable[0m
  require [32m_param1[0m[1m < [0m14
  return [32mcooldowns[0m[32m[[0m[38;5;8muint8([0m[32m_param1[0m[38;5;8m)[0m[32m][0m

[95mdef [0mkittyIndexToOwner(uint256 [32m_param1[0m): [38;5;8m# not payable[0m
  return [32mkittyIndexToOwner[0m[32m[[0m[32m_param1[0m[32m][0m

[95mdef [0mcooAddress(): [38;5;8m# not payable[0m
  return [32mcooAddress[0m

[95mdef [0mautoBirthFee(): [38;5;8m# not payable[0m
  return [32mautoBirthFee[0m

[95mdef [0merc721Metadata(): [38;5;8m# not payable[0m
  return [32merc721MetadataAddress[0m

[95mdef [0msaleAuction(): [38;5;8m# not payable[0m
  return [32msaleAuctionAddress[0m

[95mdef [0mgetKitty(uint256 [32m_tokenId[0m): [38;5;8m# not payable[0m
  require [32m_tokenId[0m[1m < [0m[32mkitty[0m[32m.length[0m
  return [32mkitty[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m.field_448[0m != 0, 
         [32mkitty[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m.field_320[0m <= block.number,
         [32mkitty[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m.field_256[0m,
         [32mkitty[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m.field_256[0m,
         [32mkitty[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m.field_448[0m,
         [32mkitty[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m.field_256[0m,
         [32mkitty[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m.field_256[0m,
         [32mkitty[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m.field_256[0m,
         [32mkitty[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m.field_256[0m,
         [32mkitty[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m.field_0[0m

[95mdef [0mgen0CreatedCount(): [38;5;8m# not payable[0m
  return [32mgen0CreatedCount[0m

[95mdef [0mgeneScience(): [38;5;8m# not payable[0m
  return [32mgeneScienceAddress[0m

[38;5;8m#
#  Regular functions
#[0m

[95mdef [0mtotalSupply(): [38;5;8m# not payable[0m
  return ([32mkitty[0m[32m.length[0m - 1)

[95mdef [0msetAutoBirthFee(uint256 [32m_val[0m): [38;5;8m# not payable[0m
  require [32mcooAddress[0m[1m == [0mcaller
  [32mautoBirthFee[0m = [32m_val[0m

[95mdef [0m_fallback()[95m payable[0m: [38;5;8m# default function[0m
  if [32msaleAuctionAddress[0m != caller:
      require [32msiringAuctionAddress[0m[1m == [0mcaller

[95mdef [0msetCEO(address [32m_newCEO[0m): [38;5;8m# not payable[0m
  require [32mceoAddress[0m[1m == [0mcaller
  require [32m_newCEO[0m
  [32mceoAddress[0m = [32m_newCEO[0m

[95mdef [0msetCOO(address [32m_newCoo[0m): [38;5;8m# not payable[0m
  require [32mceoAddress[0m[1m == [0mcaller
  require [32m_newCoo[0m
  [32mcooAddress[0m = [32m_newCoo[0m

[95mdef [0msetCFO(address [32m_newCfo[0m): [38;5;8m# not payable[0m
  require [32mceoAddress[0m[1m == [0mcaller
  require [32m_newCfo[0m
  [32mcfoAddress[0m = [32m_newCfo[0m

[95mdef [0msetMetadataAddress(address [32m_contractAddress[0m): [38;5;8m# not payable[0m
  require [32mceoAddress[0m[1m == [0mcaller
  [32merc721MetadataAddress[0m = [32m_contractAddress[0m

[95mdef [0mpause(): [38;5;8m# not payable[0m
  if [32mcooAddress[0m != caller:
      if [32mceoAddress[0m != caller:
          require [32mcfoAddress[0m[1m == [0mcaller
  require not [32mpaused[0m
  [32mpaused[0m = 1

[95mdef [0msetNewAddress(address [32m_v2Address[0m): [38;5;8m# not payable[0m
  require [32mceoAddress[0m[1m == [0mcaller
  require [32mpaused[0m
  [32mnewContractAddress[0m = [32m_v2Address[0m
  [38;5;8mlog ContractUpgrade(address newContract=_v2Address)[0m

[95mdef [0mapproveSiring(address [32m_addr[0m, uint256 [32m_sireId[0m): [38;5;8m# not payable[0m
  require not [32mpaused[0m
  require [32mkittyIndexToOwner[0m[32m[[0m[32m_sireId[0m[32m][0m[1m == [0mcaller
  [32msireAllowedTo[0m[32m[[0m[32m_sireId[0m[32m][0m = [32m_addr[0m

[95mdef [0msetSecondsPerBlock(uint256 [32m_secs[0m): [38;5;8m# not payable[0m
  if [32mcooAddress[0m != caller:
      if [32mceoAddress[0m != caller:
          require [32mcfoAddress[0m[1m == [0mcaller
  require [32m_secs[0m[1m < [0m[32mcooldowns[0m[32m.length[0m
  [32msecondsPerBlock[0m = [32m_secs[0m

[95mdef [0munpause(): [38;5;8m# not payable[0m
  require [32mceoAddress[0m[1m == [0mcaller
  require [32mpaused[0m
  require [32msaleAuctionAddress[0m
  require [32msiringAuctionAddress[0m
  require [32mgeneScienceAddress[0m
  require not [32mnewContractAddress[0m
  require [32mceoAddress[0m[1m == [0mcaller
  require [32mpaused[0m
  [32mpaused[0m = 0

[95mdef [0msetGeneScienceAddress(address [32m_address[0m): [38;5;8m# not payable[0m
  require [32mceoAddress[0m[1m == [0mcaller
  require ext_code.size([32m_address[0m)
  call [32m_address[0m.isGeneScience() with:
       gas gas_remaining - 710 [38;5;8mwei[0m
  require ext_call.success
  require ext_call.return_data[0]
  [32mgeneScienceAddress[0m = [32m_address[0m

[95mdef [0msetSaleAuctionAddress(address [32m_address[0m): [38;5;8m# not payable[0m
  require [32mceoAddress[0m[1m == [0mcaller
  require ext_code.size([32m_address[0m)
  call [32m_address[0m.isSaleClockAuction() with:
       gas gas_remaining - 710 [38;5;8mwei[0m
  require ext_call.success
  require ext_call.return_data[0]
  [32msaleAuctionAddress[0m = [32m_address[0m

[95mdef [0msetSiringAuctionAddress(address [32m_address[0m): [38;5;8m# not payable[0m
  require [32mceoAddress[0m[1m == [0mcaller
  require ext_code.size([32m_address[0m)
  call [32m_address[0m.isSiringClockAuction() with:
       gas gas_remaining - 710 [38;5;8mwei[0m
  require ext_call.success
  require ext_call.return_data[0]
  [32msiringAuctionAddress[0m = [32m_address[0m

[95mdef [0mwithdrawBalance(): [38;5;8m# not payable[0m
  require [32mcfoAddress[0m[1m == [0mcaller
  if eth.balance(this.address)[1m > [0m[32mautoBirthFee[0m + ([32mpregnantKitties[0m[1m * [0m[32mautoBirthFee[0m):
      call [32mcfoAddress[0m with:
         value eth.balance(this.address) - [32mautoBirthFee[0m - ([32mpregnantKitties[0m[1m * [0m[32mautoBirthFee[0m) [38;5;8mwei[0m
           gas 2300 * is_zero(value) [38;5;8mwei[0m

[95mdef [0mapprove(address [32m_spender[0m, uint256 [32m_tokens[0m): [38;5;8m# not payable[0m
  require not [32mpaused[0m
  require [32mkittyIndexToOwner[0m[32m[[0m[32m_tokens[0m[32m][0m[1m == [0mcaller
  [32mkittyIndexToApproved[0m[32m[[0m[32m_tokens[0m[32m][0m = [32m_spender[0m
  [38;5;8mlog Approval([0m
  [38;5;8m      address owner=caller,[0m
  [38;5;8m      address spender=addr(_spender),[0m
  [38;5;8m      uint256 value=_tokens)[0m

[95mdef [0misReadyToBreed(uint256 [32m_tokenId[0m): [38;5;8m# not payable[0m
  require [32m_tokenId[0m[1m > [0m0
  require [32m_tokenId[0m[1m < [0m[32mkitty[0m[32m.length[0m
  if [32mkitty[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m.field_448[0m:
      return not bool([32mkitty[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m.field_256[0m)
  return [32mkitty[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m.field_256[0m <= [38;5;8muint64([0mblock.number[38;5;8m)[0m

[95mdef [0mwithdrawAuctionBalances(): [38;5;8m# not payable[0m
  if [32mcooAddress[0m != caller:
      if [32mceoAddress[0m != caller:
          require [32mcfoAddress[0m[1m == [0mcaller
  require ext_code.size([32msaleAuctionAddress[0m)
  call [32msaleAuctionAddress[0m.withdrawBalance() with:
       gas gas_remaining - 710 [38;5;8mwei[0m
  require ext_call.success
  require ext_code.size([32msiringAuctionAddress[0m)
  call [32msiringAuctionAddress[0m.withdrawBalance() with:
       gas gas_remaining - 710 [38;5;8mwei[0m
  require ext_call.success

[95mdef [0msupportsInterface(bytes4 [32m_interfaceId[0m): [38;5;8m# not payable[0m
  if Mask(32, 224, [32m_interfaceId[0m)[1m == [0mMask(32, 224, sha3('supportsInterface(bytes4)')):
      return True
  return (Mask(32, 224, [32m_interfaceId[0m)[1m == [0mMask(32, 224, sha3('name()')[1m xor [0msha3('symbol()')[1m xor [0msha3('totalSupply()')[1m xor [0msha3('balanceOf(address)')[1m xor [0msha3('ownerOf(uint256)')[1m xor [0msha3('approve(address,uint256)')[1m xor [0msha3('transfer(address,uint256)')[1m xor [0msha3('transferFrom(address,address,uin', 't256)')[1m xor [0msha3('tokensOfOwner(address)')[1m xor [0msha3('tokenMetadata(uint256,string)')))

[95mdef [0mtransfer(address [32m_to[0m, uint256 [32m_tokens[0m): [38;5;8m# not payable[0m
  require not [32mpaused[0m
  require [32m_to[0m
  require [32m_to[0m != this.address
  require [32msaleAuctionAddress[0m != [32m_to[0m
  require [32msiringAuctionAddress[0m != [32m_to[0m
  require [32mkittyIndexToOwner[0m[32m[[0m[32m_tokens[0m[32m][0m[1m == [0mcaller
  [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m++
  [32mkittyIndexToOwner[0m[32m[[0m[32m_tokens[0m[32m][0m = [32m_to[0m
  if caller:
      [32mbalanceOf[0m[32m[[0mcaller[32m][0m--
      [32msireAllowedTo[0m[32m[[0m[32m_tokens[0m[32m][0m = 0
      [32mkittyIndexToApproved[0m[32m[[0m[32m_tokens[0m[32m][0m = 0
  [38;5;8mlog Transfer([0m
  [38;5;8m      address from=caller,[0m
  [38;5;8m      address to=addr(_to),[0m
  [38;5;8m      uint256 value=_tokens)[0m

[95mdef [0mtransferFrom(address [32m_from[0m, address [32m_to[0m, uint256 [32m_tokens[0m): [38;5;8m# not payable[0m
  require not [32mpaused[0m
  require [32m_to[0m
  require [32m_to[0m != this.address
  require [32mkittyIndexToApproved[0m[32m[[0m[32m_tokens[0m[32m][0m[1m == [0mcaller
  require [32mkittyIndexToOwner[0m[32m[[0m[32m_tokens[0m[32m][0m[1m == [0m[32m_from[0m
  [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_to[0m[38;5;8m)[0m[32m][0m++
  [32mkittyIndexToOwner[0m[32m[[0m[32m_tokens[0m[32m][0m = [32m_to[0m
  if [32m_from[0m:
      [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_from[0m[38;5;8m)[0m[32m][0m--
      [32msireAllowedTo[0m[32m[[0m[32m_tokens[0m[32m][0m = 0
      [32mkittyIndexToApproved[0m[32m[[0m[32m_tokens[0m[32m][0m = 0
  [38;5;8mlog Transfer([0m
  [38;5;8m      address from=addr(_from),[0m
  [38;5;8m      address to=addr(_to),[0m
  [38;5;8m      uint256 value=_tokens)[0m

[95mdef [0mcreateSaleAuction(uint256 [32m_artworkId[0m, uint256 [32m_startingPrice[0m, uint256 [32m_endingPrice[0m, uint256 [32m_duration[0m): [38;5;8m# not payable[0m
  require not [32mpaused[0m
  require [32mkittyIndexToOwner[0m[32m[[0m[32m_artworkId[0m[32m][0m[1m == [0mcaller
  require [32m_artworkId[0m[1m > [0m0
  require [32m_artworkId[0m[1m < [0m[32mkitty[0m[32m.length[0m
  require not [32mkitty[0m[32m[[0m[32m_artworkId[0m[32m][0m[32m.field_448[0m
  [32mkittyIndexToApproved[0m[32m[[0m[32m_artworkId[0m[32m][0m = [32msaleAuctionAddress[0m
  require ext_code.size([32msaleAuctionAddress[0m)
  call [32msaleAuctionAddress[0m.createAuction([38;5;8muint256[0m tokenId, [38;5;8muint256[0m startingPrice, [38;5;8muint256[0m endingPrice, [38;5;8muint256[0m duration, [38;5;8maddress[0m seller) with:
       gas gas_remaining - 710 [38;5;8mwei[0m
      args 0, [38;5;8muint32([0m[32m_artworkId[0m[38;5;8m)[0m, [32m_startingPrice[0m, [32m_endingPrice[0m, [32m_duration[0m, caller
  require ext_call.success

[95mdef [0mcreateSiringAuction(uint256 [32m_tokenId[0m, uint256 [32m_startingPrice[0m, uint256 [32m_endingPrice[0m, uint256 [32m_duration[0m): [38;5;8m# not payable[0m
  require not [32mpaused[0m
  require [32mkittyIndexToOwner[0m[32m[[0m[32m_tokenId[0m[32m][0m[1m == [0mcaller
  require [32m_tokenId[0m[1m > [0m0
  require [32m_tokenId[0m[1m < [0m[32mkitty[0m[32m.length[0m
  require not [32mkitty[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m.field_448[0m
  require [32mkitty[0m[32m[[0m[32m_tokenId[0m[32m][0m[32m.field_320[0m[1m <= [0m[38;5;8muint64([0mblock.number[38;5;8m)[0m
  [32mkittyIndexToApproved[0m[32m[[0m[32m_tokenId[0m[32m][0m = [32msiringAuctionAddress[0m
  require ext_code.size([32msiringAuctionAddress[0m)
  call [32msiringAuctionAddress[0m.createAuction([38;5;8muint256[0m tokenId, [38;5;8muint256[0m startingPrice, [38;5;8muint256[0m endingPrice, [38;5;8muint256[0m duration, [38;5;8maddress[0m seller) with:
       gas gas_remaining - 710 [38;5;8mwei[0m
      args [32m_tokenId[0m, [32m_startingPrice[0m, [32m_endingPrice[0m, [32m_duration[0m, caller
  require ext_call.success

[95mdef [0mtokenMetadata(uint256 [32m_tokenId[0m, string [32m_preferredTransport[0m): [38;5;8m# not payable[0m
  require [32merc721MetadataAddress[0m
  [95mmem[[0m356[95m len [0m[32m_preferredTransport.length[0m[95m][0m = [32m_preferredTransport[[0mall[32m][0m
  require ext_code.size([32merc721MetadataAddress[0m)
  call [32merc721MetadataAddress[0m.0xcb4799f2 with:
       gas gas_remaining - 710 [38;5;8mwei[0m
      args [32m_tokenId[0m, [38;5;8mArray(len=[0m[32m_preferredTransport.length[0m[38;5;8m, data=[0m[32m_preferredTransport[[0mall[32m][0m[38;5;8m)[0m
  [95mmem[[0m256[95m len [0m160[95m][0m = ext_call.return_data[0 len 160]
  require ext_call.success
  [95mmem[[0m416[95m][0m = 0
  [95mmem[[0m448[95m][0m = 0
  [94m_msize[0m = max(124, [32m_preferredTransport.length[0m)
  [95mmem[[0m[94m_msize[0m + 356[95m][0m = ext_call.return_data[128]
  [95mmem[[0m([94m_msize[0m + 356) + 32[95m len [0mfloor32(ext_call.return_data[128])[95m][0m = [95mmem[[0m256[95m len [0mfloor32(ext_call.return_data[128])[95m][0m
  [95mmem[[0m([94m_msize[0m + 356) + floor32(ext_call.return_data[128]) + -(ext_call.return_data[128][1m % [0m32) + 64[95m len [0mext_call.return_data[128][1m % [0m32[95m][0m = [95mmem[[0mfloor32(ext_call.return_data[128]) + -(ext_call.return_data[128][1m % [0m32) + 288[95m len [0mext_call.return_data[128][1m % [0m32[95m][0m
  return [38;5;8mArray(len=[0mext_call.return_data[128][38;5;8m, data=[0m[95mmem[[0m([94m_msize[0m + 356) + 32[95m len [0mext_call.return_data[128][95m][0m[38;5;8m)[0m

[95mdef [0mtokensOfOwner(address [32m_owner[0m): [38;5;8m# not payable[0m
  if not [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_owner[0m[38;5;8m)[0m[32m][0m:
      return ''
  [94midx[0m = 1
  [94ms[0m = 0
  [32mwhile [0m[94midx[0m[1m <= [0m[32mkitty[0m[32m.length[0m - 1[32m:[0m
      [95mmem[[0m0[95m][0m = [94midx[0m
      [95mmem[[0m32[95m][0m = 7
      if [32mkittyIndexToOwner[0m[32m[[0m[94midx[0m[32m][0m != [32m_owner[0m:
          [94midx[0m = [94midx[0m + 1
          [94ms[0m = [94ms[0m
          [32mcontinue [0m
      require [94ms[0m[1m < [0m[32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_owner[0m[38;5;8m)[0m[32m][0m
      [95mmem[[0m(32[1m * [0m[94ms[0m) + 192[95m][0m = [94midx[0m
      [94midx[0m = [94midx[0m + 1
      [94ms[0m = [94ms[0m + 1
      [32mcontinue [0m
  [95mmem[[0m(32[1m * [0m[32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_owner[0m[38;5;8m)[0m[32m][0m) + 256[95m len [0mfloor32([32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_owner[0m[38;5;8m)[0m[32m][0m)[95m][0m = [95mmem[[0m192[95m len [0mfloor32([32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_owner[0m[38;5;8m)[0m[32m][0m)[95m][0m
  return [38;5;8mArray(len=[0m[32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_owner[0m[38;5;8m)[0m[32m][0m[38;5;8m, data=[0m[95mmem[[0m192[95m len [0mfloor32([32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_owner[0m[38;5;8m)[0m[32m][0m)[95m][0m, [95mmem[[0m(32[1m * [0m[32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_owner[0m[38;5;8m)[0m[32m][0m) + floor32([32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_owner[0m[38;5;8m)[0m[32m][0m) + 256[95m len [0m(32[1m * [0m[32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_owner[0m[38;5;8m)[0m[32m][0m) - floor32([32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_owner[0m[38;5;8m)[0m[32m][0m)[95m][0m[38;5;8m)[0m, 

[95mdef [0mcanBreedWith(uint256 [32m_matronId[0m, uint256 [32m_sireId[0m): [38;5;8m# not payable[0m
  require [32m_matronId[0m[1m > [0m0
  require [32m_sireId[0m[1m > [0m0
  require [32m_matronId[0m[1m < [0m[32mkitty[0m[32m.length[0m
  require [32m_sireId[0m[1m < [0m[32mkitty[0m[32m.length[0m
  if [32m_matronId[0m[1m == [0m[32m_sireId[0m:
      return 0
  if [32m_sireId[0m[1m == [0m[32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_384[0m:
      return 0
  if [32m_sireId[0m[1m == [0m[32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_416[0m:
      return 0
  if [32m_matronId[0m[1m == [0m[32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_384[0m:
      return 0
  if [32m_matronId[0m[1m == [0m[32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_416[0m:
      return 0
  if [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_384[0m:
      if [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_384[0m:
          if [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_384[0m[1m == [0m[32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_384[0m:
              return 0
          if [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_416[0m[1m == [0m[32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_384[0m:
              return 0
          if [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_384[0m[1m == [0m[32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_416[0m:
              return 0
          if [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_416[0m[1m == [0m[32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_416[0m:
              return 0
  if [32mkittyIndexToOwner[0m[32m[[0m[32m_matronId[0m[32m][0m[1m == [0m[32mkittyIndexToOwner[0m[32m[[0m[32m_sireId[0m[32m][0m:
      return True
  return ([32mkittyIndexToOwner[0m[32m[[0m[32m_matronId[0m[32m][0m[1m == [0m[32msireAllowedTo[0m[32m[[0m[32m_sireId[0m[32m][0m)

[95mdef [0mcreatePromoKitty(uint256 [32m_genes[0m, address [32m_owner[0m): [38;5;8m# not payable[0m
  require [32mcooAddress[0m[1m == [0mcaller
  require [32mpromoCreatedCount[0m[1m < [0m5000
  [32mpromoCreatedCount[0m++
  [32mkitty[0m[32m.length[0m++
  if not [32mkitty[0m[32m.length[0m[1m <= [0m[32mkitty[0m[32m.length[0m + 1:
      [94midx[0m = 2[1m * [0m[32mkitty[0m[32m.length[0m + 1
      [32mwhile [0m2[1m * [0m[32mkitty[0m[32m.length[0m[1m > [0m[94midx[0m[32m:[0m
          [32mkitty[0m[32m[[0m[94midx[0m[32m][0m[32m.field_0[0m = 0
          [32mkitty[0m[32m[[0m[94midx[0m[32m][0m[32m.field_256[0m = 0
          [94midx[0m = [94midx[0m + 2
          [32mcontinue [0m
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_0[0m = [32m_genes[0m
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_256[0m = [38;5;8muint64([0mblock.timestamp[38;5;8m)[0m
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_320[0m = 0
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_512[0m = 0
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_384[0m = 0
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_512[0m = 0
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_416[0m = 0
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_512[0m = 0
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_448[0m = 0
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_512[0m = 0
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_480[0m = 0
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_512[0m = 0
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_256[0m = [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_256[0m
  require [32mkitty[0m[32m.length[0m[1m == [0m[38;5;8muint32([0m[32mkitty[0m[32m.length[0m[38;5;8m)[0m
  if [32m_owner[0m:
      [38;5;8mlog Birth([0m
      [38;5;8m      address owner=addr(_owner),[0m
      [38;5;8m      uint256 clownId=kitty.length,[0m
      [38;5;8m      uint256 matronId=0,[0m
      [38;5;8m      uint256 sireId=0,[0m
      [38;5;8m      uint256 genes=_genes)[0m
      [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0m[32m_owner[0m[38;5;8m)[0m[32m][0m++
      [32mkittyIndexToOwner[0m[32m[[0m[32mstor6[0m[32m.length[0m[32m][0m = [32m_owner[0m
      [38;5;8mlog Transfer([0m
      [38;5;8m      address from=0,[0m
      [38;5;8m      address to=addr(_owner),[0m
      [38;5;8m      uint256 value=kitty.length)[0m
  else:
      [38;5;8mlog Birth([0m
      [38;5;8m      address owner=cooAddress,[0m
      [38;5;8m      uint256 clownId=kitty.length,[0m
      [38;5;8m      uint256 matronId=0,[0m
      [38;5;8m      uint256 sireId=0,[0m
      [38;5;8m      uint256 genes=_genes)[0m
      [32mbalanceOf[0m[32m[[0m[32mstor2[0m[32m][0m++
      [32mkittyIndexToOwner[0m[32m[[0m[32mstor6[0m[32m.length[0m[32m][0m = [32mcooAddress[0m
      [38;5;8mlog Transfer([0m
      [38;5;8m      address from=0,[0m
      [38;5;8m      address to=cooAddress,[0m
      [38;5;8m      uint256 value=kitty.length)[0m

[95mdef [0mcreateGen0Auction(uint256 [32m_pandaId[0m): [38;5;8m# not payable[0m
  require [32mcooAddress[0m[1m == [0mcaller
  require [32mgen0CreatedCount[0m[1m < [0m45000
  [32mkitty[0m[32m.length[0m++
  if not [32mkitty[0m[32m.length[0m[1m <= [0m[32mkitty[0m[32m.length[0m + 1:
      [94midx[0m = 2[1m * [0m[32mkitty[0m[32m.length[0m + 1
      [32mwhile [0m2[1m * [0m[32mkitty[0m[32m.length[0m[1m > [0m[94midx[0m[32m:[0m
          [32mkitty[0m[32m[[0m[94midx[0m[32m][0m[32m.field_0[0m = 0
          [32mkitty[0m[32m[[0m[94midx[0m[32m][0m[32m.field_256[0m = 0
          [94midx[0m = [94midx[0m + 2
          [32mcontinue [0m
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_0[0m = [32m_pandaId[0m
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_256[0m = [38;5;8muint64([0mblock.timestamp[38;5;8m)[0m
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_320[0m = 0
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_512[0m = 0
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_384[0m = 0
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_512[0m = 0
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_416[0m = 0
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_512[0m = 0
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_448[0m = 0
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_512[0m = 0
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_480[0m = 0
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_512[0m = 0
  [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_256[0m = [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_256[0m
  require [32mkitty[0m[32m.length[0m[1m == [0m[38;5;8muint32([0m[32mkitty[0m[32m.length[0m[38;5;8m)[0m
  [38;5;8mlog Birth([0m
  [38;5;8m      address owner=addr(this.address),[0m
  [38;5;8m      uint256 clownId=kitty.length,[0m
  [38;5;8m      uint256 matronId=0,[0m
  [38;5;8m      uint256 sireId=0,[0m
  [38;5;8m      uint256 genes=_pandaId)[0m
  [32mbalanceOf[0m[32m[[0m[38;5;8maddr([0mthis.address[38;5;8m)[0m[32m][0m++
  [32mkittyIndexToOwner[0m[32m[[0m[32mstor6[0m[32m.length[0m[32m][0m = this.address
  [38;5;8mlog Transfer([0m
  [38;5;8m      address from=0,[0m
  [38;5;8m      address to=addr(this.address),[0m
  [38;5;8m      uint256 value=kitty.length)[0m
  [32mkittyIndexToApproved[0m[32m[[0m[32mstor6[0m[32m.length[0m[32m][0m = [32msaleAuctionAddress[0m
  require ext_code.size([32msaleAuctionAddress[0m)
  call [32msaleAuctionAddress[0m.averageGen0SalePrice() with:
       gas gas_remaining - 710 [38;5;8mwei[0m
  require ext_call.success
  require ext_call.return_data[0][1m == [0mext_call.return_data[16 len 16]
  require ext_code.size([32msaleAuctionAddress[0m)
  if ext_call.return_data[0] + (ext_call.return_data[0][1m / [0m2)[1m >= [0m10^16:
      call [32msaleAuctionAddress[0m.createAuction([38;5;8muint256[0m tokenId, [38;5;8muint256[0m startingPrice, [38;5;8muint256[0m endingPrice, [38;5;8muint256[0m duration, [38;5;8maddress[0m seller) with:
           gas gas_remaining - 710 [38;5;8mwei[0m
          args [32mkitty[0m[32m.length[0m, ext_call.return_data[0] + (ext_call.return_data[0][1m / [0m2), 0, 24[1m * [0m3600, this.address
  else:
      call [32msaleAuctionAddress[0m.createAuction([38;5;8muint256[0m tokenId, [38;5;8muint256[0m startingPrice, [38;5;8muint256[0m endingPrice, [38;5;8muint256[0m duration, [38;5;8maddress[0m seller) with:
           gas gas_remaining - 710 [38;5;8mwei[0m
          args [32mkitty[0m[32m.length[0m, 10^16, 0, 24[1m * [0m3600, this.address
  require ext_call.success
  [32mgen0CreatedCount[0m++

[95mdef [0mbreedWithAuto(uint256 [32m_matronId[0m, uint256 [32m_sireId[0m)[95m payable[0m: 
  require not [32mpaused[0m
  require call.value[1m >= [0m[32mautoBirthFee[0m
  require [32mkittyIndexToOwner[0m[32m[[0m[32m_matronId[0m[32m][0m[1m == [0mcaller
  if [32mkittyIndexToOwner[0m[32m[[0m[32m_matronId[0m[32m][0m != [32mkittyIndexToOwner[0m[32m[[0m[32m_sireId[0m[32m][0m:
      require [32mkittyIndexToOwner[0m[32m[[0m[32m_matronId[0m[32m][0m[1m == [0m[32msireAllowedTo[0m[32m[[0m[32m_sireId[0m[32m][0m
  require [32m_matronId[0m[1m < [0m[32mkitty[0m[32m.length[0m
  require not [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_448[0m
  require [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_320[0m[1m <= [0m[38;5;8muint64([0mblock.number[38;5;8m)[0m
  require [32m_sireId[0m[1m < [0m[32mkitty[0m[32m.length[0m
  require not [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_448[0m
  require [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_320[0m[1m <= [0m[38;5;8muint64([0mblock.number[38;5;8m)[0m
  require [32m_matronId[0m != [32m_sireId[0m
  require [32m_sireId[0m != [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_384[0m
  require [32m_sireId[0m != [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_416[0m
  require [32m_matronId[0m != [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_384[0m
  require [32m_matronId[0m != [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_416[0m
  if [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_384[0m:
      if [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_384[0m:
          require [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_384[0m != [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_384[0m
          require [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_416[0m != [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_384[0m
          require [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_384[0m != [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_416[0m
          require [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_416[0m != [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_416[0m
  require [32m_sireId[0m[1m < [0m[32mkitty[0m[32m.length[0m
  require [32m_matronId[0m[1m < [0m[32mkitty[0m[32m.length[0m
  [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_448[0m = [38;5;8muint32([0m[32m_sireId[0m[38;5;8m)[0m
  require [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_480[0m[1m < [0m14
  require [32msecondsPerBlock[0m
  [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_320[0m = [38;5;8muint64([0m([32mcooldowns[0m[32m[[0m[32mstor6[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_480[0m[32m][0m[1m / [0m[32msecondsPerBlock[0m) + block.number[38;5;8m)[0m
  if [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_480[0m[1m < [0m13:
      [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_480[0m = [38;5;8muint16([0m[32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_480[0m + 1[38;5;8m)[0m
  require [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_480[0m[1m < [0m14
  require [32msecondsPerBlock[0m
  [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_320[0m = [38;5;8muint64([0m([32mcooldowns[0m[32m[[0m[32mstor6[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_480[0m[32m][0m[1m / [0m[32msecondsPerBlock[0m) + block.number[38;5;8m)[0m
  if [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_480[0m[1m < [0m13:
      [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_480[0m = [38;5;8muint16([0m[32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_480[0m + 1[38;5;8m)[0m
  [32msireAllowedTo[0m[32m[[0m[32m_matronId[0m[32m][0m = 0
  [32msireAllowedTo[0m[32m[[0m[32m_sireId[0m[32m][0m = 0
  [32mpregnantKitties[0m++
  [38;5;8mlog Pregnant([0m
  [38;5;8m      address owner=kittyIndexToOwner[_matronId],[0m
  [38;5;8m      uint256 mareId=_matronId,[0m
  [38;5;8m      uint256 stallionId=_sireId,[0m
  [38;5;8m      uint256 unproductiveEndBlock=kitty[_matronId].field_320)[0m

[95mdef [0mbidOnSiringAuction(uint256 [32m_sireId[0m, uint256 [32m_matronId[0m)[95m payable[0m: 
  require not [32mpaused[0m
  require [32mkittyIndexToOwner[0m[32m[[0m[32m_matronId[0m[32m][0m[1m == [0mcaller
  require [32m_matronId[0m[1m > [0m0
  require [32m_matronId[0m[1m < [0m[32mkitty[0m[32m.length[0m
  require not [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_448[0m
  require [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_320[0m[1m <= [0m[38;5;8muint64([0mblock.number[38;5;8m)[0m
  require [32m_matronId[0m[1m < [0m[32mkitty[0m[32m.length[0m
  require [32m_sireId[0m[1m < [0m[32mkitty[0m[32m.length[0m
  require [32m_matronId[0m != [32m_sireId[0m
  require [32m_sireId[0m != [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_384[0m
  require [32m_sireId[0m != [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_416[0m
  require [32m_matronId[0m != [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_384[0m
  require [32m_matronId[0m != [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_416[0m
  if [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_384[0m:
      if [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_384[0m:
          require [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_384[0m != [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_384[0m
          require [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_416[0m != [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_384[0m
          require [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_384[0m != [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_416[0m
          require [32mkitty[0m[32m[[0m[32m_sireId[0m[32m][0m[32m.field_416[0m != [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_416[0m
  require ext_code.size([32msiringAuctionAddress[0m)
  call [32msiringAuctionAddress[0m.getCurrentPrice([38;5;8muint256[0m tokenId) with:
       gas gas_remaining - 710 [38;5;8mwei[0m
      args [32m_sireId[0m
  require ext_call.success
  require call.value[1m >= [0mext_call.return_data[0] + [32mautoBirthFee[0m
  require ext_code.size([32msiringAuctionAddress[0m)
  call [32msiringAuctionAddress[0m.bid([38;5;8muint256[0m tokenId) with:
     value call.value - [32mautoBirthFee[0m [38;5;8mwei[0m
       gas gas_remaining - 9710 [38;5;8mwei[0m
      args [32m_sireId[0m
  require ext_call.success
  require [38;5;8muint32([0m[32m_sireId[0m[38;5;8m)[0m[1m < [0m[32mkitty[0m[32m.length[0m
  require [38;5;8muint32([0m[32m_matronId[0m[38;5;8m)[0m[1m < [0m[32mkitty[0m[32m.length[0m
  [32mkitty[0m[32m[[0m2[1m * [0m[38;5;8muint32([0m[32m_matronId[0m[38;5;8m)[0m[32m][0m[32m.field_448[0m = [38;5;8muint32([0m[32m_sireId[0m[38;5;8m)[0m
  require [32mkitty[0m[32m[[0m2[1m * [0m[38;5;8muint32([0m[32m_sireId[0m[38;5;8m)[0m[32m][0m[32m.field_480[0m[1m < [0m14
  require [32msecondsPerBlock[0m
  [32mkitty[0m[32m[[0m2[1m * [0m[38;5;8muint32([0m[32m_sireId[0m[38;5;8m)[0m[32m][0m[32m.field_320[0m = [38;5;8muint64([0m([32mcooldowns[0m[32m[[0m[32mstor6[0m[32m[[0m2[1m * [0m[38;5;8muint32([0m[32m_sireId[0m[38;5;8m)[0m[32m][0m[32m.field_480[0m[32m][0m[1m / [0m[32msecondsPerBlock[0m) + block.number[38;5;8m)[0m
  if [32mkitty[0m[32m[[0m2[1m * [0m[38;5;8muint32([0m[32m_sireId[0m[38;5;8m)[0m[32m][0m[32m.field_480[0m[1m < [0m13:
      [32mkitty[0m[32m[[0m2[1m * [0m[38;5;8muint32([0m[32m_sireId[0m[38;5;8m)[0m[32m][0m[32m.field_480[0m = [38;5;8muint16([0m[32mkitty[0m[32m[[0m2[1m * [0m[38;5;8muint32([0m[32m_sireId[0m[38;5;8m)[0m[32m][0m[32m.field_480[0m + 1[38;5;8m)[0m
  require [32mkitty[0m[32m[[0m2[1m * [0m[38;5;8muint32([0m[32m_matronId[0m[38;5;8m)[0m[32m][0m[32m.field_480[0m[1m < [0m14
  require [32msecondsPerBlock[0m
  [32mkitty[0m[32m[[0m2[1m * [0m[38;5;8muint32([0m[32m_matronId[0m[38;5;8m)[0m[32m][0m[32m.field_320[0m = [38;5;8muint64([0m([32mcooldowns[0m[32m[[0m[32mstor6[0m[32m[[0m2[1m * [0m[38;5;8muint32([0m[32m_matronId[0m[38;5;8m)[0m[32m][0m[32m.field_480[0m[32m][0m[1m / [0m[32msecondsPerBlock[0m) + block.number[38;5;8m)[0m
  if [32mkitty[0m[32m[[0m2[1m * [0m[38;5;8muint32([0m[32m_matronId[0m[38;5;8m)[0m[32m][0m[32m.field_480[0m[1m < [0m13:
      [32mkitty[0m[32m[[0m2[1m * [0m[38;5;8muint32([0m[32m_matronId[0m[38;5;8m)[0m[32m][0m[32m.field_480[0m = [38;5;8muint16([0m[32mkitty[0m[32m[[0m2[1m * [0m[38;5;8muint32([0m[32m_matronId[0m[38;5;8m)[0m[32m][0m[32m.field_480[0m + 1[38;5;8m)[0m
  [32msireAllowedTo[0m[32m[[0m[32m_matronId[0m[1m << [0m224[32m][0m = 0
  [32msireAllowedTo[0m[32m[[0m[38;5;8muint32([0m[32m_sireId[0m[38;5;8m)[0m[32m][0m = 0
  [32mpregnantKitties[0m++
  [38;5;8mlog Pregnant([0m
  [38;5;8m      address owner=kittyIndexToOwner[_matronId << 224],[0m
  [38;5;8m      uint256 mareId=_matronId << 224,[0m
  [38;5;8m      uint256 stallionId=_sireId << 224,[0m
  [38;5;8m      uint256 unproductiveEndBlock=kitty[2 * uint32(_matronId)].field_320)[0m

[95mdef [0mgiveBirth(uint256 [32m_matronId[0m): [38;5;8m# not payable[0m
  require not [32mpaused[0m
  require [32m_matronId[0m[1m < [0m[32mkitty[0m[32m.length[0m
  require [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_256[0m
  require [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_448[0m
  require [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_320[0m[1m <= [0m[38;5;8muint64([0mblock.number[38;5;8m)[0m
  require [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_448[0m[1m < [0m[32mkitty[0m[32m.length[0m
  require ext_code.size([32mgeneScienceAddress[0m)
  call [32mgeneScienceAddress[0m.mixGenes([38;5;8muint256[0m genes1, [38;5;8muint256[0m genes2, [38;5;8muint256[0m targetBlock) with:
       gas gas_remaining - 710 [38;5;8mwei[0m
      args [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_0[0m, [32mkitty[0m[32m[[0m[32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_448[0m[32m][0m[32m.field_0[0m, [38;5;8muint64([0m[32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_320[0m - 1[38;5;8m)[0m
  require ext_call.success
  require [32m_matronId[0m[1m == [0m[38;5;8muint32([0m[32m_matronId[0m[38;5;8m)[0m
  require [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_448[0m[1m == [0m[32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_448[0m
  if [32mkitty[0m[32m[[0m[32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_448[0m[32m][0m[32m.field_496[0m[1m <= [0m[32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_496[0m:
      require [38;5;8muint16([0m[32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_496[0m + 1[38;5;8m)[0m[1m == [0m[38;5;8muint16([0m[32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_496[0m + 1[38;5;8m)[0m
      [32mkitty[0m[32m.length[0m++
      if not [32mkitty[0m[32m.length[0m[1m <= [0m[32mkitty[0m[32m.length[0m + 1:
          [94midx[0m = 2[1m * [0m[32mkitty[0m[32m.length[0m + 1
          [32mwhile [0m2[1m * [0m[32mkitty[0m[32m.length[0m[1m > [0m[94midx[0m[32m:[0m
              [32mkitty[0m[32m[[0m[94midx[0m[32m][0m[32m.field_0[0m = 0
              [32mkitty[0m[32m[[0m[94midx[0m[32m][0m[32m.field_256[0m = 0
              [94midx[0m = [94midx[0m + 2
              [32mcontinue [0m
      [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_0[0m = ext_call.return_data[0]
      [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_256[0m = [38;5;8muint64([0mblock.timestamp[38;5;8m)[0m
      [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_320[0m = 0
      [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_512[0m = 0
      [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_384[0m = [38;5;8muint32([0m[32m_matronId[0m[38;5;8m)[0m
      [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_416[0m = [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_448[0m
      [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_448[0m = 0
      [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_512[0m = 0
      if [38;5;8muint16([0m[32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_496[0m + 1[38;5;8m)[0m[1m / [0m2[1m <= [0m13:
          [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_480[0m = [38;5;8muint16([0m[32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_496[0m + 1[38;5;8m)[0m[1m / [0m2
          [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_495[0m = 0
      else:
          [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_480[0m = 13
          [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_488[0m = 0
      [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_496[0m = [38;5;8muint16([0m[32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_496[0m + 1[38;5;8m)[0m
  else:
      require [38;5;8muint16([0m[32mkitty[0m[32m[[0m[32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_448[0m[32m][0m[32m.field_496[0m + 1[38;5;8m)[0m[1m == [0m[38;5;8muint16([0m[32mkitty[0m[32m[[0m[32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_448[0m[32m][0m[32m.field_496[0m + 1[38;5;8m)[0m
      [32mkitty[0m[32m.length[0m++
      if not [32mkitty[0m[32m.length[0m[1m <= [0m[32mkitty[0m[32m.length[0m + 1:
          [94midx[0m = 2[1m * [0m[32mkitty[0m[32m.length[0m + 1
          [32mwhile [0m2[1m * [0m[32mkitty[0m[32m.length[0m[1m > [0m[94midx[0m[32m:[0m
              [32mkitty[0m[32m[[0m[94midx[0m[32m][0m[32m.field_0[0m = 0
              [32mkitty[0m[32m[[0m[94midx[0m[32m][0m[32m.field_256[0m = 0
              [94midx[0m = [94midx[0m + 2
              [32mcontinue [0m
      [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_0[0m = ext_call.return_data[0]
      [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_256[0m = [38;5;8muint64([0mblock.timestamp[38;5;8m)[0m
      [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_320[0m = 0
      [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_512[0m = 0
      [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_384[0m = [38;5;8muint32([0m[32m_matronId[0m[38;5;8m)[0m
      [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_416[0m = [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_448[0m
      [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_448[0m = 0
      [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_512[0m = 0
      if [38;5;8muint16([0m[32mkitty[0m[32m[[0m[32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_448[0m[32m][0m[32m.field_496[0m + 1[38;5;8m)[0m[1m / [0m2[1m <= [0m13:
          [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_480[0m = [38;5;8muint16([0m[32mkitty[0m[32m[[0m[32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_448[0m[32m][0m[32m.field_496[0m + 1[38;5;8m)[0m[1m / [0m2
          [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_495[0m = 0
      else:
          [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_480[0m = 13
          [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_488[0m = 0
      [32mkitty[0m[32m[[0m[32mkitty[0m[32m.length[0m[32m][0m[32m.field_496[0m = [38;5;8muint16([0m[32mkitty[0m[32m[[0m[32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_448[0m[32m][0m[32m.field_496[0m + 1[38;5;8m)[0m
  require [32mkitty[0m[32m.length[0m[1m == [0m[38;5;8muint32([0m[32mkitty[0m[32m.length[0m[38;5;8m)[0m
  [38;5;8mlog Birth([0m
  [38;5;8m      address owner=kittyIndexToOwner[_matronId],[0m
  [38;5;8m      uint256 clownId=kitty.length,[0m
  [38;5;8m      uint256 matronId=_matronId << 224,[0m
  [38;5;8m      uint256 sireId=kitty[_matronId].field_256,[0m
  [38;5;8m      uint256 genes=ext_call.return_data[0])[0m
  [32mbalanceOf[0m[32m[[0m[32mstor7[0m[32m[[0m[32m_matronId[0m[32m][0m[32m][0m++
  [32mkittyIndexToOwner[0m[32m[[0m[32mstor6[0m[32m.length[0m[32m][0m = [32mkittyIndexToOwner[0m[32m[[0m[32m_matronId[0m[32m][0m
  [38;5;8mlog Transfer([0m
  [38;5;8m      address from=0,[0m
  [38;5;8m      address to=kittyIndexToOwner[_matronId],[0m
  [38;5;8m      uint256 value=kitty.length)[0m
  [32mkitty[0m[32m[[0m[32m_matronId[0m[32m][0m[32m.field_448[0m = 0
  [32mpregnantKitties[0m--
  call caller with:
     value [32mautoBirthFee[0m [38;5;8mwei[0m
       gas 2300 * is_zero(value) [38;5;8mwei[0m
  return [32mkitty[0m[32m.length[0m

