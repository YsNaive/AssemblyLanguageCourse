W_KEY equ 77h
A_KEY equ 61h
S_KEY equ 73h
D_KEY equ 64h
Q_KEY equ 71h
E_KEY equ 65h
MOVE_DISTANCE equ 10
ROTATE_RATE equ 10

MoveCamera PROC
READ:
    mov ah, 7
    int 21h
    cmp al, W_KEY
    Je MOVE_UP
    cmp al, A_KEY
    je MOVE_LEFT
    cmp al, S_KEY
    je MOVE_DOWE
    cmp al, D_KEY
    je MOVE_RIGHT
    cmp al, Q_KEY
    

    jmp READ

MOVE_UP:
    logChar 'w'
    mov ax, MOVE_DISTANCE
    ADD camera.pos.x, ax
    ret
MOVE_DOWE:
    logChar 's'
    mov ax, MOVE_DISTANCE
    SUB camera.pos.x, ax
    ret
MOVE_LEFT:
    logChar "a"
    mov ax, MOVE_DISTANCE
    SUB camera.pos.z, ax
    ret
MOVE_RIGHT:
    logChar "d"
    mov ax, MOVE_DISTANCE
    ADD camera.pos.z, ax
    ret
LEFT_ROTATE:
    logChar "q"
    MOV ax, ROTATE_RATE
    SUB camera.euler.y, ax
    ret
RIGHT_ROTATE:
    logChar "e"
    MOV ax, ROTATE_RATE
    Add camera.euler.y, ax
    ret
MoveCamera ENDP

; rotate object move dx, dy, dz
; input : si : object.pos
;         di : pointer to Vector3<dx,dy,dz>
object_move PROC
    MOV ax, [di]
    Add [si], ax

    MOV ax, [di+2]
    Add [si+2], ax

    MOV ax, [di+4]
    Add [si+4], ax
    ret
object_move ENDP


; rotate object with dx, dy, dz
; input : si : object.eular
;         di : pointer to Vector3<dx,dy,dz>
object_roatate PROC
    MOV ax, [di]
    Add [si], ax

    MOV ax, [di+2]
    Add [si+2], ax

    MOV ax, [di+4]
    Add [si+4], ax
    ret
object_roatate ENDP