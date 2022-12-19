DebugBool MACRO
push ax dx
    mov dx, BF
    mov ah, 02h
    int 21h
    call NewLine
pop dx ax
ENDM

; jump true
jt MACRO target
	cmp BF, TRUE
	je target
ENDM
; jump false
jf MACRO target
	cmp BF, FALSE
	je target
ENDM

andproc PROC
push ax
	save_sp_bp
	mov ax, TRUE
	cmp ax, [WORD PTR bp+06h]
	jne andprocFalse
	cmp ax, [WORD PTR bp+08h]
	jne andprocFalse
	mov BF, TRUE
	jmp andprocEnd
	andprocFalse:
	mov BF, FALSE
	andprocEnd:
	load_sp_bp
pop ax
ret 4
andproc ENDP
andb MACRO val1, val2
	push val1
	push val2
	call andproc
ENDM

orProc PROC
push ax
	save_sp_bp
	mov ax, TRUE
	cmp ax, [WORD PTR bp+06h]
	je orprocTrue
	cmp ax, [WORD PTR bp+08h]
	je orprocTrue
	mov BF, FALSE
	jmp orprocEnd
	orprocTrue:
	mov BF, TRUE
	orprocEnd:
	load_sp_bp
pop ax
ret 4
orProc ENDP
orb MACRO val1, val2
push ax
	push val1
	push val2
	call orProc
pop ax
ENDM

isA MACRO val1, val2
	local @@above, @@end
push ax
	mov ax, val1
	cmp ax, val2
	jg @@above
	mov BF, FALSE
	jmp @@end
	@@above:
	mov BF, TRUE
	@@end:
pop ax
ENDM
isAE MACRO val1, val2
	local @@above, @@end
push ax
	mov ax, val1
	cmp ax, val2
	jge @@above
	mov BF, FALSE
	jmp @@end
	@@above:
	mov BF, TRUE
	@@end:
pop ax
ENDM
isB MACRO val1, val2
	local @@below, @@end
push ax
	mov ax, val1
	cmp ax, val2
	jl @@below
	mov BF, FALSE
	jmp @@end
	@@below:
	mov BF, TRUE
	@@end:
pop ax
ENDM
isBE MACRO val1, val2
	local @@below, @@end
push ax
	mov ax, val1
	cmp ax, val2
	jle @@below
	mov BF, FALSE
	jmp @@end
	@@below:
	mov BF, TRUE
	@@end:
pop ax
ENDM
