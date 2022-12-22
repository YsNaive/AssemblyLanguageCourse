IsNeg MACRO val
	isB val, 0
ENDM

; Abs
;=============================================================================
Abs MACRO val
	isNeg val
	.IF BF == T
		push ebx
		mov eax, val
		mov ebx, -1
		imul ebx
		pop ebx
	.EndIF
ENDM

; Max Min, the result will in eax
;=============================================================================
Max2Proc Proc, val1:DWORD, val2:DWORD
	mov eax, val1
	cmp eax, val2
	jg Max2ProcCheck
		mov eax, val2
	Max2ProcCheck:
ret
Max2Proc EndP
Max2 Macro val1, val2
	INVOKE Max2Proc, val1,val2
EndM

Max3Proc Proc, val1:DWORD, val2:DWORD, val3:DWORD
	mov eax, val1
	cmp eax, val2
	jg Max3ProcCheck1
		mov eax, val2
	Max3ProcCheck1:
	cmp eax, val3
	jg Max3ProcCheck2
		mov eax, val3
	Max3ProcCheck2:
ret
Max3Proc EndP
Max3 Macro val1, val2, val3
	INVOKE Max3Proc, val1,val2,val3
EndM

Min2Proc Proc, val1:DWORD, val2:DWORD
	mov eax, val1
	cmp eax, val2
	jl Min2ProcCheck
		mov eax, val2
	Min2ProcCheck:
ret
Min2Proc EndP
Min2 Macro val1, val2
	INVOKE Min2Proc, val1,val2
EndM

Min3Proc Proc, val1:DWORD, val2:DWORD, val3:DWORD
	mov eax, val1
	cmp eax, val2
	jl Min3ProcCheck1
		mov eax, val2
	Min3ProcCheck1:
	cmp eax, val3
	jl Min3ProcCheck2
		mov eax, val3
	Min3ProcCheck2:
ret
Min3Proc EndP
Min3 Macro val1, val2, val3
	INVOKE Min3Proc, val1,val2,val3
EndM

; Clamp
;=============================================================================
ClampProc Proc  val:DWORD, min:DWORD, max:DWORD
	isA val, max
	.IF BF == T
		mov eax, max
		ret
	.EndIF
	isB val, min
	.IF BF == T
		mov eax, min
		ret
	.EndIF

	mov eax, val
ret
ClampProc EndP
Clamp MACRO val, min, max
	INVOKE ClampProc, val, min, max
ENDM

; Mult and Dive (double word)
;=============================================================================
MultProc Proc uses ebx edx, val1:dword, val2:dword
	mov edx, 0
	mov eax, val1
	mov ebx, val2
	imul ebx

	cmp edx, 0
	je MultProcNotOverflow
	cmp edx, 0FFFFFFFFh
	je MultProcNotOverflow
	MultProcOverflow:
	IsNeg edx
	jt MultProcNegOverflow
	mov eax, 7FFFFFFFh
	jmp MultProcNotOverflow
	MultProcNegOverflow:
	mov eax, 80000000h
	MultProcNotOverflow:
ret
MultProc ENDP
Mult Macro val1, val2
	INVOKE MultProc, val1, val2
EndM
; last 3 digit is float
MultF Macro val1, val2
	INVOKE MultProc, val1, val2
	dive eax, 1000
EndM

DiveProc Proc uses ebx, val1:dword, val2:dword
	mov edx, 0
	mov eax, val1
	mov ebx, val2

	cmp eax,0
	je DiveProcEnd
	cmp ebx,0
	je DiveProcEnd
	
	isNeg eax
	jf  DiveProcNotNeg
	push eax
	mov edx, -1
	mov eax, ebx
	mult eax,edx
	mov ebx, eax
	pop eax
	mult eax, edx
	mov edx, 0

	DiveProcNotNeg:
	idiv ebx
	DiveProcEnd:
ret
DiveProc ENDP
Dive Macro val1, val2
	INVOKE DiveProc, val1, val2
EndM

; Sqrt
;=============================================================================
SqrtProc Proc uses ebx ecx edx, val:dword
	mov i, 1
	mov ecx,0
	mov edx, val
	SqrtProcLoop:
		mult i, i	; now -> ax
		mov ebx, edx ; target
		sub ebx, eax	; target - now
		isAE eax, edx
		jt SqrtProcEndLoop
		inc i
		mov ecx, ebx
		jmp SqrtProcLoop
	SqrtProcEndLoop:
	neg ebx
	isB ebx, ecx
	mov eax, i
	jt SqrtProcEnd
	dec eax
	SqrtProcEnd:
ret
SqrtProc ENDP
Sqrt Macro val
	INVOKE SqrtProc, val
EndM

SetSphereProc Proc uses eax esi, spherePtr:DWORD, posX:DWORD, posY:DWORD, posZ:DWORD, r:DWORD
	mov esi, spherePtr
	mov eax, posX
	mov [esi] ,eax
	mov eax, posY
	mov [esi+4] ,eax
	mov eax, posZ
	mov [esi+8] ,eax
	mov eax, r
	mov [esi+12] ,eax
ret
SetSphereProc ENDP
SetSphere MACRO spherePtr, posX, posY, posZ, r
	INVOKE SetSphereProc, spherePtr, posX, posY, posZ, r
ENDM