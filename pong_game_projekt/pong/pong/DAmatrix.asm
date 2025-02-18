// TO DO LIST:

// GÖR PARAMETERBASERAT DVS DU SKA KUNNA SKICKA IN POSX, POSY OCH COLOR SOM PARAMETER




#ifndef _DAMATRIX_
#define _DAMATRIX_

;::::::::::::::::
;       SPI
;::::::::::::::::

SPI_MASTER_INIT:
; Set MOSI and SCK output, all others input
        ldi     r17, (1<<MATRIX_LATCH)|(1<<MOSI)|(1<<SCK)
        out     DDRB, r17
; Enable SPI, Master, set clock rate fck/4
        ldi     r17, (1<<SPE)|(1<<MSTR)|(1<<SPR0)
        out     SPCR, r17
		call	RUN
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


RUN: 
	//höger display 
	ldi		r16,$00
	call	SPI_MasterTransmit
	ldi		r16,$00
	call	SPI_MasterTransmit
	ldi		r16,$00
	call	SPI_MasterTransmit
	ldi		r16, $7F
	call	SPI_MasterTransmit

	//Vänster display
	ldi		r16,$80	//blå 
	call	SPI_MasterTransmit
	ldi		r16,$80 // grön 
	call	SPI_MasterTransmit
	ldi		r16,$80	// röd
	call	SPI_MasterTransmit
	ldi		r16, $7F
	call	SPI_MasterTransmit
	
	call	LATCH


#endif /* _DAMATRIX_ */

