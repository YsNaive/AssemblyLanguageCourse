model small

.stack 8192

.data
include struct~1.asm
include variable.asm

.code
include proced~1.asm

main proc
    mov dl, "G"
    Call WriteChar
	
    mov ah, 4Ch ; Exit Program no matter any situation
    int 21h
main endp
end main
