include Irvine32.inc

.data
Result byte 9 DUP(?)

.code
Main PROC
	Mov ecx, 9
	Mov esi, OFFSET Result
	
calculate:
	

	exit
main ENDP
END main
