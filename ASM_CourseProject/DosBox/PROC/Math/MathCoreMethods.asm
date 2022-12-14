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
	mov bx, val2
	mul bx
	jnc @@notOverflow
	jno @@notOverflow

	cmp ax, 0
	jb @@neg
	mov ax, 7FFFh
	jmp @@notOverflow
	@@neg:
	mov ax, 0FFFFh
	@@notOverflow:
ENDM

; todo : boundary check
; Mult_d MACRO val1 val2
; 	mov ax, val1
; 	mov bx, val2
; 	imul bx
; ENDM

; Div_d MACRO val1_1 val1_2 val2
; 	mov dx, val1_1
; 	mov ax, val1_2
; 	mov cx, val2
; 	IDIV cx
; ENDM

; todo :  boundary check. push pop register
mDiv MACRO dividend, divisor
    MOV dx, 0		
    MOV ax, dividend
    MOV bx, divisor
    IDIV bx		;dx:ax = q:ax, r:dx
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
push ax
	mov ax, val1
	mov Vector.x, ax
	mov ax, val2
	mov Vector.y, ax
	mov ax, val3
	mov Vector.z, ax
pop ax
ENDM

AddVector3 MACRO Vector, val1, val2, val3
push ax
	mov ax, val1
	ADD Vector.x, ax
	mov ax, val2
	ADD Vector.y, ax
	mov ax, val3
	ADD Vector.z, ax
pop ax
ENDM

SetCubeData MACRO CubeData, pos, euler, extend
push ax
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
pop ax
ENDM

SetSphereData MACRO SphereData, pos, euler, radius
push ax
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
pop ax
ENDM

SetCamera MACRO pos, euler
push ax
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