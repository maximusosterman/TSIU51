#ifndef __SPEAKER__
#define __SPEAKER__

BEEP:
	sbi PORTB, 1
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
	rjmp CONTINUE

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

#endif __SPEAKER__
