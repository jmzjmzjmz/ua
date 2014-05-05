import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 
import hypermedia.net.*; 
import com.onformative.yahooweather.*; 
import controlP5.*; 
import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class UASerialTest2 extends PApplet {






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

public void setup() {

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

public void draw() {
  
  background(200);

  int c;
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

    colorBytes[i * 3 + 0] = PApplet.parseByte((c >> 16) & 0xFF); 
    colorBytes[i * 3 + 1] = PApplet.parseByte((c >> 8) & 0xFF);
    colorBytes[i * 3 + 2] = PApplet.parseByte(c & 0xFF);

    i++;

    fill(c);
    rect(x * BLOCK_SIZE, y * BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE);

  }

  udp.send(colorBytes, UDP_IP, UDP_PORT);
  
}

public void keyPressed() {

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

public void updateTitle() {
  String clazz = pattern.getClass().getName();
  frame.setTitle(clazz.substring(clazz.indexOf("$")+1));
}

public void serialEvent(Serial thisPort) {

  if (IR_DISABLED) return;

  String message = thisPort.readStringUntil(13);

  if (message == null) return;

  int[] values = PApplet.parseInt(splitTokens(message));

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

public void mouseMoved() {

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
public void storeIRTable() {

  for (int i = 0; i < irTable.length; i++) {
    System.arraycopy(irTable[i], 0, irTablePrev[i], 0, irTable[i].length);
  }

}
class AnalBuffer {
    
  public Serial serial;
  public final int x;
  public final int y;

  public final int[][] order;

  public final int length;
  public final int id;

  AnalBuffer(int id, PApplet p, String serialID, int x, int y, int[][] order) {
    
    this.serial = new Serial(p, serialID, BAUD);
    this.serial.bufferUntil(13);
    this.id = id;
    this.x = x;
    this.y = y;
    this.order = order;
    this.length = this.order.length;
  }

}

class CrawlPattern extends Pattern {

  ArrayList<Crawler> crawlers = new ArrayList<Crawler>();
  float[][] fadeTable = new float[WIDTH][HEIGHT];

  float DECAY = 0.9f;

  int[][] directions = new int[][]{
    {-1, 0},
    {-1, -1},
    {0, -1},
    {1, -1},
    {1, 0},
    {1, 1},
    {0, 1},
    {-1, 1}
  };

  class Crawler {

    public int x;
    public int y;

    public boolean isDead = false;

    public int age = 0;

    Crawler(int x, int y) {
      
      this.x = x;
      this.y = y;

      crawlers.add(this);

    }

    public void update() {
      
      int[] dir = directions[PApplet.parseInt(random(8))];

      x += dir[0];
      y += dir[1];

      age++;

      if (x < 0 || x >= WIDTH || y < 0 || y >= HEIGHT || age > 40) {
        isDead = true;
      }

    }


  }

  public void update() {


    for (int x = 0; x < WIDTH; x++) {
      for (int y = 0; y < HEIGHT; y++) {

        if (irTable[x][y] < THRESH && irTablePrev[x][y] >= THRESH) {

          new Crawler(x, y);
          new Crawler(x, y);
          new Crawler(x, y);
          new Crawler(x, y);

        }

      }
    }

    ListIterator<Crawler> itr = crawlers.listIterator();

    while (itr.hasNext()) {
      Crawler c = itr.next();
      if (c.isDead) {
        itr.remove();
      } else {
        fadeTable[c.x][c.y] += map(c.age, 0, 40, 1, 0);
      }
      c.update();
    }

    for (int x = 0; x < fadeTable.length; x++) {
      for (int y = 0; y < fadeTable[0].length; y++) {

        fadeTable[x][y] *= DECAY;

      }
    }


  }

  public int colorAt(int x, int y) {
    return lerpColor(color(255, 0, 0), color(255), fadeTable[x][y]);

  }

};
int[] histogram = new int[IR_MAX+1];

int histMax;

float mean;
float stdDev;

int[][] pixelTable = new int[WIDTH][HEIGHT];

int NUM_PIXELS;

public void findAntiPixels() {

    for (int i = 0; i < pixelOrder.length; i++) {
        int[] coords = pixelOrder[i];
        pixelTable[coords[0]][coords[1]] = 1;
    }

    NUM_PIXELS = irTable[0].length * irTable.length;

    for (int i = 0; i < irTable.length; i++) {
        for (int j = 0; j < irTable[0].length; j++) {
            if (isAntiPixel(i, j)) {
                NUM_PIXELS--;
            }
        }
    }


}

public boolean isAntiPixel(int x, int y) {
    return pixelTable[x][y] == 0;
}

public void calcStats() {

    // zero out the histogram
    for (int i = 0; i < histogram.length; i++) {
        histogram[i] = 0;
    }

    // zero out the mean
    mean = 0;


    for (int i = 0; i < irTable.length; i++) {
        for (int j = 0; j < irTable[0].length; j++) {

            if (isAntiPixel(i, j)) {
                continue;
            }

            int value = irTable[i][j];

            histogram[value]++;
            mean += value;

        }

    }

    histMax = max(histogram);

    mean /= NUM_PIXELS;
    
    // math is "fun"
    // http://www.mathsisfun.com/data/standard-deviation.html
    float variance = 0;

    for (int i = 0; i < irTable.length; i++) {
        for (int j = 0; j < irTable[0].length; j++) {

            if (isAntiPixel(i, j)) {
                continue;
            }
            
            int value = irTable[i][j];
            variance += pow(value - mean, 2);

        }
    }

    variance /= NUM_PIXELS;
    
    stdDev = sqrt(variance);

    THRESH = PApplet.parseInt(mean - stdDev*deviationFactor);
    
//    println ( THRESH + " " + stdDev + " " + deviationFactor);

}

public void drawStats(int x, int y, int w, int h) {

    stroke(0);

    for (int i = 0; i < histogram.length; i++) {

        float px = map(i, 0, histogram.length, x, x + w);
        float py = map(histogram[i], histMax, 0, y, y + h);

        line(px, y+h, px, py);

    }


    // draw mean
    stroke(0, 255, 0);

    float px = map(mean, 0, histogram.length, x, x + w);
    line(px, y + h, px, y);

    // draw a std deviation
    stroke(0, 0, 255);

    px = map(mean - stdDev, 0, histogram.length, x, x+w);
    line(px, y + h, px, y);
    px = map(mean + stdDev, 0, histogram.length, x, x+w);
    line(px, y + h, px, y);

    // draw thresh.
    px = map(THRESH, 0, histogram.length, x, x + w);

    stroke(255, 0, 0);
    line(px, y + h, px, y);
    


}
// For when IR doesn't work anymore (sun is down)
// Picks a random pixel in the grid every X frames
// and pretends it has been "stepped on"

class InputFaker {

    int UPDATE_FREQUENCY = 40;

    boolean ENABLED = false;

    int frame;

    int x, y;
    int px, py;

    public void start() {

        frame = 0;
        
        IR_DISABLED = true;
        ENABLED = true;

        // Set all the values in the IR table to MAX.
        // (pretend the sun is hitting everything)
        for (int x = 0; x < irTable.length; x++) {
            for (int y = 0; y < irTable[0].length; y++) {
                irTable[x][y] = IR_MAX;
                irTablePrev[x][y] = IR_MAX;
            }
        }

    }

    public void stop() {

        IR_DISABLED = false;
        ENABLED = false;

    }

    public void update() {

        if (frame % UPDATE_FREQUENCY == 0) {

            px = x;
            py = y;

            x = PApplet.parseInt(random(WIDTH));
            y = PApplet.parseInt(random(HEIGHT));

            // put your "foot" on a random pixel
            irTable[x][y] = 0;

            // take your "foot" off that last pixel
            irTable[px][py] = IR_MAX;

        }

        frame++;

    }

}
class Pattern {

  public void update() {}
  public int colorAt(int x, int y) { return 0; }

};

class SolidPattern extends Pattern {

  public int colorAt(int x, int y) {
    return color(255, 0, 0);
  }

};

class OrderTestPattern extends Pattern {

  int frame = 0;

  public void update() {
    
    frame++;
    frame %= WIDTH * HEIGHT;

  }

  public int colorAt(int x, int y) {
    
    if (frame % WIDTH == x && frame / WIDTH == y) {
      return color(255);
    } else { 
      return color(255, 0, 0);
    }

  }

};

class IRTestPattern extends Pattern {

  public int colorAt(int x, int y) {

    float t = map(irTable[x][y], 0, 1023, 0, 1);
    return lerpColor(color(255), color(255, 0, 0), t);

  }

};

class FadePattern extends Pattern {

  float DECAY = 0.03f;
  float[][] fadeTable = new float[WIDTH][HEIGHT];

  public void update() {

    for (int x = 0; x < fadeTable.length; x++) {
      for (int y = 0; y < fadeTable[0].length; y++) {

        fadeTable[x][y] += (0 - fadeTable[x][y]) * DECAY;

        if (irTable[x][y] < THRESH) {
          fadeTable[x][y] = 1;
        }

      }
    }

  }

  public int colorAt(int x, int y) {
    
    return lerpColor(color(255, 0, 0), color(255), fadeTable[x][y]);

//uncomment to turn white on blue!

//return lerpColor(color(0, 0, 255), color(255), fadeTable[x][y]);

  }

};

class FadePattern2 extends Pattern {

  float DECAY = 0.03f;
  float[][] fadeTable = new float[WIDTH][HEIGHT];

  public void update() {

    for (int x = 0; x < fadeTable.length; x++) {
      for (int y = 0; y < fadeTable[0].length; y++) {

        fadeTable[x][y] += (0 - fadeTable[x][y]) * DECAY;

        if (irTable[x][y] < THRESH) {
          fadeTable[x][y] = 1;
        }

      }
    }

  }

  public int colorAt(int x, int y) {
    
    return lerpColor(color(0), color(255, 0, 0), fadeTable[x][y]);

  }

};

class SinePattern extends Pattern {

  int frame = 0;

  public void update() {
    frame++;
  }

  public int colorAt(int x, int y) {
    
    float t = map(sin(frame / 50.0f + y / 8.0f), -1, 1, 0, 1);
    return lerpColor(color(255, 0, 0), color(0), t);

  }

};

class PulsePattern extends Pattern {

  int frame = 0;

  public void update() {
    frame++;
  }

  public int colorAt(int x, int y) {
    
    float t = map(sin(frame / 50.0f), -1, 1, 0, .45f);
    return lerpColor(color(255, 0, 0), color(0), t);

  }

};

class PuddlePattern extends Pattern {

  float DAMPING = 0.96f;
  int SLOW = 2;

  float WAVE_CONST = 2.2f;

  float[] buffer1 = new float[WIDTH * HEIGHT];
  float[] buffer2 = new float[WIDTH * HEIGHT];
  float[] temp;

  int frame = 0;

  public void update() {

    frame++;

    int x, y;

    float x1, x2, y1, y2;
    int l = WIDTH * HEIGHT;

    for (int i = 0; i < l; i++) {

      if (irTable[i%WIDTH][i/WIDTH] < THRESH) {
        if (irTablePrev[i%WIDTH][i/WIDTH] >= THRESH) {
          buffer1[ i ] = 10;
        } else { 
          buffer1[ i ] = 5;
        }
      }
    }

    if (frame % SLOW != 0) return;

    for (int i = 0; i < l; i++) {

      x = i % WIDTH;
      y = i / WIDTH;

      if ( x == 0 ) {

        // left edge
        x1 = 0;        
        x2 = buffer1[ i + 1 ];

      } else if ( x == WIDTH - 1 ) {

        // right edge
        x1 = buffer1[ i - 1 ];
        x2 = 0;

      } else {

        x1 = buffer1[ i - 1 ];
        x2 = buffer1[ i + 1 ];

      }

      if ( i < WIDTH ) {

        // top edge
        y1 = 0;
        y2 = buffer1[ i + WIDTH ];

      } else if ( i > l - WIDTH - 1 ) {

        // bottom edge
        y1 = buffer1[ i - WIDTH ];
        y2 = 0;

      } else {

        y1 = buffer1[ i - WIDTH ];
        y2 = buffer1[ i + WIDTH ];

      }

      buffer2[ i ] = ( x1 + x2 + y1 + y2 ) / WAVE_CONST - buffer2[ i ];
      buffer1[ i ] += ( buffer2[ i ] - buffer1[ i ] ) * 0.25f;

    }

    temp = buffer1;
    buffer1 = buffer2;
    buffer2 = temp;

  }

  public int colorAt(int x, int y) {

    float p = buffer2[ y*WIDTH + x ];
    return color(255, p*255, p*255);

  }

};

class RainbowPuddlePattern extends PuddlePattern {

  float WAVE_CONST = 2;
  int SLOW = 1;

  public int colorAt(int x, int y) {

    colorMode(HSB, 1, 1, 1);
    float p = buffer2[ y*WIDTH + x ];
    while (p < 0) p += 1;
    int c = color(p%1, 1, 1);
    colorMode(RGB, 255, 255, 255);
    return c;

  }

};


class PinPointPattern extends Pattern {

  ArrayList<Crawler> crawlers = new ArrayList<Crawler>();
  float[][] fadeTable = new float[WIDTH][HEIGHT];

  float DECAY = 0.9f;

  class Crawler {

    int xDir;
    int yDir;

    public int x;
    public int y;

    public boolean isDead = false;

    Crawler(int x, int y, int xDir, int yDir) {
      
      this.x = x;
      this.y = y;

      this.xDir = xDir;
      this.yDir = yDir;

      crawlers.add(this);

    }

    public void update() {
      
      x += xDir;
      y += yDir;

      if (x < 0 || x >= WIDTH || y < 0 || y >= HEIGHT) {
        isDead = true;
      }

    }


  }

  public void update() {


    for (int x = 0; x < WIDTH; x++) {
      for (int y = 0; y < HEIGHT; y++) {

        if (irTable[x][y] < THRESH && irTablePrev[x][y] >= THRESH) {

          new Crawler(x, y, -1, 0);
          new Crawler(x, y, 1, 0);
          new Crawler(x, y, 0, -1);
          new Crawler(x, y, 0, 1);

        }

      }
    }

    ListIterator<Crawler> itr = crawlers.listIterator();

    while (itr.hasNext()) {
      Crawler c = itr.next();
      if (c.isDead) {
        itr.remove();
      } else {
        fadeTable[c.x][c.y] = 1;
      }
      c.update();
    }

    for (int x = 0; x < fadeTable.length; x++) {
      for (int y = 0; y < fadeTable[0].length; y++) {

        fadeTable[x][y] *= DECAY;

      }
    }


  }

  public int colorAt(int x, int y) {
    return lerpColor(color(0), color(255, 0, 0), fadeTable[x][y]);

  }

};
// scheduler

// list of patterns in order
// pattern index

class Scheduler {

    // Patterns are scheduled to run for a random amount
    // of minutes between these two numbers

    int MINIMUM_PATTERN_DURATION = 30;
    int MAXIMUM_PATTERN_DURATION = 60;

    // "Minute of day" at which scheduler switches over to 
    // "night mode". Since IR won't be reliable at night,
    // we provide fake input data to the patterns.

    int NIGHT_STARTS = 19 * 60 + 45; // 7:45PM
    int NIGHT_ENDS = 6 * 60; // 6AM

    Pattern[] dayPatterns = new Pattern[] {

//         new PinPointPattern(),
        new FadePattern2()
        // new PuddlePattern()

    };

    Pattern[] nightPatterns = new Pattern[] {

//         new PinPointPattern(),
        // new FadePattern(),
        // new PuddlePattern(),
      //   new SinePattern(),
        // new SolidPattern(),
        new PulsePattern()

    };

    int patternIndex = -1;
    int lastMinute;

    int currentPatternDuration;
    int currentPatternStarted;

    Pattern[] currentPatternList;

    Scheduler() {
          
        // int m = minuteOfDay();
        // lastMinute = m;

        // if (isNight(m)) {
        //     currentPatternList = nightPatterns;
        //     inputFaker.start();
        // } else { 
        //     currentPatternList = dayPatterns;
        // }
 
        // nextPattern();

    }

    public void update() {

        try { 

            weather.update();

            int[] sunrise = PApplet.parseInt(splitTokens(weather.getSunrise(),": "));
            NIGHT_ENDS = sunrise[0] * 60 + sunrise[1];

            int[] sunset = PApplet.parseInt(splitTokens(weather.getSunset(),": "));
            NIGHT_STARTS = (12+ sunset[0]) * 60 + sunset[1];

        } catch (Exception e) {
            // no sunrise sunset :[
        }

        int m = minuteOfDay();

        // from day to night
        if (isNight(m) && !isNight(lastMinute)) {
            println("Switching to night patterns.");
            inputFaker.start();
            nextPattern();
        }

        // from night to day
        else if (!isNight(m) && isNight(lastMinute)) {
            println("Switching to day patterns.");
            inputFaker.stop();
            nextPattern();
        }

        // current pattern expires
        else if (m - currentPatternStarted >= currentPatternDuration) {
            nextPattern();
        }

        lastMinute = m;

    }

    public boolean isNight(int m) {
        return m < NIGHT_ENDS || m > NIGHT_STARTS;
    }

    public void nextPattern() {

        int m = minuteOfDay();
        boolean nightTime = isNight(m);

        currentPatternList = nightTime ? nightPatterns : dayPatterns;

        currentPatternDuration = PApplet.parseInt(random(MINIMUM_PATTERN_DURATION, MAXIMUM_PATTERN_DURATION));
        currentPatternStarted = m;

        patternIndex++;
        patternIndex %= currentPatternList.length;

        pattern = currentPatternList[patternIndex];

        println("Setting pattern to " + pattern);
        println("Next pattern in " + currentPatternDuration);

        println("Night starts @ " + NIGHT_STARTS);
        println("Night ends @ " + NIGHT_ENDS);

        println("Night time: " + nightTime);

    }

    public int minuteOfDay() {
        return hour() * 60 + minute();
        
        // use this line if you want to simulate time moving faster
        // return hour() * 3600 + minute() * 60 + second();
    }

}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "UASerialTest2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
