#ifndef _PORT_DEF_
#define _PORT_DEF_

	.equ	GAME_SPEED = 2

	.equ	MATRIX_LATCH = PB4
	.equ	MOSI = PB5
	.equ	SCK = PB7
	.equ	MISO = PB6
	.equ	DDR_SPI = DDRB

	.equ    ADDR_JOY = $27

	.equ    SCL = PC0
	.equ    SDA = PC1

	.equ	JOY_CHAN_RIGHT_Y = 1
	.equ	JOY_CHAN_LEFT_Y = 3
	.equ	PRESCALER = 7

	// 7seg displays
	.equ    ADDR_LEFT8 = $24
	.equ    ADDR_RIGHT8 = $25

	jmp		COLD




#endif /* _PORT_DEF_ */
