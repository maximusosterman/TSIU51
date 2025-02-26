#ifndef _HELPERS_
#define _HELPERS_

REVERSE_REGISTER: // REVERSERS r16
	push	r17
	push	r18

	ldi		r17, 8
	clr		r18

REVERSE_LOOP:
	lsr		r16  // Shift left 
	rol		r16	//Rotate left, Carry goes to LSB
	dec		r17
	brne	REVERSE_LOOP
	
	pop		r18
	pop		r17
	ret

#endif /* _HELPERS_ */
