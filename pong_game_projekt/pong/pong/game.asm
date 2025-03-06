
#ifndef _GAME_
#define _GAME_

GAME_START:
	call	GET_STARTER_1_POS
	call	GET_STARTER_2_POS
	call	SET_STARTER_BALL_POS
	call	GAME_LOOP
	ret


GAME_LOOP:
	call	ERASE_VMEM
	call	PLAYERS
	call	BALL
	call	CHECK_BALL_OUTSIDE_COURT
	call	GAME_SPEED_DELAY
	call	CHECK_WIN
	rjmp	GAME_LOOP
	ret
CHECK_BALL_OUTSIDE_COURT:

    // Get ball pos
    lds     r16, BALL_POS
	
	andi	r16, $F0
	cpi		r16, $F0
	breq	GAME_POINT_PLAYER_1

	cpi		r16, $00
	breq	GAME_POINT_PLAYER_2

	ret


CHECK_WIN:
	lds		r16, PLAYER_1_SCORE
	cpi		r16, 10
	breq	WIN
	lds		r16, PLAYER_2_SCORE
	cpi		r16, 10
	breq	WIN
	ret

WIN:
	call	ERASE_VMEM
	jmp		START

GAME_SPEED_DELAY:
		push	r16
		ldi		r16,10 ; Decimal bas
GAME_SPEED_INNER_LOOP:
		dec		r16
		brne	GAME_SPEED_INNER_LOOP
		pop		r16
GAME_DELAY_1SEC:
		push	r16
		push	r17
		push	r18
		ldi		r18, GAME_SPEED
		ldi		r16,10 ; Decimal bas
GAME_DELAY_1SEC_OUTER_LOOP:
		ldi		r17,$FF
GAME_DELAY1SEC_INNER_LOOP:
		dec		r17
		brne	GAME_DELAY1SEC_INNER_LOOP
		dec		r16
		brne	GAME_DELAY_1SEC_OUTER_LOOP
		dec		r18
		brne	GAME_DELAY_1SEC_OUTER_LOOP
		pop		r18
		pop		r17
		pop		r16
		ret

GAME_POINT_PLAYER_1:
	ldi		r21, 1 // LOADING PLAYER 1
	call	INC_PLAYER_SCORE //ARG PLAYER NUM 1 or 2 in r21
	call	GAME_POINT_DELAY
	jmp		GAME_START

GAME_POINT_PLAYER_2:
	ldi		r21, 2 // LOADING PLAYER 1
	call	INC_PLAYER_SCORE //ARG PLAYER NUM 1 or 2 in r21
	call	GAME_POINT_DELAY
	jmp		GAME_START


GAME_POINT_DELAY:
	push r16
	push r17 
	push r18 
	push r19 

	ldi		r16,2

GAME_POINT_DELAY_OUTER:
	ldi		r17, 5
GAME_POINT_DELAY_INNER:
	call	GAME_SPEED_DELAY
	dec		r17
	brne	GAME_POINT_DELAY_INNER
	call	ERASE_VMEM

	dec r16
	brne GAME_POINT_DELAY_OUTER
	pop		r19
	pop		r18
	pop		r17
	pop		r16
	ret 



#endif /* _game_ */
