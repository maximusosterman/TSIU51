#ifndef _HARWARE_INIT_
#define _HARWARE_INIT_


HW_INIT:
	call	HW_INIT_JOYSTICK
	call	SPI_MASTER_INIT
	call	INT_INIT
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

#endif /*_harware_init_*/
