#ifndef _HARWARE_INIT_
#define _HARWARE_INIT_


HW_INIT:
	call	HW_INIT_JOYSTICK
	call	SPI_MASTER_INIT
	call	INT_INIT
	call	HW_INIT_LEFT_BUTTON
	ret 

INT_INIT:
	ldi		r16, (1 << CS02)
	out		TCCR0, r16
	ldi		r16, (1	<< TOIE0)
	out		TIMSK, r16

SPI_MASTER_INIT:
; Set MOSI and SCK output, all others input
		clr		r17 
        ldi     r17, (1<<MATRIX_LATCH)|(1<<MOSI)|(1<<SCK)
        out     DDRB, r17
; Enable SPI, Master, set clock rate fck/4
        ldi     r17, (1<<SPE)|(1<<MSTR)|(1<<SPR0)
        out     SPCR, r17
        ret
		
HW_INIT_JOYSTICK:
	ldi		r16, (1 << ADEN) | 7
	out		ADCSRA, r16 
	ldi		r16, (1 << REFS0)
	sts		ADMUX, r16 
	
	ret 



HW_INIT_LEFT_BUTTON:  
// The button "L" on DAvid is accessed through PORTD pin 0. PD0, RXD. 
// This routine henceforth sets PORTD and inputs and is then red by checking if P0 is set or not.
	push	r16
	
	clr		r16
	out		DDRD, r16 // INPUT

	ldi		r16, $F
	out		PORTD, r16

	pop		r16
	ret

#endif /*_harware_init_*/
