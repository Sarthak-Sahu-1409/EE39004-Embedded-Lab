.INCLUDE "M32DEF.INC" 
.ORG 0x0000 

; Initialize I/O
LDI R16,0xFF 
OUT DDRB,R16 
OUT DDRD,R16 

; Initialize stack pointer
LDI R16,HIGH(RAMEND) 
OUT SPH,R16 
LDI R16,LOW(RAMEND) 
OUT SPL,R16 

; Initialize ADC
LDI R16,(1<<ADLAR) 
OUT ADMUX,R16 
LDI R16,0x87 
OUT ADCSRA,R16 

; Initialize filter delay line
LDI R16, 0
MOV R8, R16
MOV R9, R16
MOV R10, R16
MOV R11, R16
MOV R12, R16
MOV R13, R16

MAIN: 
    ; Start ADC conversion
    SBI ADCSRA, ADSC  
CONV: 
    SBIC ADCSRA, ADSC  
    RJMP CONV 

    ; Shift delay line
    MOV R13, R12
    MOV R12, R11
    MOV R11, R10
    MOV R10, R9
    MOV R9, R8

    ; Read ADC result
    IN R16, ADCL  
    IN R17, ADCH 
    MOV R8, R17   ; Store new sample in delay line

    ; Clear accumulator register
    LDI R20, 0    ; Use R20 as accumulator

    ; Process coefficient -11 with R13
    LDI R16, 5  ; Load absolute value
    MUL R13, R16  ; Unsigned multiplication
    NEG R1        ; Negate high byte (for negative coefficient)
    ADD R20, R1
    CLR R0
    CLR R1

    ; Process coefficient -24 with R12
    LDI R16, 20
    MUL R12, R16
    NEG R1
    ADD R20, R1
    CLR R0
    CLR R1

    ; Process coefficient -80 with R11
    LDI R16, 79
    MUL R11, R16
    NEG R1
    ADD R20, R1
    CLR R0
    CLR R1

    ; Process coefficient 80 with R10
    LDI R16, 79
    MUL R10, R16
    ADD R20, R1
    CLR R0
    CLR R1

    ; Process coefficient 24 with R9
    LDI R16, 20
    MUL R9, R16
    ADD R20, R1
    CLR R0
    CLR R1

    ; Process coefficient 11 with R8
    LDI R16, 5
    MUL R8, R16
    ADD R20, R1
    CLR R0
    CLR R1

    ; Add DC offset (128) to center output in 0-5V range
    SUBI R20, -128

    ; Output the result
    OUT PORTB, R20

    ; Delay and repeat
    ;RCALL DELAY
    RJMP MAIN

DELAY:
    LDI R25, 1
Outer_Loop:
    LDI R26, 1
Inner_Loop:
    NOP     
    DEC R26
    BRNE Inner_Loop
    
    DEC R25    
    BRNE Outer_Loop  
    RET
