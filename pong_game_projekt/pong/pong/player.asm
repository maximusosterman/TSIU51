#ifndef __PLAYER__
#define __PLAYER__

GET_PLAYER_1_POS:
	call	LISTEN_TO_RIGHT_JOYSTICK
	sts		PLAYER_1, r16
	ret

GET_PLAYER_2_POS:
	call	LISTEN_TO_LEFT_JOYSTICK
	sts		PLAYER_2, r16
	ret

GET_STARTER_1_POS:

	ldi		r16, $04
	sts		PLAYER_1, r16
	ret


GET_STARTER_2_POS:
	ldi		r16, $F4
	sts		PLAYER_2, r16
	ret

RENDER_PLAYER_1:
	push	r16

	lds		r16, PLAYER_1
	call	SET_WHITE_PIX

	lds		r16, PLAYER_1
	inc		r16
	call	SET_WHITE_PIX

	lds		r16, PLAYER_1
	dec		r16
	call	SET_WHITE_PIX

	pop		r16
	ret

RENDER_PLAYER_2:
	push	r16

	lds		r16, PLAYER_2
	call	SET_WHITE_PIX

	lds		r16, PLAYER_2
	inc		r16
	call	SET_WHITE_PIX

	lds		r16, PLAYER_2
	dec		r16
	call	SET_WHITE_PIX

	pop		r16

	ret


#endif // __PLAYER__
