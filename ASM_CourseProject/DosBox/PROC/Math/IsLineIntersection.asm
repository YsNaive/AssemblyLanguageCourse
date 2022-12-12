; use line1, line2
IsLineIntersection proc
push ax
push bx
    ; check X max
    max line1.p1.x, line1.p2.x
    mov i, ax
    min line2.p1.x, line2.p2.x
    cmp i, ax
    jb LineIntersectionFalse

    ; check X min
    min line1.p1.x, line1.p2.x
    mov i, ax
    max line2.p1.x, line2.p2.x
    cmp i, ax
    ja LineIntersectionFalse

    ; check Y max
    max line1.p1.y, line1.p2.y
    mov i,ax
    min line2.p1.y, line2.p2.y
    cmp i, ax
    jb LineIntersectionFalse

    ; check Y min
    min line1.p1.y, line1.p2.y
    mov i, ax
    max line2.p1.y, line2.p2.y
    cmp i, ax
    ja LineIntersectionFalse

    ; product check
    mov bx, 0
    CrossProduct2 line1.p1, line1.p2, line2.p1
    IsNeg ax
    jf LineIntersectionNegCheck1
    inc bx
    LineIntersectionNegCheck1:
    CrossProduct2 line1.p1, line1.p2, line2.p2
    IsNeg ax
    jf LineIntersectionNegCheck2
    inc bx
    LineIntersectionNegCheck2:
    cmp ax,1
    je LineIntersectionTrue
    
    mov bx, 0
    CrossProduct2 line2.p1, line2.p2, line1.p1
    IsNeg ax
    jf LineIntersectionNegCheck3
    inc bx
    LineIntersectionNegCheck3:
    CrossProduct2 line2.p1, line2.p2, line1.p2
    IsNeg ax
    jf LineIntersectionNegCheck4
    inc bx
    LineIntersectionNegCheck4:
    cmp ax,1
    je LineIntersectionTrue

    LineIntersectionFalse:
    mov BF, FALSE
    jmp LineIntersectionEnd
    LineIntersectionTrue:
    mov BF, TRUE
LineIntersectionEnd:
pop ax
pop bx
ret
IsLineIntersection ENDP