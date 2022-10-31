include Irvine32.inc

divide MACRO dividend, divisor, quotient, remainder
	Push eax
	Push edx
	
	MOV edx,0
	MOVSX eax,dividend
	IDIV divisor
	MOV quotient, ax
	MOV remainder, dx

	Pop edx
	Pop eax
ENDM

.data
dividend WORD 4517d
divisor WORD 100
quotient WORD ?
remainder WORD ?
	
.code
main PROC
	movsx eax, dividend
	call WriteDec
	call Crlf
	
	divide dividend, divisor, quotient, remainder
	
	movsx eax, quotient
	call WriteDec
	call Crlf
	
	movsx eax, remainder
	call WriteDec
	call Crlf
	exit
main ENDP
END main

