init Proc
; Get HANDLE
;=============================================================================
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov consoleHandle,eax
	
; Set Display rect
;=============================================================================
	INVOKE SetConsoleWindowInfo,      ; set position of console window
		consoleHandle,            ; screen buffer handle
		TRUE,             ; coordinate type
		ADDR windowRect  ; ptr to window rectangle
ret
init ENDP

updateSystemValue Proc
local Euler:Vector
	; camera
	copyVector ADDR Euler, ADDR camera.euler
	EulerToRotMatrix ADDR neg_cameraRotMat, ADDR Euler
	mulVector ADDR Euler, -1
	EulerToRotMatrix ADDR cameraRotMat, ADDR Euler
	setVector cameraFacing, 0, 0 ,1000 ; 1.000
	RotVector ADDR cameraFacing, ADDR cameraRotMat
ret
updateSystemValue EndP

logSystem Proc uses eax
	logc "C"
	logc "a"
	logc "m"
	logc "e"
	logc "r"
	logc "a"
	logc " "
	logc ":"
	call crlf
	logc "P"
	logc "o"
	logc "s"
	logc " "
	logc ":"
	logv camera.pos
	logc "R"
	logc "o"
	logc "t"
	logc " "
	logc ":"
	logv camera.euler
	call crlf
	logc "K"
	logc "e"
	logc "y"
	logc "C"
	logc "o"
	logc "d"
	logc "e"
	logc " "
	logc ":"
	logc " "
	movsx eax, keyDownCode
	log eax
	
ret
logSystem EndP