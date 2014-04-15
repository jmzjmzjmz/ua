import processing.serial.*;
import hypermedia.net.*;

UDP udp;      

// four "matrices" with 2 arduinos apiece
// measuring presence
Serial[] matrixASerial;
Serial[] matrixBSerial;

// [matrixIndex][pixelsPerMatrix]
int[][] matrixA = new int[4][arrayVals];
int[][] matrixB = new int[4][arrayVals];

// 
int NUM_PIXELS = 10;
int THRESH = 10;

color myMovieColors[];

byte[] bytes = new byte[NUM_PIXELS*3];


int[] px1_1 =  new int[arrayVals];
int[] px1_2 =  new int[arrayVals];
int[] px2_1 =  new int[arrayVals];
int[] px2_2 =  new int[arrayVals];
int[] px3_1 =  new int[arrayVals];
int[] px3_2 =  new int[arrayVals];
int[] px4_1 =  new int[arrayVals];
int[] px4_2 =  new int[arrayVals];



void setup()
{
  //initialize all arrays
  for(int i = 0; i < arrayVals; i++){
px1_1[i] = 0;
px1_2[i] = 0;
px2_1[i] = 0;
px2_2[i] = 0;
px3_1[i] = 0;
px3_2[i] = 0;
px4_1[i] = 0;
px4_2[i] = 0;
  }

  String port_matrix1_1 = Serial.list()[0];
  String port_matrix1_2 = Serial.list()[2];
  String port_matrix2_1 = Serial.list()[4];
  String port_matrix2_2 = Serial.list()[6];
  String port_matrix3_1 = Serial.list()[8];
  String port_matrix3_2 = Serial.list()[10];
  String port_matrix4_1 = Serial.list()[12];
  String port_matrix4_2 = Serial.list()[14];
  // printArray(Serial.list());

  matrix1_1 = new Serial(this, port_matrix1_1, 115200);
  matrix1_2 = new Serial(this, port_matrix1_2, 115200);
  matrix2_1 = new Serial(this, port_matrix2_1, 115200);
  matrix2_2 = new Serial(this, port_matrix2_2, 115200);
  matrix3_1 = new Serial(this, port_matrix3_1, 115200);
  matrix3_2 = new Serial(this, port_matrix3_2, 115200);
  matrix4_1 = new Serial(this, port_matrix4_1, 115200);
  matrix4_2 = new Serial(this, port_matrix4_2, 115200);


  matrix1_1.bufferUntil(13);
  matrix1_2.bufferUntil(13);
  matrix2_1.bufferUntil(13);
  matrix2_2.bufferUntil(13);
  matrix3_1.bufferUntil(13);
  matrix3_2.bufferUntil(13);
  matrix4_1.bufferUntil(13);
  matrix4_2.bufferUntil(13);


  // udp = new UDP( this);
  // udp.setBuffer(1024);

  size(800, 800);

  myMovieColors = new color[NUM_PIXELS];

  for (int i=0; i<NUM_PIXELS*3; i++) {
    bytes[i] = byte(0);
  }

  frameRate(500);
}

void draw()
{
  //for (int j = 0; j < NUM_PIXELS; j++) {
  //      fill(pixelSensor[j]/4);
  //      noStroke();
  //      rect(j*blockSize, 0, blockSize-1, blockSize-1);
  //      myMovieColors[j] = color(255,255-int(map(pixelSensor[j],100,300,0,1023)/4),255-int(map(pixelSensor[j],100,300,0,1023)/4));
  //  }
  //
  //// println(pixelSensor[0]);
  //
  //
  // updateByteArray();
  //
  // udp.send(bytes, "192.168.2.11", 9999 );

// delay(100);

// printArray(px1_1);
delay(1000);
for(int i = 0; i < arrayVals; i++){
print(px1_1[i]);
print("\t\t\t");
print(px1_2[i]);
print("\t\t\t");
print(px2_1[i]);
print("\t\t\t");
print(px2_2[i]);
print("\t\t\t");
print(px3_1[i]);
print("\t\t\t");
print(px3_2[i]);
print("\t\t\t");
print(px4_1[i]);
print("\t\t\t");
println(px4_2[i]);
}
println();
} 


// int newStart = 0;
// int oldStart = 0;
// float lapsed = 0;

void printArray(int [] myArray){

  for(int i = 0; i < myArray.length; i++){

println("[" + i + "] " + myArray[i]);

  }
}

int[] analBuffer = new int[48];

void serialEvent(Serial thisPort) {
  // get message till line break (ASCII > 13)
  String message = thisPort.readStringUntil(13);

  if (message != null)
  {

    if (thisPort == matrix1_1) {
      analBuffer = int(splitTokens(message));
      if(analBuffer.length == 48){
      px1_1  = int(splitTokens(message));
    }
    }
    else if (thisPort == matrix1_2) {
      analBuffer = int(splitTokens(message));
      if(analBuffer.length == 48){
      px1_2  = int(splitTokens(message));
    }}
  else if (thisPort == matrix2_1) {
    analBuffer = int(splitTokens(message));
      if(analBuffer.length == 48){
      px2_1  = int(splitTokens(message));
    }}
  else if (thisPort == matrix2_2) {
    analBuffer = int(splitTokens(message));
      if(analBuffer.length == 48){
      px2_2  = int(splitTokens(message));
    }}
  else if (thisPort == matrix3_1) {
    analBuffer = int(splitTokens(message));
      if(analBuffer.length == 48){
      px3_1  = int(splitTokens(message));
    }}
  else if (thisPort == matrix3_2) {
    analBuffer = int(splitTokens(message));
      if(analBuffer.length == 48){
      px3_2  = int(splitTokens(message));
    }}
  else if (thisPort == matrix4_1) {
    analBuffer = int(splitTokens(message));
      if(analBuffer.length == 48){
      px4_1  = int(splitTokens(message));
    }}
  else if (thisPort == matrix4_2) {
    analBuffer = int(splitTokens(message));
      if(analBuffer.length == 48){
      px4_2  = int(splitTokens(message));
    }}
  }
}







void updateByteArray() {
  for (int i = 0; i < NUM_PIXELS; i++) {
    int r = (myMovieColors[i] >> 16) & 0xFF;  // Faster way of getting red(argb)
    int g = (myMovieColors[i] >> 8) & 0xFF;   // Faster way of getting green(argb)
    int b = myMovieColors[i] & 0xFF;          // Faster way of getting blue(argb)

    bytes[i*3] = byte(r);
    bytes[i*3+1] = byte(g);
    bytes[i*3+2] = byte(b);
  }
}

