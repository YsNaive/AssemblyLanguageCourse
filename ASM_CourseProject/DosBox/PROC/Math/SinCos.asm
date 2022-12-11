;==============================================================
PI equ 314                ; pi = 3.14
N_PI equ -314
CONST_E equ 271        ;  e = 2.71
RADIAN_TO_DEGREE equ 5729 ; 1 radians = 57.2957795 degrees
DEGREE_TO_RADIAN equ 0001 ; 1 degrees =  0.0174532 radians
;==============================================================


;=====================================
; sin fuction
; input  : i
; output : ax
;=====================================
sin_function PROC
    local @@result : word, @@divisor : word
    MOV ax, i 

    call normalize_pi
    MOV i, ax

;CALCULATE
    MOV ax, i
    MOV @@result, ax  

    MOV @@divisor, 100           
    MOV dx, 0                   
    IDIV @@divisor    

    mult ax, i
    MOV @@divisor, 100
    MOV dx, 0
    IDIV @@divisor

    mult ax, i
    MOV @@divisor, 6
    MOV dx, 0
    IDIV @@divisor


    SUB @@result, ax
    MOV ax, @@result
    ret
sin_function ENDP


;=====================================
; normalize radians into -pi~pi
; input  : ax
; output : ax
;=====================================
normalize_pi PROC
    cmp ax, pi
    jg OVER_PI
    cmp ax, n_pi
    jl OVER_NPI
    ret
    OVER_PI:
    SUB ax, PI
    ret
    OVER_NPI:
    ADD ax, PI 
    ret
normalize_pi ENDP

;=====================================
; sin fuction
; input  : i
; output : ax
;=====================================
cos_fuction PROC
    local @@result : word, @@divior : word
    MOV ax, i

    call normalize_pi
    MOV i, ax

;CALCULATE
    MOV @@result, 100

    MOV ax, i
    MOV @@divisor, 100
    MOV dx, 0
    IDIV @@divisor

    mult ax, i
    MOV @@divisor, 2
    MOV dx, 0
    IDIV @@divisor

    SUB @@result, ax

    MOV ax, i 
    MOV @@divisor, 100
    MOV dx, 0
    IDIV @@divisor

    mult ax, i 
    MOV @@divisor, 100
    MOV dx, 0
    IDIV @@divisor

    mult ax, i 
    MOV @@divisor, 100
    MOV dx, 0
    IDIV @@divisor

    mult ax, i 
    MOV @@divisor, 24
    MOV dx, 0
    IDIV @@divisor

    ADD @@result, ax

    MOV ax,@@result
    ret
cos_fuction ENDP



; calculate point roatation on X-axis
roatate_on_m MACRO X 
    
ENDM

