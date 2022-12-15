; use line1, line2
IsLineIntersection proc
push ax bx dx i j

    mov ax, line1.p2.y
    sub ax, line1.p1.y
    mov a, ax
    mov ax, line1.p1.x
    sub ax, line1.p2.x
    mov b, ax
    mov ax, a
    mult ax, line1.p1.x
    mov i, ax
    mov ax, b
    mult ax, line1.p1.y
    add ax, i
    mov c, ax
    
    mov ax, line2.p2.y
    sub ax, line2.p1.y
    mov d, ax
    mov ax, line2.p1.x
    sub ax, line2.p2.x
    mov e, ax
    mov ax, d
    mult ax, line2.p1.x
    mov i, ax
    mov ax, e
    mult ax, line2.p1.y
    add ax, i
    mov f, ax
    
    ; (c * e - b * f) / (a * e - b * d)
    mov ax, b
    mult ax, d
    mov word1, ax
    mov ax, a
    mult ax, e
    sub ax, word1
    mov bx, ax

    mov ax, b
    mult ax, f
    mov word1, ax
    mov ax, c
    mult ax, e
    sub ax, word1
    
    mov dx, 0
    dive ax, bx
    mov word1, ax

    ; (c * d - a * f) / (b * d - a * e)
    mov ax, a
    mult ax, e
    mov word2, ax
    mov ax, b
    mult ax, d
    sub ax, word2
    mov bx, ax

    mov ax, a
    mult ax, f
    mov word2, ax
    mov ax, c
    mult ax, d
    sub ax, word2
    mov dx, 0
    dive ax, bx
    mov word2, ax
    
    ; cmp line1 points
    mov ax, line1.p1.x
    isA ax, line1.p2.x
    jf LIBoolCheck1
        mov Vec2_1.x, ax
        mov ax, line1.p2.x
        mov Vec2_2.x, ax
    jmp LIBoolCheck1End
    LIBoolCheck1:
        mov Vec2_2.x, ax
        mov ax, line1.p2.x
        mov Vec2_1.x, ax
    LIBoolCheck1End:

    mov ax, line1.p1.y
    isA ax, line1.p2.y
    jf LIBoolCheck2
        mov Vec2_1.y, ax
        mov ax, line1.p2.y
        mov Vec2_2.y, ax
    jmp LIBoolCheck2End
    LIBoolCheck2:
        mov Vec2_2.y, ax
        mov ax, line1.p2.y
        mov Vec2_1.y, ax
    LIBoolCheck2End:

    dec Vec2_2.x
    dec Vec2_2.y
    inc Vec2_1.x
    inc Vec2_1.y
    isAE word1, Vec2_2.x
    push BF
    isBE word1, Vec2_1.x
    push BF 
    isAE word2, Vec2_2.y
    push BF
    isBE word2, Vec2_1.y
    mov ax, BF
    pop BF
    andb ax, BF
    mov ax, BF
    pop BF
    andb ax, BF
    mov ax, BF
    pop BF
    andb ax, BF
    
    jf LineIntersectionFalse
    ; cmp line2 points
    mov ax, line2.p1.x
    cmp ax, line2.p2.x
    jb LIBoolCheck3
        mov Vec2_1.x, ax
        mov ax, line2.p2.x
        mov Vec2_2.x, ax
    jmp LIBoolCheck3End
    LIBoolCheck3:
        mov Vec2_2.x, ax
        mov ax, line2.p2.x
        mov Vec2_1.x, ax
    LIBoolCheck3End:

    mov ax, line2.p1.y
    cmp ax, line2.p2.y
    jb LIBoolCheck4
        mov Vec2_1.y, ax
        mov ax, line2.p2.y
        mov Vec2_2.y, ax
    jmp LIBoolCheck4End
    LIBoolCheck4:
        mov Vec2_2.y, ax
        mov ax, line2.p2.y
        mov Vec2_1.y, ax
    LIBoolCheck4End:
    
    dec Vec2_2.x
    dec Vec2_2.y
    inc Vec2_1.x
    inc Vec2_1.y
    isAE word1, Vec2_2.x
    push BF
    isBE word1, Vec2_1.x
    push BF 
    isAE word2, Vec2_2.y
    push BF
    isBE word2, Vec2_1.y
    mov ax, BF
    pop BF
    andb ax, BF
    mov ax, BF
    pop BF
    andb ax, BF
    mov ax, BF
    pop BF
    andb ax, BF
    jf LineIntersectionFalse


    jmp LineIntersectionTrue


    LineIntersectionFalse:
    mov BF, FALSE
    jmp LineIntersectionEnd
    LineIntersectionTrue:
    mov BF, TRUE

LineIntersectionEnd:
pop j i dx bx ax
ret
IsLineIntersection ENDP