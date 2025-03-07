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

	call	MOVE_BALL_POS
	call	RENDER_BALL
	
	pop r18
	pop r17
	pop r16

	ret


RENDER_BALL:

	lds		r16, BALL_POS
	call	SET_WHITE_PIX
	ret

MOVE_BALL_POS:

	push	r25
/*
	Will move the ball according to dx and dy

	Read DX adn DY

	When we know desired value for new ball pos
	load BALL_POS_PARAMETER with that position and call SET_BALL_POS
*/

	call	CHECK_COLLISION
	// Ball pos x + dx
	lds		BALL_POS_PARAMETER, BALL_POS // Load ballpos

	lds		BALL_dx_PARAMETER, BALL_dx // Load ball_dx

	cpi		BALL_dx_PARAMETER, 0
	breq	BALL_GOING_RIGHT

	//Ball going left

	swap	BALL_POS_PARAMETER // Now pos is (Y | X)
	inc		BALL_POS_PARAMETER

	jmp		MOVE_BALL_CONTINUE_X

BALL_GOING_RIGHT:
    swap	BALL_POS_PARAMETER // Now pos is (Y | X)
    dec		BALL_POS_PARAMETER

MOVE_BALL_CONTINUE_X:
    swap	BALL_POS_PARAMETER // Now pos is (X | Y)

	//Setting DY
	lds		BALL_dy_PARAMETER, BALL_dy // Load ball_dy

	cpi		BALL_dy_PARAMETER, 0
	breq	DECREASE_TWO_STEPS_Y  

	cpi		BALL_dy_PARAMETER, 1
	breq	DECREASE_ONE_STEP_Y

	cpi		BALL_dy_PARAMETER, 3
	breq	INCREASE_ONE_STEP_Y  

	cpi		BALL_dy_PARAMETER, 4
	breq	INCREASE_TWO_STEPS_Y

	rjmp	MOVE_BALL_CONTINUE_Y

DECREASE_TWO_STEPS_Y:

	//CHECK IF BALL IS ON NEXT TO BOTTOM ROW

	mov		r21, BALL_POS_PARAMETER // COpy ball pos to 21

	andi	r21, $0F // Get only the Y cords

	cpi		r21, $01 // If on the next to last row, we can't decrease two steps
	breq	DECREASE_ONE_STEP_Y 

	subi	BALL_POS_PARAMETER, 2
	rjmp	MOVE_BALL_CONTINUE_Y

	
DECREASE_ONE_STEP_Y:
	dec 	BALL_POS_PARAMETER
	rjmp	MOVE_BALL_CONTINUE_Y

INCREASE_ONE_STEP_Y:
	ldi		r25, 1
	add		BALL_POS_PARAMETER, r25
	rjmp	MOVE_BALL_CONTINUE_Y

INCREASE_TWO_STEPS_Y:

	//CHECK IF BALL IF NEXT TO TOP ROW

	mov		r21, BALL_POS_PARAMETER // COpy ball pos to 21

	andi	r21, $0F // Get only the Y cords

	cpi		r21, $06 // If on the next to frist row, we can't increase two steps
	breq	INCREASE_ONE_STEP_Y

	ldi		r25, 2
	add		BALL_POS_PARAMETER, r25
	

MOVE_BALL_CONTINUE_Y:
	// ldi BALL_POS_PARAMETER, desired value
	call	SET_BALL_POS

	pop		r25
	ret

SET_DX:
    /*
        Every time DX is to be changed it is either to be 0 or 1. Then save the data into its byte.

        To make the workflow easier in assembly 0 and 1 will be used instead of -1 and 1. 0 = going right, 1 = going left.

        This routine therfore implemnts the logic BALL_DX = !BALL_DX

    */
    push    BALL_dx_PARAMETER
    push    r19

    lds     r19, BALL_dx

    //if ball_dx == 0 -> set ball_dx = 1
    cpi     r19, 0
    breq    SET_DX_ONE

    //if ball_dx == 1 -> set ball_dx = 0
    ldi BALL_dx_PARAMETER, 0

    jmp LOAD_DX

SET_DX_ONE:
    ldi BALL_dx_PARAMETER, 1


LOAD_DX:
    sts		BALL_dx, BALL_dx_PARAMETER // stores into byte

    pop     r19
	pop     BALL_dx_PARAMETER
	ret


SET_DY: // takes BALL_dy_REG as parameter (NEW_VALUE)

    /*

    if dy > 2 then no increase dy

    if dy < -2 then no increase dy
    */

	sts		BALL_dy, BALL_dy_PARAMETER
	ret

SET_BALL_POS: // takes BALL_POS_PARAMETER (NEW_VALUE)
	sts		BALL_POS, BALL_POS_PARAMETER
	ret

SET_STARTER_BALL_POS:
    push    BALL_POS_PARAMETER
	push	BALL_dy_PARAMETER

	call	SET_DX

	ldi		BALL_dy_PARAMETER, 2
	call	SET_DY

	ldi		BALL_POS_PARAMETER, $73
	call	SET_BALL_POS //arg (BALL_POS_PARAMETER)

	pop		BALL_dy_PARAMETER
	pop     BALL_POS_PARAMETER
	ret

CHECK_COLLISION:
    push r19
    push r16
    push r20


	clr	r16
    // Get ball pos
    lds     r16, BALL_POS

	// CHECKING THE NEXT POS OF THE BALL
	swap	r16 // Getting the x cord first

	/*

	if ball is going right, aka dx 0, the next pos is x - 1
	if ball is going left, aka dx is 1, the next pos is x +1

	*/
	lds		r17, BALL_dx

	//if Ball_dx = 0 -> dec r16
	sbrs	r17, 0
	dec		r16

	//if Ball_dx = 1 -> inc r16
	sbrc	r17, 0
	inc		r16

	swap	r16

	/*

	if ball is going up, aka dy 4, the next pos is y - 2
	if ball is going down, aka dy is 0, the next pos is y + 2
	if ball is going up, aka dy 3, the next pos is y - 1
	if ball is going down, aka dy is 1, the next pos is y + 1
	*/
/*
	lds		r17, BALL_dy

	//if Ball_dy = 0 -> dec r16 * 2
	cpi		r17, 0
	breq	DY_IS_ZERO // 

	cpi		r17, 1
	breq	DY_IS_ONE

	cpi		r17, 3
	breq	DY_IS_THREE

	cpi		r17, 4
	breq	DY_IS_FOUR

	jmp COLLISION_COURT

DY_IS_ZERO:
	inc	r16
	inc	r16
	jmp COLLISION_COURT

DY_IS_ONE:
	inc	r16
	jmp COLLISION_COURT

DY_IS_THREE:
	dec r16
	jmp COLLISION_COURT

DY_IS_FOUR:
	dec r16
	jmp COLLISION_COURT

*/
COLLISION_COURT:
	lds		r17, BALL_POS
	andi	r17, $0F
	cpi		r17, $00
	breq	TOP_COLLISION
	cpi		r17, $07
	breq	BOTTOM_COLLISION
	jmp		CONTINUE_COLLISION

TOP_COLLISION:
	lds		BALL_dy_PARAMETER, BALL_dy
	sbrc	BALL_dy_PARAMETER, 0
	ldi		BALL_dy_PARAMETER, 3

	sbrs	BALL_dy_PARAMETER, 0
	ldi		BALL_dy_PARAMETER, 4
	
	call	SET_DY
	jmp		CONTINUE_COLLISION
	//checking if collision with top or bottom court


BOTTOM_COLLISION:
	lds		BALL_dy_PARAMETER, BALL_dy
	sbrc	BALL_dy_PARAMETER, 3
	ldi		BALL_dy_PARAMETER, 0

	sbrs	BALL_dy_PARAMETER, 3
	ldi		BALL_dy_PARAMETER, 1
	
	call	SET_DY
	jmp		CONTINUE_COLLISION

CONTINUE_COLLISION:

    //Load players pos
    lds     r19, PLAYER_1
    lds     r20, PLAYER_2


    //if collsion with player 1

    // Checking collision with middle of paddle -> no change to dy
    cp		r16, r19
    breq    COLLISION_MIDDLE_PADDLE
    // Cheecking collision with top paddle -> dy = dy - 1
    dec     r19
    cp     r16, r19
    breq    COLLISION_TOP_PADDLE

    // Checking collision with bottom paddle -> dy = dy + 1
    inc     r19
    inc     r19
    cp		r16, r19
    breq    COLLISION_BOTTOM_PADDLE

    //if collsion with player 2
    // Checking collision with middle of paddle -> no change to dy
    cp     r16, r20
    breq    COLLISION_MIDDLE_PADDLE

    // Cheecking collision with top paddle -> dy = dy - 1
    dec     r20
    cp		r16, r20
    breq    COLLISION_TOP_PADDLE

    // Checking collision with bottom paddle -> dy = dy + 1
    inc     r20
    inc     r20
    cp      r16, r20
    breq    COLLISION_BOTTOM_PADDLE

	jmp		DONE_COLLISION



COLLISION_MIDDLE_PADDLE:
    call    SET_DX
	call	INCREASE_GAME_SPEED
    jmp		DONE_COLLISION

COLLISION_TOP_PADDLE:
    call    SET_DX

	//Changing the DY_VALUE
	lds		BALL_dy_PARAMETER, BALL_dy // Load DY_VALUE
	dec		BAll_dy_PARAMETER
	call	SET_DY

    jmp		DONE_COLLISION


COLLISION_BOTTOM_PADDLE:
    call    SET_DX

		//Changing the DY_VALUE
	lds		BALL_dy_PARAMETER, BALL_dy // Load DY_VALUE
	inc		BAll_dy_PARAMETER
	call	SET_DY

    jmp		DONE_COLLISION




DONE_COLLISION:
	
	pop r20
    pop r16
    pop r19

    ret



#endif //__BALL__
