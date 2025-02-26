
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


	/*			LÄSA AV X OCH Y FRÅN JOYSTICK
; ----------------------
; Läsa X-position (ADC0 - PA0)
; ----------------------
ldi r16, 0x00          ; Välj ADC0 (PA0)
sts ADMUX, r16         ; Lagra i ADMUX

sbi ADCSRA, ADSC       ; Starta konvertering
wait_x:
sbis ADCSRA, ADIF      ; Vänta på att ADIF sätts
rjmp wait_x
in r17, ADCL           ; Läs låg byte
in r18, ADCH           ; Läs hög byte (10-bit värde)

; ----------------------
; Läsa Y-position (ADC1 - PA1)
; ----------------------
ldi r16, 0x01          ; Välj ADC1 (PA1)
sts ADMUX, r16         ; Lagra i ADMUX

sbi ADCSRA, ADSC       ; Starta konvertering
wait_y:
sbis ADCSRA, ADIF      ; Vänta på att ADIF sätts
rjmp wait_y
in r19, ADCL           ; Läs låg byte
in r20, ADCH           ; Läs hög byte (10-bit värde) */

GET_STARTER_2_POS


	ret 

#endif /* _game_ */
