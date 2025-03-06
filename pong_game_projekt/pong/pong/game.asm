
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
	call	GAME_SPEED_DELAY
	ldi		r21, 1 // LOADING PLAYER 1
	call	INC_PLAYER_SCORE //ARG PLAYER NUM 1 or 2 in r21
	rjmp	GAME_LOOP
	//call	CHECK_WIN
	ret

CHECK_WIN:
	lds		r16, PLAYER_1_SCORE
	cpi		r16, 10
	brne	GAME_START
	lds		r16, PLAYER_2_SCORE
	cpi		r16, 10
	brne	GAME_START
	ret

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



#endif /* _game_ */
