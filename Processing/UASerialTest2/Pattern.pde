class Pattern {

  void update() {}
  color colorAt(int x, int y) { return 0; }

};

class SolidPattern extends Pattern {

  color colorAt(int x, int y) {
    return color(255, 0, 0);
  }

};

class OrderTestPattern extends Pattern {

  int frame = 0;

  void update() {
    
    frame++;
    frame %= WIDTH * HEIGHT;

  }

  color colorAt(int x, int y) {
    
    if (frame % WIDTH == x && frame / WIDTH == y) {
      return color(255);
    } else { 
      return color(255, 0, 0);
    }

  }

};

class IRTestPattern extends Pattern {

  color colorAt(int x, int y) {

    float t = map(irTable[x][y], 0, 1023, 0, 1);
    return lerpColor(color(255), color(255, 0, 0), t);

  }

};

class FadePattern extends Pattern {

  float DECAY = 0.03;
  float[][] fadeTable = new float[WIDTH][HEIGHT];

  void update() {

    for (int x = 0; x < fadeTable.length; x++) {
      for (int y = 0; y < fadeTable[0].length; y++) {

        fadeTable[x][y] += (0 - fadeTable[x][y]) * DECAY;

        if (irTable[x][y] < THRESH) {
          fadeTable[x][y] = 1;
        }

      }
    }

  }

  color colorAt(int x, int y) {
    
    return lerpColor(color(255, 0, 0), color(255), fadeTable[x][y]);

//uncomment to turn white on blue!

//return lerpColor(color(0, 0, 255), color(255), fadeTable[x][y]);

  }

};

class FadePattern2 extends Pattern {

  float DECAY = 0.03;
  float[][] fadeTable = new float[WIDTH][HEIGHT];

  void update() {

    for (int x = 0; x < fadeTable.length; x++) {
      for (int y = 0; y < fadeTable[0].length; y++) {

        fadeTable[x][y] += (0 - fadeTable[x][y]) * DECAY;

        if (irTable[x][y] < THRESH) {
          fadeTable[x][y] = 1;
        }

      }
    }

  }

  color colorAt(int x, int y) {
    
    return lerpColor(color(0), color(255, 0, 0), fadeTable[x][y]);

  }

};

class SinePattern extends Pattern {

  int frame = 0;

  void update() {
    frame++;
  }

  color colorAt(int x, int y) {
    
    float t = map(sin(frame / 50.0 + y / 8.0), -1, 1, 0, 1);
    return lerpColor(color(255, 0, 0), color(0), t);

  }

};

class PulsePattern extends Pattern {

  int frame = 0;

  void update() {
    frame++;
  }

  color colorAt(int x, int y) {
    
    float t = map(sin(frame / 50.0), -1, 1, 0, .45);
    return lerpColor(color(255, 0, 0), color(0), t);

  }

};

class PuddlePattern extends Pattern {

  float DAMPING = 0.96;
  int SLOW = 2;

  float WAVE_CONST = 2.2;

  float[] buffer1 = new float[WIDTH * HEIGHT];
  float[] buffer2 = new float[WIDTH * HEIGHT];
  float[] temp;

  int frame = 0;

  void update() {

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
      buffer1[ i ] += ( buffer2[ i ] - buffer1[ i ] ) * 0.25;

    }

    temp = buffer1;
    buffer1 = buffer2;
    buffer2 = temp;

  }

  color colorAt(int x, int y) {

    float p = buffer2[ y*WIDTH + x ];
    return color(255, p*255, p*255);

  }

};

class RainbowPuddlePattern extends PuddlePattern {

  float WAVE_CONST = 2;
  int SLOW = 1;

  color colorAt(int x, int y) {

    colorMode(HSB, 1, 1, 1);
    float p = buffer2[ y*WIDTH + x ];
    while (p < 0) p += 1;
    color c = color(p%1, 1, 1);
    colorMode(RGB, 255, 255, 255);
    return c;

  }

};
