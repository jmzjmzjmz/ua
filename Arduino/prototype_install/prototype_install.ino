#include <MuxShield.h>
#include "FastLED.h"

// How many leds in your strip?
#define NUM_LEDS 10

//Initialize the Mux Shield
MuxShield muxShield;

CRGB leds[NUM_LEDS];

const int numReadings = 10;

const int numChannels = 10;
int myInts[numChannels];

int readings[numChannels][numReadings];      // the readings from the analog input
int index[numChannels];                  // the index of the current reading
int total[numChannels];                  // the running total
int average[numChannels];                // the average

// the setup routine runs once when you press reset:
void setup() {
  FastLED.addLeds<WS2801, RGB>(leds, NUM_LEDS);
  // initialize serial communication at 9600 bits per second:
  Serial.begin(115200);

  for (int thisVal = 0; thisVal < numChannels; thisVal++){
    for (int thisReading = 0; thisReading < numReadings; thisReading++){
      readings[thisVal][thisReading] = 0;        
    }
  }

   //Set I/O 1, I/O 2, and I/O 3 as analog inputs
    muxShield.setMode(1,ANALOG_IN);
//muxShield.setMode(2,ANALOG_IN);
//muxShield.setMode(3,ANALOG_IN);

}

//Arrays to store analog values after recieving them
//int IO1AnalogVals[16];
// int IO2AnalogVals[16];
// int IO3AnalogVals[16];

int chan = 0;

// the loop routine runs over and over again forever:
void loop() {
  
  

//  Serial.println("START");
  // read the input on analog pin 0:
  for(chan = 0; chan < numChannels; chan++){
    leds[chan] =CRGB::Red;
    // subtract the last reading:
  total[chan]= total[chan] - readings[chan][index[chan]];       
//  Serial.println("test");
  // read from the sensor:  
  if(chan < 16){
  readings[chan][index[chan]] = muxShield.analogReadMS(1,chan);//analogRead(inputPin[chan]);
  }
//  else if(chan < 32){
//  readings[chan][index[chan]] = muxShield.analogReadMS(2,chan-16);//analogRead(inputPin[chan]);
//  }
//  else if(chan < 48){
//  readings[chan][index[chan]] = muxShield.analogReadMS(3,chan-32);//analogRead(inputPin[chan]);
//  }
  // add the reading to the total:
  total[chan]= total[chan] + readings[chan][index[chan]];       
  // advance to the next position in the array:  
  index[chan]++;                    

  // if we're at the end of the array...
  if (index[chan] >= numReadings){           
    index[chan] = 0;                           
}

  // calculate the average:
  average[chan] = total[chan] / numReadings;         
  // send it to the computer as ASCII digits
  
  }
  
  FastLED.show();

}


