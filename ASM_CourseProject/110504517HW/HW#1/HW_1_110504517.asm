include Irvine32.inc
.data 
Digit0 BYTE 4h
Digit1 BYTE 5h
Digit2 BYTE 1h
Digit3 BYTE 7h
MyId DWORD ?

.code 
main PROC			
	MOV ah, Digit0
	MOV al, Digit1
	SHL eax, 16
	MOV ah, Digit2
	MOV al, Digit3
	MOV MyId, eax

	exit
main ENDP
END main

