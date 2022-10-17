include Irvine32.inc

.data   ;we can't found ASCII code in mem watch window, so we use ANSI code.
myID byte 49,49,48,53,48,52,53,49,55
myID2 byte 49,49,48,53,48,52,53,49,56

.code
Convert PROC USES esi ecx
    L1:
    push ecx
    mov cl,17
    Add [esi], cl
    pop ecx
    Add esi, 1
    loop L1
    ret
Convert ENDP

Convert2 PROC	
    L1:	
    push ecx
    mov cl,17
    Add [esi], cl
    pop ecx
    Add esi, 1
    loop L1
    ret
Convert2 ENDP

Main PROC
    Mov eax,9999h
    Mov ebx,9999h
    Mov edx,9999h

    Mov ecx, 9
    Mov esi,OFFSET myID
    call Convert
    
    Mov esi,OFFSET myID2
    call Convert2
	exit
main ENDP
END main


