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