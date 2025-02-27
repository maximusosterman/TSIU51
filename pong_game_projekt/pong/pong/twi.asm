#ifndef _TWI_
#define _TWI_

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; TWI_SEND(r20=address, r17=data)
TWI_SEND: // ALWAYS SEND r20
	call	TWI_START
	call	TWI_81
	mov		r20, r17
	call	TWI_81
	call	STOP
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


READ_TWI:
	ldi		r18, 8 // loop counter
LOOP_READ:
		cbi		DDRC, SCL
		call	WAIT
		lsl		r20
		sbic	PINC, SDA
		ori		r20, 1
		sbi		DDRC, SCL
		call	WAIT
		dec		r18
		brne	LOOP_READ // end of loop
		call	SDH	//ACK
		ret

TWI_START:
	sbi		DDRC, SDA
	call	WAIT_TWI
	sbi		DDRC, SCL
	call	WAIT_TWI
	ret

TWI_STOP:
	sbi		DDRC, SDA
	call	WAIT_TWI
	cbi		DDRC, SCL
	call	WAIT_TWI
	cbi		DDRC, SDA
	call	WAIT_TWI
	ret

SDL:
	sbi		DDRC, SDA
	call	WAIT_TWI
	cbi		DDRC, SCL
	call	WAIT_TWI
	sbi		DDRC, SCL
	call	WAIT_TWI
	ret

SDH:
	cbi		DDRC, SDA
	call	WAIT_TWI
	cbi		DDRC, SCL
	call	WAIT_TWI
	sbi		DDRC, SCL
	call	WAIT_TWI
	ret

WAIT_TWI:
		push	r16
		ldi		r16,10 ; Decimal bas
WAIT_inner_loop:
		dec		r16
		brne	WAIT_inner_loop
		pop		r16
		ret

delay_1sec:
		push	r16
		push	r17
		push	r18
		ldi		r18, $FF
		ldi		r16,10 ; Decimal bas
delay1sec_outer_loop:
		ldi		r17,$1F
delay1sec_inner_loop:
		dec		r17
		brne	delay1sec_inner_loop
		dec		r16
		brne	delay1sec_outer_loop
		dec		r18
		brne	delay1sec_outer_loop
		pop		r18
		pop		r17
		pop		r16
		ret

#ednif /*_TWI*/
