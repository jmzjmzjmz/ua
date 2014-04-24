#include <MuxShield.h>

//Initialize the Mux Shield
MuxShield muxShield;




// char addr[2] = {'0', 32}; //make sure this contains a space after it, 0 - 7
// String addr = "0 ";
const int row1 = 9;
const int row2 = 9;
const int row3 = 9;
const int row4 = 9;

const int DELAY = 1;

const int numReadings = 14; //number of readings to average, helps smooth value





const int numChannels = 48;

int myInts[numChannels];

int readings[numChannels][numReadings];      // the readings from the analog input
int index[numChannels];                  // the index of the current reading
int total[numChannels];                  // the running total
int average[numChannels];                // the average

// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(115200);

  //initialize values
  for (int thisVal = 0; thisVal < numChannels; thisVal++){
    for (int thisReading = 0; thisReading < numReadings; thisReading++){
      readings[thisVal][thisReading] = 0;        
    }
  }

  //Set I/O 1, I/O 2, and I/O 3 as analog inputs
  muxShield.setMode(1,ANALOG_IN);
  muxShield.setMode(2,ANALOG_IN);
  muxShield.setMode(3,ANALOG_IN);

}


int chan = 0;

// the loop routine runs over and over again forever:
void loop() {

Serial.print("3 ");

  //iterate through all 48 channels
  for(chan = 0; chan < numChannels; chan++){

    //conditions to skip channels
    if(chan == 14 || chan == 15 || chan == 46 || chan == 47 || 
      (chan >= row1 && chan < 11) ||

      (chan >= row2+11 && chan < 14) || 
      (chan >= row2+13 && chan < 24) || 

      (chan >= row3+24 && chan < 35) || 

      (chan >= row4+35 && chan < 46)){
      continue;
    }

    // subtract the last reading:
    total[chan]= total[chan] - readings[chan][index[chan]];       
    // read from the sensor:  
    if(chan < 16){
      readings[chan][index[chan]] = muxShield.analogReadMS(1,chan);
    }
    else if(chan < 32){
      readings[chan][index[chan]] = muxShield.analogReadMS(2,chan-16);
    }
    else if(chan < 48){
      readings[chan][index[chan]] = muxShield.analogReadMS(3,chan-32);
    }
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

    //send serial data
Serial.print(average[chan]);
Serial.print(" ");  

  }

  Serial.println();// terminate packet

  delay(DELAY); //delay if necessary



}


