#ifndef _HARWARE_INIT_
#define _HARWARE_INIT_


HW_INIT:
	call	HW_INIT_JOYSTICK
	call	
	
	ret 



HW_INIT_JOYSTICK:
	ldi		r16, (1 << ADEN) | 7
	out		ADCSRA, r16 
	ldi		r16, (1 << REFS0)
	sts		ADMUX, r16 
	
	ret 

#ednif /*_harware_init_*/