import processing.serial.*;
import hypermedia.net.*;

String UDP_IP = "192.168.2.11";
int BAUD = 115200;

int THRESH = 10;
int BLOCK_SIZE = 20;

int WIDTH = 36;
int HEIGHT = 9;

UDP udp;

AnalBuffer[] analBuffers = new AnalBuffer[8];
int[][] analGlobal = new int[WIDTH][HEIGHT];

byte[] colorBytes;

Pattern pattern = new SinePattern();

void setup() {

  size(720, 160);

  udp = new UDP(this);
  udp.setBuffer(1024);

  colorBytes = new byte[pixelOrder.length * 3];

  String[] serials = Serial.list();

  analBuffers[0] = new AnalBuffer(this, serials[0], 0, 0, new int[][] { { 2, 0 }, { 2, 1 }, { 3, 0 }, { 3, 1 }, { 4, 0 }, { 4, 1 }, { 5, 0 }, { 5, 1 }, { 6, 0 }, { 6, 1 }, { 7, 0 }, { 7, 1 }, { 8, 0 }, { 8, 1 }, { 2, 2 }, { 2, 3 }, { 3, 2 }, { 3, 3 }, { 4, 2 }, { 4, 3 }, { 5, 2 }, { 5, 3 }, { 6, 2 }, { 6, 3 }, { 7, 2 }, { 7, 3 }, { 8, 2 }, { 8, 3 } });
  analBuffers[1] = new AnalBuffer(this, serials[2], 0, 4, new int[][] { { 0, 0 }, { 0, 1 }, { 1, 0 }, { 1, 1 }, { 2, 0 }, { 2, 1 }, { 3, 0 }, { 3, 1 }, { 4, 0 }, { 4, 1 }, { 5, 0 }, { 5, 1 }, { 6, 0 }, { 6, 1 }, { 7, 0 }, { 7, 1 }, { 8, 0 }, { 8, 1 }, { 0, 2 }, { 0, 3 }, { 1, 2 }, { 1, 3 }, { 2, 2 }, { 2, 3 }, { 3, 2 }, { 3, 3 }, { 4, 2 }, { 4, 3 }, { 5, 2 }, { 5, 3 }, { 6, 2 }, { 6, 3 }, { 7, 2 }, { 7, 3 }, { 8, 2 }, { 8, 3 } });

  // analBuffers[2] = new AnalBuffer(this, serials[4], 9, 0);
  // analBuffers[3] = new AnalBuffer(this, serials[6], 9, 4);

  // analBuffers[4] = new AnalBuffer(this, serials[8], 18, 0);
  // analBuffers[5] = new AnalBuffer(this, serials[10], 18, 4);

  // analBuffers[6] = new AnalBuffer(this, serials[12], 27, 0);
  // analBuffers[7] = new AnalBuffer(this, serials[14], 27, 4);

}

void draw() {

  color c;
  int i = 0, x, y;

  // Draw pixels to screen
  // ... also send them over UDP.

  for (int[] coord : pixelOrder) {

    x = coord[0];
    y = coord[1];

    c = pattern.colorAt(x, y);

    // assign rgb to color byte array
    colorBytes[i * 3 + 0] = byte((c >> 16) & 0xFF); 
    colorBytes[i * 3 + 1] = byte((c >> 8) & 0xFF);
    colorBytes[i * 3 + 2] = byte(c & 0xFF);

    i++;

    fill(c);
    rect(x * BLOCK_SIZE, y * BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE);

  }

  pattern.update();
  udp.send(colorBytes, UDP_IP, 9999);

}

void serialEvent(Serial thisPort) {

  String message = thisPort.readStringUntil(13);

  if (message == null) return;

  // Merge all the AnalBuffers into a global (x, y) table
  // that we can send to the patterns to do interactivity.

  for (AnalBuffer buffer : analBuffers) {
    
    if (thisPort != buffer.serial) continue;

    int[] values = int(splitTokens(message));

    if (values.length != buffer.length + 1) return;



    // System.arraycopy(values, 0, buffer.values, 0, buffer.length);

  }

}