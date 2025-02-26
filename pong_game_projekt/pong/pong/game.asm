
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


	/*			L�SA AV X OCH Y FR�N JOYSTICK
; ----------------------
; L�sa X-position (ADC0 - PA0)
; ----------------------
ldi r16, 0x00          ; V�lj ADC0 (PA0)
sts ADMUX, r16         ; Lagra i ADMUX

sbi ADCSRA, ADSC       ; Starta konvertering
wait_x:
sbis ADCSRA, ADIF      ; V�nta p� att ADIF s�tts
rjmp wait_x
in r17, ADCL           ; L�s l�g byte
in r18, ADCH           ; L�s h�g byte (10-bit v�rde)

; ----------------------
; L�sa Y-position (ADC1 - PA1)
; ----------------------
ldi r16, 0x01          ; V�lj ADC1 (PA1)
sts ADMUX, r16         ; Lagra i ADMUX

sbi ADCSRA, ADSC       ; Starta konvertering
wait_y:
sbis ADCSRA, ADIF      ; V�nta p� att ADIF s�tts
rjmp wait_y
in r19, ADCL           ; L�s l�g byte
in r20, ADCH           ; L�s h�g byte (10-bit v�rde) */

GET_STARTER_2_POS


	ret 

#endif /* _game_ */
