stack segment para stack
	db 64 dup(' ')
stack ends
; �w�q�ƾڬq�A�s��ƾ�
data segment
    ; db �O�w�q���U�Ӫ��ƾڬ���r�`���N��A
    ; '$'�O�r�ꪺ�����A���� C �� '\0'
    string db 13,10,'Hello World!',13,10,'$'
data ends

; �w�q�N�X�q�A���檺�{���X
code segment
    ; �����O�A�i�D��Ķ���N�X�q������
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

end start   ; ����Ķ�����D�{�����i�J�I