#ifndef __PLAYER__
#define __PLAYER__

.dseg
	PLAYER_1: .byte 1
	PLAYER_2: .byte 1

	PLAYER_1_SCORE: .byte 1
	PLAYER_2_SCORE: .byte 1
.cseg

PLAYERS:
	call	GET_PLAYER_1_POS
	call	GET_PLAYER_2_POS
	call	RENDER_PLAYER_1
	call 	RENDER_PLAYER_2
	ret

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

INC_PLAYER_SCORE: // (r21 = 1 or 2) = Player number // Takes only one or two.

// Simply just increasing the scores of the player's byte.
// Does not take score limit into account.
// If neither 1 or 2 is givien as parameter, player 2 will be affected.

    push    r19
    push    r17
    push    r20

    // if player one
    cpi     r21, 1
    breq    LOAD_PLAYER_1_SCORE

    //else  player two
    jmp     LOAD_PLAYER_2_SCORE

LOAD_PLAYER_1_SCORE:
    lds     r19, PLAYER_1_SCORE // Loading player 1 score into r19
    inc     r19
	sts		PLAYER_1_SCORE, r19 
    jmp SET_SCORE_DISPLAY

LOAD_PLAYER_2_SCORE:
    lds     r19, PLAYER_2_SCORE // Loading player 1 score into r19
    inc     r19
	sts		PLAYER_2_SCORE, r19 
SET_SCORE_DISPLAY:

    //Loading the socre onto segment display
    call    LOAD_DIGIT // (r19=number) -> r17=7seg segment

    //if player one
    cpi     r21, 1
    breq    SELECT_PLAYER1_DISPLAY

    // else if player two
    jmp SELECT_PLAYER2_DISPLAY

SELECT_PLAYER1_DISPLAY:
   	ldi 	r20, ADDR_RIGHT8*2
    jmp     SEND_SCORE_DATA

SELECT_PLAYER2_DISPLAY:
   	ldi 	r20, ADDR_LEFT8*2

SEND_SCORE_DATA:
	call    TWI_SEND  ; (r20=address, r17=data)

	pop     r20
	pop     r17
    pop     r19
    ret


#endif // __PLAYER__
