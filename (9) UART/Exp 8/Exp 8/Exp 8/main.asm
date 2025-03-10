;
; Exp 8.asm
;
; Created: 10-03-2025 15:00:45
; Author : ssart
;


; Replace with your application code
.INCLUDE "M32DEF.INC" 
.ORG 0x0000 
LDI R16,HIGH(RAMEND) 
OUT SPH,R16 
LDI R16,LOW(RAMEND) 
OUT SPL,R16 
//Data Direction Register Initialization 
CBI DDRD,PIND0 // PORTD0 as Input Pin 
SBI PORTD,PIND0 //Enabling internal Pull-up register 
LDI R16,0xFF 
OUT DDRC,R16 // PORTC as data receive status pins 
// UART Initialization 
LDI R16,0x10 
OUT UCSRB,R16 
LDI R16,0x86 
OUT UCSRC,R16 
LDI R16,51 
OUT UBRRL,R16 
AGAIN:  
SBIS UCSRA,RXC 
RJMP AGAIN 
IN R17,UDR 
OUT PORTC,R17 
RJMP AGAIN 