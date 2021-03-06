import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 
import hypermedia.net.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class UASerialTest extends PApplet {




UDP udp;  // define the UDP object

Serial matrix1_1;
Serial matrix1_2;
Serial matrix2_1;
Serial matrix2_2;
Serial matrix3_1;
Serial matrix3_2;
Serial matrix4_1;
Serial matrix4_2;

int pxWidth= 10;
int pxHeight= 1;
int numPixels = pxWidth * pxHeight;

int thresh = 10 ;

int blockSize = 100;
int myMovieColors[];
byte[] bytes = new byte[numPixels*3];

int arrayVals = 48;

int[] px1_1=  new int[arrayVals];
int[] px1_2=  new int[arrayVals];
int[] px2_1=  new int[arrayVals];
int[] px2_2=  new int[arrayVals];
int[] px3_1=  new int[arrayVals];
int[] px3_2=  new int[arrayVals];
int[] px4_1=  new int[arrayVals];
int[] px4_2=  new int[arrayVals];



public void setup()
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

  myMovieColors = new int[numPixels];

  for (int i=0; i<numPixels*3; i++) {
    bytes[i] = PApplet.parseByte(0);
  }

  frameRate(500);
}

public void draw()
{
  //for (int j = 0; j < numPixels; j++) {
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

public void printArray(int [] myArray){

  for(int i = 0; i < myArray.length; i++){

println("[" + i + "] " + myArray[i]);

  }
}

int[] analBuffer = new int[48];

public void serialEvent(Serial thisPort) {
  // get message till line break (ASCII > 13)
  String message = thisPort.readStringUntil(13);

  if (message != null)
  {

    if (thisPort == matrix1_1) {
      analBuffer = PApplet.parseInt(splitTokens(message));
      if(analBuffer.length == 48){
      px1_1  = PApplet.parseInt(splitTokens(message));
    }
    }
    else if (thisPort == matrix1_2) {
      analBuffer = PApplet.parseInt(splitTokens(message));
      if(analBuffer.length == 48){
      px1_2  = PApplet.parseInt(splitTokens(message));
    }}
  else if (thisPort == matrix2_1) {
    analBuffer = PApplet.parseInt(splitTokens(message));
      if(analBuffer.length == 48){
      px2_1  = PApplet.parseInt(splitTokens(message));
    }}
  else if (thisPort == matrix2_2) {
    analBuffer = PApplet.parseInt(splitTokens(message));
      if(analBuffer.length == 48){
      px2_2  = PApplet.parseInt(splitTokens(message));
    }}
  else if (thisPort == matrix3_1) {
    analBuffer = PApplet.parseInt(splitTokens(message));
      if(analBuffer.length == 48){
      px3_1  = PApplet.parseInt(splitTokens(message));
    }}
  else if (thisPort == matrix3_2) {
    analBuffer = PApplet.parseInt(splitTokens(message));
      if(analBuffer.length == 48){
      px3_2  = PApplet.parseInt(splitTokens(message));
    }}
  else if (thisPort == matrix4_1) {
    analBuffer = PApplet.parseInt(splitTokens(message));
      if(analBuffer.length == 48){
      px4_1  = PApplet.parseInt(splitTokens(message));
    }}
  else if (thisPort == matrix4_2) {
    analBuffer = PApplet.parseInt(splitTokens(message));
      if(analBuffer.length == 48){
      px4_2  = PApplet.parseInt(splitTokens(message));
    }}
  }
}







public void updateByteArray() {
  for (int i = 0; i < numPixels; i++) {
    int r = (myMovieColors[i] >> 16) & 0xFF;  // Faster way of getting red(argb)
    int g = (myMovieColors[i] >> 8) & 0xFF;   // Faster way of getting green(argb)
    int b = myMovieColors[i] & 0xFF;          // Faster way of getting blue(argb)

    bytes[i*3] = PApplet.parseByte(r);
    bytes[i*3+1] = PApplet.parseByte(g);
    bytes[i*3+2] = PApplet.parseByte(b);
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "UASerialTest" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
