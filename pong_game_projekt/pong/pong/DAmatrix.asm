#ifndef _DAMATRIX_
#define _DAMATRIX_

;::::::::::::::::
;       SPI
;::::::::::::::::

SPI_MASTER_INIT:
; Set MOSI and SCK output, all others input
        ldi     r17, (1<<MATRIX_LATCH)|(1<<MOSI)|(1<<SPI_CLK)
        out     DDRB, r17
; Enable SPI, Master, set clock rate fck/4
        ldi     r17, (1<<SPE)|(1<<MSTR)|(0<<SPR1)|(0<<SPR0)
        out     SPCR, r17
        ret


#endif /* _DAMATRIX_ */
