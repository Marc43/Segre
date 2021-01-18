segre_test:
    li x1, 0x1
    li x2, 0x20
    li x3, 0x0
    li x4, 0x1
    li x5, 0x2
    li x6, 0x3
    li x7, 0x4
    li x8, 0x5

    div x10, x1, x4
    div x11, x1, x5
    div x12, x1, x6
    div x13, x1, x7
    div x14, x1, x8

    div x16, x2, x4
    div x17, x2, x5
    div x18, x2, x6
    div x19, x2, x7
    div x20, x2, x8

    div x21, x1, x2
    div x22, x5, x2
    div x23, x6, x2
    div x24, x7, x2
    div x25, x8, x2
