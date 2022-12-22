CameraMovement Proc uses eax ebx
	local moveVec:vector
	mov ax, keyDownCode
	.IF ax == 01177h ; W
		setVector moveVec,0 ,0 ,moveSpeed
		rotVector ADDR moveVec, ADDR neg_cameraRotMat
		mov moveVec.y, 0
		addVector ADDR camera.pos, ADDR moveVec
	.EndIF
	.IF ax == 01E61h ; A
		mov ebx, moveSpeed
		neg ebx
		setVector moveVec,ebx ,0 ,0
		rotVector ADDR moveVec, ADDR neg_cameraRotMat
		mov moveVec.y, 0
		addVector ADDR camera.pos, ADDR moveVec
	.EndIF
	.IF ax == 01F73h ; S
		mov ebx, moveSpeed
		neg ebx
		setVector moveVec,0 ,0 ,ebx
		rotVector ADDR moveVec, ADDR neg_cameraRotMat
		mov moveVec.y, 0
		addVector ADDR camera.pos, ADDR moveVec
	.EndIF
	.IF ax == 02064h ; D
		setVector moveVec,moveSpeed ,0 ,0
		rotVector ADDR moveVec, ADDR neg_cameraRotMat
		mov moveVec.y, 0 
		addVector ADDR camera.pos, ADDR moveVec
	.EndIF

	.IF ax == 01769h ; I
		mov eax, camera.euler.x
		sub eax, 1
		degNor eax
		mov camera.euler.x, eax
	.EndIF
	.IF ax == 0256Bh ; K
		mov eax, camera.euler.x
		add eax, 1
		degNor eax
		mov camera.euler.x, eax
	.EndIF
	.IF ax == 9322 ; J
		mov eax, camera.euler.y
		sub eax, 1
		degNor eax
		mov camera.euler.y, eax
	.EndIF
	.IF ax == 9836 ; L
		mov eax, camera.euler.y
		add eax, 1
		degNor eax
		mov camera.euler.y, eax
	.EndIF
ret
CameraMovement EndP