INCLUDE Irvine32.inc

Str_copyN PROTO, source:PTR BYTE, target:PTR BYTE, maxChars:DWORD
main   EQU start@0

.data
string_1 BYTE "110504517",0
string_2 BYTE "110504518",0

.code
main PROC
    INVOKE Str_copyN, OFFSET string_1, OFFSET string_2 + 9, (SIZEOF string_2) - 1    

    mov  edx, OFFSET string_2
    call WriteString
    call Crlf
    call WaitMsg
    exit
main ENDP
 
Str_copyN PROC USES eax ecx esi edi,
    source:PTR BYTE, target:PTR BYTE, maxChars:DWORD          

    MOV ecx, maxChars
    MOV esi, source
    MOV edi, target
    CLD
    REP MOVSB
    MOV BYTE PTR [esi], 0
    MOVSB
    ret
Str_copyN ENDP

END main

