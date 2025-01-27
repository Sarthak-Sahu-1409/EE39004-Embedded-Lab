;
; Triangle.asm
;
; Created: 27-01-2025 14:43:18
; Author : ssart
;


.INCLUDE "M32DEF.INC"
.ORG 0x0000
LDI R16, 0xFF
OUT DDRC, R16
LDI R16, 0x00     
LDI R17, 0x01      ; Direction: 1 for increment, -1 for decrement

LOOP:
    OUT PORTC, R16 
    ; Update R16 based on direction
    ADD R16, R17  
    ; Reverse direction if limits are reached
    CPI R16, 0xFF  ; If R16 == 0xFF
    BREQ REVERSE   ; Reverse direction
    CPI R16, 0x00  ; If R16 == 0x00
    BREQ REVERSE   ; Reverse direction
    RJMP LOOP      ; Repeat loop
REVERSE:
    NEG R17        ; Reverse direction
    RJMP LOOP

