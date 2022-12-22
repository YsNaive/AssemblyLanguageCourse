; And
; =============================================================
and2 Proc, val1:BYTE, val2:BYTE
	.IF val1 == T
	.IF val2 == T
		mov BF, T
		ret
	.EndIF
	.EndIF
	mov BF, F
ret
and2 EndP
and3 Proc, val1:BYTE, val2:BYTE, val3:BYTE
	.IF val1 == T
	.IF val2 == T
	.IF val3 == T
		mov BF, T
		ret
	.EndIF
	.EndIF
	.EndIF
	mov BF, F
ret
and3 EndP

; Or
; =============================================================
or2 Proc, val1:BYTE, val2:BYTE
	.IF val1 == F
	.IF val2 == F
		mov BF, F
		ret
	.EndIF
	.EndIF
	mov BF, T
ret
or2 EndP
or3 Proc, val1:BYTE, val2:BYTE, val3:BYTE
	.IF val1 == F
	.IF val2 == F
	.IF val3 == F
		mov BF, F
		ret
	.EndIF
	.EndIF
	.EndIF
	mov BF, T
ret
or3 EndP

; Jump
; =============================================================
JT Macro target
	cmp BF, T
	je target
EndM

JF Macro target
	cmp BF, F
	je target
EndM


isEProc Proc val1:dword, val2:dword
push eax
	mov eax, val1
	cmp eax, val2
	jne isEfalsePart
		mov BF, T
	jmp isEendProc
	isEfalsePart:
		mov BF, F
	isEendProc:
pop eax
ret
isEProc EndP
isE MACRO v1, v2
	INVOKE isEProc, v1, v2
EndM

isAProc Proc val1:dword, val2:dword
push eax
	mov eax, val1
	cmp eax, val2
	jle isAfalsePart
		mov BF, T
	jmp isAendProc
	isAfalsePart:
		mov BF, F
	isAendProc:
pop eax
ret
isAProc EndP
isA MACRO v1, v2
	INVOKE isAProc, v1, v2
EndM

isAEProc Proc val1:dword, val2:dword
push eax
	mov eax, val1
	cmp eax, val2
	jl isAEfalsePart
		mov BF, T
	jmp isAEendProc
	isAEfalsePart:
		mov BF, F
	isAEendProc:
pop eax
ret
isAEProc EndP
isAE MACRO v1, v2
	INVOKE isAEProc, v1, v2
EndM

isBProc Proc val1:dword, val2:dword
push eax
	mov eax, val1
	cmp eax, val2
	jge isBfalsePart
		mov BF, T
	jmp isBendProc
	isBfalsePart:
		mov BF, F
	isBendProc:
pop eax
ret
isBProc EndP
isB MACRO v1, v2
	INVOKE isBProc, v1, v2
EndM

isBEProc Proc val1:dword, val2:dword
push eax
	mov eax, val1
	cmp eax, val2
	jg isBEfalsePart
		mov BF, T
	jmp isBEendProc
	isBEfalsePart:
		mov BF, F
	isBEendProc:
pop eax
ret
isBEProc EndP
isBE MACRO v1, v2
	INVOKE isBEProc, v1, v2
EndM