setVector MACRO vec, val1, val2, val3
push eax
	mov eax,val1
	mov vec.x, eax
	mov eax,val2
	mov vec.y, eax
	mov eax,val3
	mov vec.z, eax
pop eax
ENDM

addVectorProc Proc uses eax esi edi, v1:DWORD, v2:DWORD 
	mov esi, v2
	mov edi, v1
	mov eax, [esi]
	add [edi], eax
	mov eax, [esi+4]
	add [edi+4], eax
	mov eax, [esi+8]
	add [edi+8], eax
ret
addVectorProc ENDP
addVector MACRO v1, v2
	INVOKE addVectorProc, v1 ,v2
ENDM

mulVectorProc Proc uses eax edi, v1:DWORD, k:DWORD 
	mov edi, v1
	mult [edi], k
	mov [edi], eax
	mult [edi+4], k
	mov [edi+4], eax
	mult [edi+8], k
	mov [edi+8], eax
ret
mulVectorProc ENDP
mulVector MACRO v1, k
	INVOKE mulVectorProc, v1 ,k
ENDM

divVectorProc Proc uses eax edi, v1:DWORD, k:DWORD 
	mov edi, v1
	dive [edi], k
	mov [edi], eax
	dive [edi+4], k
	mov [edi+4], eax
	dive [edi+8], k
	mov [edi+8], eax
ret
divVectorProc ENDP
divVector MACRO v1, k
	INVOKE divVectorProc, v1 ,k
ENDM

subVectorProc Proc uses eax esi edi, v1:DWORD, v2:DWORD 
	mov esi, v2
	mov edi, v1
	mov eax, [esi]
	sub [edi], eax
	mov eax, [esi+4]
	sub [edi+4], eax
	mov eax, [esi+8]
	sub [edi+8], eax
ret
subVectorProc ENDP
subVector MACRO v1, v2
	INVOKE subVectorProc, v1 ,v2
ENDM

copyVectorProc Proc uses eax esi edi, v1:DWORD, v2:DWORD 
	mov esi, v2
	mov edi, v1
	mov eax, [esi]
	mov [edi], eax
	mov eax, [esi+4]
	mov [edi+4], eax
	mov eax, [esi+8]
	mov [edi+8], eax
ret
copyVectorProc ENDP
copyVector MACRO v1, v2
	INVOKE copyVectorProc, v1 ,v2
ENDM

VectorLenProc Proc uses esi, vec:DWORD
	mov esi, vec
	mult [esi], [esi]
	mov ebx, eax
	mult [esi+4], [esi+4]
	add ebx, eax
	mult [esi+8], [esi+8]
	add eax, ebx
	sqrt eax
ret
VectorLenProc ENDP
VectorLen MACRO vec
	INVOKE VectorLenProc, vec
	ENDM