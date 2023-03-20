    ; 
    ; Tic-Tac-Toe
    ; by Oscar Toledo G.
    ; Creation date: Jun/21/2019
    ;
    org 0x100

board:  equ 0x0300

start:
    mov bx,board        ; board address in BX
    mov cx,9            ; count 9 squares
    mov al,'1'          
b09:
    mov [bx],al         ; put ASCII digit in board
    inc al              ; increment digit ('1','2','3',..)
    inc bx              ; next cell of board
    loop b09            ; cx--; jne

b10:
    call show_board
    call find_line
    call get_movement
    mov byte [bx],'X'   ; put 'X' into square

    call show_board
    call find_line

    call get_movement
    mov byte [bx],'O'   ; put 'O' into square
    
    jmp b10

get_movement:
    call read_keyboard
    cmp al,0x1b         ; esc key pressed?
    je do_exit          ; ..yes, done
    sub al,'1'          ; convert ASCII digit to number
    jc get_movement     ; is it less than 1? wait for another key
    cmp al,9
    jnc get_movement    ; is it greater than 9? wait for another key
    cbw                 ; extend AL to 16-bits using AH
    mov bx,board
    add bx,ax           ; add the key entered
    mov al,[bx]         ; get the square content
    cmp al,0x40         ; is the content an ASCII digit?
    jnc get_movement    ; if so, wait for another key
    call show_crlf
    ret

do_exit:
    int 0x20            ; exit to command-line

show_board:
    mov bx,board
    call show_row
    call show_div
    mov bx,board+3
    call show_row
    call show_div
    mov bx,board+6
    jmp show_row

show_row:
    call show_square
    mov al,'|'
    call display_letter
    call show_square
    mov al,'|'
    call display_letter
    call show_square
show_crlf:
    mov al,0x0d
    call display_letter
    mov al,0x0a
    jmp display_letter

show_div:
    mov al,'-'
    call display_letter
    mov al,'+'
    call display_letter
    mov al,'-'
    call display_letter
    mov al,'+'
    call display_letter
    mov al,'-'
    call display_letter
    jmp show_crlf

show_square:
    mov al,[bx]
    inc bx
    jmp display_letter

find_line:
    ; first horizontal row
    mov al,[board]          ; X.. ... ...
    cmp al,[board+1]        ; .X. ... ...
    jne b01
    cmp al,[board+2]        ; ..X ... ...
    je won
b01:
    ; leftmost vertical col
    cmp al,[board+3]        ; ... X.. ...
    jne b04
    cmp al,[board+6]        ; ... ... X..
    je won
b04:
    ; first diagonal
    cmp al,[board+4]        ; ... .X. ...
    jne b05
    cmp al,[board+8]        ; ... ... ..X
    je won
b05:
    ; second horiz row
    mov al,[board+3]        ; ... X.. ...
    cmp al,[board+4]        ; ... .X. ...
    jne b02
    cmp al,[board+5]        ; ... ..X ...
    je won
b02:
    ; third horiz row
    mov al,[board+6]        ; ... ... X..
    cmp al,[board+7]        ; ... ... .X.
    jne b03
    cmp al,[board+8]        ; ... ... ..X
    je won
b03:
    ; middle vert col
    mov al,[board+1]        ; .X. ... ...
    cmp al,[board+4]        ; ... .X. ...
    jne b06
    cmp al,[board+7]        ; ... ... .X.
    je won
b06:
    ; rightmost vert col
    mov al,[board+2]        ; ..X ... ...
    cmp al,[board+5]        ; ... ..X ...
    jne b07
    cmp al,[board+8]        ; ... ... ..X
    je won
b07:
    ; second diag
    cmp al,[board+4]        ; ... .X. ...
    jne b08
    cmp al,[board+6]        ; ... ... X..
    je won
b08:
    ret

won:
    ; at this point AL has the letter which made the line
    call display_letter
    mov al,' '
    call display_letter
    mov al,'w'
    call display_letter
    mov al,'i'
    call display_letter
    mov al,'n'
    call display_letter
    mov al,'s'
    call display_letter
    int 0x20

    %include "../lib/library1.asm"