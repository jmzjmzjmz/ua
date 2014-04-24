int[] histogram = new int[IR_MAX+1];

int histMax;

float mean;
float stdDev;

int[][] pixelTable = new int[WIDTH][HEIGHT];

int NUM_PIXELS;

void findAntiPixels() {

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

boolean isAntiPixel(int x, int y) {
    return pixelTable[x][y] == 0;
}

void calcStats() {

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
    println(stdDev);

    THRESH = int(mean - stdDev*deviationFactor);
    
//    println ( THRESH + " " + stdDev + " " + deviationFactor);

}

void drawStats(int x, int y, int w, int h) {

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
