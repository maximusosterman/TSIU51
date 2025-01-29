;
; lab1.asm
;
; Created: 2025-01-28 18:00:49
; Author : maxve266
;


; Replace with your application code
	.equ ADDR_LEFT8 = $24
	.equ ADDR_RIGHT8 = $25

	.equ SCL = PC0
	.equ SDA = PC1

MAIN:
	ldi		r16, HIGH(RAMEND)
	out		SPH, r16
	ldi		r16, LOW(RAMEND)
	out		SPL, r16

TWI_SEND: // ALWAYS SEND r20
	call	START
	call	ADRESS
	call	DATA
	call	STOP

ADRESS:
	ldi		r20, ADDR_LEFT8*2
	call	TWI_81
	ret

DATA:
	mov		r20, r17
	call	TWI_81
	ret


TWI_81:
	ldi		r18,8 // loop counter	
LOOP:
	sbrc	r20, 7
	call	SDH
	sbrs	r20, 7
	call	SDL
	lsl		r20
	dec		r18
	cpi		r18, 0
	brne	LOOP // end of loop

	call	SDH	//ACK 
	ret

START:
	sbi		DDRC, SDA
	call	WAIT
	sbi		DDRC, SCL
	call	WAIT
	ret

STOP:
	sbi		DDRC, SDA
	call	WAIT
	cbi		DDRC, SCL
	call	WAIT
	cbi		DDRC, SDA
	call	WAIT
	ret

SDL:
	sbi		DDRC, SDA
	call	WAIT
	cbi		DDRC, SCL
	call	WAIT
	sbi		DDRC, SCL
	call	WAIT
	ret

SDH:
	cbi		DDRC, SDA
	call	WAIT
	cbi		DDRC, SCL
	call	WAIT
	sbi		DDRC, SCL
	call	WAIT
	ret

WAIT:

	ret