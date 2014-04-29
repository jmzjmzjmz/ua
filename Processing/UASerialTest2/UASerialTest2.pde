import processing.serial.*;
import hypermedia.net.*;
import com.onformative.yahooweather.*;
import controlP5.*;

// this the flag james
// if you set it to false, the histogram goes away
// and the threshhold slider will work.
boolean USE_ADAPTIVE_THRESH = true;

boolean USE_SCHEDULER = true;
boolean USE_INPUT_FAKER = false;
boolean USE_WEATHER = true;

// so i can code without the arduino
boolean OPEN_SERIAL = true;

// prints analog-in messages
boolean DEBUG_SERIAL = false;
boolean IR_DISABLED = false;

int[][] pixelOrder = new int[][] { { 2, 0 }, { 2, 1 }, { 3, 0 }, { 3, 1 }, { 4, 0 }, { 4, 1 }, { 5, 0 }, { 5, 1 }, { 6, 0 }, { 6, 1 }, { 7, 0 }, { 7, 1 }, { 8, 0 }, { 8, 1 }, { 9, 0 }, { 9, 1 }, { 10, 0 }, { 10, 1 }, { 11, 0 }, { 11, 1 }, { 12, 0 }, { 12, 1 }, { 13, 0 }, { 13, 1 }, { 14, 0 }, { 14, 1 }, { 15, 0 }, { 15, 1 }, { 16, 1 }, { 17, 1 }, { 18, 1 }, { 19, 1 }, { 20, 0 }, { 20, 1 }, { 21, 0 }, { 21, 1 }, { 22, 0 }, { 22, 1 }, { 23, 0 }, { 23, 1 }, { 24, 0 }, { 24, 1 }, { 25, 0 }, { 25, 1 }, { 26, 0 }, { 26, 1 }, { 27, 0 }, { 27, 1 }, { 28, 0 }, { 28, 1 }, { 29, 0 }, { 29, 1 }, { 30, 0 }, { 30, 1 }, { 31, 0 }, { 31, 1 }, { 32, 0 }, { 32, 1 }, { 33, 0 }, { 33, 1 }, { 34, 0 }, { 34, 1 }, { 35, 1 }, { 35, 2 }, { 35, 3 }, { 34, 2 }, { 34, 3 }, { 33, 2 }, { 33, 3 }, { 32, 2 }, { 32, 3 }, { 31, 2 }, { 31, 3 }, { 30, 2 }, { 30, 3 }, { 29, 2 }, { 29, 3 }, { 28, 2 }, { 28, 3 }, { 27, 2 }, { 27, 3 }, { 26, 2 }, { 26, 3 }, { 25, 2 }, { 25, 3 }, { 24, 2 }, { 24, 3 }, { 23, 2 }, { 23, 3 }, { 22, 2 }, { 22, 3 }, { 21, 2 }, { 21, 3 }, { 20, 2 }, { 20, 3 }, { 19, 2 }, { 19, 3 }, { 18, 2 }, { 18, 3 }, { 17, 2 }, { 17, 3 }, { 16, 2 }, { 16, 3 }, { 15, 2 }, { 15, 3 }, { 14, 2 }, { 14, 3 }, { 13, 2 }, { 13, 3 }, { 12, 2 }, { 12, 3 }, { 11, 2 }, { 11, 3 }, { 10, 2 }, { 10, 3 }, { 9, 2 }, { 9, 3 }, { 8, 2 }, { 8, 3 }, { 7, 2 }, { 7, 3 }, { 6, 2 }, { 6, 3 }, { 5, 2 }, { 5, 3 }, { 4, 2 }, { 4, 3 }, { 3, 2 }, { 3, 3 }, { 2, 2 }, { 2, 3 }, { 0, 4 }, { 0, 5 }, { 1, 4 }, { 1, 5 }, { 2, 4 }, { 2, 5 }, { 3, 4 }, { 3, 5 }, { 4, 4 }, { 4, 5 }, { 5, 4 }, { 5, 5 }, { 6, 4 }, { 6, 5 }, { 7, 4 }, { 7, 5 }, { 8, 4 }, { 8, 5 }, { 9, 4 }, { 9, 5 }, { 10, 4 }, { 10, 5 }, { 11, 4 }, { 11, 5 }, { 12, 4 }, { 12, 5 }, { 13, 4 }, { 13, 5 }, { 14, 4 }, { 14, 5 }, { 15, 4 }, { 15, 5 }, { 16, 4 }, { 16, 5 }, { 17, 4 }, { 17, 5 }, { 18, 4 }, { 18, 5 }, { 19, 4 }, { 20, 4 }, { 21, 4 }, { 21, 5 }, { 22, 4 }, { 22, 5 }, { 23, 4 }, { 23, 5 }, { 24, 4 }, { 24, 5 }, { 25, 4 }, { 25, 5 }, { 26, 4 }, { 26, 5 }, { 27, 4 }, { 27, 5 }, { 28, 4 }, { 28, 5 }, { 29, 4 }, { 29, 5 }, { 30, 4 }, { 30, 5 }, { 31, 4 }, { 31, 5 }, { 32, 4 }, { 32, 5 }, { 33, 4 }, { 33, 5 }, { 34, 4 }, { 34, 5 }, { 35, 4 }, { 35, 5 }, { 35, 6 }, { 35, 7 }, { 34, 6 }, { 34, 7 }, { 33, 6 }, { 33, 7 }, { 32, 6 }, { 32, 7 }, { 31, 6 }, { 31, 7 }, { 30, 6 }, { 30, 7 }, { 29, 6 }, { 29, 7 }, { 28, 6 }, { 28, 7 }, { 27, 6 }, { 27, 7 }, { 26, 6 }, { 26, 7 }, { 25, 6 }, { 25, 7 }, { 24, 6 }, { 24, 7 }, { 23, 6 }, { 23, 7 }, { 22, 6 }, { 22, 7 }, { 21, 6 }, { 21, 7 }, { 20, 7 }, { 19, 7 }, { 18, 6 }, { 18, 7 }, { 17, 6 }, { 17, 7 }, { 16, 6 }, { 16, 7 }, { 15, 6 }, { 15, 7 }, { 14, 6 }, { 14, 7 }, { 13, 6 }, { 13, 7 }, { 12, 6 }, { 12, 7 }, { 11, 6 }, { 11, 7 }, { 10, 6 }, { 10, 7 }, { 9, 6 }, { 9, 7 }, { 8, 6 }, { 8, 7 }, { 7, 6 }, { 7, 7 }, { 6, 6 }, { 6, 7 }, { 5, 6 }, { 5, 7 }, { 4, 6 }, { 4, 7 }, { 3, 6 }, { 3, 7 }, { 2, 6 }, { 2, 7 }, { 1, 6 }, { 1, 7 }, { 0, 6 }, { 0, 7 } };

String UDP_IP = "192.168.2.11";
int UDP_PORT = 9999;

int BAUD = 115200;

int BLOCK_SIZE = 20;

int WIDTH = 36;
int HEIGHT = 8;

int THRESH = 225;
int IR_MAX = 1023;

UDP udp;

ControlP5 controlP5;

AnalBuffer[] analBuffers = new AnalBuffer[8];

int[][] irTable = new int[WIDTH][HEIGHT];
int[][] irTablePrev = new int[WIDTH][HEIGHT];

byte[] colorBytes;

Pattern pattern = new IRTestPattern();

YahooWeather weather;

InputFaker inputFaker = new InputFaker();
Scheduler scheduler;


// the amount of standard deviations below the mean
// at which we define the "STEP" threshhold.
float deviationFactor = 2;

void setup() {

  size(IR_MAX+1, 260);

  findAntiPixels();

  // Start out with IR_MAX everywhere.
  for (int x = 0; x < irTable.length; x++) {
      for (int y = 0; y < irTable[0].length; y++) {
          irTable[x][y] = IR_MAX;
          irTablePrev[x][y] = IR_MAX;
      }
  }

  udp = new UDP(this);
  udp.setBuffer(1024);

  colorBytes = new byte[pixelOrder.length * 3];

  String[] serials = Serial.list();
  println(serials);

  controlP5 = new ControlP5(this);
  controlP5.addSlider("deviationFactor")
    .setPosition(WIDTH * BLOCK_SIZE, 0)
    .setRange(0, 3)
    .setSize(220, 20)
    .setColorCaptionLabel(color(0));

  controlP5.addSlider("THRESH")
    .setPosition(WIDTH * BLOCK_SIZE, 21)
    .setRange(0, 1023)
    .setSize(220, 20)
    .setColorCaptionLabel(color(0));

  if (USE_SCHEDULER) scheduler = new Scheduler();

  if (USE_WEATHER) {
    try { 
      weather = new YahooWeather(this, 12761344, "c", 86400000); //86400000 millis in a day
    } catch (Exception e) {
      println("Weather API failed to connect! I don't know what the sun is doing :[");
    }
  }

  if (OPEN_SERIAL) {
    analBuffers[0] = new AnalBuffer(0, this, serials[12], 0, 0, new int[][] { { 2, 0 }, { 3, 0 }, { 4, 0 }, { 5, 0 }, { 6, 0 }, { 7, 0 }, { 8, 0 }, { 2, 1 }, { 3, 1 }, { 4, 1 }, { 5, 1 }, { 6, 1 }, { 7, 1 }, { 8, 1 }, { 2, 2 }, { 3, 2 }, { 4, 2 }, { 5, 2 }, { 6, 2 }, { 7, 2 }, { 8, 2 }, { 2, 3 }, { 3, 3 }, { 4, 3 }, { 5, 3 }, { 6, 3 }, { 7, 3 }, { 8, 3 } } );
    analBuffers[1] = new AnalBuffer(1, this, serials[13], 0, 4, new int[][] { { 0, 0 }, { 1, 0 }, { 2, 0 }, { 3, 0 }, { 4, 0 }, { 5, 0 }, { 6, 0 }, { 7, 0 }, { 8, 0 }, { 0, 1 }, { 1, 1 }, { 2, 1 }, { 3, 1 }, { 4, 1 }, { 5, 1 }, { 6, 1 }, { 7, 1 }, { 8, 1 }, { 0, 2 }, { 1, 2 }, { 2, 2 }, { 3, 2 }, { 4, 2 }, { 5, 2 }, { 6, 2 }, { 7, 2 }, { 8, 2 }, { 0, 3 }, { 1, 3 }, { 2, 3 }, { 3, 3 }, { 4, 3 }, { 5, 3 }, { 6, 3 }, { 7, 3 }, { 8, 3 } } );

    analBuffers[2] = new AnalBuffer(2, this, serials[14], 9, 0, new int[][] { { 0, 0 }, { 1, 0 }, { 2, 0 }, { 3, 0 }, { 4, 0 }, { 5, 0 }, { 6, 0 }, { 0, 1 }, { 1, 1 }, { 2, 1 }, { 3, 1 }, { 4, 1 }, { 5, 1 }, { 6, 1 }, { 7, 1 }, { 8, 1 }, { 0, 2 }, { 1, 2 }, { 2, 2 }, { 3, 2 }, { 4, 2 }, { 5, 2 }, { 6, 2 }, { 7, 2 }, { 8, 2 }, { 0, 3 }, { 1, 3 }, { 2, 3 }, { 3, 3 }, { 4, 3 }, { 5, 3 }, { 6, 3 }, { 7, 3 }, { 8, 3 } } );
    analBuffers[3] = new AnalBuffer(3, this, serials[15], 9, 4, new int[][] { { 0, 0 }, { 1, 0 }, { 2, 0 }, { 3, 0 }, { 4, 0 }, { 5, 0 }, { 6, 0 }, { 7, 0 }, { 8, 0 }, { 0, 1 }, { 1, 1 }, { 2, 1 }, { 3, 1 }, { 4, 1 }, { 5, 1 }, { 6, 1 }, { 7, 1 }, { 8, 1 }, { 0, 2 }, { 1, 2 }, { 2, 2 }, { 3, 2 }, { 4, 2 }, { 5, 2 }, { 6, 2 }, { 7, 2 }, { 8, 2 }, { 0, 3 }, { 1, 3 }, { 2, 3 }, { 3, 3 }, { 4, 3 }, { 5, 3 }, { 6, 3 }, { 7, 3 }, { 8, 3 } } );

    analBuffers[4] = new AnalBuffer(4, this, serials[16], 18, 0, new int[][] { { 2, 0 }, { 3, 0 }, { 4, 0 }, { 5, 0 }, { 6, 0 }, { 7, 0 }, { 8, 0 }, { 0, 1 }, { 1, 1 }, { 2, 1 }, { 3, 1 }, { 4, 1 }, { 5, 1 }, { 6, 1 }, { 7, 1 }, { 8, 1 }, { 0, 2 }, { 1, 2 }, { 2, 2 }, { 3, 2 }, { 4, 2 }, { 5, 2 }, { 6, 2 }, { 7, 2 }, { 8, 2 }, { 0, 3 }, { 1, 3 }, { 2, 3 }, { 3, 3 }, { 4, 3 }, { 5, 3 }, { 6, 3 }, { 7, 3 }, { 8, 3 } } );
    analBuffers[5] = new AnalBuffer(5, this, serials[17], 18, 4, new int[][] { { 0, 0 }, { 1, 0 }, { 2, 0 }, { 3, 0 }, { 4, 0 }, { 5, 0 }, { 6, 0 }, { 7, 0 }, { 8, 0 }, { 0, 1 }, { 3, 1 }, { 4, 1 }, { 5, 1 }, { 6, 1 }, { 7, 1 }, { 8, 1 }, { 0, 2 }, { 3, 2 }, { 4, 2 }, { 5, 2 }, { 6, 2 }, { 7, 2 }, { 8, 2 }, { 0, 3 }, { 1, 3 }, { 2, 3 }, { 3, 3 }, { 4, 3 }, { 5, 3 }, { 6, 3 }, { 7, 3 }, { 8, 3 } } );

    analBuffers[6] = new AnalBuffer(6, this, serials[18], 27, 0, new int[][] { { 0, 0 }, { 1, 0 }, { 2, 0 }, { 3, 0 }, { 4, 0 }, { 5, 0 }, { 6, 0 }, { 7, 0 }, { 0, 1 }, { 1, 1 }, { 2, 1 }, { 3, 1 }, { 4, 1 }, { 5, 1 }, { 6, 1 }, { 7, 1 }, { 8, 1 }, { 0, 2 }, { 1, 2 }, { 2, 2 }, { 3, 2 }, { 4, 2 }, { 5, 2 }, { 6, 2 }, { 7, 2 }, { 8, 2 }, { 0, 3 }, { 1, 3 }, { 2, 3 }, { 3, 3 }, { 4, 3 }, { 5, 3 }, { 6, 3 }, { 7, 3 }, { 8, 3 } } );
    analBuffers[7] = new AnalBuffer(7, this, serials[19], 27, 4, new int[][] { { 0, 0 }, { 1, 0 }, { 2, 0 }, { 3, 0 }, { 4, 0 }, { 5, 0 }, { 6, 0 }, { 7, 0 }, { 8, 0 }, { 0, 1 }, { 1, 1 }, { 2, 1 }, { 3, 1 }, { 4, 1 }, { 5, 1 }, { 6, 1 }, { 7, 1 }, { 8, 1 }, { 0, 2 }, { 1, 2 }, { 2, 2 }, { 3, 2 }, { 4, 2 }, { 5, 2 }, { 6, 2 }, { 7, 2 }, { 8, 2 }, { 0, 3 }, { 1, 3 }, { 2, 3 }, { 3, 3 }, { 4, 3 }, { 5, 3 }, { 6, 3 }, { 7, 3 }, { 8, 3 } } );
  }
  
  frameRate(25);
  updateTitle();

}

void draw() {
  
  background(200);

  color c;
  int i = 0, x, y;

  if (USE_SCHEDULER) scheduler.update();
  if (USE_INPUT_FAKER) inputFaker.update();

  pattern.update();

  if (USE_ADAPTIVE_THRESH) {
    calcStats();
    drawStats(0, height - 100, IR_MAX+1, 100);
  }


  stroke(200);

  for (int[] coord : pixelOrder) {

    x = coord[0];
    y = coord[1];

    c = pattern.colorAt(x, y);

    colorBytes[i * 3 + 0] = byte((c >> 16) & 0xFF); 
    colorBytes[i * 3 + 1] = byte((c >> 8) & 0xFF);
    colorBytes[i * 3 + 2] = byte(c & 0xFF);

    i++;

    fill(c);
    rect(x * BLOCK_SIZE, y * BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE);

  }

  udp.send(colorBytes, UDP_IP, UDP_PORT);
  
}

void keyPressed() {

  if (key == '1') {
    pattern = new SolidPattern();
  } else if (key == '2') {
    pattern = new SinePattern();
  } else if (key == '3') {
    pattern = new PulsePattern();
  } else if (key == '4') {
    pattern = new FadePattern();
  } else if (key == '5') {
    pattern = new FadePattern2();
  } else if (key == '6') {
    pattern = new PinPointPattern();
  } else if (key == '7') {
    pattern = new PuddlePattern();
  }

  else if (key == 'q') {
    pattern = new IRTestPattern();    
  } else if (key == 'w') { 
    pattern = new OrderTestPattern();
  } else if (key == 'e') {
    pattern = new CrawlPattern();
  }

  //  else if (key == 'z') {
  //   pattern = new RainbowPuddlePattern();
  // }

  updateTitle();

}

void updateTitle() {
  String clazz = pattern.getClass().getName();
  frame.setTitle(clazz.substring(clazz.indexOf("$")+1));
}

void serialEvent(Serial thisPort) {

  if (IR_DISABLED) return;

  String message = thisPort.readStringUntil(13);

  if (message == null) return;

  int[] values = int(splitTokens(message));

  if (DEBUG_SERIAL) {
    for (int i = 0; i < values.length; i++) {
      print(values[i]);
      print("\t");
    }
    println();
  }

  if (values.length == 0) return;

  // Merge all the AnalBuffers into a global (x, y) table
  // that we can send to the patterns to do interactivity.

  for (AnalBuffer buffer : analBuffers) {

    if (buffer == null || values[0] != buffer.id || values.length != buffer.length + 1) continue;

    storeIRTable();
   
    for (int i = 0; i < buffer.length; i++) {

      int x = buffer.order[i][0] + buffer.x;
      int y = buffer.order[i][1] + buffer.y;

      irTable[x][y] = values[i+1]; 

    }

  }

}

int previousMouseCellX = 0;
int previousMouseCellY = 0;

void mouseMoved() {

  int mouseCellX = mouseX / BLOCK_SIZE;
  int mouseCellY = mouseY / BLOCK_SIZE;

  if (mouseCellY >= HEIGHT || mouseCellX >= WIDTH) return;

  storeIRTable();

  if (previousMouseCellY != mouseCellY ||
      previousMouseCellX != mouseCellX) {

    irTable[previousMouseCellX][previousMouseCellY] = IR_MAX;
    irTable[mouseCellX][mouseCellY] = 0;

  }

  previousMouseCellX = mouseCellX;
  previousMouseCellY = mouseCellY;

}

// make sure you always call this BEFORE you manipulate the ir table.
// stores previous ir values.
void storeIRTable() {

  for (int i = 0; i < irTable.length; i++) {
    System.arraycopy(irTable[i], 0, irTablePrev[i], 0, irTable[i].length);
  }

}
