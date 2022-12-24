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
p1 Vector < 0,50,0 >
p2 Vector < 10,0,0 >        
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
INCLUDE DrawMethod/DrawLine.asm
INCLUDE DrawMethod/DrawSphere.asm
INCLUDE Core/Movement.asm
INCLUDE Core/System.asm
  
 temp MACRO oo, color
	VectorLen ADDR oo
	world2camera ADDR oo, ADDR sc  ; posX, posY, depth
	mov sc.z, 1
	INVOKE DrawSphereproc, ADDR sc, color ; posX, posY, r
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
	;temp obj1, 010h
	;temp obj2, 020h
	;temp obj3, 030h
	;temp obj4, 040h
	;temp obj5, 050h
	;temp obj6, 0A0h
	;temp obj7, 0B0h
	;temp obj8, 090h  
	World2Camera ADDR obj1.pos, ADDR p1
	World2Camera ADDR obj2.pos, ADDR p2
	INVOKE DrawLineProc, ADDR p1, ADDR p2, 030h
	World2Camera ADDR obj3.pos, ADDR p2
	INVOKE DrawLineProc, ADDR p1, ADDR p2, 010h
	World2Camera ADDR obj4.pos, ADDR p2
	INVOKE DrawLineProc, ADDR p1, ADDR p2, 030h

	World2Camera ADDR obj5.pos, ADDR p1
	World2Camera ADDR obj3.pos, ADDR p2
	INVOKE DrawLineProc, ADDR p1, ADDR p2, 020h
	World2Camera ADDR obj2.pos, ADDR p2
	INVOKE DrawLineProc, ADDR p1, ADDR p2, 010h
	World2Camera ADDR obj8.pos, ADDR p2
	INVOKE DrawLineProc, ADDR p1, ADDR p2, 020h

	World2Camera ADDR obj7.pos, ADDR p1
	World2Camera ADDR obj2.pos, ADDR p2
	INVOKE DrawLineProc, ADDR p1, ADDR p2, 030h 
	World2Camera ADDR obj4.pos, ADDR p2
	INVOKE DrawLineProc, ADDR p1, ADDR p2, 030h
	World2Camera ADDR obj8.pos, ADDR p2
	INVOKE DrawLineProc, ADDR p1, ADDR p2, 010h

	World2Camera ADDR obj6.pos, ADDR p1
	World2Camera ADDR obj3.pos, ADDR p2
	INVOKE DrawLineProc, ADDR p1, ADDR p2, 020h
	World2Camera ADDR obj4.pos, ADDR p2
	INVOKE DrawLineProc, ADDR p1, ADDR p2, 010h
	World2Camera ADDR obj8.pos, ADDR p2
	INVOKE DrawLineProc, ADDR p1, ADDR p2, 020h

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
