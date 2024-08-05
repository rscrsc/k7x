PHDRS {
    text PT_LOAD FLAGS(5);
    data PT_LOAD FLAGS(6);
}

SECTIONS
{
    . = 0x80000;
    .text : { *(.text.boot) *(text) } : text
    .data : { *(.data) } : data
    .bss (NOLOAD) : {
        . = ALIGN(16);
        __bss_start = .;
        *(.bss)
        __bss_end = .;
    }
    __bss_size = (__bss_end - __bss_start) >> 3;
    /DISCARD/ : { *(.comment) }
}