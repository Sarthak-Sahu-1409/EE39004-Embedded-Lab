.INCLUDE "M32DEF.INC"
.ORG 0x0000

LDI R16,HIGH(RAMEND)
OUT SPH,R16
LDI R16,LOW(RAMEND)
OUT SPL,R16

LDI R16,0xFF
OUT DDRC,R16

MAIN:
    LDI R16,0x00
LOOP1:
    OUT PORTC,R16
    INC R16
    BRNE LOOP1

    LDI R16,0x7F
    LDI R17,0x7F
LOOP2:
    OUT PORTC,R16
    INC R17
    BRNE LOOP2

    JMP MAIN
