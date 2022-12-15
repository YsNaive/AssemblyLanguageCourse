INCLUDE Irvine32.inc
.data
consoleHandle    DWORD ?
xyInit COORD <19,19> 
xyBound COORD <80,25> 
xyPos COORD <,>
main EQU start@0
.code
main PROC
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov consoleHandle,eax
INITIAL:
	mov ax,xyInit.x
	mov xyPos.x,ax
	mov ax,xyInit.y
	mov xyPos.y,ax

START:
	call ClrScr
	INVOKE SetConsoleCursorPosition, consoleHandle, xyPos
	call ReadChar
	.IF ax == 4800h ;UP
		sub xyPos.y,1
	.ENDIF
	.IF ax == 5000h ;DOWN
		add xyPos.y,1
	.ENDIF
	.IF ax == 4B00h ;LEFT
		sub xyPos.x,1
	.ENDIF
	.IF ax == 4d00h ;RIGHT
		add xyPos.x,1
	.ENDIF
	.IF ax == 011Bh ;ESC
		jmp END_FUNC
	.ENDIF
	
	; examine if each directions are over the border.
	.IF xyPos.x == 0h ;x lowerbound
		inc xyPos.x
	.ENDIF
	mov ax,xyBound.x 
	.IF xyPos.x == ax ;x upperbound
		dec xyPos.x
	.ENDIF
	
	.IF xyPos.y == 0h ;y lowerbound
		inc xyPos.y
	.ENDIF
	mov ax,xyBound.y
	.IF xyPos.y == ax ;y upperbound
		dec xyPos.y
	.ENDIF
	
	jmp START
END_FUNC:
	exit
main ENDP

END main

