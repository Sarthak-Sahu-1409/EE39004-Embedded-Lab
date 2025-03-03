;
; Pull Down Internal.asm
;
; Created: 03-03-2025 14:39:32
; Author : ssart
;


; Replace with your application code
.INCLUDE "M32DEF.INC"
.ORG 0X0000
LDI R16,HIGH(RAMEND)
OUT SPH,R16
LDI R16,LOW(RAMEND)
OUT SPL,R16

SBI DDRC, PINC0      ; Set PINC0 as output (LED control)
CBI DDRB, PINB0      ; Set PINB0 as input (Tactile switch)

LDI R17, 0x01

MAIN: SBI PORTC, PINC0  ; LED initially ON
Loop: IN R16, PINB      ; Read the status of PINB
AND R16, R17           ; Mask PINB0
BREQ MAIN              ; If button is not pressed, keep LED ON
CBI PORTC, PINC0       ; If button is pressed, turn LED OFF
JMP Loop
