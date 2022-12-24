; here we use zYX rotation
EulerToRotMatrixProc Proc matrix:DWORD, euler:DWORD
	local xm:matrix3, ym:matrix3, zm:matrix3 ; rotation matrix
	local zxm:matrix3
	mov edi, euler
	; here is float 1.000
	; x axis
	;	1		0		0
	;	0		cos		sin
	;	0	   -sin	    cos
	mov xm.n00, 1000
	mov xm.n01, 0
	mov xm.n02, 0
	mov xm.n10, 0
	mov xm.n20, 0
	cos [edi]
	mov xm.n11, eax
	mov xm.n22, eax
	sin [edi]
	mov xm.n21, eax
	neg eax
	mov xm.n12, eax
	
	; y axis
	;	cos		0		sin
	;	0		1		0
	;  -sin		0		cos
	mov ym.n01, 0
	mov ym.n10, 0
	mov ym.n11, 1000
	mov ym.n12, 0
	mov ym.n21, 0
	cos [edi+4]
	mov ym.n00, eax
	mov ym.n22, eax
	sin [edi+4]
	mov ym.n02, eax
	neg eax
	mov ym.n20, eax

	; z axis
	;	cos	   -sin		0
	;	sin		cos		0
	;	0		0		1
	mov zm.n02, 0
	mov zm.n12, 0
	mov zm.n20, 0
	mov zm.n21, 0
	mov zm.n22, 1000
	cos [edi+8]
	mov zm.n00, eax
	mov zm.n11, eax
	sin [edi+8]
	mov zm.n01, eax
	neg eax
	mov zm.n10, eax
	; 專案中 EulerAngle 的表達式為 zYX
	; 此時要倒推坐標系則反過來做 : zXY
	INVOKE Matrix3Mult, ADDR zxm, ADDR zm, ADDR xm
	Matrix3diveK ADDR zxm, 1000 ; 消去乘法倍率
	INVOKE Matrix3Mult, matrix, ADDR zxm, ADDR ym
	Matrix3diveK matrix, 1000	 
ret
EulerToRotMatrixProc EndP
EulerToRotMatrix MACRO matrix, euler
	INVOKE EulerToRotMatrixProc, matrix, euler
ENDM


; vector, rotationMatrix
RotVectorProc PROC uses eax ebx esi edi, vec:DWORD, rotMat:DWORD 
	local result:Vector
	mov esi, vec
	mov edi, rotMat

	; x pos = x,y,z * 00,01,02
	mult [esi], [edi]
	mov ebx, eax
	mult [esi+4], [edi+4]
	add ebx, eax
	mult [esi+8], [edi+8]
	add eax, ebx
	dive eax, 1000
	mov result.x, eax

	; y pos = x,y,z * 10,11,12
	mult [esi], [edi+12]
	mov ebx, eax
	mult [esi+4], [edi+16]
	add ebx, eax
	mult [esi+8], [edi+20]
	add eax, ebx
	dive eax, 1000
	mov result.y, eax

	; y pos = x,y,z * 20,21,22
	mult [esi], [edi+24]
	mov ebx, eax
	mult [esi+4], [edi+28]
	add ebx, eax
	mult [esi+8], [edi+32]
	add eax, ebx
	dive eax, 1000
	mov result.z, eax

	mov eax,result.x
	mov [esi], eax
	mov eax,result.y
	mov [esi+4], eax
	mov eax,result.z
	mov [esi+8], eax
ret
RotVectorProc ENDP
RotVector MACRO vec, rotMat
	INVOKE RotVectorProc, vec, rotMat
ENDM

; world position, screen output {pos.X, pos.Y, scale if need (1.000)}
; { -1, -1, -1 } means not in screen
World2CameraProc Proc uses eax ebx esi, pos:DWORD, cor:DWORD
	local position:vector, posOffset:vector, tempVec:vector, vLen:Dword
	mov esi, pos
	copyvector ADDR position, pos
	copyvector ADDR posOffset, ADDR camera.pos
	rotVector ADDR position, ADDR cameraRotMat
	rotVector ADDR posOffset, ADDR cameraRotMat
	subVector ADDR position, ADDR posOffset
	isBE position.z, CameraDepth
	.IF BF == T
		setVector position, -1, -1, -1
		jmp World2CameraProcEnd
	.EndIF
	mov esi, cor

	mult cameraDepth, 1000
	dive eax, position.z

	mulVector ADDR position, eax
	divVector ADDR position, 1000
	
	mov eax, position.z
	mov [esi+8], eax ;output z as depth
	
	; screen offset to mid
	mov eax, position.x
	add eax, 80
	mov position.x, eax
	mov eax, position.y
	neg eax
	add eax, 50
	mov position.y, eax

	mov eax, position.x
	mov [esi], eax
	mov eax, position.y
	mov [esi+4], eax
	World2CameraProcEnd:
ret
World2CameraProc ENDP
World2Camera MACRO pos, cor
	INVOKE World2CameraProc, pos, cor
ENDM