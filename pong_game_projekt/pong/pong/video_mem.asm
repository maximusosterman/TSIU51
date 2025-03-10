#ifndef _VIDEO_MEM_
#define _VIDEO_MEM_

ERASE_VMEM:
	push	ZH
	push	ZL
	push	r17
	push	r16

	ldi    ZH,HIGH(VMEM)
	ldi    ZL,LOW(VMEM)

	ldi		r17, 64
	clr		r16

LOOP_ERASE:
	st		Z+, r16
	dec		r17
	brne	LOOP_ERASE
	call	LAST_BYTES
	pop		r16
	pop		r17
	pop		ZL
	pop		ZH
	
	ret


LAST_BYTES:
	// Shall load 8 last bytes to make the last row less intense
	ldi		r16,2

LAST_BYTES_LOOP:
	ldi		r17,$00	
	st		Z+, r17
	ldi		r17,$00
	st		Z+, r17
	ldi		r17,$00
	st		Z+, r17
	ldi		r17, $FF
	st		Z+, r17
	dec		r16 
	brne	LAST_BYTES_LOOP
	ret

#endif /*__video_MEM.asm__*/
