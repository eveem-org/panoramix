## Opcodes doc

(mask_shl, size, offset, shl, value)
(mask_shl, 256, 0, 0, val) == val
(mask_shl, 255, 0, 1) == 2 * val
(mask_shl, 254, 0, 2) == 4 * val
(mask_shl, 255, 1, -1) == val / 2
evererything is in bits
