;
; pong.asm
;
; Created: 2025-02-18 13:36:43
; Author : maxve266
;

#ifndef __MAIN__
#define __MAIN__
.org $0
	rjmp COLD

.org OVF0ADDR
	rjmp RENDER_TO_DAM

 .dseg
	.org SRAM_START
	VMEM: .byte 64
.cseg

; ---------------------------------------
; --- Memory layout in SRAM


.INCLUDE "port_definitions.asm"
.INCLUDE "DAmatrix.asm"
.INCLUDE "video_mem.asm"
.INCLUDE "display.asm"
.INCLUDE "helpers.asm"
.INCLUDE "game.asm"
.INCLUDE "start_screen.asm"
.INCLUDE "joystick.asm"
.INCLUDE "7seg.asm"

; ---------------------------------------
; --- Memory layout in SRAM
 
COLD:
; ***         s�tt stackpekaren
	ldi    r16, HIGH(RAMEND)
	out    sph, r16
	ldi    r16, LOW(RAMEND)
	out    spl, r16
	call	HW_INIT
	sei

START:
	call	START_SCREEN
	call	GAME_START
	call	END_GAME
	
	





END_GAME: 
	// DISPLAY WINNER AND VICTORY SOUND (REQUEST TO PLAY AGAIN)
	jmp		END_GAME


.INCLUDE "twi.asm"
.INCLUDE "hardware_init.asm"

#endif /*__MAIN__ */ 

