;
; LED Blinking Assembly Code.asm
;
; Created: 12-01-2025 20:38:51
; Author : ssart
;


; Replace with your application code

// LED Blink Assembly Code 
.INCLUDE "M32DEF.INC" 
.ORG 0 
SBI DDRB,PINB0 
 
LDI R16, HIGH(RAMEND) 
OUT SPH,R16 
LDI R16, LOW(RAMEND) 
OUT SPL, R16 
 
MAIN: SBI PORTB,PINB0 
  CALL Delay 
  CBI PORTB,PINB0 
  CALL Delay 
  JMP MAIN 
 
Delay: 
  LDI R16,0xFF //Loop 1 
 L1: LDI R17,0xFF // Loop 2 
 L2: LDI R18,0x07 // Loop 3 
 L3: NOP 
  DEC R18 
  BRNE L3 //Loop 3 End 
  DEC R17 
  BRNE L2 //Loop 2 End 
  DEC R16 
  BRNE L1 // Loop 1 End 
  RET 
