;
; lab1.asm
;
; Created: 2025-05-29 08:37:19
; Author : maxve266
;


; Replace with your application code

COLD:
	ldi r16, HIGH(RAMEND)
	out SPH, r16
	ldi r16, LOW(RAMEND)
	out SPL, r16
	call HW_INIT
	call MAIN

MAIN:
	call GET_KEYBOARD_INPUT
	call LOAD_OUTPUT

GET_KEYBOARD_INPUT: //return r17 = num_of_input
	clr r17
	in r17, PINB
	andi r17, 0b01111111
	ret

LOAD_OUTPUT:

	call CHECK_IF_STROBE
	
	cpi r17, 10
	brlo LESS_THAN_10

	jmp GREATER_THAN_10

CONT_LOAD_OUTPUT:
  	ret

CHECK_IF_STROBE:
	sbis PINB, 7

	jmp RESET

	ret

RESET:
	push r18
	ldi r18, 0

	out PORTA, r18

	ldi r18, 0

	out PORTD, r18

	pop r18

	jmp MAIN

GREATER_THAN_10:
	push r18

	ldi r18, 1
	out PORTA, r18

	subi r17, 10
	out PORTD, r17

	pop r18

	jmp CONT_LOAD_OUTPUT


LESS_THAN_10:
	push r18

	clr r18
	out PORTA, r18

	out PORTD, r17

	pop r18

	jmp CONT_LOAD_OUTPUT



HW_INIT:
	ldi r16, $FF
	out DDRA, r16
	ldi r16, $FF
	out DDRD, r16
	ldi r16, $0
	out DDRB, r16
	ret



