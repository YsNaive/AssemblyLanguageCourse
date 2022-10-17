include Irvine32.inc

.data   
myID byte 49,49,48,53,48,52,53,49,55
myID2 byte 49,49,48,53,48,52,53,49,56
result byte 9 DUP(?)  


.code
Main PROC ;we can't found ASCII code in mem watch window, so we use ANSI code.
    mov ecx, 9
	mov esi, 0
L1:
	mov al, myID[esi]
	mov bl, myID2[esi]
	cmp al, bl			; al - bl
	JA Above			; al > bl
	JB Below			; al < bl
	mov result[esi], 65 ; al = bl
	JMP nextLoop

Above:
	mov result[esi], 66
	JMP nextLoop

Below:
	mov result[esi], 67
	JMP nextLoop

nextLoop:
	inc esi
	LOOP L1

	exit
main ENDP
END main
