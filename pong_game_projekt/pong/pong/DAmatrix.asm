// TO DO LIST:

// GÖR PARAMETERBASERAT DVS DU SKA KUNNA SKICKA IN POSX, POSY OCH COLOR SOM PARAMETER




#ifndef _DAMATRIX_
#define _DAMATRIX_

;::::::::::::::::
;       SPI
;::::::::::::::::


SPI_MASTER_INIT:
; Set MOSI and SCK output, all others input
		clr		r17 
        ldi     r17, (1<<MATRIX_LATCH)|(1<<MOSI)|(1<<SCK)
        out     DDRB, r17
; Enable SPI, Master, set clock rate fck/4
        ldi     r17, (1<<SPE)|(1<<MSTR)|(1<<SPR0)
        out     SPCR, r17
		call	RENDER_TO_DAM
        ret
		
SPI_MasterTransmit:
	; Start transmission of data (r16)
	out SPDR,r16

Wait_Transmit:
	; Wait for transmission complete
		sbis SPSR,SPIF
		rjmp Wait_Transmit
		ret

SPI_SlaveInit:
	; Set MISO output, all others input
	ldi r17,(1<<MISO)
	out DDR_SPI,r17
	; Enable SPI
	ldi r17,(1<<SPE)
	out SPCR,r17
	ret

SPI_SlaveReceive:
	; Wait for reception complete
	sbis SPSR,SPIF
	rjmp SPI_SlaveReceive
	; Read received data and return
	in r16,SPDR
	ret

LATCH: 
	sbi		PORTB, MATRIX_LATCH
	cbi		PORTB, MATRIX_LATCH

	ret


RENDER_TO_DAM:  //Ska läsa från VMEM

	push	ZH
	push	ZL
	push	r16
	push	r17

	ldi		ZH,HIGH(VMEM)
	ldi		ZL,LOW(VMEM) 
	ldi		r17, 8 //loop counter

RENDER_LOOP:
	ld		r16,Z+
	call	SPI_MasterTransmit
	dec		r17
	brne	RENDER_LOOP




/*	
	//höger display 
	ld		r16,Z+
	call	SPI_MasterTransmit
	ld		r16, Z+
	call	SPI_MasterTransmit
	ld		r16, Z+
	call	SPI_MasterTransmit
	ld		r16, Z+
	call	SPI_MasterTransmit

	//Vänster display
	ld		r16, Z+	//blå 
	call	SPI_MasterTransmit
	ld		r16, Z+ // grön 
	call	SPI_MasterTransmit
	ld		r16, Z+	// röd
	call	SPI_MasterTransmit
	ld		r16, Z+
	call	SPI_MasterTransmit
*/
	call	LATCH

	pop		r17
	pop		r16
	pop		ZL
	pop		ZH







#endif /* _DAMATRIX_ */

