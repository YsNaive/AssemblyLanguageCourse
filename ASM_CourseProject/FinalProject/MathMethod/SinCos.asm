; last 3 digit is float

; degree normalize
degNorProc Proc, deg:Dword
	mov eax, deg
	degNorCheckA:
	isa eax, 360
	jf degNorCheckB
	sub eax, 360
	jmp degNorCheckA

	degNorCheckB:
	isb eax, 0
	jf degNorEnd
	add eax, 360
	jmp degNorCheckB

	degNorEnd:
ret
degNorProc EndP
degNor MACRO val
	INVOKE degNorProc, val
ENDM

; 近似值 sin
sinProc Proc uses ebx ecx edx, deg:Dword
	degNor deg
	isA eax, 180
	.IF BF == T
		sub eax, 180
		mov ecx, -1
	.ElseIF
		mov ecx, 1
	.EndIF

	isA eax, 90
	.IF BF == T
		sub eax, 180
		Abs eax
	.EndIF
	isBE eax, 45
	.IF BF == T
		call sinProc45
	.ELSE
		sub eax, 90
		Abs eax
		call sinProc45
		mult eax,eax
		mov ebx, 1000000 ; 1.000000
		sub ebx, eax
		sqrt ebx
	.EndIF
	mult eax, ecx
ret
sinProc EndP
sin MACRO val
	Invoke sinProc,val
ENDM

; do sin between 0~45 deg
; use eax as input and output
sinProc45 Proc
	isBE eax, 15
	.IF BF == T
		mult eax, 1000
		mult eax, PI
		dive eax, 180000 ; 180 * 1000
	.ELSE
		isBE eax, 30
		.IF BF == T
			sub eax, 15
			mult eax, 016 ; sin(15-30) 每度近似值為 0.016
			add eax, 259  ; sin(15) ~= 0.259
		.Else
			sub eax, 30
			mult eax, 014 ; sin(30-45) 每度近似值為 0.016
			add eax, 500  ; sin(30) ~= 0.5
		.EndIF
	.EndIF
ret
sinProc45 EndP

; con(θ) = sin(90- θ)
cosProc Proc deg:dword
	mov eax,90
	sub eax, deg
	sin eax 
ret
cosProc EndP
cos MACRO deg
	INVOKE cosProc, deg
ENDM