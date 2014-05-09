import java.util.*;

class PinPointPattern extends Pattern {

  ArrayList<Crawler> crawlers = new ArrayList<Crawler>();
  float[][] fadeTable = new float[WIDTH][HEIGHT];

  float DECAY = 0.9;

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

    void update() {
      
      x += xDir;
      y += yDir;

      if (x < 0 || x >= WIDTH || y < 0 || y >= HEIGHT) {
        isDead = true;
      }

    }


  }

  void update() {


    for (int x = 0; x < WIDTH; x++) {
      for (int y = 0; y < HEIGHT; y++) {

        if (irTable[x][y] <= THRESH && irTablePrev[x][y] > THRESH) {

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

  color colorAt(int x, int y) {
    return lerpColor(color(0), hueColor, fadeTable[x][y]);

  }

};


class PinPointPattern2 extends Pattern {

  ArrayList<Crawler> crawlers = new ArrayList<Crawler>();
  float[][] fadeTable = new float[WIDTH][HEIGHT];

  float DECAY = 0.9;

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

    void update() {
      
      x += xDir;
      y += yDir;

      if (x < 0 || x >= WIDTH || y < 0 || y >= HEIGHT) {
        isDead = true;
      }

    }


  }

  void update() {


    for (int x = 0; x < WIDTH; x++) {
      for (int y = 0; y < HEIGHT; y++) {

        if (irTable[x][y] <= THRESH && irTablePrev[x][y] > THRESH) {

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

  color colorAt(int x, int y) {
    return lerpColor(hueColor, color(255), fadeTable[x][y]);

  }

};

