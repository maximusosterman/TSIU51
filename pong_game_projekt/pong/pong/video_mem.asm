#ifndef _VIDEO_MEM_
#define _VIDEO_MEM_






ERASE_VMEM: 
	push	ZH
	push	ZL
	push	r17 
	push	r16

	ldi    ZH,HIGH(VMEM)
	ldi    ZL,LOW(VMEM)
	
	ldi		r17, 65
	clr		r16 

LOOP_ERASE:
	st		Z+, r16 
	dec		r17
	brne	LOOP_ERASE
	pop		r16
	pop		r17
	pop		ZL
	pop		ZH
	ret


#endif /*__video_MEM.asm__*/
