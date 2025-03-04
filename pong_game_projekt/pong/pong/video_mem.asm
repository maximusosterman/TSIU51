#ifndef _VIDEO_MEM_
#define _VIDEO_MEM_

TEST_TABLE: .db $01 , $01, $01, $C7, $80, $80, $80, $C3	//starting pos

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
	pop		r16
	pop		r17
	pop		ZL
	pop		ZH
	ret

/*SET_VM:
	ldi	r16, $F5
	call SET_WHITE_PIX // ARG( $XY)
	ldi	r16, $F4
	call SET_WHITE_PIX // ARG( $XY)
	ldi	r16, $F3
	call SET_WHITE_PIX // ARG( $XY)


	ldi	r16, $05
	call SET_WHITE_PIX // ARG( $XY)
	ldi	r16, $04
	call SET_WHITE_PIX // ARG( $XY)
	ldi	r16, $03
	call SET_WHITE_PIX // ARG( $XY)


	ldi	r16, $74
	call SET_WHITE_PIX // ARG( $XY)


	ret */

#endif /*__video_MEM.asm__*/
