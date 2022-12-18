
; use point1 as pos, word1 as R
DrawSphere PROC
	local @@beginX:word, @@beginY:word, @@endX:word, @@endY:word
	mov ax, point1.x
	sub ax, word1
	isb ax, 0
	mov @@beginX, ax
	jf DrawSphereRangeCheck1
	mov @@beginX, 0
	DrawSphereRangeCheck1:

	mov ax, point1.x
	add ax, word1
	isa ax, 319
	mov @@endX, ax
	jf DrawSphereRangeCheck2
	mov @@endX, 319
	DrawSphereRangeCheck2:

	mov ax, point1.y
	sub ax, word1
	isb ax, 0
	mov @@beginY, ax
	jf DrawSphereRangeCheck3
	mov @@beginY, 0
	DrawSphereRangeCheck3:

	mov ax, point1.y
	add ax, word1
	isa ax, 199
	mov @@endY, ax
	jf DrawSphereRangeCheck4
	mov @@endY, 199
	DrawSphereRangeCheck4:

	mov bx, 12
	dive word1 bx
	mov word2, ax ;¿÷¾¦«×
	mov bx, 2
	inc ax

	mov ax, @@beginX
	mov i, ax
	DrawSphereIloop:
		mov ax, @@beginY
		mov j, ax
		DrawSphereJloop:
			mov ax, i
			sub ax, point1.x
			mAbs ax
			mov point2.x, ax

			mov ax, j
			sub ax, point1.y
			mAbs ax
			mov point2.y, ax
			push point2
			call Vec2Len
			isBE ax, word1
			jf DrawSphereSkip
			mov ax, i
			mov bx, j
			mov cx, i
			add cx, word2
			mov dx, j
			add dx, word2
			DrawSphereAXloop:
			mov bx, j
				DrawSphereBXloop:
				setPixel ax,bx
				inc bx
				isA bx, dx
				jf DrawSphereBXloop
			inc ax
			isA ax, cx
			jf DrawSphereAXloop

			DrawSphereSkip:
		mov ax, word2
		isA j, @@endY
		add j, ax
		jf DrawSphereJloop
	mov ax, word2
	isA i, @@endX
	add i, ax
	jf DrawSphereIloop
	ret 0
DrawSphere ENDP