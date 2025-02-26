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
 
 .dseg
	.org SRAM_START
	VMEM: .byte 64
.cseg

; ---------------------------------------
; --- Memory layout in SRAM
 
COLD:
; ***         sätt stackpekaren
	ldi    r16, HIGH(RAMEND)
	out    sph, r16
	ldi    r16, LOW(RAMEND)
	out    spl, r16

START:
	call	ERASE_VMEM
	call	SET_VM
	call	SPI_MASTER_INIT
	jmp		START
	//call WAIT_FOR_START:
	
