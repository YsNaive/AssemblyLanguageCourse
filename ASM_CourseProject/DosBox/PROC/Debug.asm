
LOG MACRO val
    local @@DebugNumberDivLoop, @@DebugNumberPrintLoop
push ax
push bx
push cx
push dx
    
    mov ax, val
    mov bx, 10
    mov cx, 0
    mov dx, 0

@@DebugNumberDivLoop:
    mov dx, 0
    div bx
    add dx, "0"
    push dx
    inc cx
    cmp ax, 0
    jnz @@DebugNumberDivLoop

    mov ah, 02h
@@DebugNumberPrintLoop:
    pop dx
    int 21h
    loop @@DebugNumberPrintLoop

    call NewLine

pop dx
pop cx
pop bx
pop ax
ENDM


NewLine Proc
    MOV dl, 10
    MOV ah, 02h
    INT 21h
    MOV dl, 13
    MOV ah, 02h
    INT 21h
    ret
NewLine ENDP


DebugBool PROC
push ax
push dx

    mov dl, BF
    mov ah, 02h
    int 21h
    call NewLine
pop dx
pop ax
ret
DebugBool ENDP