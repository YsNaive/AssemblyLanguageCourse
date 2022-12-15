CAMERA_DISTANCE equ 100
SCALER = 0

map PROC
    local @@dataPtr : word, @@coreDistance : word, @@extend : Vector3, @@scale : word, @@point_1 : Vector3, @@point_2 : Vector3, @@point_3 : Vector3, @@point_4 : Vector3, @@point_5 : Vector3, @@point_6 : Vector3, @@point_7 : Vector3, @@point_8 : Vector3,
    MOV @@dataPtr, si

    ; set extend
    MOV si, @@dataPtr
    MOV ax, word ptr [si+12]
    MOV bx, word ptr [si+14]
    MOV cx, word ptr [si+16]
    SetVector3 @@extend ax bx cx


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


    ;================== Working Area ======================

    ; logVector3 @@extend
    ;offset x, y, z by extend
    
    mDiv @@extend.x, 2
    mNeg ax
    ; mDiv @@extend.y, 2
    ; mDiv @@extend.z, 2

    mov ax, -10
    mov ax, 100


    logVector3 @@point_1
    logVector3 @@point_2

    ; AddVector3 @@point_1  
    ; AddVector3 @@point_2 

    logVector3 @@point_1
    logVector3 @@point_2

    ; set all point to each point
    ; AddVector3 @@point_1 -1 -1 -1


    ; logVector3 @@point_1

    ret
map ENDP