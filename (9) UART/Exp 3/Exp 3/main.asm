; Exp 2.asm
;
; Created: 10-03-2025 14:33:17
; Author : ssart
;


; Replace with your application code
.INCLUDE "M32DEF.INC" 
.ORG 0x0000 
LDI R16,HIGH(RAMEND) 
OUT SPH,R16 
LDI R16,LOW(RAMEND) 
OUT SPL,R16 
// Tx Rx pins Data Direction Register 
CBI DDRD,PIND0 // Set Rx as Input Pin 
SBI PORTD,PIND0 //Enable Internal Pull-Up Register 
SBI DDRD,PIND1 // Set Tx as Output Pin 
SBI PORTD,PIND1 
LDI R16,(1<<TXEN) //Enable Transmitter 
OUT UCSRB,R16 
LDI R17,0xAE 
OUT UCSRC,R17 
LDI R16,0x33 
OUT UBRRL,R16 
AGAIN:  
SBIS UCSRA, UDRE 
RJMP AGAIN 
LDI R16,0b11110111 
OUT UDR,R16 
RJMP AGAIN 