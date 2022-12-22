; info is ptr of a vector
; { coord.x, coord.y, r }
DrawSphereProc Proc uses eax ebx ecx edx esi, infoPtr:DWORD, color:WORD
	local maxX:DWORD,maxY:DWORD,minX:DWORD,minY:DWORD
	local originPos:vector, targetPos:vector
	local iLoop:DWORD, jLoop:DWORD, limit:DWORD
	mov esi, infoPtr
	isE [esi], -1
	mov al,BF
	isE [esi+4], -1
	mov ah,BF
	and2 ah, bl
	.IF BF == T
		jmp DrawSphereProcEnd
	.EndIF

	mov eax, [esi+8]
	mov limit, eax
	copyVector ADDR originPos, infoPtr
	mov originPos.z, 0
	mov targetPos.z, 0

	mov eax, [esi]
	add eax, [esi+8]
	isB eax, 0
	jt DrawSphereProcEnd
	clamp eax, 0, 159
	mov maxX, eax
	mov esi, infoPtr
	mov eax, [esi]
	sub eax, [esi+8]
	isA eax, 159
	jt DrawSphereProcEnd
	clamp eax, 0, 159
	mov minX, eax

	mov esi, infoPtr
	mov eax, [esi+4]
	add eax, [esi+8]
	isB eax, 0
	jt DrawSphereProcEnd
	clamp eax, 0, 99
	mov maxY, eax
	mov esi, infoPtr
	mov eax, [esi+4]
	sub eax, [esi+8]
	isA eax, 99
	jt DrawSphereProcEnd
	clamp eax, 0, 99
	mov minY, eax
	mov eax, minX
	mov iLoop, eax
	DrawSphereProcLoopI:
		mov eax, minY
		mov jLoop, eax
		DrawSphereProcLoopJ:
			mov eax, iLoop
			mov targetPos.x, eax
			mov eax, jLoop
			mov targetPos.y, eax
			subVector ADDR targetPos, ADDR originPos
			vectorLen ADDR targetPos
			isBE eax, limit
			jf DrawSphereProcDontDraw
				setPixel iLoop, jLoop, color
			DrawSphereProcDontDraw:
		inc jLoop
		isBE jLoop, maxY
		jt DrawSphereProcLoopJ
	inc iLoop
	isBE iLoop, maxX
	jt DrawSphereProcLoopI
	DrawSphereProcEnd:
ret
DrawSphereProc ENDP