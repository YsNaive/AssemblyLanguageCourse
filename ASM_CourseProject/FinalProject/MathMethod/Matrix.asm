Matrix3Mult Proc uses eax ebx esi edi, result:DWORD ,m1:DWORD, m2:DWORD
	mov esi, m1
	mov edi, m2

	; 00 ~ 02
	mov eax, [esi] 
	mult eax, [edi] ; s00 * d00
	mov ebx, eax
	mov eax, [esi+4] 
	mult eax, [edi+12] ; s01 * d10
	add ebx, eax
	mov eax, [esi+8] 
	mult eax, [edi+24] ; s02 * d20
	add ebx, eax
	
	mov esi, result
	mov [esi], ebx
	mov esi, m1

	mov eax, [esi] 
	mult eax, [edi+4] ; s00 * d01
	mov ebx, eax
	mov eax, [esi+4] 
	mult eax, [edi+16] ; s01 * d11
	add ebx, eax
	mov eax, [esi+8] 
	mult eax, [edi+28] ; s02 * d21
	add ebx, eax
	
	mov esi, result
	mov [esi+4], ebx
	mov esi, m1

	mov eax, [esi] 
	mult eax, [edi+8] ; s00 * d01
	mov ebx, eax
	mov eax, [esi+4] 
	mult eax, [edi+20] ; s01 * d11
	add ebx, eax
	mov eax, [esi+8] 
	mult eax, [edi+32] ; s02 * d21
	add ebx, eax
	
	mov esi, result
	mov [esi+8], ebx
	mov esi, m1

	
	; 10 ~ 12
	mov eax, [esi+12] 
	mult eax, [edi] ; s00 * d00
	mov ebx, eax
	mov eax, [esi+16] 
	mult eax, [edi+12] ; s01 * d10
	add ebx, eax
	mov eax, [esi+20] 
	mult eax, [edi+24] ; s02 * d20
	add ebx, eax
	
	mov esi, result
	mov [esi+12], ebx
	mov esi, m1

	mov eax, [esi+12] 
	mult eax, [edi+4] ; s00 * d01
	mov ebx, eax
	mov eax, [esi+16] 
	mult eax, [edi+16] ; s01 * d11
	add ebx, eax
	mov eax, [esi+20] 
	mult eax, [edi+28] ; s02 * d21
	add ebx, eax
	
	mov esi, result
	mov [esi+16], ebx
	mov esi, m1

	mov eax, [esi+12] 
	mult eax, [edi+8] ; s00 * d01
	mov ebx, eax
	mov eax, [esi+16] 
	mult eax, [edi+20] ; s01 * d11
	add ebx, eax
	mov eax, [esi+20] 
	mult eax, [edi+32] ; s02 * d21
	add ebx, eax
	
	mov esi, result
	mov [esi+20], ebx
	mov esi, m1
	

	; 20 ~ 22
	mov eax, [esi+24] 
	mult eax, [edi] ; s00 * d00
	mov ebx, eax
	mov eax, [esi+28] 
	mult eax, [edi+12] ; s01 * d10
	add ebx, eax
	mov eax, [esi+32] 
	mult eax, [edi+24] ; s02 * d20
	add ebx, eax
	
	mov esi, result
	mov [esi+24], ebx
	mov esi, m1

	mov eax, [esi+24] 
	mult eax, [edi+4] ; s00 * d01
	mov ebx, eax
	mov eax, [esi+28] 
	mult eax, [edi+16] ; s01 * d11
	add ebx, eax
	mov eax, [esi+32] 
	mult eax, [edi+28] ; s02 * d21
	add ebx, eax
	
	mov esi, result
	mov [esi+28], ebx
	mov esi, m1

	mov eax, [esi+24] 
	mult eax, [edi+8] ; s00 * d01
	mov ebx, eax
	mov eax, [esi+28] 
	mult eax, [edi+20] ; s01 * d11
	add ebx, eax
	mov eax, [esi+32] 
	mult eax, [edi+32] ; s02 * d21
	add ebx, eax
	mov esi, result
	mov [esi+32], ebx

ret
Matrix3Mult EndP

Matrix3MultKProc Proc uses eax ecx edi, mat:DWORD, K:DWORD
	mov edi, mat
	mov ecx, 9
	Matrix3MultKLoop:
		mult [edi], K
		mov [edi], eax
		add edi, 4
	loop Matrix3MultKLoop
ret
Matrix3MultKProc EndP
Matrix3MultK Macro mat, k
	INVOKE Matrix3MultKProc, mat, k
ENDM

Matrix3DiveKProc Proc uses eax ecx edi, mat:DWORD, K:DWORD
	mov edi, mat
	mov ecx, 9
	Matrix3DiveKLoop:
		dive [edi], K
		mov [edi], eax
		add edi, 4
	loop Matrix3DiveKLoop
ret
Matrix3DiveKProc EndP
Matrix3DiveK Macro mat, k
	INVOKE Matrix3DiveKProc, mat, k
ENDM