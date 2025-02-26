#ifndef _DISPLAY_
#define _DISPLAY_
.dseg
	POS_Y_ADRESS: .db $FF, $7F, $BF, $DF, $EF, $F7, $FB, $FD, $FE 
.cseg

SET_WHITE_PIX: // r16 = POS (     Y     |     X      )
	push	r18
	call	DISPLAY_IX

	//blue
	ldd		r18, Z+0
	or		r18, r16
	std		Z+0, r18

	//green
	ldd		r18, Z+1
	or		r18, r16
	std		Z+1, r18

	//red
	ldd		r18, Z+2
	or		r18, r16
	std		Z+2, r18

	//anode
	ldd		r18, Z+3
	or		r18, r16
	com		r18
	std		Z+3, r18

	pop		r18

	ret

DISPLAY_IX: // r16 = PIXEL_POS

	push r1
	
	clr		r1
	ldi		ZH, HIGH(VMEM)
	ldi		ZL, LOW(VMEM)

	mov		r17, r16
	andi	r16, 0b11111000 
	lsr		r16
	
	add		ZL, r16
	adc		ZH, r1

	andi	r17, 0b00000111

	ldi		r16, 0x01

LOOP:
	cpi		r17, 0
	breq	END_LOOP
	lsl		r16
	dec		r17
	rjmp	LOOP

END_LOOP:
	pop r1
	ret

#endif /* _DISPLAY_ */
