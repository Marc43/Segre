segre_test:
    li x1, 0x1
    li x2, 0xffffffff
    li x3, 0x0
    li x4, 0x1
    li x5, 0x2
    li x6, 0x3
    li x7, 0x4
    li x8, 0x5

    mulh x9, x1, x3
    mulh x10, x1, x4
    mulh x11, x1, x5
    mulh x12, x1, x6
    mulh x13, x1, x7
    mulh x14, x1, x8

    mulh x15, x2, x3
    mulh x16, x2, x4
    mulh x17, x2, x5
    mulh x18, x2, x6
    mulh x19, x2, x7
    mulh x20, x2, x8
