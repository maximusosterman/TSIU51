#ifndef _DISPLAY_
#define _DISPLAY_

POS_Y_ADRESS: .db $FE, $FD, $FB, $F7, $EF, $DF, $BF, $7F

SET_WHITE_PIX: // r16 = POS (     X     |     Y      )

	// REVERSE r16 to POS (	  Y		|	  X		 )
	call REVERSE_REGISTER // r16

	push	ZH
	push	ZL
	push	r18
	push	r20
	
	mov		r20,r16
	andi	r20,0b11110000

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

	push	ZH
	push	ZL

	clr		r18
	ldi		ZH,HIGH(POS_Y_ADRESS*2)
	ldi		ZL,LOW(POS_Y_ADRESS*2)

	lsr		r20 
	lsr		r20
	lsr		r20 
	lsr		r20 
	
ANODE_LOOP: 
	lpm		r18, Z+
	cpi		r20,0
	breq	LOOP_DONE
	dec		r20
	rjmp	ANODE_LOOP

LOOP_DONE:
	
	pop		ZL
	pop		ZH
	
	std		Z+3, r18

	pop		r20
	pop		r18
	pop		ZL
	pop		ZH
	
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
