
#ifndef _GAME_
#define _GAME_

.dseg
	PLAYER_1: .byte 1
	PLAYER_2: .byte 1 
.cseg



GAME_LOOP:
	call	GET_STARTER_1_POS 
	call	GET_STARTER_2_POS
	call	GAME_START
	ret


GAME_START:	
	call	ERASE_VMEM
	call	GET_PLAYER_1_POS
	call	GET_PLAYER_2_POS
	call	RENDER_PLAYER_1
	call 	RENDER_PLAYER_2 
	call	GAME_SPEED_DELAY
	jmp		GAME_START
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
