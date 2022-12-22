SetScreen Proc uses esi ecx ax, color:word
mov ax, color
	mov esi, OFFSET layoutAttributes
	mov ecx, 16000
	SetScreenLoop:
		mov [esi], ax
		add esi,2
	loop SetScreenLoop
ret
SetScreen EndP

SetPixelProc Proc uses eax ebx, x:dword,y:dword, color:WORD
	mov eax, y
	mov ebx, 320
	mul ebx
	add eax, x
	add eax, x
	mov esi, OFFSET layoutAttributes
	add esi, eax
	mov bx, color
	mov [esi], bx
ret
SetPixelProc ENDP
SetPixel Macro x,y,color
	Invoke SetPixelProc, x, y, color
EndM


RePaint Proc uses esi ecx
	local writeCount:word, pos:COORD

	mov ax, 0
	mov pos.x, ax
	mov ax, 0
	mov pos.y, ax

	lea esi, layoutAttributes
	mov ecx, 100
	RePaintLoop:
	push ecx
	INVOKE WriteConsoleOutputAttribute, ; change cell setting
		consoleHandle,
		esi,
		160,
		pos,
		ADDR writeCount
	inc pos.y
	add esi, 320
	pop ecx
	loop RePaintLoop
ret
RePaint ENDP

ShowColor Proc uses ax bx ecx 
	mov ecx, 15
	mov bx ,00h
	ShowColorLoop:
	INVOKE setScreen, bx
	call repaint
	call readChar
	add bx, 010h
	loop ShowColorLoop
ret
ShowColor EndP