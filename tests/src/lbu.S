.globl _start
.section .text

segre_test:
    li x1,  0xffffffff
    li x2,  0xffffffff
    li x3,  0xffffffff
    li x4,  0xffffffff
    li x5,  0xffffffff
    li x6,  0xffffffff
    li x7,  0xffffffff
    li x8,  0xffffffff
    li x9,  0xffffffff
    li x10, 0xffffffff
    li x11, 0xffffffff
    li x12, 0xffffffff
    li x13, 0xffffffff
    li x14, 0xffffffff
    li x15, 0xffffffff
    li x17, 0xffffffff
    li x18, 0xffffffff
    li x19, 0xffffffff
    li x20, 0xffffffff
    li x21, 0xffffffff
    li x22, 0xffffffff
    li x23, 0xffffffff
    li x24, 0xffffffff
    li x25, 0xffffffff
    li x26, 0xffffffff
    li x27, 0xffffffff
    li x28, 0xffffffff
    li x29, 0xffffffff
    la x30, user_stack_start
    lbu x0, 0(x30)
    lbu x1, 1(x30)
    lbu x2, 2(x30)
    lbu x3, 3(x30)
    lbu x4, 4(x30)
    lbu x5, 5(x30)
    lbu x6, 6(x30)
    lbu x7, 7(x30)
    lbu x8, 8(x30)
    lbu x9, 9(x30)
    lbu x10, 10(x30)
    lbu x11, 11(x30)
    lbu x12, 12(x30)
    lbu x13, 13(x30)
    lbu x14, 14(x30)
    lbu x15, 15(x30)
    lbu x16, 16(x30)
    lbu x17, 17(x30)
    lbu x18, 18(x30)
    lbu x19, 19(x30)
    lbu x20, 20(x30)
    lbu x21, 21(x30)
    lbu x22, 22(x30)
    lbu x23, 23(x30)
    lbu x24, 24(x30)
    lbu x25, 25(x30)
    lbu x26, 26(x30)
    lbu x27, 27(x30)
    lbu x28, 28(x30)
    lbu x29, 29(x30)
    li x30, 0xffffffff
    li x31, 0xffffffff
