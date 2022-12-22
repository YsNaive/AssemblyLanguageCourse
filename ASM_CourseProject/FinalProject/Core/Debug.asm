DigitsNumber Proc uses ebx ecx edx, val:DWORD
	mov eax, val
	mov ecx,0
	cmp eax,0
	jg DigitsNumberLOOP
	mov edx, 0
	mov ebx, -1
	imul ebx
	DigitsNumberLOOP:
	.IF eax !=0
		inc ecx
		mov edx, 0
		mov ebx, 10
		idiv ebx
		jmp DigitsNumberLOOP
	.EndIF
	mov eax, ecx
ret
DigitsNumber ENDP

logc Macro val
	push ax
	mov al, val
	call writeChar
	pop ax
EndM

log Macro val
	push eax
	mov eax, val
	call writeInt
	call crlf
	pop eax
ENDM

fixLog Macro val, len
	local @@end, @@loop
	push eax
	push ecx
	INVOKE DigitsNumber, val
	mov ecx, len
	sub ecx, eax
	mov eax, val
	call writeInt
	.IF eax == 0
		dec ecx
	.EndIF
	cmp ecx,0
	jle @@end
	mov al, " "
	@@loop:
		call writeChar
		loop @@loop
	@@end:
	pop ecx
	pop eax
ENDM

logf Macro val
	push eax
	push edx
	dive val, 1000
	call writeInt
	logc "."
	mov eax, edx
	call writeDec
	call crlf
	pop edx
	pop eax
ENDM

logCor Macro cor
	push eax
	logc "("
	mov ax, cor.x
	call writeInt
	logc ","
	logc " "
	mov ax, cor.y
	call writeInt
	logc ")"
	call crlf
	pop eax
ENDM

logv Macro vector
	push eax
	logc "("
	mov eax, vector.x
	call writeInt
	logc ","
	logc " "
	mov eax, vector.y
	call writeInt
	logc ","
	logc " "
	mov eax, vector.z
	call writeInt
	logc ")"
	call crlf
	pop eax
ENDM

logvPtr Macro vectorPtr
	push eax
	push esi
	mov esi, vectorPtr
	logc "("
	mov eax, [esi]
	call writeInt
	logc ","
	logc " "
	mov eax, [esi+4]
	call writeInt
	logc ","
	logc " "
	mov eax, [esi+8]
	call writeInt
	logc ")"
	call crlf
	pop esi
	pop eax
ENDM

logm3Proc Proc uses eax ebx edi, matrix:dword
	local fix:vector
	mov edi,matrix

	Invoke DigitsNumber, [edi]
	mov ebx, eax
	Invoke DigitsNumber, [edi+12]
	.IF eax > ebx
		mov ebx, eax
	.EndIF
	Invoke DigitsNumber, [edi+24]
	.IF eax > ebx
		mov ebx, eax
	.EndIF
	inc ebx
	mov fix.x, ebx
	
	Invoke DigitsNumber, [edi+4]
	mov ebx, eax
	Invoke DigitsNumber, [edi+16]
	.IF eax > ebx
		mov ebx, eax
	.EndIF
	Invoke DigitsNumber, [edi+28]
	.IF eax > ebx
		mov ebx, eax
	.EndIF	
	inc ebx
	mov fix.y, ebx
	
	Invoke DigitsNumber, [edi+8]
	mov ebx, eax
	Invoke DigitsNumber, [edi+20]
	.IF eax > ebx
		mov ebx, eax
	.EndIF
	Invoke DigitsNumber, [edi+32]
	.IF eax > ebx
		mov ebx, eax
	.EndIF
	mov fix.z, ebx
	inc ebx

	logc "|"
	mov ebx, fix.x
	fixlog [edi], ebx
	mov ebx, fix.y
	fixlog [edi+4], ebx
	mov ebx, fix.z
	fixlog [edi+8], ebx
	logc "|"
	call crlf

	logc "|"
	mov ebx, fix.x
	fixlog [edi+12], ebx
	mov ebx, fix.y
	fixlog [edi+16], ebx
	mov ebx, fix.z
	fixlog [edi+20], ebx
	logc "|"
	call crlf

	logc "|"
	mov ebx, fix.x
	fixlog [edi+24], ebx
	mov ebx, fix.y
	fixlog [edi+28], ebx
	mov ebx, fix.z
	fixlog [edi+32], ebx
	logc "|"
	call crlf

ret
logm3Proc EndP
logm3 Macro val
	Invoke logm3Proc, val
ENDM
