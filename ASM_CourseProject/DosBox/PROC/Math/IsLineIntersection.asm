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
    CrossProduct2 line1.p1, line1.p2, line2.p1
    mov bx, ax
    CrossProduct2 line1.p1, line1.p2, line2.p2
    mult ax, bx
    IsNeg ax
    jt LineIntersectionTrue
    CrossProduct2 line2.p1, line2.p2, line1.p1
    mov bx, ax
    CrossProduct2 line2.p1, line2.p2, line1.p2
    mult ax, bx
    IsNeg ax
    jt LineIntersectionTrue

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