include Irvine32.inc
.data 
Value1 SBYTE 03h
Value2 SBYTE 02h
Value3 SBYTE 8fh
Result SDWORD ?

.code 
main PROC				;caculate -(Val3 ¡V 14 * (Val1 ¡Ï Val2))
	MOV al, Value1
	ADD al, Value2
	MOV bl, al
	SHL al, 4
	SHL bl, 1
	SUB al, bl
	MOV bl, Value3
	SUB bl, al
	NEG bl
	MOVSX eax, bl
	MOV Result, eax
	

	exit
main ENDP
END main