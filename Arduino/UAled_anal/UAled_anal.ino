#include "FastLED.h"
//This example shows how to use the Mux Shield for analog inputs

#include <MuxShield.h>

//Initialize the Mux Shield
MuxShield muxShield;

// How many leds in your strip?
#define NUM_LEDS 4

// For led chips like Neopixels, which have a data line, ground, and power, you just
// need to define DATA_PIN.  For led chipsets that are SPI based (four wires - data, clock,
// ground, and power), like the LPD8806 define both DATA_PIN and CLOCK_PIN
#define DATA_PIN 11
#define CLOCK_PIN 13

// Define the array of leds
CRGB leds[NUM_LEDS];
CRGB buffer[NUM_LEDS];

int IOAnalogVals[48];

void setup() { 
  //  
//  ADCSRA &= ~((1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0));
//  ADCSRA |= (1 << ADPS2);


  // Uncomment/edit one of the following lines for your leds arrangement.
  // FastLED.addLeds<TM1803, DATA_PIN, RGB>(leds, NUM_LEDS);
  // FastLED.addLeds<TM1804, DATA_PIN, RGB>(leds, NUM_LEDS);
  // FastLED.addLeds<TM1809, DATA_PIN, RGB>(leds, NUM_LEDS);
  // FastLED.addLeds<WS2811, DATA_PIN, RGB>(leds, NUM_LEDS);
  // FastLED.addLeds<WS2812, DATA_PIN, RGB>(leds, NUM_LEDS);
  // FastLED.addLeds<WS2812B, DATA_PIN, RGB>(leds, NUM_LEDS);
  //  	  FastLED.addLeds<NEOPIXEL, DATA_PIN>(leds, NUM_LEDS);
  // FastLED.addLeds<UCS1903, DATA_PIN, RGB>(leds, NUM_LEDS);
  // FastLED.addLeds<UCS1903B, DATA_PIN, RGB>(leds, NUM_LEDS);
  // FastLED.addLeds<GW6205, DATA_PIN, RGB>(leds, NUM_LEDS);
  // FastLED.addLeds<GW6205_400, DATA_PIN, RGB>(leds, NUM_LEDS);

//  FastLED.addLeds<WS2801, RGB>(leds, NUM_LEDS);

FastLED.addLeds<LPD8806, RGB>(leds, NUM_LEDS);

//FastLED.addLeds<WS2801, DATA_PIN, CLOCK_PIN, RGB>(leds, NUM_LEDS);
  // FastLED.addLeds<SM16716, DATA_PIN, CLOCK_PIN, RGB>(leds, NUM_LEDS);
  // FastLED.addLeds<LPD8806, DATA_PIN, CLOCK_PIN, RGB>(leds, NUM_LEDS);

  //Set I/O 1, I/O 2, and I/O 3 as analog inputs
  muxShield.setMode(1,ANALOG_IN);
  muxShield.setMode(2,ANALOG_IN);
  muxShield.setMode(3,ANALOG_IN);

  Serial.begin(115200);
}

//on micro w/ LPD8806
int onDelay = 200; //128
int offDelayMicro = 500; //25

//on UNO w/ ws2801
//int onDelay = 128;
//int offDelayMicro = 1;

int k = 0;
int j = 0;  
int i = 0;
int startTime = 0;

void loop() { 


  
  for (j=0; j < 256 * 5; j++) {     // 5 cycles of all 25 colors in the wheel
  
  startTime = millis();
  
    for (i=0; i < NUM_LEDS; i++) {
      // tricky math! we use each pixel as a fraction of the full 96-color wheel
      // (thats the i / strip.numPixels() part)
      // Then add in j which makes the colors go around per pixel
      // the % 96 is to make the wheel cycle around
//      leds[i] = Wheel( ((i * 256 / NUM_LEDS) + j) % 256);
      leds[i] = Color(255,255,255);
//      leds[i] = Color(0,0,0);
      buffer[i] = leds[i];
    }  
    FastLED.show();   // write all the pixels out

    delay(onDelay);


memset(leds,0,3*NUM_LEDS);
FastLED.show();
delayMicroseconds(offDelayMicro);

//    for(k = 0; k < 16; k++){
//      leds[k] = Color(0,0,0);
//      FastLED.show(); 
//      delayMicroseconds(offDelayMicro);  
//      IOAnalogVals[k] = muxShield.analogReadMS(1,k);
//      leds[k] = buffer[k];
//      FastLED.show(); 
//    }
//    for(k = 0; k < 16; k++){
//      leds[k+16] = Color(0,0,0);
//      FastLED.show(); 
//      delayMicroseconds(offDelayMicro);
//      IOAnalogVals[k+16] = muxShield.analogReadMS(2,k);
//      leds[k+16] = buffer[k+16];
//      FastLED.show(); 
//    }
//    for(k = 0; k < 16; k++){
//      leds[k+32] = Color(0,0,0);
//      FastLED.show(); 
//      delayMicroseconds(offDelayMicro);
//      IOAnalogVals[k+32] = muxShield.analogReadMS(3,k);
//      leds[k+32] = buffer[k+32];
//      FastLED.show(); 
//    }

//sendSerialData();

//Serial.println(millis()-startTime);

Serial.print(analogRead(0));
Serial.print("\t");
Serial.println(analogRead(1));
  }


}

/* Helper functions */
int i_ = 0;
void sendSerialData(){
  
  Serial.println("START");
  for(i_ = 0; i_ < 48; i_++){
//   Serial.print(i_);
// Serial.print(" : ");
   Serial.println(IOAnalogVals[i_]);
    
  }
  
}

// Create a 24 bit color value from R,G,B
uint32_t Color(byte r, byte g, byte b)
{
  uint32_t c;
  c = r;
  c <<= 8;
  c |= g;
  c <<= 8;
  c |= b;
  return c;
}

//Input a value 0 to 255 to get a color value.
//The colours are a transition r - g -b - back to r
uint32_t Wheel(byte WheelPos)
{
  if (WheelPos < 85) {
    return Color(WheelPos * 3, 255 - WheelPos * 3, 0);
  } 
  else if (WheelPos < 170) {
    WheelPos -= 85;
    return Color(255 - WheelPos * 3, 0, WheelPos * 3);
  } 
  else {
    WheelPos -= 170; 
    return Color(0, WheelPos * 3, 255 - WheelPos * 3);
  }
}


