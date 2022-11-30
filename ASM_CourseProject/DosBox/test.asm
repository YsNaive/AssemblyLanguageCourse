stack segment para stack
	db 64 dup(' ')
stack ends
; 定義數據段，存放數據
data segment
    ; db 是定義接下來的數據為單字節的意思，
    ; '$'是字串的結尾，類似 C 的 '\0'
    string db 13,10,'Hello World!',13,10,'$'
data ends

; 定義代碼段，執行的程式碼
code segment
    ; 偽指令，告訴組譯器代碼段的對應
    assume  cs:code, ds:data, ss:stack
start:
	mov ax, data
	mov ds, ax
	mov ax, stack
	mov ss, ax

	mov ah, 00h
	mov al, 13h
	int 10h

	mov ah, 0ch
	mov cx, 160
	mov dx, 100
	mov al, 4
	int 10h

	mov ah, 00h
	int 16h

	mov ah, 00h
	mov al, 03h
	int 10h

	mov ah,4ch
	int 21h
code ends

end start   ; 讓組譯器知道程式的進入點