/* Buttons to USB Keyboard Example

   You must select Keyboard from the "Tools > USB Type" menu

   This example code is in the public domain.
*/

#include <Bounce.h>
#include <Encoder.h>


// Create Bounce objects for each button.  The Bounce object
// automatically deals with contact chatter or "bounce", and
// it makes detecting changes very simple.
Bounce button0 = Bounce(0, 10);
Bounce button1 = Bounce(1, 10);  // 10 = 10 ms debounce time
Bounce button2 = Bounce(2, 10);  // which is appropriate for
Bounce button3 = Bounce(7, 10);  // most mechanical pushbuttons
Bounce button4 = Bounce(8, 10);
Bounce button5 = Bounce(14, 10);  // if a button is too "sensitive"
Bounce button6 = Bounce(15, 10);  // to rapid touch, you can
Bounce button7 = Bounce(16, 10);  // increase this time.
Bounce button8 = Bounce(17, 10);  // increase this time.

Bounce button9 = Bounce(19, 10);  // increase this time.


const int ledPins[9] = {3,4,5,6,9,10,20,21,22};

int ledStatus[9] = {0,0,0,0,0,0,0,0,0};
bool ledBool[9] = {0,0,0,0,0,0,0,0,0};

int pulseCurve [] = {1, 1, 2, 3, 5, 8, 11, 15, 20, 25, 30, 36, 43, 49, 56, 64, 72, 80, 88, 97, 105, 114, 123, 132, 141, 150, 158, 167, 175, 183, 191, 199, 206, 212, 219, 225, 230, 235, 240, 244, 247, 250, 252, 253, 254, 255, 254, 253, 252, 250, 247, 244, 240, 235, 230, 225, 219, 212, 206, 199, 191, 183, 175, 167, 158, 150, 141, 132, 123, 114, 105, 97, 88, 80, 72, 64, 56, 49, 43, 36, 30, 25, 20, 15, 11, 8, 5, 3, 2, 1, 0};
int counter = 0;

Encoder myEnc(11, 12);

long oldPosition  = 0;

void setup() {
  Serial.begin(9600);
  
  pinMode(0, INPUT_PULLUP);
  pinMode(1, INPUT_PULLUP);
  pinMode(2, INPUT_PULLUP);
  pinMode(7, INPUT_PULLUP);
  pinMode(8, INPUT_PULLUP);
  pinMode(14, INPUT_PULLUP);
  pinMode(15, INPUT_PULLUP);  
  pinMode(16, INPUT_PULLUP);
  pinMode(17, INPUT_PULLUP);
  pinMode(19, INPUT_PULLUP);
  
pinMode(ledPins[0], OUTPUT);
pinMode(ledPins[1], OUTPUT);
pinMode(ledPins[2], OUTPUT);
pinMode(ledPins[3], OUTPUT);
pinMode(ledPins[4], OUTPUT);
pinMode(ledPins[5], OUTPUT);
pinMode(ledPins[6], OUTPUT);
pinMode(ledPins[7], OUTPUT);
pinMode(ledPins[8], OUTPUT);

//boot sequence
for(int j = 0; j < 9; j++){
analogWrite(ledPins[j],1023);
delay(150);
}
for(int j = 0; j < 9; j++){
analogWrite(ledPins[j],0);
}

ledBool[6] = true;

}

int lastTime = 1000;
int timePassed = 0;

void loop() {
  // Update all the buttons.  There should not be any long
  // delays in loop(), so this runs repetitively at a rate
  // faster than the buttons could be pressed and released.
  button0.update();
  button1.update();
  button2.update();
  button3.update();
  button4.update();
  button5.update();
  button6.update();
  button7.update();
  button8.update();
  button9.update();
 
  
  long newPosition = myEnc.read();
  
  if (newPosition > oldPosition) {
    oldPosition = newPosition;
    Keyboard.print("+");
  }
  if (newPosition < oldPosition) {
    oldPosition = newPosition;
    Keyboard.print("-");
  }
  

  // Check each button for "falling" edge.
  // Type a message on the Keyboard when each button presses
  // Update the Joystick buttons only upon changes.
  // falling = high (not pressed - voltage from pullup resistor)
  //           to low (pressed - button connects pin to ground)
  if (button0.fallingEdge()) {
    Keyboard.print("1"); 
    exclusiveLed(0);
  }
  if (button1.fallingEdge()) {
    Keyboard.print("2");
    exclusiveLed(1);
  }
  if (button2.fallingEdge()) {
    Keyboard.print("3");
    exclusiveLed(2);
  }
  if (button3.fallingEdge()) {
    Keyboard.print("4");
    exclusiveLed(3);
  }
  if (button4.fallingEdge()) {
    Keyboard.print("5");
    exclusiveLed(4);
  }
  if (button5.fallingEdge()) {
    Keyboard.print("6");
    exclusiveLed(5);
  }
  if (button6.fallingEdge()) {
    Keyboard.print("7");
    exclusiveLed(6);
  }
  if (button7.fallingEdge()) {
    Keyboard.print("8");
    exclusiveLed(7);
  }
  
  
  if (button8.fallingEdge()) {
    Keyboard.print("r");
  }

  if (button9.fallingEdge()) {
    Keyboard.print("0");
    for(int i = 0; i < 8; i++){
    ledBool[i] = false;
  }
}
  
updateLed();



if(timePassed > 110){

if(counter >= 90){
counter = 0;
}
else{
counter++;
}
lastTime = millis();
Serial.println(counter);
}

timePassed = millis() - lastTime;
analogWrite(ledPins[8],pulseCurve[counter]);
}


void exclusiveLed(int safeLED){
for(int i = 0; i < 8; i++){
  if(i == safeLED){
    ledBool[i] = true;
    }
  else{
    ledBool[i] = false;
      }
  }
}

void updateLed(){

for(int i = 0; i < 8; i++){

if(ledBool[i] == true && ledStatus[i] < 1023){
  ledStatus[i]++;
  Serial.print(i);
  Serial.println(" lighting up!");
}
else if (ledBool[i] == false ){
  ledStatus[i] = 0;
}

analogWrite(ledPins[i], ledStatus[i]);

}

}