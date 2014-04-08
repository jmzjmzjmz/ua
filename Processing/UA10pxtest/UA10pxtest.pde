import hypermedia.net.*;
UDP udp;  // define the UDP object


int pxWidth= 5;
int pxHeight= 2;
int numPixels = pxWidth * pxHeight;

int blockSize = 10;
color myMovieColors[];

byte[] bytes = new byte[numPixels*3];

void setup() {
  udp = new UDP( this);
  udp.setBuffer(1024);

  size(800, 800, P2D);
  noStroke();

  myMovieColors = new color[numPixels];

  for (int i=0; i<numPixels*3; i++) {
    bytes[i] = byte(0);
  }
}



// Display values from movie
void draw() {
  
  
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

void updateByteArray() {
  for (int i = 0; i < numPixels; i++) {
    int r = (myMovieColors[i] >> 16) & 0xFF;  // Faster way of getting red(argb)
    int g = (myMovieColors[i] >> 8) & 0xFF;   // Faster way of getting green(argb)
    int b = myMovieColors[i] & 0xFF;          // Faster way of getting blue(argb)

    bytes[i*3] = byte(r);
    bytes[i*3+1] = byte(g);
    bytes[i*3+2] = byte(b);
  }
}
