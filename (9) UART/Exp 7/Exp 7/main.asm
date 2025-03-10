;
; Exp 7.asm
;
; Created: 10-03-2025 14:47:52
; Author : ssart
;


; Replace with your application code
.INCLUDE "M32DEF.INC" 
.ORG 0x0000 
JMP MAIN 
.ORG 0x001C 
JMP Tx_Data 
MAIN: LDI R16,HIGH(RAMEND) 
OUT SPH,R16 
LDI R16,LOW(RAMEND) 
OUT SPL,R16 
//Data Direction Register for transmitter 
SBI DDRD,PIND1 
//UART Initialization 
LDI R16,0x28 
OUT UCSRB,R16 
LDI R16,0x86 
OUT UCSRC,R16 
LDI R16,51 
OUT UBRRL,R16 
SEI 
LDI R17,0x00 
Infinite_Loop: NOP 
JMP Infinite_Loop 
Tx_Data: 
OUT UDR,R17 
INC R17 
RETI 