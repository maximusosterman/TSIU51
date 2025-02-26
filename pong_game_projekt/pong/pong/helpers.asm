#ifndef _HELPERS_
#define _HELPERS_

REVERSE_REGISTER_LUT:
    push ZH
    push ZL

    ldi ZH, high(REVERSE_LUT<<1)  ; Load LUT address
    ldi ZL, low(REVERSE_LUT<<1)
    add ZL, r16                   ; Use r16 as index
    adc ZH, r1                    ; Add carry if needed
    lpm r16, Z                    ; Load reversed byte into r16

    pop ZL
    pop ZH
    ret

#endif /* _HELPERS_ */
