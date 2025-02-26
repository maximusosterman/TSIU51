
#ifndef _GAME_
#define _GAME_

.dseg
	PLAYER_1: .byte 1
	PLAYER_2: .byte 1 
.cseg

GAME_LOOP:
	
	call	ERASE_VMEM 
	
	call	GET_PLAYER_1_POS
	call	GET_PLAYER_2_POS
	

	ret 

GET_PLAYER_1_POS:
		
	call	GET_STARTER_1_POS
	call	LISTEN_TO_RIGHT_JOYSTICK
	ret

GET_PLAYER_2_POS:
	
	call	GET_STARTER_2_POS 
	call	LISTEN_TO_LEFT_JOYSTICK

	ret

GET_PLAYER_1_POS:
	
	ldi		r16, $04
	sts		PLAYER_1, r16
	ret


GET_STARTER_2_POS

	ldi		r16, $F4 
	sts		PLAYER_2, r16 
	ret 




GET_STARTER_2_POS


	ret 

#endif /* _game_ */
