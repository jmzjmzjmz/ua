void drawHistogram(int x, int y, int w, int h) {

    stroke(0);

    // zero out the histogram
    for (int i = 0; i < histogram.length; i++) {
        histogram[i] = 0;
    }

    for (int i = 0; i < irTable.length; i++) {
      for (int j = 0; j < irTable[0].length; j++) {

        int value = irTable[i][j];
        histogram[value]++;

      }
    }

    int histMax = max(histogram);

    for (int i = 0; i < histogram.length; i++) {

        float px = map(i, 0, histogram.length, x, x + w);
        float py = map(histogram[i], histMax, 0, y, y + h);

        line(px, y+h, px, py);

    }

    float px = map(THRESH, 0, histogram.length, x, x + w);

    stroke(255, 0, 0);
    line(px, y + h, px, y);

}