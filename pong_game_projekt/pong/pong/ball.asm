#ifndef __BALL__
#define __BALL__

.dseg

	BALL_POS: .byte 1

	BALL_dx: .byte 1
	BALL_dy: .byte 1 

	.def BALL_POS_PARAMETER = r16 // (	X |	Y  )
	.def BALL_dx_PARAMETER = r17
	.def BALL_dy_PARAMETER = r18
 
.cseg

BALL:
	
	push r16
	push r17
	push r18

	call	RENDER_BALL		
	call	MOVE_BALL_POS
	//Get position and send it to CHECK COLLISION and WRTIE_BALL_TO_VMEM as param.

	//CHECK_COLLISION takes BALL_POS + 1

	pop r18
	pop r17
	pop r16

	ret


RENDER_BALL:

	lds		r16, BALL_POS
	call	SET_WHITE_PIX
	ret 

MOVE_BALL_POS:
/*
	Will move the ball according to dx and dy

	Read DX adn DY	

	When we know desired value for new ball pos
	load BALL_POS_PARAMETER with that position and call SET_BALL_POS
*/

	//Calculate next position
	

	// ldi BALL_POS_PARAMETER, desired value				
	call	SET_BALL_POS

	ret 

SET_DX: // takes BALL_dx_REG as parameter (NEW_VALUE)

	sts		BALL_dx, BALL_dx_PARAMETER
	ret

SET_DY: // takes BALL_dy_REG as parameter (NEW_VALUE)

	sts		BALL_dy, BALL_dy_PARAMETER
	ret

SET_BALL_POS: // takes BALL_POS_PARAMETER (NEW_VALUE)
	sts		BALL_POS, BALL_POS_PARAMETER
	ret

SET_STARTER_BALL_POS:
	ldi		BALL_POS_PARAMETER, $73
	call	SET_BALL_POS //arg (BALL_POS_PARAMETER)
	ret 

#endif //__BALL__



move:
	cpi VALUE_1,$01
	breq ADD_Y
	dec XY
	dec Y
	jmp X_ROW
ADD_Y:
	inc XY
	inc Y
X_ROW:	
	cpi VALUE_2,$01
	breq ADD_X
	sub XY, "byte, X" // byte with value of $10
	sub X
	jmp X_ROW_DONE
ADD_X:
	add XY,"byte, X"
	add X
ret

Y_COLLISION:
	XY - X-led = r16
	cpi r16,$07
	brne nothing
	inc VALUE_1
nothing:
	ret
