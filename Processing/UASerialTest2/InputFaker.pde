// For when IR doesn't work anymore (sun is down)
// Picks a random pixel in the grid every X frames
// and pretends it has been "stepped on"

class InputFaker {

    int UPDATE_FREQUENCY = 40;

    boolean ENABLED = false;

    int frame;

    int x, y;
    int px, py;

    void start() {

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

    void stop() {

        IR_DISABLED = false;
        ENABLED = false;

    }

    void update() {

        if (frame % UPDATE_FREQUENCY == 0) {

            px = x;
            py = y;

            x = int(random(WIDTH));
            y = int(random(HEIGHT));

            // put your "foot" on a random pixel
            irTable[x][y] = 0;

            // take your "foot" off that last pixel
            irTable[px][py] = IR_MAX;

        }

        frame++;

    }

}
