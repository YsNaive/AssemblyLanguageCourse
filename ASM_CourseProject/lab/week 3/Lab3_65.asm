include Irvine32.inc

.data
Result byte 9 DUP(?)

.code
Main PROC
	Mov ecx, 9
	Mov esi, OFFSET Result
	MOV al, 9

Calculate:
	MOV [esi], al
	ADD esi, 1
	ADD al, 9
	LOOP Calculate

	MOV al, bl
	exit
main ENDP
END main
