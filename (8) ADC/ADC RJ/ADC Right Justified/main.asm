;
; ADC Right Justified.asm
;
; Created: 03-03-2025 14:22:30
; Author : ssart
;


; Replace with your application code
/* Analog to Digital conversion with Right Justified and display  
the digital conversion on LED bar graph */ 

.INCLUDE "M32DEF.INC" 
.ORG 0x0000 
//Data direction register of PORTB and PORTD 
LDI R16,0xFF 
OUT DDRB,R16 
OUT DDRD,R16 
//stack declaration 
LDI R16,HIGH(RAMEND) 
OUT SPH,R16 
LDI R16,LOW(RAMEND) 
OUT SPL,R16 
// ADC Initialization 
LDI R16,0x00 
OUT ADMUX,R16 
LDI R16,0xC3 
OUT ADCSRA,R16 
MAIN: SBI ADCSRA,ADSC  
CONV: SBIC ADCSRA,ADSC  
RJMP CONV //Jump over next instruction if portbit clear  
IN R16,ADCL  
//IN R17,ADCH 
OUT PORTB,R16 
OUT PORTD,R17 
JMP MAIN 
