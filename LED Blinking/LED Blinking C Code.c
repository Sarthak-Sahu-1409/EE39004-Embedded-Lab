//C code for LED Blink 

#include <avr/io.h> 
#define F_CPU 1000000L 
#include <util/delay.h> 
int main(void) 
{ 
DDRB=0xFF; //DDRB=0X01; 
/* Replace with your application code */ 
while (1)  
{ 
    PORTB=0xFF; //PORTB=0X01; 
    _delay_ms(500); 
    PORTB=0X00; 
    _delay_ms(500); 
} 
} 