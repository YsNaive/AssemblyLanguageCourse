save_sp_bp MACRO 
    push bp
	mov bp,sp
 ENDM

load_sp_bp MACRO 
    mov sp,bp
    pop bp
 ENDM
include PROC\Debug.asm
include PROC\Bool.asm
include PROC\Math\MathCo~1.asm
include PROC\Math\SinCos.asm
include PROC\Math\Vector.asm
include PROC\Math\IsLine~1.asm
include PROC\init.asm
include PROC\Draw\DrawCore.asm
include PROC\move.asm
include PROC\Draw\Draw4P~1.asm
include PROC\Draw\DrawSp~1.asm



WaitForKeypress PROC 
push ax
    mov ah, 0
    int 16h
pop ax
ret
WaitForKeypress ENDP

