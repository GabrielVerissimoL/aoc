.text	# 0x00000000 
.globl _start
_start:
    li s0, 0x104
    li t0, 0x400
    li t1, 0x200
    li t2, 0x1

vai:
    srli t0, t0, 1
    sw t0, 0(s0)
    bne t0, t2, vai

volta:
    slli t0, t0, 1
    sw t0, 0(s0)
    bne t0, t1, volta
    j vai

.data	# 0x00000100 