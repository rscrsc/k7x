.global _start

_start:
    // if cpu0, -> 2f; if cpu1-3, -> 1f
    mrs x1, mpidr_el1
    and x1, x1, #0x3
    cbz x1, 2f
1:  wfe
    b 1b
2:  // set sp (stack pointer)
    ldr x1, =_start
    mov sp, x1
    // clear .bss
    ldr x1, =__bss_start
    ldr w2, =__bss_size
3:  cbz w2, 4f
    str xzr, [x1], #8
    sub w2, w2, #1
    cbnz w2, 3b
4:  bl init
    b 1b
