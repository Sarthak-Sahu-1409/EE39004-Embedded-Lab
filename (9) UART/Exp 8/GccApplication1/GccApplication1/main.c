#include <Wire.h>
#include <LiquidCrystal_I2C.h>

#define LCD_ADDR 0x27   // I2C address (change if necessary)
LiquidCrystal_I2C lcd(LCD_ADDR, 16, 2);

const int timerPin = 2;  // 555 Timer output connected to Arduino digital pin 2
const int buttonPin = 3; // Push button input

volatile int pulseCount = 0;
unsigned long lastTime = 0;
float frequency = 0.0;

void IRAM_ATTR countPulse() {
	pulseCount++;
}

void setup() {
	pinMode(timerPin, INPUT);
	pinMode(buttonPin, INPUT_PULLUP);

	attachInterrupt(digitalPinToInterrupt(timerPin), countPulse, RISING);

	lcd.init();
	lcd.backlight();
	lcd.setCursor(0, 0);
	lcd.print("Freq Monitor");
}

void loop() {
	unsigned long currentTime = millis();
	
	if (currentTime - lastTime >= 1000) { // Measure every second
		frequency = pulseCount;
		pulseCount = 0;
		lastTime = currentTime;

		lcd.setCursor(0, 1);
		lcd.print("Freq: ");
		lcd.print(frequency);
		lcd.print(" Hz    "); // Extra spaces to clear old values
	}
}