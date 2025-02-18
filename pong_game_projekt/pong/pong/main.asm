;
; pong.asm
;
; Created: 2025-02-18 13:36:43
; Author : maxve266
;

.INCLUDE "port_definitions.asm"
.INCLUDE "DAmatrix.asm"

.equ VMEM_SZ = 5    ; #rows on display
.equ GAME_SPEED  = 150 ; inter-run delay (millisecs)


; ---------------------------------------
; --- Memory layout in SRAM
.dseg
	.org SRAM_START
	POSX_BALL: .byte 1 
	POSY_BALL: .byte 1
	P1_POSY: .byte 1 
	P2_POSY: .byte 1
	LINE: .byte 1 ; Current line    
	VMEM: .byte VMEM_SZ ; Video MEMory
.cseg

	jmp COLD 

COLD:
; ***         sätt stackpekaren
	ldi    r16, HIGH(RAMEND)
	out    sph, r16
	ldi    r16, LOW(RAMEND)
	out    spl, r16

	// call HW_INIT