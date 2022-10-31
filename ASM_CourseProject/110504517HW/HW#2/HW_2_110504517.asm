include Irvine32.inc

.data 
BitStrs BYTE 8 dup(?)
ChStrs BYTE "########"
	   BYTE "      ##"
	   BYTE "     ## "
	   BYTE "   ##   "
	   BYTE "   ##   "
	   BYTE "   ##   "
	   BYTE "   ##   "
	   BYTE "   ##   "

.code 
change PROC
		SHL BitStrs[edi], 1
		CMP ChStrs[esi], "#"
		JNE notEqual
		INC BitStrs[edi]
		notEqual:
		
		INC esi
		RET
change ENDP

main PROC		
	MOV ecx, 8
	MOV esi, 0 ; use esi as ChStrs's  index
	MOV edi, 0 ; use edi as BitStrs's index

ConvertRow:
	Push ecx
	MOV ecx, 8
	ConvertColumn:
		CALL change
		LOOP ConvertColumn
	MOVZX eax, BitStrs[edi]

	MOV ebx, 1
	CALL WriteBinB
	CALL Crlf

	INC edi
	Pop ecx
	LOOP ConvertRow

	exit
main ENDP
END main

