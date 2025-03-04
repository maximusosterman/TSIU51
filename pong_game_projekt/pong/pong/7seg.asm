;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; LOAD_DIGIT(r19=number) -> r17=7seg mönster
LOAD_DIGIT:
	push	ZH
	push	ZL

	ldi		ZH, HIGH(DIGIT_LOOKUP*2)
	ldi		ZL, LOW(DIGIT_LOOKUP*2)

	add		ZL, r19
	lpm		r17, Z

	pop		ZL
	pop		ZH
	ret


DIGIT_LOOKUP:
	.db 0b0111111, 0b0000110, 0b1011011, 0b1001111, 0b1100110, 0b1101101, 0b1111101, 0b0000111, 0b1111111, 0b1101111, 0b1110111, 0b1111100, 0b0111001, 0b1011110, 0b1111001, 0b1110001
