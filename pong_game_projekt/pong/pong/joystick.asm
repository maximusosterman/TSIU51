
#ifndef _JOYSTICK_
#define _JOYSTICK_

    
ADC10:         ; initiate AD
	out		ADMUX, r17
	ldi		r17,(1<<ADEN)|PRESCALER
	out		ADCSRA, r17
CONVERT10:
	sbi		ADCSRA,ADSC
WAIT10:
	sbic	ADCSRA,ADSC
	jmp		WAIT10
	in	r17,ADCH
	ret

LISTEN_TO_RIGHT_JOYSTICK:

INPUT_RIGHT_Y:
	push r17
	push r18
	clr	r16

	ldi		r17, (1<<REFS0)|JOY_CHAN_RIGHT_Y
	call	ADC10
	cpi		r17, $00
	breq	DEC_RIGHT_Y
	cpi		r17, $03
	breq	INC_RIGHT_Y
	lds		r16, PLAYER_1
	jmp		DONE_RIGHT_Y

DEC_RIGHT_Y:
	lds		r16, PLAYER_1
	// MUST CHECK LIMITS 
	cpi		r16,$06 // Reached upper limit
	breq	DONE_RIGHT_Y
	inc		r16
	jmp 	DONE_RIGHT_Y
INC_RIGHT_Y:
	lds		r16,PLAYER_1
	cpi		r16,$01
	breq	DONE_RIGHT_Y
	dec		r16
DONE_RIGHT_Y:
	pop	r18
	pop r17
	ret


LISTEN_TO_LEFT_JOYSTICK:


INPUT_LEFT_Y:
	push r17
	push r18
	clr	r16

		
	ldi		r17, (1<<REFS0)|JOY_CHAN_LEFT_Y
	call	ADC10
	cpi		r17, $00
	breq	DEC_LEFT_Y
	cpi		r17, $03
	breq	INC_LEFT_Y
	lds		r16, PLAYER_2
	jmp		DONE_LEFT_Y
DEC_LEFT_Y:
	lds		r16, PLAYER_2
	cpi		r16,$F6 //Check left lowr limit
	breq	DONE_LEFT_Y
	inc		r16
	jmp 	DONE_LEFT_Y
INC_LEFT_Y:
	lds		r16,PLAYER_2
	cpi		r16,$F1 //Check left lowr limit
	breq	DONE_LEFT_Y
	dec		r16
DONE_LEFT_Y:
	pop	r18
	pop r17
	ret

#endif /*__JOYSTICK__*/ 
