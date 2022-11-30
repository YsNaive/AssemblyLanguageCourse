INCLUDE Irvine32.inc
main EQU start@0
.stack 4096
ExitProcess proto, dwExitCode : dword
FindLargest proto, aPtr : PTR SDWORD, arraySize : DWORD

.data
Ex1Array sdword 105522063 , 110504517 , 110504518 
Ex2Array sdword -105522063 , -110504517 , -110504518
 
.code
main proc
    push LengthOf Ex1Array
    push OFFSET Ex1Array
    call FindLargest 

    push LengthOf Ex2Array
    push OFFSET Ex2Array
    call FindLargest
   
    call WaitMsg
    invoke ExitProcess,0
main endp

FindLargest proc,
    aPtr : PTR SDWORD, arraySize : DWORD
    push esi
    push ecx

    mov  eax, 0 
    mov  esi, aPtr
    mov  ecx, arraySize
 
L1: 
    CMP eax, [esi]
    JA  L2
    MOV eax, [esi]
 
L2: 
    add  esi,4       
    loop L1
   
    call WriteInt
    call Crlf
   
    pop ecx
    pop esi
    ret
FindLargest endp
 
end main

