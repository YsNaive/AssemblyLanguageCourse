logChar MACRO char
push ax dx
    mov ah, 02h
    mov dl, char
    int 21h
pop dx ax
ENDM

WriteNumber MACRO val
    local @@DebugNumberDivLoop, @@DebugNumberPrintLoop, @@negCheck
push ax bx cx dx
    
    mov ax, val
    mov bx, 10
    mov cx, 0
    mov dx, 0
    
    mov BF, FALSE
	test ax, 1000000000000000b
	jz @@negCheck
	mov BF, TRUE
	@@negCheck:
    
    jf @@DebugNumberDivLoop
    mov bx, -1
    mul bx
    mov bx, 10
    logChar "-"
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


pop dx cx bx ax
ENDM

log MACRO val
    WriteNumber val
    call newLine
ENDM


logVector2 MACRO Vector
    logChar "("
    logChar " "
    WriteNumber Vector.x
    logChar " "
    logChar ","
    WriteNumber Vector.y
    logChar " "
    logChar ")"
    call NewLine
ENDM

logVector3 MACRO Vector
    logChar "("
    WriteNumber Vector.x
    logChar ","
    WriteNumber Vector.y
    logChar " "
    logChar ","
    WriteNumber Vector.z
    logChar ")"
    call NewLine
ENDM

logTransform MACRO T
    logChar "P"
    logChar "o"
    logChar "s"
    logChar "("
    WriteNumber T.pos.x
    logChar ","
    logChar " "
    WriteNumber T.pos.y
    logChar ","
    logChar " "
    WriteNumber T.pos.z
    logChar ")"
    logChar " "
    logChar " "
    logChar "R"
    logChar "o"
    logChar "t"
    logChar "("
    WriteNumber T.euler.x
    logChar ","
    logChar " "
    WriteNumber T.euler.y
    logChar ","
    logChar " "
    WriteNumber T.euler.z
    logChar ")"
    call NewLine
ENDM

logLine MACRO line
    logChar "L"
    logChar ":"
    logChar "("
    logChar " "
    WriteNumber line.p1.x
    logChar " "
    logChar ","
    WriteNumber line.p1.y
    logChar " "
    logChar ")"
    logChar "-"
    logChar "("
    logChar " "
    WriteNumber line.p2.x
    logChar " "
    logChar ","
    WriteNumber line.p2.y
    logChar " "
    logChar ")"
    call newLine
ENDM

NewLine Proc
push ax dx
    MOV dl, 10
    MOV ah, 02h
    INT 21h
    MOV dl, 13
    MOV ah, 02h
    INT 21h
pop dx ax
ret
NewLine ENDP
