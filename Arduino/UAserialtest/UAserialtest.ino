#include <MuxShield.h>

//Initialize the Mux Shield
MuxShield muxShield;


const int numReadings = 10;

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
 // subtract the last reading:
  total[chan]= total[chan] - readings[chan][index[chan]];       
//  Serial.println("test");
  // read from the sensor:  
  if(chan < 16){
  readings[chan][index[chan]] = muxShield.analogReadMS(1,chan);//analogRead(inputPin[chan]);
  }
  else if(chan < 32){
  readings[chan][index[chan]] = muxShield.analogReadMS(2,chan-16);//analogRead(inputPin[chan]);
  }
  else if(chan < 48){
  readings[chan][index[chan]] = muxShield.analogReadMS(3,chan-32);//analogRead(inputPin[chan]);
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
  // send it to the computer as ASCII digits
  if(chan == 0){
  Serial.print(988); 
  }
  else if(chan == 47){
  Serial.print(13);
  }
  else{
  Serial.print(average[chan]); 
  }  
  Serial.print(" ");
  if(chan == numChannels - 1){
   Serial.println(); 
  }
  else{
  Serial.print(" ");
  }
  
// Serial.print("\t");

// delay(300);

//    myInts[i] = analogRead(inputPin);
//
//    Serial.println(myInts[i]);




  }
  
  
//  Serial.print(0x03);


}


