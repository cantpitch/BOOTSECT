    org 0x0100

    in al,(0x40)        ; read the timer counter chip
    and al,0x07         ; mask bits so value becomes 0-7
    add al,0x30         ; convert to ASCII
    mov cl,al           ; save al
game_loop:
    mov al,'?'          ; '?' character
    call display_letter
    call read_keyboard
    cmp al,cl           ; read key (al) == random character?
    jne game_loop       ; nope
    call display_letter ; display number
    mov al,':'          ; display happy face
    call display_letter
    mov al,')'
    call display_letter

    %include "../lib/library1.asm"
