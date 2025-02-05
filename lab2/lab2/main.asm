	
.equ	ADDR_JOY =	$27

COLD:
	ldi		r16, HIGH(RAMEND)
	out		SPH, r16
	ldi		r16, LOW(RAMEND)
	out		SPL, r16

MAIN:
	call 

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