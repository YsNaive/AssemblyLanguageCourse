; use point1, point2, point3, point4
Draw4Pole proc
    local @@maxX:WORD, @@minX:WORD, @@maxY:WORD, @@minY:WORD
push ax bx dx
    mov bx, 2

    max point1.x, point2.x
    max ax, point3.x
    max ax, point4.x
    mov @@maxX, ax
    dec @@maxX
    min point1.x, point2.x
    min ax, point3.x
    min ax, point4.x
    mov @@minX, ax

    max point1.y, point2.y
    max ax, point3.y
    max ax, point4.y
    mov @@maxY, ax
    dec @@maxY
    min point1.y, point2.y
    min ax, point3.y
    min ax, point4.y
    mov @@minY, ax
    
    mov ax, @@minX
    mov i, ax
    mov ax, @@minY
    mov j, ax

    mov bx, 0
    Draw4Pole_iLOOP:
    mov ax, @@minY
    mov j, ax
        Draw4Pole_jLOOP:
        mov ax, 0
        setLine line1, i, j, 320, 200
        setLine line2, point1.x, point1.y, point2.x, point2.y
        call IsLineIntersection
        jf Draw4PoleLineCheck1
        inc ax
        Draw4PoleLineCheck1:

        setLine line2, point2.x, point2.y, point3.x, point3.y
        call IsLineIntersection
        jf Draw4PoleLineCheck2
        inc ax
        Draw4PoleLineCheck2:

        setLine line2, point3.x, point3.y, point4.x, point4.y
        call IsLineIntersection
        jf Draw4PoleLineCheck3
        inc ax
        Draw4PoleLineCheck3:

        setLine line2, point4.x, point4.y, point1.x, point1.y
        call IsLineIntersection
        jf Draw4PoleLineCheck4
        inc ax
        Draw4PoleLineCheck4:
        
        WriteNumber ax
        cmp ax, 0
        je Draw4PoleNextLoop
        mov color, 03h
        Draw4PoleNextLoop:
        ;SetPixel i, j
        mov color, 1100b


        mov ax, j
        inc j
        inc bx
        cmp ax, @@maxY
        jb Draw4Pole_jLOOP
        call newline
    mov ax, i
    inc i
    cmp ax, @@maxX
    jb Draw4Pole_iLOOP

pop dx bx ax
ret
Draw4Pole ENDP