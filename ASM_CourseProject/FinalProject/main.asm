;=============================================================================
; Important!
; please set cmd charactor size to 1:1 for best experience
;=============================================================================  
INCLUDE Irvine32.inc
.386
.data
INCLUDE Core/struct.asm
INCLUDE Core/variable.asm

.code  
INCLUDE Core/Debug.asm
INCLUDE MathMethod/bool.asm
INCLUDE MathMethod/MathCore.asm
INCLUDE MathMethod/SinCos.asm
INCLUDE MathMethod/Vector.asm
INCLUDE MathMethod/Matrix.asm
INCLUDE MathMethod/RotationMatrix.asm
INCLUDE DrawMethod/DrawCore.asm
INCLUDE DrawMethod/DrawLine.asm
INCLUDE DrawMethod/DrawSphere.asm
INCLUDE Core/Movement.asm
INCLUDE Core/System.asm
      
main PROC
call init
appLoop:    
	; do your code here

	call ReadChar
	mov keyDownCode, ax
	call cameraMovement
	.IF keyDownCode != 283
		jmp appLoop
	.ENDIF
	exit     
main ENDP
END main
