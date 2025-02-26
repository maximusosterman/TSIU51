#ifndef _VIDEO_MEM_
#define _VIDEO_MEM_
 


TEST_TABLE: .db $01 , $01, $01, $C7, $80, $80, $80, $C3	//starting pos

ERASE_VMEM: 
	push	ZH
	push	ZL
	push	r17 
	push	r16

	ldi    ZH,HIGH(VMEM)
	ldi    ZL,LOW(VMEM)
	
	ldi		r17, 65
	clr		r16 

LOOP_ERASE:
	st		Z+, r16 
	dec		r17
	brne	LOOP_ERASE
	pop		r16
	pop		r17
	pop		ZL
	pop		ZH
	ret

SET_VM:
	ldi	r16, $0F
	call SET_WHITE_PIX
	ret

/*
SET_VM:
	push ZL
	push ZH
	push YH
	push YL
	push r17

	ldi ZL, LOW(TEST_TABLE*2)  ; Load lower byte of TEST_TABLE address
    ldi ZH, HIGH(TEST_TABLE*2)  ; Load higher byte of TEST_TABLE address

    ldi YL, LOW(VMEM)        ; Load lower byte of VMEM address
    ldi YH, HIGH(VMEM)        ; Load higher byte of VMEM address

    ldi r16, 8               ; Set loop counter (number of bytes to copy)

copy_loop:
    lpm r17, Z+               ; Load byte from TEST_TABLE (Z points to next byte after)
    st Y+, r17               ; Store byte into VMEM (Y points to next byte after)
    dec r16                  ; Decrement loop counter
    brne copy_loop           ; Repeat until all bytes copied

	pop r17
	pop YL
	pop YH
	pop ZH
	pop ZL
	ret
	

*/
#endif /*__video_MEM.asm__*/
