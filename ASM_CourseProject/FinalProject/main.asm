;=============================================================================
; Important!
; please set cmd charactor size to 1:1 for best experience
;=============================================================================  
INCLUDE Irvine32.inc
.386
.data
INCLUDE Core/struct.asm
INCLUDE Core/variable.asm
obj1 SphereData < < 0,0,0 >,0 >
obj2 SphereData < < 2000,0,0 >,0 > 
obj3 SphereData < < 0,2000,0 >,0 >
obj4 SphereData < < 0,0,2000 >,0 >
obj5 SphereData < < 2000,2000,0 >,0 >   
obj6 SphereData < < 0,2000,2000 >,0 >
obj7 SphereData < < 2000,0,2000 >,0 >
obj8 SphereData < < 2000,2000,2000 >,0 >
sc vector <> 
.code  
INCLUDE Core/Debug.asm
INCLUDE MathMethod/bool.asm
INCLUDE MathMethod/MathCore.asm
INCLUDE MathMethod/SinCos.asm
INCLUDE MathMethod/Vector.asm
INCLUDE MathMethod/Matrix.asm
INCLUDE MathMethod/RotationMatrix.asm
INCLUDE DrawMethod/DrawCore.asm
INCLUDE DrawMethod/DrawSphere.asm
INCLUDE Core/Movement.asm
INCLUDE Core/System.asm
 
 temp MACRO oo, color
	VectorLen ADDR oo
	world2camera ADDR oo, ADDR sc
	mov eax, sc.z
	dive eax, 300000000  
	mult eax, 2 
	inc eax     
	mov sc.z, eax
	INVOKE DrawSphereproc, ADDR sc, color
 ENDM
      
main PROC
call init
pop esi
call ClrScr
appLoop:    
	call UpdateSystemValue
	INVOKE SetConsoleCursorPosition, consoleHandle, cursorPos  
	Invoke SetScreen, 070h

	; draw ground
	mov eax, 50
	mov ebx, camera.euler.x
	isA ebx, 180
	.IF BF == T
		sub ebx, 360
	.EndIF 
	mult ebx, 10
	mult eax, 40 ; 4.0
	dive eax, 100
	mov ebx, eax
	mov eax, 50
	sub eax, ebx
	
	isB eax, 100
	jf groundEnd
	isAE eax, 0
	jf groundEnd
	testLoopA:
		mov ecx, 160
		testLoopB:
			mov ebx, ecx
			dec ebx
			setPixel ebx, eax, 080h
			loop testLoopB
		inc eax
		isB eax, 100
		jt testLoopA
	groundEnd:


	; draw sphere
	temp obj1, 010h
	temp obj2, 020h
	temp obj3, 030h
	temp obj4, 040h
	temp obj5, 050h
	temp obj6, 0A0h
	temp obj7, 0B0h
	temp obj8, 090h  
	setPixel 80, 50, 040h
	 
	call repaint  
	call logSystem   
	call ReadChar
	mov keyDownCode, ax
	call cameraMovement
	.IF keyDownCode != 283
		jmp appLoop
	.ENDIF
	exit     
main ENDP
END main

