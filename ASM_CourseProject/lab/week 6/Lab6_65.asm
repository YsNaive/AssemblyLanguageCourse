include Irvine32.inc
.data   
	result byte 81 DUP(?)
.code
Main PROC
	MOV bl,  0 ;use for i loop
	MOV bh,  0 ;use for j loop
	MOV esi, 0
	MOV ecx, 9
	
iloop: ;i loop start
	INC bl
	MOV bh, 0
	Push ecx
	MOV ecx, 9
	jloop:;j loop start

		INC bh
		MOV al, bl
		MUL bh
		MOV result[esi], al
		INC esi
		LOOP jloop
		;j loop end

	Pop ecx
	LOOP iloop
	;i loop end
	exit
main ENDP
END main

