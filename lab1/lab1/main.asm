;
; lab1.asm
;
; Created: 2025-01-28 18:00:49
; Author : maxve266
;


; Replace with your application code
	.equ ADDR_LEFT8 = $24
	.equ ADDR_RIGHT8 = $25
	.equ ADDR_LEDS = $26 

	.equ SCL = PC0
	.equ SDA = PC1

MAIN:
	ldi		r16, HIGH(RAMEND)
	out		SPH, r16
	ldi		r16, LOW(RAMEND)
	out		SPL, r16

MAIN_2:
	ldi r19, 0

main_loop:
	call	LOAD_DIGIT ; (r19=number) -> r17=7seg mönster
	ldi	 r20, ADDR_LEDS*2
	call TWI_SEND  ; (r20=address, r17=data)
	inc		r19
	call delay_1sec
	cpi		r19, 16
	brne	main_loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; TWI_SEND(r20=address, r17=data)
TWI_SEND: // ALWAYS SEND r20
	call	START
	call	TWI_81
	mov		r20, r17
	call	TWI_81
	call	STOP
	ret

/*DATA:
	ldi		r19, 0
DATA_LOOP:
	call	LOAD_DIGIT 
	mov		r20, r17
	call	TWI_81
	inc		r19
	cpi		r19,15
	brne	DATA_LOOP
	ret
*/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; LOAD_DIGIT(r19=number) -> r17=7seg mönster
LOAD_DIGIT:
	push	ZH
	push	ZL

	ldi		ZH, HIGH(DIGIT_LOOKUP*2)
	ldi		ZL, LOW(DIGIT_LOOKUP*2)

	add		ZL, r19 
	lpm		r17, Z

	pop		ZL
	pop		ZH
	ret 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; TWI_81(r20=byte)
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

	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

delay_1sec:
	push	r16
	push	r17
	push	r18
	ldi		r18, $FF
	ldi		r16,10 ; Decimal bas
delay_YttreLoop:
	ldi		r17,$1F
delay_InreLoop:
	dec		r17
	brne	delay_InreLoop
	dec		r16
	brne	delay_YttreLoop
	dec		r18
	brne	delay_YttreLoop
	pop		r18
	pop		r17
	pop		r16
	ret

DIGIT_LOOKUP:
	.db 0b0111111, 0b0000110, 0b1011011, 0b1001111, 0b1100110, 0b1101101, 0b1111101, 0b0000111, 0b1111111, 0b1101111, 0b1110111, 0b1111100, 0b0111001, 0b1011110, 0b1111001, 0b1110001