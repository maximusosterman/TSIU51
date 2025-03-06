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

	call CHECK_COLLSION

	//Calculate next position


	// ldi BALL_POS_PARAMETER, desired value
	call	SET_BALL_POS

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
    sts		BALL_dx, BALL_dx_PARAMETER

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
	ldi		BALL_POS_PARAMETER, $73
	call	SET_BALL_POS //arg (BALL_POS_PARAMETER)
	ret

CHECK_COLLISION:
    push r19
    push r16
    push r17
    push r20

    // Get ball pos
    lds     r16, BALL_POS

    mov     r17, r16 // Copy ball pos into r17. r17 used to andi and compare

    //Load players pos
    lds     r19, PLAYER_1
    lds     r20, PLAYER_2

    andi    r17, $F0 // Get only the X bits in r17

    //if collsion with player 1

    // Checking collision with middle of paddle -> no change to dy
    cpi     r17, r19
    breq    COLLISION_MIDDLE_PADDLE

    // Cheecking collision with top paddle -> dy = dy - 1
    dec     r19
    cpi     r17, r19
    breq    COLLISION_TOP_PADDLE

    // Checking collision with bottom paddle -> dy = dy + 1
    inc     r19
    inc     r19
    cpi     r17, r19
    breq    COLLISION_BOTTOM_PADDLE

    //if collsion with player 2

    // Checking collision with middle of paddle -> no change to dy
    cpi     r17, r20
    breq    COLLISION_MIDDLE_PADDLE

    // Cheecking collision with top paddle -> dy = dy - 1
    dec     r20
    cpi     r17, r20
    breq    COLLISION_TOP_PADDLE

    // Checking collision with bottom paddle -> dy = dy + 1
    inc     r20
    inc     r20
    cpi     r17, r20
    breq    COLLISION_BOTTOM_PADDLE

    pop r17
    pop r16
    pop r19

    ret

COLLISION_MIDDLE_PADDLE:
    call    SET_DX
    ret

COLLISION_TOP_PADDLE:
    call    SET_DX
    ret

COLLISION_BOTTOM_PADDLE:
    call    SET_DX
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
