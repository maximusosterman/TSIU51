;
; lab2.asm
;
; Created: 2025-02-05 
; Author : maxve266
;
;
	.equ ADDR_JOY =	$27
	.equ SCL = PC0
	.equ SDA = PC1

COLD:
	ldi		r16, HIGH(RAMEND)
	out		SPH, r16
	ldi		r16, LOW(RAMEND)
	out		SPL, r16

MAIN:
	ldi		r20, ADDR_JOY 
	call	SET_READ_ADDR	
	call	TWI_SEND


SET_READ_ADDR:
	lsl		r20
	inc		r20 ; Set read
	ret 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; TWI_SEND(r20=address, r17=data)
TWI_SEND: // ALWAYS SEND r20
	call	START
	call	TWI_81
	call	WAIT
	call	READ_TWI
	call	STOP

	ret

READ_TWI:
	ldi		r18,8 // loop counter	
	in		r16, PINC
LOOP_READ:
	


	lsl		r20
	dec		r18
	cpi		r18, 0
	brne	LOOP_READ // end of loop

	call	SDH	//ACK 
	ret	
	
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
	push	r16
	ldi		r16,10 ; Decimal bas
W8_InreLoop:
	dec		r16
	brne	W8_InreLoop
	pop		r16
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

