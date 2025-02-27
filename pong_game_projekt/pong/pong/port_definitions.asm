#ifndef _PORT_DEF_
#define _PORT_DEF_



	.equ	MATRIX_LATCH = PB4
	.equ	MOSI = PB5
	.equ	SCK = PB7
	.equ	MISO = PB6
	.equ	DDR_SPI = DDRB

	.equ	SCL = PC0
	.equ	SDA = PC1

	.equ	JOY_CHAN_RIGHT_Y = 1
	.equ	JOY_CHAN_LEFT_Y = 3

	jmp		COLD




#endif /* _PORT_DEF_ */
