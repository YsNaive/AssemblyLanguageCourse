; point is ptr of a vector {x, y, not use}
DrawLineProc Proc uses eax ebx ecx edx esi edi, fromPtr:DWORD, toPtr:DWORD, color:WORD
	local from:vector, to:vector, posOffset:vector
	local iLoop:DWORD, len:DWORD
	mov esi, fromPtr
	mov edi, toPtr
	mov eax, [esi]
	mov from.x, eax
	mov eax, [esi+4]
	mov from.y, eax
	mov eax, [edi]
	mov to.x, eax
	mov eax, [edi+4]
	mov to.y, eax

	copyVector ADDR posOffset, ADDR to
	subVector ADDR posOffset, ADDR from
	mov posOffset.z, 0
	VectorLen ADDR posOffset
	mov len, eax
	mulVector ADDR from, 1000
	mulVector ADDR posOffset, 1000
	divVector ADDR posOffset, len

	mov iLoop, 0
	DrawLineProcLoopI:
		inc iLoop
		isBE iLoop, len
		jf DrawLineProcEnd

		mult posOffset.x, iLoop
		add eax, from.x
		dive eax, 1000
		mov ebx, eax
		mult posOffset.y, iLoop
		add eax, from.y
		dive eax, 1000

		isB ebx, 0
		jt DrawLineProcLoopI
		isA ebx, 159
		jt DrawLineProcLoopI
		isB eax, 0
		jt DrawLineProcLoopI
		isA eax, 99
		jt DrawLineProcLoopI

		setPixel ebx, eax, color

		jmp DrawLineProcLoopI
	DrawLineProcEnd:
ret
DrawLineProc ENDP