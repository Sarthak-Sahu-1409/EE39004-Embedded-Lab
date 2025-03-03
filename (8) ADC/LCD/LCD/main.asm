;
; LCD.asm
;
; Created: 03-03-2025 16:00:15
; Author : ssart
;


; Replace with your application code
Experiment4: /* Print ADC data on LCD. Oscillator frequency=8MHz*/ 
 
.INCLUDE "M32DEF.INC" 
.ORG 0x0000 
 
LDI R16,HIGH(RAMEND) 
OUT SPH,R16 
LDI R16,LOW(RAMEND) 
OUT SPL,R16 
 
MAIN: //Data Direction Register of LCD 
  LDI R16,0xFF 
  OUT DDRB,R16 
  SBI DDRD,PIND4 //Falling Edged Enable 
  SBI DDRD,PIND5 //Register Select 
 
  // LCD Initialization 
  CBI PORTD,PIND5 // Command Register Enable 
  LDI R16,0x38 //2 lines and 5x7 matrix  
  OUT PORTB,R16 
  CALL ENABLE 
  LDI R16,0x02 // Return Home 
  OUT PORTB,R16 
  CALL ENABLE 
  LDI R16,0x01 // Clear display screen 
  OUT PORTB,R16 
  CALL ENABLE 
  LDI R16,0x0C //Display on, cursor off 
  OUT PORTB,R16 
  CALL ENABLE 
  LDI R16,0x06 // Shift Cursor to right after print on LCD 
  OUT PORTB,R16 
  CALL ENABLE 
  //Set Cursor Coordinate 
  LDI R16,0x80 //Set Cursor at beginning of 1st Line  
  OUT PORTB,R16 
  CALL ENABLE 
 
  //ADC Initialization 
  LDI R16,0x00 
  OUT ADMUX,R16 
  LDI R16,0xC3 
  OUT ADCSRA,R16 
 
  Infinite_Loop: SBI ADCSRA,ADSC 
      ADC_CONV: SBIC ADCSRA,ADSC 
         RJMP ADC_CONV 
      IN R24,ADCL  
      IN R25,ADCH 
 
      //Digit separation to print on LCD 
      LDI R21,0 
      LOOP_Digit3: INC R21 
        LDI R23,19 
      THOUSAND: SBIW R25:R24,50 
        DEC R23 
        BRNE THOUSAND 
        SBIW R25:R24,50 
        BRPL LOOP_Digit3 
      DEC R21 
      LDI R23,20 
      THOUSAND_ADD: ADIW R25:R24,50 
        DEC R23 
        BRNE THOUSAND_ADD 
      LDI R19,0 
      LOOP_Digit2: INC R19 
        SBIW R25:R24,50 
        SBIW R25:R24,50 
        BRPL LOOP_Digit2 
      DEC R19 
      ADIW R25:R24,50 
      ADIW R25:R24,50 
 
      LDI R20,0 
      LOOP_Digit1: INC R20 
        SBIW R25:R24,10 
        BRPL LOOP_Digit1 
      DEC R20 
      ADIW R25:R24,10 
 
      //Digit to Ascii Digit conversion 
      LDI R22,48 
      ADD R21,R22 
      ADD R19,R22 
      ADD R20,R22 
      ADD R24,R22 
 
      //Clear LCD Screen 
      CBI PORTD,PIND5 
      LDI R16,0x01 // Clear display screen 
      OUT PORTB,R16 
      CALL ENABLE 
      //Print on LCD 
      SBI PORTD,PIND5 
      OUT PORTB,R21
      CALL ENABLE 
      OUT PORTB,R19 
      CALL ENABLE 
      OUT PORTB,R20 
      CALL ENABLE 
      OUT PORTB,R24 
      CALL ENABLE 
      //Wait for few times 
      CALL DELAY 
      JMP Infinite_Loop 
       
 
ENABLE:  SBI PORTD,PIND4 
       LDI R18,0xFF 
   LOOP2_EN:  LDI R17,0x00 
      LOOP1_EN: NOP 
       DEC R17 
       BRNE LOOP1_EN 
      DEC R18 
      BRNE LOOP2_EN 
   CBI PORTD,PIND4 
   RET 
 
DELAY:   LDI R16,0x0F 
LOOP3_DL:  LDI R18,0xFF 
   LOOP2_DL: LDI R17,0xFF 
     LOOP1_DL: NOP 
       DEC R17 
       BRNE LOOP1_DL 
     DEC R18 
     BRNE LOOP2_DL 
   DEC R16 
   BRNE LOOP3_DL 
   RET 