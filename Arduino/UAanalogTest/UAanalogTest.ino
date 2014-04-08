#include "SPI.h"
#include "Adafruit_WS2801.h"


uint8_t dataPin  = 2;    // Yellow wire on Adafruit Pixels
uint8_t clockPin = 3;    // Green wire on Adafruit Pixels

// Don't forget to connect the ground wire to Arduino ground,
// and the +5V wire to a +5V supply

// Set the first variable to the NUMBER of pixels in a row and
// the second value to number of pixels in a column.
Adafruit_WS2801 strip = Adafruit_WS2801(16,dataPin, clockPin);


int sensorPin = A5;    // 10K OHMS

int sensorValue = 0;  // variable to store the value coming from the sensor

int THRESH = 200;


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
 
Serial.println(sensorValue); 



if(sensorValue < THRESH){
 //RUN WHITE FADE
// Serial.println("RUNNING FADE");  
whiteFade(0); 
}
else{
  for(int i = 0;i < strip.numPixels(); i++){
strip.setPixelColor(i, 255,0,0);
  }
    strip.show();
}

}


void whiteFade(int wait){
  int waitCheck = 0;
  for(int i = 0; i < 255; i++){
 for(int j = 0;j < strip.numPixels(); j++){
    strip.setPixelColor(j, 255,i,i);
 }
 strip.show();
 delay(wait);
  }
  

while(waitCheck < THRESH){
waitCheck = analogRead(sensorPin);
//Serial.print("\t");
Serial.println(waitCheck);
}

    for(int i = 255; i > 0; i--){
  for(int j = 0;j < strip.numPixels(); j++){
      strip.setPixelColor(j, 255,i,i);
  }
 strip.show();
 delay(wait);
  }
  
}
