;
; lab1.asm
;
; Created: 2025-01-28 18:00:49
; Author : maxve266
;


; Replace with your application code
	.equ ADDR_LEFT8 = $24
	.equ ADDR_RIGHT8 = $25

	.equ SCL = PC0
	.equ SDA = PC1

START:
	sbi		DDRC, SDA
	call	WAIT
	sbi		DDRC, SCL
	call	WAIT
	ret

STOP:
	sbi		DDRC, SDA
	call	WAIT
	cbi		DDRC, SCL
	call	WAIT
	cbi		DDRC, SDA
	call	WAIT
	ret

SDL:
	sbi		DDRC, SDA
	call	WAIT
	cbi		DDRC, SCL
	call	WAIT
	sbi		DDRC, SCL
	call	WAIT
	ret

SDH:
	cbi		DDRC, SDA
	call	WAIT
	cbi		DDRC, SDL
	call	WAIT
	sbi		DDRC, SCL
	call	WAIT
	ret