#ifndef _7SEG_
#define _7SEG_

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

RESET_7SEGS:
    push    r19
    push    r17
    push    r20

    ldi     r19, 0
    call    LOAD_DIGIT // (r19=number) -> r17=7seg pattern

    //Loading the socre onto segment display right
   	ldi 	r20, ADDR_RIGHT8*2
	call    TWI_SEND  ; (r20=address, r17=data)

  	//Loading the socre onto segment display left
	ldi 	r20, ADDR_LEFT8*2
	call    TWI_SEND  ; (r20=address, r17=data)

    pop     r20
	pop     r17
    pop     r19
    ret

DIGIT_LOOKUP:
	.db 0b0111111, 0b0000110, 0b1011011, 0b1001111, 0b1100110, 0b1101101, 0b1111101, 0b0000111, 0b1111111, 0b1101111, 0b1110111, 0b1111100, 0b0111001, 0b1011110, 0b1111001, 0b1110001

#endif //__7SEG__//
