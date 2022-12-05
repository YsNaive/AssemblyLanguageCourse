include PROC\init.asm

store_sp_bp MACRO 
    push bp
	mov bp,sp
 ENDM

restore_sp_bp MACRO 
    mov sp,bp
    pop bp
 ENDM

WriteChar proc
    push ax
    mov ah, 02h
    int 21h
    pop ax
    ret
WriteChar ENDP

WaitForKeypress PROC 
    mov ah, 0
    int 16h
    ret
WaitForKeypress ENDP