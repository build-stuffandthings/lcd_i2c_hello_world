#include <LiquidCrystal_I2C.h>
#include <Wire.h>

// Set the LCD address to 0x27 for a 16 chars and 2 line display
LiquidCrystal_I2C lcd(0x27, 20, 4);

void setup()
{
  Serial.begin(115200);
  Wire.begin(2, 0);
  // initialize the LCD
  lcd.begin();

  lcd.home();
  lcd.print("Hello, World!");

}

void loop()
{
  // do nothing here
}
