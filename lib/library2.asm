    int 0x20        ; DOS exit to command-line

    ; Display ASCII letter in AL
display_letter:
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    mov ah,0x0e     ; terminal output mode
    mov bx,0x000f   ; load BH page zero, and BL color (graphic mode)
    int 0x10        ; call BIOS to display one letter
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

    ;
    ; read keyboard ASCII code into AL
    ;
read_keyboard:
    push bx
    push cx
    push dx
    push si
    push di
    mov ah,0x00     ; load AH with code for keyboard read
    int 0x16        ; BIOS read keyboard
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    ret

    ; 
    ; Display the value of AX as a decimal number
    ;
display_number:
    mov dx,0
    mov cx,10
    div cx          ; AX = DX:AX / CX
    push dx         ; save remainder (DX)
    cmp ax,0        ; are we done dividing?
    je display_number_1 ; ..yes
    call display_number ; ..no, call self recursively
display_number_1:
    pop ax          ; get remainder to print
    add al,'0'      ; convert remainder to ASCII digit
    call display_letter
    ret