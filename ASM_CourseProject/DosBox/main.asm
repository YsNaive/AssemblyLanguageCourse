model small

.stack 8192
.386
.data
include struct~1.asm
include variable.asm

.code
include include.asm

main proc
mov ax,SEG _DATA ; set up data segment
mov ds,ax

    mov ax,12345
    log ax

mov ah, 4Ch ; Exit Program no matter any situation
int 21h
main endp
end main
