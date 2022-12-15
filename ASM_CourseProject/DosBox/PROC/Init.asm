init PROC
	; set to vga mode
	mov al, 13h
	mov ah, 0
	int 10h
	mov al, 00h
	mov ah, 05h
	int 10h
	ret
init ENDP