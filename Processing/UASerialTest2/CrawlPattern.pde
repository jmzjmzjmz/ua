
class CrawlPattern extends Pattern {

  ArrayList<Crawler> crawlers = new ArrayList<Crawler>();
  float[][] fadeTable = new float[WIDTH][HEIGHT];

  float DECAY = 0.9;

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

    void update() {
      
      int[] dir = directions[int(random(8))];

      x += dir[0];
      y += dir[1];

      age++;

      if (x < 0 || x >= WIDTH || y < 0 || y >= HEIGHT || age > 40) {
        isDead = true;
      }

    }


  }

  void update() {


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

  color colorAt(int x, int y) {
    return lerpColor(color(255, 0, 0), color(255), fadeTable[x][y]);

  }

};