IsNeg MACRO val
	local @@end
	mov BF, FALSE
	test val, 1000000000000000b
	jz @@end
	mov BF, TRUE
	@@end:
ENDM

mAbs MACRO val
	local @@end
	mov ax, val
	IsNeg ax
	jf @@end
	push bx
	mov bx, -1
	imul bx
	pop bx
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

Sqrt MACRO val
	local @@loop, @@endloop, @@end
	push bx cx dx i
	mov i, 1
	mov cx,0
	mov dx, val
	@@loop:
		mult i, i	; now -> ax
		mov bx, dx ; target
		sub bx, ax	; target - now
		isAE ax, dx
		jt @@endloop
		inc i
		mov cx, bx
		jmp @@loop
	@@endloop:
	neg bx
	isB bx, cx
	mov ax, i
	jt @@end
	dec ax
	@@end:
	pop i dx cx bx
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

SetVector3 MACRO Vector, val1, val2, val3
	mov ax, val1
	mov Vector.x, ax
	mov ax, val2
	mov Vector.y, ax
	mov ax, val3
	mov Vector.z, ax
ENDM

SetCubeData MACRO CubeData, pos, euler, extend
	mov ax, pos.x
	mov CubeData.pos.x, ax
	mov ax, pos.y
	mov CubeData.pos.y, ax
	mov ax, pos.z
	mov CubeData.pos.z, ax

	mov ax, euler.x
	mov CubeData.euler.x, ax
	mov ax, euler.y
	mov CubeData.euler.y, ax
	mov ax, euler.z
	mov CubeData.euler.z, ax

	mov ax, extend.x
	mov CubeData.extend.x, ax
	mov ax, extend.y
	mov CubeData.extend.y, ax
	mov ax, extend.z
	mov CubeData.extend.z, ax
ENDM

SetSphereData MACRO SphereData, pos, euler, radius
	mov ax, pos.x
	mov SphereData.pos.x, ax
	mov ax, pos.y
	mov SphereData.pos.y, ax
	mov ax, pos.z
	mov SphereData.pos.z, ax

	mov ax, euler.x
	mov SphereData.euler.x, ax
	mov ax, euler.y
	mov SphereData.euler.y, ax
	mov ax, euler.z
	mov SphereData.euler.z, ax

	mov ax, radius
	mov SphereData.radius, ax
ENDM

SetCamera MACRO pos, euler
	mov ax, pos.x
	mov camera.pos.x, ax
	mov ax, pos.y
	mov camera.pos.y, ax
	mov ax, pos.z
	mov camera.pos.z, ax

	mov ax, euler.x
	mov camera.euler.X, ax
	mov ax, euler.y
	mov camera.euler.y, ax
	mov ax, euler.z
	mov camera.euler.z, ax
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