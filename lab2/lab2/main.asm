;
; lab2.asm
;
; Created: 2025-02-05 
; Author : maxve266
;
;
	.equ ADDR_LEFT8 = $24
	.equ ADDR_JOY =	$27
	.equ ADDR_LEDS = $26 
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
	call	PRINT_NUMBER	
	rjmp	MAIN

SET_SIX:
	ldi		r20, ADDR_LEFT8*2
	call	START
	call	TWI_81 
	ldi		r20, 0b1111101
	call	TWI_81
	call	STOP
	rjmp	CONTINUE

SET_FIVE:
	ldi		r20, ADDR_LEFT8*2
	call	START
	call	TWI_81 
	ldi		r20, 0b1101101
	call	TWI_81
	call	STOP 
	rjmp	CONTINUE

PRINT_NUMBER:
	andi	r20, $3F
	cpi		r20, $3F  
	breq	SET_ZERO
	cpi		r20, $3E
	breq	SET_ONE
	cpi		r20, $3D
	breq	SET_TWO 
	cpi		r20, $3B
	breq	SET_THREE
	cpi		r20, $37
	breq	SET_FOUR 
	cpi		r20, $2F
	breq	SET_FIVE
	cpi		r20, $1F
	breq	SET_SIX

SET_ZERO:
	ldi		r20, ADDR_LEFT8*2
	call	START
	call	TWI_81 
	ldi		r20, 0b0111111
	call	TWI_81
	call	STOP
	rjmp	CONTINUE

SET_ONE:
	ldi		r20, ADDR_LEFT8*2
	call	START
	call	TWI_81 
	ldi		r20, 0b0000110
	call	TWI_81
	call	STOP
	rjmp	CONTINUE

SET_TWO:
	ldi		r20, ADDR_LEFT8*2
	call	START
	call	TWI_81 
	ldi		r20, 0b1011011
	call	TWI_81	
	call	STOP
	rjmp	CONTINUE

SET_THREE:
	ldi		r20, ADDR_LEFT8*2
	call	START
	call	TWI_81 
	ldi		r20, 0b1001111
	call	TWI_81
	call	STOP 
	call	START
	ldi		r17, 2
	call	MAIN_CONT
	call	STOP
	rjmp	CONTINUE

SET_FOUR:
	ldi		r20, ADDR_LEFT8*2
	call	START
	call	TWI_81 
	ldi		r20, 0b1100110
	call	TWI_81
	call	STOP
	call	START
	ldi		r17, 1
	call	MAIN_CONT
	call	STOP
	rjmp	CONTINUE


CONTINUE:
	ret


MAIN_CONT:
	ldi		r20, ADDR_LEDS*2
	call	TWI_81
	mov		r20, r17
	call	TWI_81 
	ret

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