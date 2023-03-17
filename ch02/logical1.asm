    org 0x100
start:
    mov al,0x32
    and al,0x0f

    add al,0x30     ; convert to ASCII
    call display_letter

    %include "../lib/library1.asm"