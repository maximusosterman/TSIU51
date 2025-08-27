;
; lax1.asm
;
; Created: 2025-08-25 15:21:57
; Author : maxve266
;


; Replace with your application code
COLD:
	ldi r16, HIGH(RAMEND)
	out SPH, r16
	ldi r16, LOW(RAMEND)
	out SPL, r16

HW_INTI:
	ldi r16, $00
	out DDRA, r16
	ldi r16, $FF
	out DDRB, r16

MAIN:
	push r17

WAIT:
	sbis PINA, 7
	rjmp WAIT

	call GET_NUM
	call SET_NUM

	pop r17
	rjmp MAIN

GET_NUM: // --> returns in r17
	in r17, PINA
	andi r17, 0b00001111
	ret

SET_NUM:

	cpi r17, 0b00001010 // 10
	breq SET_10

	cpi r17, 0b00001011 // 11
	breq SET_11

	cpi r17, 0b00001100 // 12
	breq SET_12

	cpi r17, 0b00001101 // 13
	breq SET_13

	cpi r17, 0b00001110 // 14
	breq SET_14

	cpi r17, 0b00001111 // 15
	breq SET_15

CONTINUE_SET_NUM:
	swap r17
	out PORTB, r17
	ret

SET_10:
	ldi r17, 0b00010000
	jmp CONTINUE_SET_NUM

SET_11:
	ldi r17, 0b00010001
	jmp CONTINUE_SET_NUM

SET_12:
	ldi r17, 0b00010010
	jmp CONTINUE_SET_NUM

SET_13:
	ldi r17, 0b00010011
	jmp CONTINUE_SET_NUM

SET_14:
	ldi r17, 0b00010100
	jmp CONTINUE_SET_NUM

SET_15:
	ldi r17, 0b00010101
	jmp CONTINUE_SET_NUM
