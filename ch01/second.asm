    org 0x100
start:
    mov ah,0x00     ; keybaord read
    int 0x16        ; BIOS keyboard services

    cmp al,0x1b     ; ESC key pressed?
    je exit_to_command_line
    mov ah,0x0e     ; display letter in terminal
    mov bx,0x000f   ; BH is page zero, BL is color (graphic mode)
    int 0x10        ; BIOS video services
    jmp start

exit_to_command_line:
    int 0x20        ; DOS terminate program
    