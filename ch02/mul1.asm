    org 0x100
start:
    mov al,0x03
    mov cl,0x02
    mul cl          ; ax = al * cl

    add al,0x30     ; convert to ASCII
    call display_letter

    %include "../lib/library1.asm"