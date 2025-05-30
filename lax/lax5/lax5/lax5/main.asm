;
; lax5.asm
;
; Created: 2025-05-30 14:13:59
; Author : maxve266
;


; Replace with your application code

.def toggle = r20

COLD:
	ldi r16, HIGH(RAMEND)
	out SPH, r16
	ldi r16, LOW(RAMEND)
	out SPL, r16
	call HW_INIT
	call MAIN

HW_INIT:
	ldi r16, $FF
	out DDRB, r16
	ldi r16, $0
	out DDRA, r16
	ret

MAIN:
	sbis PINA, 4
	jmp MAIN
	call GET_INPUT
	call SET_OUTPUT
	jmp MAIN

GET_INPUT: 
	push r18

	ldi r18, 0b11101111
	
	in r16, PINA

	and r16, r18

	cpi r16, 0 
	breq TOGGLE_INVERSE

DONE_INPUT:
	pop r18

WAIT:
	sbic PINA, 4
	jmp WAIT

	ret

TOGGLE_INVERSE:
	cpi toggle, 0
	breq SET_TOGGLE1

	cpi toggle, 1
	breq SET_TOGGLE0

SET_TOGGLE1:
	ldi toggle, 1
	jmp DONE_INPUT

SET_TOGGLE0:
	ldi toggle, 0
	jmp DONE_INPUT

DONE_TOGGLE:
	jmp DONE_INPUT

SET_OUTPUT:
	push r17
	push r18

	cpi toggle, 1
	breq DISPLAY_OUTPUT

SHOW_INVERSE:
	ldi r17, $FF
	and r17, r16

	com r17
	swap r17

	ldi r18, 0b11110000

	and r17, r18

	add r16, r17

DISPLAY_OUTPUT:
	out PORTB, r16

	pop r18
	pop r17

	ret