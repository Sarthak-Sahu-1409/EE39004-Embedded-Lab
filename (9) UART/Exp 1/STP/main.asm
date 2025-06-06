;
; STP.asm
;
; Created: 10-03-2025 14:24:32
; Author : ssart
;


; Replace with your application code
.INCLUDE "M32DEF.INC" 
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
LDI R16,0x86 
OUT UCSRC,R16 
LDI R16,0x00 
OUT UBRRH,R16 
LDI R16,0x33 
OUT UBRRL,R16 
AGAIN:  
SBIS UCSRA, UDRE 
RJMP AGAIN 
LDI R16,'A' 
OUT UDR,R16 
RJMP AGAIN 
