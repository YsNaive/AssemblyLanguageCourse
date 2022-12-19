Vec2Len PROC
save_sp_bp
	mov bx, [WORD PTR bp+04h] ; x
	mult bx, bx
	mov bx, ax
	mov cx, [WORD PTR bp+06h] ; y
	mult cx, cx
	add ax, bx
	sqrt ax
load_sp_bp
ret 4
Vec2Len ENDP