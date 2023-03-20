    ;
    ; Sieve of Eratosthenes
    ;
    org 0x100

table:      equ 0x8000
table_size: equ 1000

start:
    mov bx,table
    mov cx,table_size
    mov al,0
p1:
    mov [bx],al     ; [ds:bx] = al (0)
    inc bx
    loop p1         ; cx--; jne 0
    mov ax,2        ; start sieve at number 2
p2: mov bx,table    ; BX = table address
    add bx,ax       ; BX = BX + AX
    cmp byte [bx],0 ; is it non-prime?
    jne p3          ; ..yes, increment to next number
    push ax         ; ..no, save current prime for later
    call display_number ; display the current prime and a ,
    mov al,','
    call display_letter
    pop ax          ; get our prime back
    mov bx,table    ; start setting all multiples of this prime as non-prime 
    add bx,ax       ; bx = prime
p4: add bx,ax       ; bx = prime + prime + ...
    cmp bx,table+table_size ; is it the end of the table?
    jnc p3          ; ..yes, done
    mov byte [bx],1 ; ..no, set this number as non-prime
    jmp p4          ; move to next multiple
p3: inc ax          ; increment prime for next test
    cmp ax,table_size   ; end of table?
    jne p2          ; ..no? next test, else done.

    %include "../lib/library2.asm"