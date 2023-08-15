.globl _start
_start:
    addi sp, x0, 0x1000
    jal x1, main
