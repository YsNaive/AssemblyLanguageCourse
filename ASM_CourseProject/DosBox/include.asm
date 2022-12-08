include PROC\Debug.asm
include PROC\Bool.asm
include PROC\Math\MathCo~1.asm
include PROC\Math\SinCos.asm
include PROC\Math\IsLine~1.asm
include PROC\init.asm
include PROC\Draw4P~1.asm

store_sp_bp MACRO 
    push bp
	mov bp,sp
 ENDM

restore_sp_bp MACRO 
    mov sp,bp
    pop bp
 ENDM


WaitForKeypress PROC 
    mov ah, 0
    int 16h
    ret
WaitForKeypress ENDP
