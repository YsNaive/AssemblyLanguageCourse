CAMERA_DISTANCE equ 100
SCALER = 0

mapCube PROC
    local @@dataPtr : word, @@coreDistance : word, @@extend : Vector3, @@euler : Vector3, @@dArray : word : 6, @@point_1 : Vector3, @@point_2 : Vector3, @@point_3 : Vector3, @@point_4 : Vector3, @@point_5 : Vector3, @@point_6 : Vector3, @@point_7 : Vector3, @@point_8 : Vector3
    
    MOV @@dataPtr, si

    ; set extend
    MOV si, @@dataPtr
    MOV ax, word ptr [si+12]
    MOV bx, word ptr [si+14]
    MOV cx, word ptr [si+16]
    SetVector3 @@extend ax bx cx
    ; set euler
    MOV si, @@dataPtr
    MOV ax, word ptr [si+6]
    MOV bx, word ptr [si+8]
    MOV cx, word ptr [si+10]
    SetVector3 @@euler ax bx cx

    ; set coreDistance : todo
    MOV @@coreDistance, 200


    ; Scale up/down extend 
    ;============================================
    ; solution 1
    ; mDiv CAMERA_DISTANCE, @@coreDistance
    ; SCALER = ax
    ; mult @@extend.z, SCALER
    ; MOV cx, ax
    ; mult @@extend.y, SCALER
    ; mov bx, ax
    ; mult @@extend.x, SCALER
    ; AddVector3 @@extend ax bx cx 

    ; solution 2
    mult @@extend.x, CAMERA_DISTANCE
    MOV @@extend.x, ax
    mult @@extend.y, CAMERA_DISTANCE
    MOV @@extend.y, ax
    mult @@extend.z, CAMERA_DISTANCE
    MOV @@extend.z, ax

    mDiv @@extend.x, @@coreDistance
    MOV @@extend.x, ax
    mDiv @@extend.y, @@coreDistance
    MOV @@extend.y, ax
    mDiv @@extend.z, @@coreDistance
    MOV @@extend.z, ax


    ;============================================
    ; set all point in core pos
    MOV si, @@dataPtr
    MOV ax, word ptr [si]
    MOV bx, word ptr [si+2]
    MOV cx, word ptr [si+4]
    SetVector3 @@point_1 ax, bx, cx
    SetVector3 @@point_2 ax, bx, cx
    SetVector3 @@point_3 ax, bx, cx
    SetVector3 @@point_4 ax, bx, cx
    SetVector3 @@point_5 ax, bx, cx
    SetVector3 @@point_6 ax, bx, cx
    SetVector3 @@point_7 ax, bx, cx
    SetVector3 @@point_8 ax, bx, cx

    ;offset x, y, z by extend
    mDiv @@extend.x, 2
    mov @@dArray[0], ax
    Neg ax
    mov @@dArray[2], ax
    mDiv @@extend.y, 2
    mov @@dArray[4], ax
    Neg ax
    mov @@dArray[6], ax
    mDiv @@extend.z, 2
    mov @@dArray[8], ax
    Neg ax
    mov @@dArray[10], ax
    ;dArray[0]  =  dx
    ;dArray[2]  = -dx
    ;dArray[4]  =  dy
    ;dArray[6]  = -dy
    ;dArray[8]  =  dz
    ;dArray[10] = -dz


    ; set all point to each point
    AddVector3 @@point_1 @@dArray[0] @@dArray[4] @@dArray[8]  
    AddVector3 @@point_2 @@dArray[2] @@dArray[4] @@dArray[8]
    AddVector3 @@point_3 @@dArray[2] @@dArray[6] @@dArray[8]
    AddVector3 @@point_4 @@dArray[0] @@dArray[6] @@dArray[8]
    AddVector3 @@point_5 @@dArray[0] @@dArray[4] @@dArray[10]
    AddVector3 @@point_6 @@dArray[2] @@dArray[4] @@dArray[10]
    AddVector3 @@point_7 @@dArray[2] @@dArray[6] @@dArray[10]
    AddVector3 @@point_8 @@dArray[0] @@dArray[6] @@dArray[10]


    ;log points
    logVector3 @@point_1
    logVector3 @@point_2
    logVector3 @@point_3
    logVector3 @@point_4
    logVector3 @@point_5
    logVector3 @@point_6
    logVector3 @@point_7
    logVector3 @@point_8


    ; spin the cube point base on eular
    ; lea si, @@point_1
    ; lea di, @@euler
    ; call rotate

    



    ; logVector3 @@point_1

    ret
mapCube ENDP

; rotate the point 
; input : si (ptr to Vector3) = point
;       : di (ptr to Vector2) = euler
; rotate PROC
;     local @@dArray : word : 12, local @@sin : word
    
;     ; sin( theta x)
;     MOV i, WORD PTR [di]
;     call sin_function 
;     MOV @@sin, ax

;     Mult_d ax [si]
;     Div_d dx ax 10  ; xsin
;     MOV @@dArray[1], ax

;     log ax


;     ret
; rotate ENDP


; input : i (theta)
;       : si (ptr to Vector3) = point
; roatate_on_x PROC
;     local @@new_y : word, @@new_z : word
;     ; i = theta
;     call sin_function
;     Mult_d ax, [si]
;     Div_d dx ax 100 


;     ret
; roatate_on_x ENDP


mapSphere PROC
    local @@dataPtr : word, @@coreDistance : word, @@pos : Vector3, @@euler : Vector3, @@radius : word 

    MOV @@dataPtr, si
    ; set pos
    MOV si, @@dataPtr
    MOV ax, word ptr [si+0]
    MOV bx, word ptr [si+2]
    MOV cx, word ptr [si+4]
    SetVector3 @@pos ax bx cx
    ; set euler
    MOV si, @@dataPtr
    MOV ax, word ptr [si+6]
    MOV bx, word ptr [si+8]
    MOV cx, word ptr [si+10]
    SetVector3 @@euler ax bx cx
    ; set radius
    MOV si, @@dataPtr
    MOV ax, word ptr [si+12]
    MOV @@radius, ax
    ; caculate coreDistance
    logVector3 @@pos
    logVector3 @@euler
    log @@radius
    ; set coreDistance
    ; todo

    ;======================================== working area==============================



    ret
mapSphere ENDP