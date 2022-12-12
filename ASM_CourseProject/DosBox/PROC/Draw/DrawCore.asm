ClearScreen PROC

ClearScreen ENDP

SetPixel MACRO x, y
	push point1
	setVector2 point1, x, y
	call SetPixelProc
	pop point1
ENDM
SetPixelProc PROC ; use point1, color
push ax cx dx
	mov ah, 0ch
	mov al, color
	mov cx, point1.x
	mov dx, point1.y
    int 10h
	ret
pop dx cx ax
SetPixelProc ENDP
