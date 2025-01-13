;
; 7 Segment Display 2.asm
;
; Created: 13-01-2025 15:02:00
; Author : ssart
;
// Road Traffic  Signaling 
.INCLUDE "M32DEF.INC" 
.ORG 0X0000 
LDI R16,HIGH(RAMEND) 
OUT SPH,R16 
LDI R16,LOW(RAMEND) 
OUT SPL,R16 
LDI R16,0x3F //Seven Segment Bits for 0 
MOV R0,R16 
LDI R16,0x06 //Seven Segment Bits for 1 
MOV R1,R16 
LDI R16,0x5B //Seven Segment Bits for 2 
MOV R2,R16 
LDI R16,0x4F //Seven Segment Bits for 3 
MOV R3,R16 
LDI R16,0x66 //Seven Segment Bits for 4 
MOV R4,R16 
LDI R16,0x6D //Seven Segment Bits for 5 
MOV R5,R16 

LDI R16,0x7D //Seven Segment Bits for 6 
 
MOV R6,R16 
 
LDI R16,0x07 //Seven Segment Bits for 7 
MOV R7,R16 
 
LDI R16,0x7F //Seven Segment Bits for 8 
MOV R8,R16 
 
LDI R16,0x6F //Seven Segment Bits for 9 
MOV R9,R16 
 
LDI R16,0XFF 
OUT DDRA,R16 //For 7 Segment Display 
 
LDI R16,0x03 
OUT DDRC,R16 //For Signaling LEDs 
 
LDI R27,0x00; // XH of the register pair X  
LDI R26,0x0A; // XL of the register pair X 
 
MAIN: SBI PORTC,PINC0 
  CBI PORTC,PINC1 
MLOOP1: LD R16,-X 
  OUT PORTA,R16 
  CALL Delay 
  CPI R26,0X00 
  BRNE MLOOP1 
  LDI R26,0x0A 
 
  CBI PORTC,PINC0 
  SBI PORTC,PINC1 
MLOOP2: LD R16,-X 
  OUT PORTA,R16 
  CALL Delay 
  CPI R26,0X00 
  BRNE MLOOP2 
  LDI R26,0x0A 
  JMP MAIN 
 
Delay: LDI R17,0xFF 
  L1: LDI R18,0xFF 
  L2: LDI R19,0x04 

L3: NOP 
DEC R19 
BRNE L3 
DEC R18 
BRNE L2 
DEC R17 
BRNE L1 
RET