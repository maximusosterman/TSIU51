#ifndef __SPEAKER__
#define __SPEAKER__

BEEP:
	ldi		r16, $ff
	out		DDRB, r16 
	sbi		PORTB, 1
	ldi r18, T/2
	call DELAY
	cbi PORTB, 1
	ldi r18, T/2
	call DELAY
	dec r20
	brne BEEP
	ret

LONG_BEEP:
	ldi r20, N*3
	call BEEP
	ret

SHORT_BEEP:
	ldi r20, N
	call BEEP
	ret

NO_BEEP:
	cbi PORTB, 1
	ldi r18, T/2
	call DELAY
	cbi PORTB, 1
	ldi r18, T/2
	call DELAY
	dec r20
	brne NO_BEEP
	ret


DELAY:
	sbi PORTB,7
	push r16
	push r17
	ldi r16,10 ; Decimal bas
delayYttreLoop:
	ldi r17,$1F
delayInreLoop:
	dec r17
	brne delayInreLoop
	dec r16
	brne delayYttreLoop
	cbi PORTB,7
	pop r17
	pop r16
	ret

#endif //__SPEAKER__

