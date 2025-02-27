#ifndef _START_SCREEN_
#define _START_SCREEN_

START_SCREEN:
	call	ERASE_VMEM
	call	RENDER_START_SCREEN
	call	WAIT_FOR_BUTTON_START
	ret
	
	//call WAIT_FOR_START:	
	
	ret

RENDER_START_SCREEN:
	// P-BOKSTAV

	ldi		r16, $F1
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $F2
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $F3
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $F4
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $F5
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $F6
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $E1
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $D1
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $D2
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $D3
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $E3
	call	SET_WHITE_PIX //ARG r16=$XY
	
	// O-BOKSTAV

	ldi		r16, $B3
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $B4
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $B5
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $B6
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $A3
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $A6
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $93
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $94
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $95
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $96
	call	SET_WHITE_PIX //ARG r16=$XY

//N-BOKSTAV

	ldi		r16, $73
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $74
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $75
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $76
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $64
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $55
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $43
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $44
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $45
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $46
	call	SET_WHITE_PIX //ARG r16=$XY
	
	//G_BOKSTAV

	ldi		r16, $03
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $13
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $23
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $24
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $25
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $26
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $16
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $06
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $05
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $15
	call	SET_WHITE_PIX //ARG r16=$XY

	//Skicka till display

	call	SPI_MASTER_INIT

	ret

WAIT_FOR_BUTTON_START:
	push r20

	ldi		r20, ADDR_JOY*2+1
	call	TWI_SEND

	pop r20
	ret

#endif /* _START_SCREEN_* */
