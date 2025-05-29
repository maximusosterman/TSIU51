;
; lab2.asm
;
; Created: 2025-05-29 11:01:14
; Author : maxve266
;

.def num_of_clicks = r17

COLD:
	ldi r16, HIGH(RAMEND)
	out SPH, r16
	ldi r16, LOW(RAMEND)
	out SPL, r16
	call HW_INIT
	clr num_of_clicks
	jmp MAIN

MAIN:
	call READ
	jmp DISPLAY

READ:
	sbic PIND, 0
	call WAIT
	ret

WAIT:
	sbic PIND, 0
	jmp WAIT
	cpi	num_of_clicks, 15
	breq DISPLAY
	inc num_of_clicks
	ret

DISPLAY:
	sbic PIND, 1 
	jmp DISPLAY_MODE
	jmp MAIN

DISPLAY_MODE:
	out PORTB, num_of_clicks
	sbis PIND, 0
	jmp DISPLAY_MODE
	clr num_of_clicks
	jmp MAIN
	 
	


HW_INIT:
	ldi r16, $FF
	out DDRB, r16
	ldi r16, $0
	out DDRD, r16
	ret