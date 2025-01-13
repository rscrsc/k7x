.global init
.global __bss_start
.global __bss_size

init:
1:  mov x20, #42
    b 1b

.balign 16
.bss
__bss_start:
/* bss here */
__bss_end:
__bss_size = __bss_end - __bss_start
