;
; SawTooth.asm
;
; Created: 27-01-2025 14:23:05
; Author : ssart
;

// Sawtooth Positive Slope Waveform Generation 
.INCLUDE "M32DEF.INC" 
.ORG 0x0000 
LDI R16,HIGH(RAMEND) 
OUT SPH,R16 
LDI R16,LOW(RAMEND) 
OUT SPL,R16 
LDI R16,0xFF 
OUT DDRC,R16 
LDI R16,0x00 
LOOP: OUT PORTC,R16 
INC R16 
JMP LOOP 
