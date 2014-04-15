import processing.core.*; 
import processing.data.*; 
import processing.opengl.*; 

import hypermedia.net.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class UA10pxtest extends PApplet {


UDP udp;  // define the UDP object


int pxWidth= 5;
int pxHeight= 2;
int numPixels = pxWidth * pxHeight;

int blockSize = 10;
int myMovieColors[];

byte[] bytes = new byte[numPixels*3];

public void setup() {
  udp = new UDP( this);
  udp.setBuffer(1024);

  size(800, 800, P2D);
  noStroke();

  myMovieColors = new int[numPixels];

  for (int i=0; i<numPixels*3; i++) {
    bytes[i] = PApplet.parseByte(0);
  }
}



// Display values from movie
public void draw() {
  
  
for (int k = 0; k < numPixels; k++) {
 myMovieColors[k] = color(255,255,255);
}
  

//  for (int j = 0; j < pxWidth; j++) {
//    for (int i = 0; i < pxHeight; i++) {
//      fill(myMovieColors[j*pxHeight + i]);
//      noStroke();
//      rect(i*blockSize, j*blockSize, blockSize-1, blockSize-1);
//    }
//  }



  // println("width : " +myMovie.width + " height: " +myMovie.height);


  updateByteArray();

  udp.send(bytes, "192.168.2.11", 9999 );
  
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
    String[] appletArgs = new String[] { "UA10pxtest" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
