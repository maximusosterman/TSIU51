#ifndef _START_SCREEN_
#define _START_SCREEN_

START_SCREEN:
	call	ERASE_VMEM
	call	RENDER_START_SCREEN
	call    RESET_7SEGS
	call	CLEAR_PLAYERS_SCORES
	call	WAIT_FOR_BUTTON_START
	ret

RENDER_START_SCREEN:
	// LETTER P

	ldi		r16, $F1
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $F2
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $F3
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $F4
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $F5
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $F6
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $E1
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $D1
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $D2
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $D3
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $E3
	call	SET_WHITE_PIX //ARG r16=$XY

	// LETTER O

	ldi		r16, $B3
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $B4
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $B5
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $B6
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $A3
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $A6
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $93
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $94
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $95
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $96
	call	SET_WHITE_PIX //ARG r16=$XY

// LETTER N

	ldi		r16, $73
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $74
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $75
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $76
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $64
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $55
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $43
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $44
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $45
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $46
	call	SET_WHITE_PIX //ARG r16=$XY

	//LETTER G

	ldi		r16, $03
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $13
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $23
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $24
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $25
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $26
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $16
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $06
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $05
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $15
	call	SET_WHITE_PIX //ARG r16=$XY

	ret


CLEAR_PLAYERS_SCORES:
	push	r19

	ldi		r19, 0

	sts		PLAYER_1_SCORE, r19
	sts		PLAYER_2_SCORE, r19

	pop		r19
	ret

WAIT_FOR_BUTTON_START:
	//Check if PD0 is pressed  (Bit is set), then the program can continue.

	sbic	PIND, 0
	jmp		WAIT_FOR_BUTTON_START //Stuck in loop until button is presserd

	//Button is pressed. Program continues. Bit is reset for next time.
	sbi		PIND, 0

	ret

#endif /* _START_SCREEN_* */
