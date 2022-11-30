INCLUDE Irvine32.inc
.386
.stack 4096

main EQU start@0
CountMatches PROTO, arr1:PTR SDWORD, arr2:PTR SDWORD, arrSize:DWORD

.data
array1 SDWORD 10,5,4,-6,2,11,12
array2 SDWORD 10,5,3, 1,4, 2,-6
.code
main PROC
    INVOKE CountMatches, OFFSET array1, OFFSET array2, LENGTHOF array1
    MOV edx, eax
    Call WriteInt
exit
main ENDP

CountMatches PROC,
    arr1:PTR SDWORD, arr2:PTR SDWORD, arrSize:DWORD
    
    Push ecx
    Push esi
    Push edi
    MOV ecx, arrSize
    MOV eax, 0
    MOV esi, arr1
    MOV edi, arr2

    CLD
    CheckLOOP:
        CMPSD
        JNE NotEqual ; continue when xi != yi
        INC eax
        NotEqual:
        LOOP CheckLOOP
    EndPROC:
    Pop edi
    Pop esi
    Pop ecx
    RET
CountMatches endp

end main

