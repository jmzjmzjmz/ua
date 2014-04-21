#include <MuxShield.h>
#include "FastLED.h"

// How many leds in your strip?
#define NUM_LEDS 10
#define DATA_PIN 11
#define CLOCK_PIN 13

//Initialize the Mux Shield
MuxShield muxShield;

CRGB leds[NUM_LEDS];

const int numReadings = 15;

const int numChannels = 10;
int myInts[numChannels];

int readings[numChannels][numReadings];      // the readings from the analog input
int index[numChannels];                  // the index of the current reading
int total[numChannels];                  // the running total
int average[numChannels];                // the average

int theThreshold = 100;
int THRESH[numChannels] = {
  210,260,250,290,270,300,350,320,320,290 };                // the threshold--- animate to white if dropping below

int frameCount[numChannels];
boolean isAnimating[numChannels];
int maxFrames = 250;

// the setup routine runs once when you press reset:
void setup() {
  FastLED.addLeds<WS2801, RGB>(leds, NUM_LEDS);
  // initialize serial communication at 9600 bits per second:
  Serial.begin(115200);

  for (int thisVal = 0; thisVal < numChannels; thisVal++){
    for (int thisReading = 0; thisReading < numReadings; thisReading++){
      readings[thisVal][thisReading] = 0;        
    }
THRESH[thisVal] = theThreshold;
    frameCount[thisVal] = 0;
    isAnimating[thisVal] = false;
  }


  //Set I/O 1, I/O 2, and I/O 3 as analog inputs
  muxShield.setMode(1,ANALOG_IN);
  //muxShield.setMode(2,ANALOG_IN);
  //muxShield.setMode(3,ANALOG_IN);
  
  // calibrate(0,5000);

}


int chan = 0;

// the loop routine runs over and over again forever:
void loop() {

  // read the input on analog pin 0:
  for(chan = 0; chan < numChannels; chan++){
    

takeAvg(chan,true);




   if((average[chan] < THRESH[chan]) && !isAnimating[chan]){
      //START ANIMATION
      frameCount[chan] = 0;
      isAnimating[chan] = true;
    }



    if(isAnimating[chan] && (frameCount[chan] < maxFrames)){
      leds[chan].r = 255;
      leds[chan].g = map(frameCount[chan],0,maxFrames,0,255);
      leds[chan].b = map(frameCount[chan],0,maxFrames,0,255);
      frameCount[chan]++;  
    }
    else if(average[chan]<THRESH[chan] && frameCount[chan] == maxFrames){
     //hold white
    leds[chan].r = 255;
      leds[chan].g = 255;
      leds[chan].b = 255;
     
    }

    else if((average[chan] > THRESH[chan]) && frameCount[chan] == maxFrames )  {
      isAnimating[chan] = false; 
      leds[chan].r = 255;
      leds[chan].g =0;
      leds[chan].b = 0; 
    }
        


  }


  Serial.println();
  FastLED.show();

}

void takeAvg(int channel, bool debug){
// subtract the last reading:
    total[chan]= total[chan] - readings[chan][index[chan]];       
    
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

if(debug){
      Serial.print(average[chan]);
    Serial.print("\t");
  }
}


// void calibrate(int channel, int duration){
//   int startTime = millis();

//   while(millis()-startTime < duration){
//   takeAvg(chan,false);
// }



// adjust threshold here



// }



