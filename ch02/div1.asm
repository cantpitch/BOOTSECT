    org 0x100
start:
    mov ax,0x64
    mov cl,0x21
    div cl          ; al = ax/cl, ah = ax % cl

    add al,0x30     ; convert to ASCII
    call display_letter

    %include "../lib/library1.asm"