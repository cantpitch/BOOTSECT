    org 0x100
start:
    mov al,0x04
    add al,0x03

    add al,0x30     ; convert to ASCII character
    call display_letter

    %include "../lib/library1.asm"