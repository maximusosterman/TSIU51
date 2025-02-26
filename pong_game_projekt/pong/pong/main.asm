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
	jmp START
	





WAIT_FOR_START:
	rjmp	WAIT_FOR_START
	ret


END_GAME:
	jmp END_GAME




