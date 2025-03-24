;
; FIR.asm
;
; Created: 24-03-2025 14:11:07
; Author : ssart
;


; Replace with your application code
.INCLUDE "M32DEF.INC"
.ORG 0x0000

LDI R16, 0xFF
OUT DDRB, R16

LDI R16, HIGH(RAMEND)
OUT SPH, R16
LDI R16, LOW(RAMEND)
OUT SPL, R16

LDI R16, 0x21  
OUT ADMUX, R16
LDI R16, 0x87  
OUT ADCSRA, R16

LDI R22, 0x08
LDI R23, 0x0A
LDI R24, 0x0B
LDI R25, 0x0B
LDI R26, 0x0A
LDI R27, 0x08

CLR R10  
CLR R11  
CLR R12  
CLR R13  
CLR R14  

MAIN:
    SBI ADCSRA, ADSC      

CONV:
    SBIC ADCSRA, ADSC    
    RJMP CONV

    IN R19, ADCH          
    ;LSR R19              

    CLR R20              
    CLR R21              

    MUL R22, R19
    ADD R20, R1

    MUL R23, R10
    ADD R20, R1

    MUL R24, R11
    ADD R20, R1

    MUL R25, R12
    ADD R20, R1

    MUL R26, R13
    ADD R20, R1

    MUL R27, R14
    ADD R20, R1

    ;LSR R20
    ;LSR R20  

    OUT PORTB, R20        

    MOV R14, R13
    MOV R13, R12
    MOV R12, R11
    MOV R11, R10
    MOV R10, R19          

    ;CALL DELAY  

    JMP MAIN              

DELAY:
    LDI R30, 255
L1: LDI R31, 255
L2: DEC R31
    BRNE L2
    DEC R30
    BRNE L1
    RET
