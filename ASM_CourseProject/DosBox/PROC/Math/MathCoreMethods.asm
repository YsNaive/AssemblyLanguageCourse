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
	local @@notOverflow,@@neg
	mov ax, val1
	mul val2
	jnc @@notOverflow
	jno @@notOverflow

	cmp ax, 0
	jb @@neg
	mov ax, 8FFFh
	jmp @@notOverflow
	@@neg:
	mov ax, 0FFFFh
	@@notOverflow:
ENDM

IsNeg MACRO val
	local @@end
	mov BF, FALSE
	test val, 1000000000000000b
	jz @@end
	mov BF, TRUE
	@@end:
ENDM

CrossProduct2 MACRO pointA, pointB, other
push bx
push cx
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

pop cx
pop bx
ENDM

SetVector2 MACRO Vector, val1, val2
	mov ax, val1
	mov Vector.x, ax
	mov ax, val2
	mov Vector.y, ax
ENDM

SetLine MACRO Line, p1x, p1y, p2x, p2y
	mov ax, p1x
	mov Line.p1.x, ax
	mov ax, p1y
	mov Line.p1.y, ax
	mov ax, p2x
	mov Line.p2.x, ax
	mov ax, p2y
	mov Line.p2.y, ax     
ENDM