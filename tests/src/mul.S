segre_test:
    li x1, 0x1
    li x2, 0xffffffff
    li x3, 0x0
    li x4, 0x1
    li x5, 0x2
    li x6, 0x3
    li x7, 0x4
    li x8, 0x5

    mul x3, x1, x3
    mul x4, x1, x4
    mul x5, x1, x5
    mul x6, x1, x6
    mul x7, x1, x7
    mul x8, x1, x8

    mul x9, x2, x3
    mul x10, x2, x4
    mul x11, x2, x5
    mul x12, x2, x6
    mul x13, x2, x7
    mul x14, x2, x8
