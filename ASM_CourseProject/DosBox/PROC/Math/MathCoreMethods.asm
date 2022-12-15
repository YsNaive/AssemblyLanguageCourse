IsNeg MACRO val
	local @@end
	mov BF, FALSE
	test val, 1000000000000000b
	jz @@end
	mov BF, TRUE
	@@end:
ENDM

; val1 will equal the bigger one
Max MACRO val1, val2
	local @@endMacro
	mov ax, val1
	cmp ax, val2
	ja @@endMacro
	mov ax, val2
	@@endMacro:
ENDM

Min MACRO val1, val2
	local @@endMacro
	mov ax, val1
	cmp ax, val2
	jb @@endMacro
	mov ax, val2
	@@endMacro:
ENDM

Mult MACRO val1, val2
	local @@overflow,@@notOverflow,@@negOverflow
	push dx
	mov dx, 0
	mov ax, val1
	imul val2

	cmp dx, 0
	je @@notOverflow
	cmp dx, -1
	je @@notOverflow
	@@overflow:
	IsNeg dx
	jt @@negOverflow
	mov ax, 7FFFh
	jmp @@notOverflow
	@@negOverflow:
	mov ax, 08000h
	@@notOverflow:
	pop dx
ENDM

Dive MACRO val1, val2
	local @@notNeg, @@end
	push bx
	mov dx, 0
	mov ax, val1
	mov bx, val2

	cmp ax,0
	je @@end
	cmp bx,0
	je @@end

	IsNeg ax
	jf  @@notNeg
	imul ax, -1
	imul bx, -1
	@@notNeg:
	idiv bx
	@@end:
	pop bx
ENDM


CrossProduct2 MACRO pointA, pointB, other
push bx cx
	mov ax, pointB.x
	sub ax, pointA.x
	mov bx, other.y
	sub bx, pointA.y
	mult ax, bx
	mov bx, ax
	
	mov ax, other.x
	sub ax, pointA.x
	mov cx, pointB.y
	sub cx, pointA.y
	mult ax, cx
	
	sub bx, ax
	mov ax, bx
pop cx bx
ENDM

SetVector2 MACRO Vector, val1, val2
push ax
	mov ax, val1
	mov Vector.x, ax
	mov ax, val2
	mov Vector.y, ax
pop ax
ENDM

SetLine MACRO Line, p1x, p1y, p2x, p2y
push ax
	mov ax, p1x
	mov Line.p1.x, ax
	mov ax, p1y
	mov Line.p1.y, ax
	mov ax, p2x
	mov Line.p2.x, ax
	mov ax, p2y
	mov Line.p2.y, ax  
pop ax   
ENDM