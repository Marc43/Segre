segre_test:
    li x1, 0x1
    li x2, 0x2
    li x3, 0x2
    li x4, 0x2
    li x5, 0x2
    li x6, 0x2
    li x31, 0x2
wb_hazard:
    mul x7, x31, x2
    add x8, x1, x2
    add x8, x1, x2
    add x8, x1, x2
    add x8, x1, x2
    addi x31, x31, -1
    bne x0, x31, wb_hazard
    li x1, 0x0
    li x2, 0x0
    li x3, 0x0
    li x4, 0x0
    li x5, 0x0
    li x6, 0x0
