
#ifndef _GAME_
#define _GAME_

.dseg
	PLAYER_1: .byte 1
	PLAYER_2: .byte 1 
.cseg



GAME_LOOP:

	call	GET_STARTER_1_POS
	call	GET_STARTER_2_POS

GAME_START:	
	call	ERASE_VMEM

	jmp		GAME_START
	call	GET_PLAYER_1_POS
	call	GET_PLAYER_2_POS
	
	
	ret 

GET_PLAYER_1_POS:
		
	call	LISTEN_TO_RIGHT_JOYSTICK
	sts		PLAYER_1, r16 
	call	UPDATE_PLAYER_1_POS
	ret

GET_PLAYER_2_POS:
	
	 
	call	LISTEN_TO_LEFT_JOYSTICK
	sts		PLAYER_2, r16
	call	UPDATE_PLAYER_2_POS
	ret 

GET_STARTER_1_POS:
	
	ldi		r16, $04
	sts		PLAYER_1, r16
	ret


GET_STARTER_2_POS:

	ldi		r16, $F4 
	sts		PLAYER_2, r16 
	ret 

UPDATE_PLAYER_1_POS:    
	clr ZH
	ldi ZL,LOW(PLAYER_1)
	call SETPOS
	ret

	UPDATE_PLAYER_2_POS:
	clr ZH
	ldi ZL,LOW(PLAYER_2)
	call SETPOS
	ret

SETPOS:
	ld r17,Z+  ; r17=POSX

	call SETBIT    ; r16=bitpattern for VMEM+POSY
	ld r17,Z    ; r17=POSY Z to POSY
	ldi ZL,LOW(VMEM)
	add ZL,r17    ; *(VMEM+T/POSY) ZL=VMEM+0..4
	ld r17,Z    ; current line in VMEM
	or r17,r16    ; OR on place
	st Z,r17    ; put back into VMEM
	ret

SETBIT:
	ldi r16,$01    ; bit to shift
	SETBIT_LOOP:
	dec r17        
	brmi SETBIT_END ; til done
	lsl r16    ; shift
	jmp SETBIT_LOOP
	SETBIT_END:
	ret


#endif /* _game_ */
