[38;5;8m#
#  Panoramix 4 Oct 2019 
#  Decompiled source of [0m0x165cFb9cCf8b185E03205Ab4118eA6afBdbA9203[38;5;8m
# 
#  Let's make the world open source 
# [0m

[95mconst [0mNOT_AUDITED = [1m0[0m
[95mconst [0mMAX_COMMISSION = [1m9[0m
[95mconst [0mMIN_AUDIT_TIME = [1m(24 * 3600)[0m
[95mconst [0mMAX_AUDIT_TIME = [1m(672 * 24 * 3600)[0m

[32mdef [0mstorage:
  [32mowner[0m is addr [38;5;8mat storage 0[0m[38;5;8m[0m
  [32mpaused[0m is uint8 [38;5;8mat storage 0[0m[38;5;8m offset 160[0m
  [32mnewContractAddress[0m is addr [38;5;8mat storage 1[0m[38;5;8m[0m
  [32mtotalRequestsAmount[0m is uint256 [38;5;8mat storage 2[0m[38;5;8m[0m
  [32mavailableCommission[0m is uint256 [38;5;8mat storage 3[0m[38;5;8m[0m
  [32mcommission[0m is uint256 [38;5;8mat storage 4[0m[38;5;8m[0m
  [32msolidStampRegisterAddress[0m is addr [38;5;8mat storage 5[0m[38;5;8m[0m
  [32mrewards[0m is mapping of uint256 [38;5;8mat storage 6[0m
  [32mauditRequests[0m is mapping of struct [38;5;8mat storage 7[0m

[95mdef [0mRewards(bytes32 [32m_param1[0m): [38;5;8m# not payable[0m
  return [32mrewards[0m[32m[[0m[32m_param1[0m[32m][0m

[95mdef [0mAuditRequests(bytes32 [32m_param1[0m): [38;5;8m# not payable[0m
  return [32mauditRequests[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_0[0m, [32mauditRequests[0m[32m[[0m[32m_param1[0m[32m][0m[32m.field_256[0m

[95mdef [0mCommission(): [38;5;8m# not payable[0m
  return [32mcommission[0m

[95mdef [0mSolidStampRegisterAddress(): [38;5;8m# not payable[0m
  return [32msolidStampRegisterAddress[0m

[95mdef [0mpaused(): [38;5;8m# not payable[0m
  return bool([32mpaused[0m)

[95mdef [0mAvailableCommission(): [38;5;8m# not payable[0m
  return [32mavailableCommission[0m

[95mdef [0mnewContractAddress(): [38;5;8m# not payable[0m
  return [32mnewContractAddress[0m

[95mdef [0mowner(): [38;5;8m# not payable[0m
  return [32mowner[0m

[95mdef [0mTotalRequestsAmount(): [38;5;8m# not payable[0m
  return [32mtotalRequestsAmount[0m

[38;5;8m#
#  Regular functions
#[0m

[95mdef [0m_fallback()[95m payable[0m: [38;5;8m# default function[0m
  revert

[95mdef [0mpause(): [38;5;8m# not payable[0m
  require caller[1m == [0m[32mowner[0m
  require not [32mpaused[0m
  [32mpaused[0m = 1
  [38;5;8mlog Pause()[0m

[95mdef [0mrenounceOwnership(): [38;5;8m# not payable[0m
  require caller[1m == [0m[32mowner[0m
  [38;5;8mlog OwnershipRenounced(address previousOwner=owner)[0m
  [32mowner[0m = 0

[95mdef [0msetNewAddress(address [32m_v2Address[0m): [38;5;8m# not payable[0m
  require caller[1m == [0m[32mowner[0m
  require [32mpaused[0m
  require [32m_v2Address[0m
  [32mnewContractAddress[0m = [32m_v2Address[0m
  [38;5;8mlog ContractUpgrade(address newContract=_v2Address)[0m

[95mdef [0munpause(): [38;5;8m# not payable[0m
  require caller[1m == [0m[32mowner[0m
  require [32mpaused[0m
  if [32mnewContractAddress[0m:
      revert with 0, 'new contract cannot be 0x0'
  require caller[1m == [0m[32mowner[0m
  require [32mpaused[0m
  [32mpaused[0m = 0
  [38;5;8mlog Unpause()[0m

[95mdef [0mtransferOwnership(address [32m_newOwner[0m): [38;5;8m# not payable[0m
  require caller[1m == [0m[32mowner[0m
  require [32m_newOwner[0m
  [38;5;8mlog OwnershipTransferred([0m
  [38;5;8m      address previousOwner=owner,[0m
  [38;5;8m      address newOwner=_newOwner)[0m
  [32mowner[0m = [32m_newOwner[0m

[95mdef [0mchangeCommission(uint256 [32m_newCommission[0m): [38;5;8m# not payable[0m
  require caller[1m == [0m[32mowner[0m
  require not [32mpaused[0m
  if [32m_newCommission[0m[1m > [0m9:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'commission should be <= MAX_COMMISSION'
  if [32m_newCommission[0m[1m == [0m[32mcommission[0m:
      revert with 0, '_newCommission==Commmission'
  [32mcommission[0m = [32m_newCommission[0m
  [38;5;8mlog NewCommission(uint256 commmission=_newCommission)[0m

[95mdef [0mwithdrawCommission(uint256 [32m_amount[0m): [38;5;8m# not payable[0m
  require caller[1m == [0m[32mowner[0m
  if [32m_amount[0m[1m > [0m[32mavailableCommission[0m:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'Cannot withdraw more than available'
  [32mavailableCommission[0m -= [32m_amount[0m
  call caller with:
     value [32m_amount[0m [38;5;8mwei[0m
       gas 2300 * is_zero(value) [38;5;8mwei[0m
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]

[95mdef [0mwithdrawRequest(address [32m_auditor[0m, bytes32 [32m_codeHash[0m): [38;5;8m# not payable[0m
  require ext_code.size([32msolidStampRegisterAddress[0m)
  call [32msolidStampRegisterAddress[0m.getAuditOutcome([38;5;8maddress[0m auditor, [38;5;8mbytes32[0m codeHash) with:
       gas gas_remaining [38;5;8mwei[0m
      args [38;5;8maddr([0m[32m_auditor[0m[38;5;8m)[0m, [32m_codeHash[0m
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m32
  if [38;5;8muint8([0mext_call.return_data[0][38;5;8m)[0m:
      revert with 0, 'contract already audited'
  if [32mauditRequests[0m[32m[[0m[32m_auditor[0m[32m][[0mcaller[32m][[0m[32m_codeHash[0m[32m][0m[32m.field_0[0m[1m <= [0m0:
      revert with 0, 'nothing to withdraw'
  if block.timestamp[1m <= [0m[32mauditRequests[0m[32m[[0m[32m_auditor[0m[32m][[0mcaller[32m][[0m[32m_codeHash[0m[32m][0m[32m.field_256[0m:
      revert with 0, 'cannot withdraw before request.expireDate'
  [32mauditRequests[0m[32m[[0m[32m_auditor[0m[32m][[0mcaller[32m][[0m[32m_codeHash[0m[32m][0m[32m.field_0[0m = 0
  [32mauditRequests[0m[32m[[0m[32m_auditor[0m[32m][[0mcaller[32m][[0m[32m_codeHash[0m[32m][0m[32m.field_256[0m = 0
  require [32mauditRequests[0m[32m[[0m[32m_auditor[0m[32m][[0mcaller[32m][[0m[32m_codeHash[0m[32m][0m[32m.field_0[0m[1m <= [0m[32mrewards[0m[32m[[0m[32m_auditor[0m[32m][[0m[32m_codeHash[0m[32m][0m
  [32mrewards[0m[32m[[0m[32m_auditor[0m[32m][[0m[32m_codeHash[0m[32m][0m -= [32mauditRequests[0m[32m[[0m[32m_auditor[0m[32m][[0mcaller[32m][[0m[32m_codeHash[0m[32m][0m[32m.field_0[0m
  require [32mauditRequests[0m[32m[[0m[32m_auditor[0m[32m][[0mcaller[32m][[0m[32m_codeHash[0m[32m][0m[32m.field_0[0m[1m <= [0m[32mtotalRequestsAmount[0m
  [32mtotalRequestsAmount[0m -= [32mauditRequests[0m[32m[[0m[32m_auditor[0m[32m][[0mcaller[32m][[0m[32m_codeHash[0m[32m][0m[32m.field_0[0m
  [38;5;8mlog RequestWithdrawn([0m
  [38;5;8m      address auditor=addr(_auditor),[0m
  [38;5;8m      address bidder=caller,[0m
  [38;5;8m      bytes32 codeHash=_codeHash,[0m
  [38;5;8m      uint256 amount=auditRequests[_auditor][caller][_codeHash].field_0)[0m
  call caller with:
     value [32mauditRequests[0m[32m[[0m[32m_auditor[0m[32m][[0mcaller[32m][[0m[32m_codeHash[0m[32m][0m[32m.field_0[0m [38;5;8mwei[0m
       gas 2300 * is_zero(value) [38;5;8mwei[0m
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]

[95mdef [0mauditContract(address [32m_auditor[0m, bytes32 [32m_codeHash[0m, bytes [32m_reportIPFS[0m, bool [32m_isApproved[0m): [38;5;8m# not payable[0m
  require not [32mpaused[0m
  if [32msolidStampRegisterAddress[0m != caller:
      revert with 0, 'can be only run by SolidStampRegister contract'
  require [32mrewards[0m[32m[[0m[32m_auditor[0m[32m][[0m[32m_codeHash[0m[32m][0m[1m <= [0m[32mtotalRequestsAmount[0m
  [32mtotalRequestsAmount[0m -= [32mrewards[0m[32m[[0m[32m_auditor[0m[32m][[0m[32m_codeHash[0m[32m][0m
  if not [32mrewards[0m[32m[[0m[32m_auditor[0m[32m][[0m[32m_codeHash[0m[32m][0m:
      require [32mavailableCommission[0m[1m >= [0m[32mavailableCommission[0m
      [38;5;8mlog ContractAudited([0m
      [38;5;8m      address auditor=addr(_auditor),[0m
      [38;5;8m      bytes32 codeHash=_codeHash,[0m
      [38;5;8m      bytes reportIPFS=Array(len=_reportIPFS.length, data=_reportIPFS[all]),[0m
      [38;5;8m      bool isApproved=_isApproved,[0m
      [38;5;8m      uint256 reward=rewards[_auditor][_codeHash])[0m
      require 0[1m <= [0m[32mrewards[0m[32m[[0m[32m_auditor[0m[32m][[0m[32m_codeHash[0m[32m][0m
      call [32m_auditor[0m with:
         value [32mrewards[0m[32m[[0m[32m_auditor[0m[32m][[0m[32m_codeHash[0m[32m][0m [38;5;8mwei[0m
           gas 2300 * is_zero(value) [38;5;8mwei[0m
  else:
      require [32mcommission[0m[1m * [0m[32mrewards[0m[32m[[0m[32m_auditor[0m[32m][[0m[32m_codeHash[0m[32m][0m[1m / [0m[32mrewards[0m[32m[[0m[32m_auditor[0m[32m][[0m[32m_codeHash[0m[32m][0m[1m == [0m[32mcommission[0m
      require ([32mcommission[0m[1m * [0m[32mrewards[0m[32m[[0m[32m_auditor[0m[32m][[0m[32m_codeHash[0m[32m][0m[1m / [0m100) + [32mavailableCommission[0m[1m >= [0m[32mavailableCommission[0m
      [32mavailableCommission[0m += [32mcommission[0m[1m * [0m[32mrewards[0m[32m[[0m[32m_auditor[0m[32m][[0m[32m_codeHash[0m[32m][0m[1m / [0m100
      [38;5;8mlog ContractAudited([0m
      [38;5;8m      address auditor=addr(_auditor),[0m
      [38;5;8m      bytes32 codeHash=_codeHash,[0m
      [38;5;8m      bytes reportIPFS=Array(len=_reportIPFS.length, data=_reportIPFS[all]),[0m
      [38;5;8m      bool isApproved=_isApproved,[0m
      [38;5;8m      uint256 reward=rewards[_auditor][_codeHash])[0m
      require [32mcommission[0m[1m * [0m[32mrewards[0m[32m[[0m[32m_auditor[0m[32m][[0m[32m_codeHash[0m[32m][0m[1m / [0m100[1m <= [0m[32mrewards[0m[32m[[0m[32m_auditor[0m[32m][[0m[32m_codeHash[0m[32m][0m
      call [32m_auditor[0m with:
         value [32mrewards[0m[32m[[0m[32m_auditor[0m[32m][[0m[32m_codeHash[0m[32m][0m - ([32mcommission[0m[1m * [0m[32mrewards[0m[32m[[0m[32m_auditor[0m[32m][[0m[32m_codeHash[0m[32m][0m[1m / [0m100) [38;5;8mwei[0m
           gas 2300 * is_zero(value) [38;5;8mwei[0m
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]

[95mdef [0mrequestAudit(address [32m_auditor[0m, bytes32 [32m_codeHash[0m, uint256 [32m_auditTime[0m)[95m payable[0m: 
  require not [32mpaused[0m
  if not [32m_auditor[0m:
      revert with 0, '_auditor cannot be 0x0'
  if [32m_auditTime[0m[1m < [0m24[1m * [0m3600:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, '_auditTime should be >= MIN_AUDIT_TIME'
  if [32m_auditTime[0m[1m > [0m672[1m * [0m24[1m * [0m3600:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, '_auditTime should be <= MIN_AUDIT_TIME'
  if call.value[1m <= [0m0:
      revert with 0, 'msg.value should be >0'
  require ext_code.size([32msolidStampRegisterAddress[0m)
  call [32msolidStampRegisterAddress[0m.getAuditOutcome([38;5;8maddress[0m auditor, [38;5;8mbytes32[0m codeHash) with:
       gas gas_remaining [38;5;8mwei[0m
      args [38;5;8maddr([0m[32m_auditor[0m[38;5;8m)[0m, [32m_codeHash[0m
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size[1m >= [0m32
  if ext_call.return_data[31 len 1]:
      revert with 0, 'contract already audited'
  require [32m_auditTime[0m + block.timestamp[1m >= [0mblock.timestamp
  require call.value + [32mrewards[0m[32m[[0m[32m_auditor[0m[32m][[0m[32m_codeHash[0m[32m][0m[1m >= [0m[32mrewards[0m[32m[[0m[32m_auditor[0m[32m][[0m[32m_codeHash[0m[32m][0m
  [32mrewards[0m[32m[[0m[32m_auditor[0m[32m][[0m[32m_codeHash[0m[32m][0m += call.value
  require call.value + [32mtotalRequestsAmount[0m[1m >= [0m[32mtotalRequestsAmount[0m
  [32mtotalRequestsAmount[0m += call.value
  if not [32mauditRequests[0m[32m[[0m[32m_auditor[0m[32m][[0mcaller[32m][[0m[32m_codeHash[0m[32m][0m[32m.field_0[0m:
      [32mauditRequests[0m[32m[[0m[32m_auditor[0m[32m][[0mcaller[32m][[0m[32m_codeHash[0m[32m][0m[32m.field_0[0m = call.value
      [32mauditRequests[0m[32m[[0m[32m_auditor[0m[32m][[0mcaller[32m][[0m[32m_codeHash[0m[32m][0m[32m.field_256[0m = [32m_auditTime[0m + block.timestamp
      [38;5;8mlog AuditRequested([0m
      [38;5;8m      address auditor=addr(_auditor),[0m
      [38;5;8m      address bidder=caller,[0m
      [38;5;8m      bytes32 codeHash=_codeHash,[0m
      [38;5;8m      uint256 amount=call.value,[0m
      [38;5;8m      uint256 expireDate=_auditTime + block.timestamp)[0m
  else:
      require call.value + [32mauditRequests[0m[32m[[0m[32m_auditor[0m[32m][[0mcaller[32m][[0m[32m_codeHash[0m[32m][0m[32m.field_0[0m[1m >= [0m[32mauditRequests[0m[32m[[0m[32m_auditor[0m[32m][[0mcaller[32m][[0m[32m_codeHash[0m[32m][0m[32m.field_0[0m
      [32mauditRequests[0m[32m[[0m[32m_auditor[0m[32m][[0mcaller[32m][[0m[32m_codeHash[0m[32m][0m[32m.field_0[0m += call.value
      if [32m_auditTime[0m + block.timestamp[1m > [0m[32mauditRequests[0m[32m[[0m[32m_auditor[0m[32m][[0mcaller[32m][[0m[32m_codeHash[0m[32m][0m[32m.field_256[0m:
          [32mauditRequests[0m[32m[[0m[32m_auditor[0m[32m][[0mcaller[32m][[0m[32m_codeHash[0m[32m][0m[32m.field_256[0m = [32m_auditTime[0m + block.timestamp
      [38;5;8mlog AuditRequested([0m
      [38;5;8m      address auditor=addr(_auditor),[0m
      [38;5;8m      address bidder=caller,[0m
      [38;5;8m      bytes32 codeHash=_codeHash,[0m
      [38;5;8m      uint256 amount=auditRequests[_auditor][caller][_codeHash].field_0,[0m
      [38;5;8m      uint256 expireDate=auditRequests[_auditor][caller][_codeHash].field_256)[0m

