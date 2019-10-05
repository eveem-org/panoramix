[38;5;8m#
#  Panoramix 4 Oct 2019 
#  Decompiled source of [0m0x68Cb858247ef5c4A0D0Cde9d6F68Dce93e49c02A[38;5;8m
# 
#  Let's make the world open source 
# [0m

[32mdef [0mstorage:
  [32munknown74e3fb3e[0m is array of uint256 [38;5;8mat storage 0[0m
  [32mowners[0m is array of addr [38;5;8mat storage 1[0m

[95mdef [0mowners(uint256 [32m_param1[0m): [38;5;8m# not payable[0m
  require calldata.size - 4[1m >= [0m32
  require [32m_param1[0m[1m < [0m[32mowners[0m[32m.length[0m
  return [32mowners[0m[32m[[0m[32m_param1[0m[32m][0m

[95mdef [0munknown74e3fb3e(uint256 [32m_param1[0m): [38;5;8m# not payable[0m
  require calldata.size - 4[1m >= [0m32
  require [32m_param1[0m[1m < [0m[32munknown74e3fb3e[0m[32m.length[0m
  return [32munknown74e3fb3e[0m[32m[[0m[32m_param1[0m[32m][0m

[38;5;8m#
#  Regular functions
#[0m

[95mdef [0m_fallback()[95m payable[0m: [38;5;8m# default function[0m
  revert

[95mdef [0munknown4214352d(uint256 [32m_param1[0m, uint256 [32m_param2[0m): [38;5;8m# not payable[0m
  require calldata.size - 4[1m >= [0m64
  require [32m_param2[0m[1m < [0m[32munknown74e3fb3e[0m[32m.length[0m
  [32munknown74e3fb3e[0m[32m[[0m[32m_param2[0m[32m][0m = [32m_param1[0m

[95mdef [0munknown2918435f(addr [32m_param1[0m)[95m payable[0m: 
  require calldata.size - 4[1m >= [0m32
  [94midx[0m = 0
  [94ms[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0m[32mowners[0m[32m.length[0m[32m:[0m
      [95mmem[[0m0[95m][0m = 1
      if [32mowners[0m[32m[[0m[94midx[0m[32m][0m != caller:
          [94midx[0m = [94midx[0m + 1
          [94ms[0m = [94ms[0m
          [32mcontinue [0m
      [94midx[0m = [94midx[0m + 1
      [94ms[0m = 1
      [32mcontinue [0m
  require [94ms[0m
  [95mmem[[0m64[95m][0m = ceil32(ext_code.size([32m_param1[0m)) + 97
  [95mmem[[0m96[95m][0m = ext_code.size([32m_param1[0m)
  [95mmem[[0m128[95m len [0mext_code.size([32m_param1[0m)[95m][0m = ext_code.copy([32m_param1[0m, 0 [95mlen[0m ext_code.size([32m_param1[0m))
  [94midx[0m = 0
  [32mwhile [0m[94midx[0m[1m < [0mext_code.size([32m_param1[0m)[32m:[0m
      require [94midx[0m[1m < [0mext_code.size([32m_param1[0m)
      require Mask(8, 248, [95mmem[[0m[94midx[0m + 128[95m][0m) != 0xf000000000000000000000000000000000000000000000000000000000000000
      require [94midx[0m[1m < [0mext_code.size([32m_param1[0m)
      require Mask(8, 248, [95mmem[[0m[94midx[0m + 128[95m][0m) != 0xf100000000000000000000000000000000000000000000000000000000000000
      require [94midx[0m[1m < [0mext_code.size([32m_param1[0m)
      require Mask(8, 248, [95mmem[[0m[94midx[0m + 128[95m][0m) != 0xf200000000000000000000000000000000000000000000000000000000000000
      require [94midx[0m[1m < [0mext_code.size([32m_param1[0m)
      require Mask(8, 248, [95mmem[[0m[94midx[0m + 128[95m][0m) != 0xf400000000000000000000000000000000000000000000000000000000000000
      require [94midx[0m[1m < [0mext_code.size([32m_param1[0m)
      require Mask(8, 248, [95mmem[[0m[94midx[0m + 128[95m][0m) != 0xfa00000000000000000000000000000000000000000000000000000000000000
      require [94midx[0m[1m < [0mext_code.size([32m_param1[0m)
      require Mask(8, 248, [95mmem[[0m[94midx[0m + 128[95m][0m) != 0xff00000000000000000000000000000000000000000000000000000000000000
      [94midx[0m = [94midx[0m + 1
      [32mcontinue [0m
  [93mdelegate[0m [32m_param1[0m with:
       gas gas_remaining [38;5;8mwei[0m
      args 
  require delegate.return_code

