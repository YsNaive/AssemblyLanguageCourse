init PROC
	; set to vga mode
	mov al, 13h
	mov ah, 0
	int 10h
	ret
init ENDP