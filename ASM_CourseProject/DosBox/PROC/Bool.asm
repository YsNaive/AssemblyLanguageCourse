
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