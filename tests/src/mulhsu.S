segre_test:
    li x1, 0x1
    li x2, 0xffffffff
    li x3, 0x0
    li x4, 0x1
    li x5, 0x2
    li x6, 0x3
    li x7, 0x4
    li x8, 0x5

    mulhsu x9, x1, x3
    mulhsu x10, x1, x4
    mulhsu x11, x1, x5
    mulhsu x12, x1, x6
    mulhsu x13, x1, x7
    mulhsu x14, x1, x8

    mulhsu x15, x2, x3
    mulhsu x16, x2, x4
    mulhsu x17, x2, x5
    mulhsu x18, x2, x6
    mulhsu x19, x2, x7
    mulhsu x20, x2, x8

    mulhsu x21, x1, x2
    mulhsu x22, x5, x2
    mulhsu x23, x6, x2
    mulhsu x24, x7, x2
    mulhsu x25, x8, x2
