#include "SPI.h"
#include "Adafruit_WS2801.h"


uint8_t dataPin  = 2;    // Yellow wire on Adafruit Pixels
uint8_t clockPin = 3;    // Green wire on Adafruit Pixels

// Don't forget to connect the ground wire to Arduino ground,
// and the +5V wire to a +5V supply

// Set the first variable to the NUMBER of pixels in a row and
// the second value to number of pixels in a column.
Adafruit_WS2801 strip = Adafruit_WS2801(2,dataPin, clockPin);


int sensorPin = A0;    // 10K OHMS
int sensorPin2 = A1;    // 30K OHMS
int sensorPin3 = A2;    // 47K OHMS
int sensorPin5 = A5;    // 47K OHMS

int sensorValue = 0;  // variable to store the value coming from the sensor
int sensorValue2 = 0;  // variable to store the value coming from the sensor
int sensorValue3 = 0;  // variable to store the value coming from the sensor
int sensorValue5 = 0;  // variable to store the value coming from the sensor

int THRESH = 1;


void setup() {
  // declare the ledPin as an OUTPUT:
  Serial.begin(9600);
  pinMode(13, OUTPUT);  
    strip.begin();

  // Update LED contents, to start they are all 'off'
  strip.show();
}

void loop() {
  // read the value from the sensor:
  sensorValue = analogRead(sensorPin); 

 sensorValue2 = analogRead(sensorPin2);
 
  sensorValue3 = analogRead(sensorPin3);
  
    sensorValue5 = analogRead(sensorPin5);
 
Serial.print(sensorValue); 
  Serial.print("\t");
  Serial.print(sensorValue2); 
  Serial.print("\t");
  Serial.print(sensorValue3); 
   Serial.print("\t");
  Serial.println(sensorValue5);   



if(sensorValue < THRESH){
 //RUN WHITE FADE
// Serial.println("RUNNING FADE");  
whiteFade(2); 
}
else{
strip.setPixelColor(0, 255,0,0);
strip.setPixelColor(1, 255,0,0);
    strip.show();
}

}


void whiteFade(int wait){
  int waitCheck = 0;
  for(int i = 0; i < 255; i++){
 strip.setPixelColor(0, 255,i,i);
  strip.setPixelColor(1, 255,i,i);
 strip.show();
 delay(wait);
  }
  

while(waitCheck < THRESH){
waitCheck = analogRead(sensorPin);
Serial.print("\t");
Serial.println(waitCheck);
}

    for(int i = 255; i > 0; i--){
 strip.setPixelColor(0, 255,i,i);
  strip.setPixelColor(1, 255,i,i);
 strip.show();
 delay(wait);
  }
  
}
