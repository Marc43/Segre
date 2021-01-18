OUTPUT_ARCH( "riscv" )
ENTRY(main)

SECTIONS
{
    . = 0x0;
    .text : { *(.text) }
    . = ALIGN(0xA000);
    .data : { *(.data) }
}

