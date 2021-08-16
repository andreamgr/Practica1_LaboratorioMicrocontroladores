

    list	    p=18f4550        
    #include	    "p18f4550.inc"

;**************** Definitions*********************************
PSECT udata 
 temp:
    DS 1
;mask = 3
;*************************************************
PSECT code; delta=2, abs
org 0x000 ;vector de reset
    goto main ;goes to main program
init: 
    MOVLB 0xF
    CLRF LATD,c ;output port
    setf LATB,c ;input port
    clrf TRISD,c ;output port
    setf TRISB,c ;input port
    return ;leaving initialization subroutine
main: call init
read_code:
    movf PORTB,w,c ;portb data is moved into wreg
    andlw 3 ;a mask preserves rb0 and rb1 only
    movwf temp,c ;data stored in reg temp
    call lookup_table
    
lookup_table:
    
    retlw 0x00
    SUBWF temp,w,c
    BZ	OUTPUT_uno
    retlw 0x01
    SUBWF temp,w,c
    BZ	OUTPUT_dos
    retlw 0x02
    SUBWF temp,w,c
    BZ	OUTPUT_tres
    retlw 0x03
    SUBWF temp,w,c
    BZ	OUTPUT_cuatro
OUTPUT_uno:
    retlw	0x1
    MOVWF	PORTD,c
    GOTO	read_code
OUTPUT_dos:
    retlw	0x2
    MOVWF	PORTD,c
    GOTO	read_code
OUTPUT_tres:
    retlw	0x4
    MOVWF	PORTD,c



