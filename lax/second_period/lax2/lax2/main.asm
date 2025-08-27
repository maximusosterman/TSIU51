;
; lax2.asm
;
; Created: 2025-08-27 15:14:13
; Author : maxve266
;


; Replace with your application code
COLD:
	ldi r16, HIGH(RAMEND)
	out SPH, r16
	ldi r16, LOW(RAMEND)
	out SPL, r16
	clr r17 // COUNTER
	ldi r18, 15 // LIMIT

HW_INIT:
	ldi r16, $00
	out DDRA, r16
	ldi r16, $FF
	out DDRB, r16

MAIN:
//Check if any buttons is pressed and if so, execute action
	sbic PINA, 0
	call INCREASE
	
	sbic PINA, 1
	call PRINT

	rjmp MAIN
	
INCREASE:
	sbic PINA, 0  // --> wait for button to release
	rjmp INCREASE

	cpse r17, r18 // If counter == Limit, skip
	inc r17

	ret

PRINT:
	sbic PINA, 1  // --> wait for button to release
	rjmp PRINT

	out PORTB, r17
	clr r17
	ret

