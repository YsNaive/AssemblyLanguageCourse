; �w�q�ƾڬq�A�s��ƾ�
data segment
    ; db �O�w�q���U�Ӫ��ƾڬ���r�`���N��A
    ; '$'�O�r�ꪺ�����A���� C �� '\0'
    string db 13,10,'Hello World!',13,10,'$'
data ends

; �w�q�N�X�q�A���檺�{���X
code segment
    ; �����O�A�i�D��Ķ���N�X�q������
    assume cs:code, ds:data
start:
    mov ax, data     ; �N data ���a�}��� ax �Ȧs��
    mov ds, ax       ; �N ax ���ȩ�� ds �Ȧs��
    lea dx, string   ; �N string �ܼƪ��a�}��i dx �Ȧs��
    mov ah, 09h      ; 09h �������O�N�r���X��ù��W
    int 21h          ; �եΨt�Υ\��A�������O�ثe ah �Ȧs��������

    mov ax, 4c00h    ; �h�X�{��
    int 21h          ; �եΨt�Υ\��
code ends

end start   ; ����Ķ�����D�{�����i�J�I