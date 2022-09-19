include Irvine32.inc
.data 
.code 
main PROC 
	mov al, 00010111b
	mov ah, 18d
	mov ax, 4517h
	mov dx, 0EEEAh
	sub dx, ax
invoke ExitProcess,0 
main ENDP 
END main