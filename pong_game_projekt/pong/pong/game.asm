
#ifndef _GAME_
#define _GAME_

.dseg
	PLAYER: .byte 1
.cseg

GAME_LOOP:
	
	call	ERASE_VMEM 
	call	GET_PLAYER_1_POS
	call	GET_PLAYER_2_POS
	

ret



GET_PLAYER_1_POS:






GET_PLAYER_2_POS:

#endif /* _game_ */
