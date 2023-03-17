    org 0x100
start:
    mov al,0x02
    shl al,1

    add al,0x30     ; convert to ASCII
    call display_letter

    %include "../lib/library1.asm"