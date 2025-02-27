#ifndef _HARWARE_INIT_
#define _HARWARE_INIT_


HW_INIT:
	call HW_INIT_JOYSTICK
	
	
	ret 





HW_INIT_JOYSTICK:
	ldi		r16, (1 << REFS0)
	sts		ADMUX, r16 

	ldi		r16, (1 << ADEN) | (1 << ADPS2) | (1 << ADPS1) ; Aktivera ADC, prescaler 64
	sts		ADCSRA, r16        ; Lagra i ADCSRA
	
	ret 

#ednif /*_harware_init_*/