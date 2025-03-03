
#ifndef _JOYSTICK_
#define _JOYSTICK_


ADC10:         ; initiate AD

	mov r16, r17
	out ADMUX, r16
	cbi ADMUX, ADLAR
	ret

LISTEN_TO_RIGHT_JOYSTICK:

INPUT_RIGHT_Y:
	push ZH
	push ZL
	push r16
	push r17

	ldi		r17, JOY_CHAN_RIGHT_Y
	call	ADC10
	cpi		r17, $00
	brne	CHECK_INC_RIGHT_Y
	jmp DONE_RIGHT_Y
CHECK_INC_RIGHT_Y:
	cpi r17, $03
	brne DONE_RIGHT_Y	
DONE_RIGHT_Y:
	pop r17
	pop r16
	pop ZL
	pop ZH
	ret
	;call POP_RUTINE;




LISTEN_TO_LEFT_JOYSTICK:


INPUT_LEFT_Y:
	push	ZH
	push	ZL
	push	r16
	push	r17

	ldi		r17, JOY_CHAN_LEFT_Y
	call	ADC10
	cpi		r17, $00
	brne	CHECK_INC_LEFT_Y
	jmp		DONE_LEFT_Y
CHECK_INC_LEFT_Y:
	cpi		r17, $03
	brne	DONE_LEFT_Y	
DONE_LEFT_Y:
	pop		r17
	pop		r16
	pop		ZL
	pop		ZH
	ret

#endif /*__JOYSTICK__*/ 
