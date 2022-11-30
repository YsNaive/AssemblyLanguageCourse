INCLUDE Irvine32.inc

main          EQU start@0
Str_remove PROTO,
pStart:PTR BYTE,
nChars:DWORD

.data
target1 BYTE "110504517",0
target2 BYTE "110504518",0
target3 BYTE "999999999",0
.code
main PROC
INVOKE Str_remove, OFFSET target1, 5
mov edx,OFFSET target1
call WriteString
call Crlf
INVOKE Str_remove, OFFSET target2, 2
mov edx,OFFSET target2
call WriteString
call Crlf

INVOKE Str_remove, OFFSET [target2+1], 15
mov edx,OFFSET target2
call WriteString
call Crlf
call WaitMsg
exit
main ENDP


Str_remove PROC,
	pStart:PTR BYTE, nChars:DWORD

	INVOKE Str_length, pStart
	mov	ecx,eax

	.IF nChars <= ecx
	    sub ecx,nChars
.ENDIF

	mov	esi,pStart
	add	esi,nChars
	mov	edi,pStart

	CLD	
	rep	movsb
    mov	BYTE PTR [edi],0

Exit_proc:
	ret
Str_remove ENDP

END main

