model small

.stack
.386
.data
include struct~1.asm
include variable.asm

.code
include include.asm

main proc
mov ax,SEG _DATA ; set up data segment
mov ds,ax
call init
mov color, 1100b
    setVector2 point1, 0, 80
    ;push point1
    ;call Vec2Len
    ;log ax
    mov word1,80
    call DrawSphere
    setVector2 point1, 180, 40
    mov word1,100
    mov color, 0011b
    call DrawSphere
    setVector2 point1, 120, 140
    mov word1,60
    mov color, 0110b
    call DrawSphere
    call waitforkeypress
    ;call IsLineIntersection
    ;debugbool
    ;call ClearScreen
mov ah, 4Ch ; Exit Program no matter any situation
int 21h
main endp
end main
