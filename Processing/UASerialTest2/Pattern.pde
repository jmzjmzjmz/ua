interface Pattern {

  void update();
  color colorAt(int x, int y);

};

class DebugPattern implements Pattern {

  int frame = 0;
  int frame2 = 0;

  void update() {
    
    frame2++;
    
    if (frame2 % 2 == 0)
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

class AnalPattern implements Pattern {

  void update() {

  }

  color colorAt(int x, int y) {

    float t = map(analGlobal[x][y], 0, 1023, 0, 1);
    return lerpColor(color(255, 0, 0), color(255), t);

  }

};

class SinePattern implements Pattern {

  int frame = 0;

  void update() {
    frame++;
  }

  color colorAt(int x, int y) {
    
    float t = map(sin(frame / 50.0 + y / 5.0), -1, 1, 0, 1);
    return lerpColor(color(255, 0, 0), color(255), t);

  }

};