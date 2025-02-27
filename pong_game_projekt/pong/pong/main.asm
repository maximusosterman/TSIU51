;
; pong.asm
;
; Created: 2025-02-18 13:36:43
; Author : maxve266
;


.INCLUDE "port_definitions.asm"
.INCLUDE "DAmatrix.asm"
.INCLUDE "video_mem.asm"
.INCLUDE "display.asm"
.INCLUDE "helpers.asm"
.INCLUDE "game.asm"
.INCLUDE "start_screen.asm"
 
 .dseg
	.org SRAM_START
	VMEM: .byte 64
.cseg

; ---------------------------------------
; --- Memory layout in SRAM
 
COLD:
; ***         s�tt stackpekaren
	ldi    r16, HIGH(RAMEND)
	out    sph, r16
	ldi    r16, LOW(RAMEND)
	out    spl, r16

START:
	call	START_SCREEN
	call	WAIT_FOR_START
	call	GAME_LOOP
	call	END_GAME
	jmp		START
	








END_GAME:
	jmp END_GAME




END_GAME: 
	// DISPLAY WINNER AND VICTORY SOUND (REQUEST TO PLAY AGAIN)
	call	ERASE_VMEM
	ret








START_SCREEN:
	call	ERASE_VMEM

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

	ldi		r16, $B2
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $B3
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $B4
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $B5
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $A2
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $A5
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $92
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $93
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $94
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $95
	call	SET_WHITE_PIX //ARG r16=$XY

//N-BOKSTAV

	ldi		r16, $72
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $73
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $74
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $75
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $63
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $54
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $42
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $43
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $44
	call	SET_WHITE_PIX //ARG r16=$XY
	
	ldi		r16, $45
	call	SET_WHITE_PIX //ARG r16=$XY
	
	//G_BOKSTAV

	ldi		r16, $02
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $12
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $22
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $23
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $24
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $25
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $15
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $05
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $04
	call	SET_WHITE_PIX //ARG r16=$XY

	ldi		r16, $14
	call	SET_WHITE_PIX //ARG r16=$XY

	//Skicka till display

	call	SPI_MASTER_INIT
	
	//call WAIT_FOR_START:	
	


	ret
