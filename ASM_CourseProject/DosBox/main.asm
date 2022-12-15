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
    setVector2 point1, 80, 100
    setVector2 point2, 110, 100
    setVector2 point3, 110, 110
    setVector2 point4, 100, 110
    mov color, 1100b
    call Draw4Pole
    setVector2 point1, 200, 100
    setVector2 point2, 220, 100
    setVector2 point3, 210, 110
    setVector2 point4, 200, 110
    mov color, 1100b
    call Draw4Pole
    setLine line1, 5, 0, 5, 5
    setLine line2, 2, 2, 320, 2
    call waitforkeypress
    ;call IsLineIntersection
    ;debugbool
    ;call ClearScreen
mov ah, 4Ch ; Exit Program no matter any situation
int 21h
main endp
end main
