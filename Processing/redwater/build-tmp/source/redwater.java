import processing.core.*; 
import processing.data.*; 
import processing.opengl.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class redwater extends PApplet {

float damping = 0.9f;

int color1 = color(255, 0, 0);
int color2 = color(255, 255, 255);

float[] buffer1;
float[] buffer2;
float[] temp;

int WIDTH = 38;
int HEIGHT = 8;

int BLOCK_SIZE = 10;

public void setup() {
    size(WIDTH * BLOCK_SIZE, HEIGHT * BLOCK_SIZE);
    noSmooth();
    buffer1 = new float[WIDTH * HEIGHT];
    buffer2 = new float[WIDTH * HEIGHT];
    stroke(200);
    strokeWeight(2);
    frameRate(30);
}

public void draw() {

    float x1, x2, y1, y2;
    int l = WIDTH * HEIGHT;

    for (int i = 0; i < l; i++) {

        if ( i % WIDTH == 0 ) {

            // left edge
            x1 = 0;        
            x2 = buffer1[ i + 1 ];

        } else if ( i % WIDTH == WIDTH - 1 ) {

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

        buffer2[ i ] = ( x1 + x2 + y1 + y2 ) / 2 - buffer2[ i ];
        buffer2[ i ] *= damping;

    }

    int x;
    int y; 
    float p;

    for (int i = 0; i < l; i++) {
        p = buffer2[ i ];
        fill(255, p*255, p*255);
        rect(i % WIDTH * BLOCK_SIZE, i / WIDTH * BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE);
    }

    temp = buffer1;
    buffer1 = buffer2;
    buffer2 = temp;

}

public void mousePressed() {
  buffer1[(mouseX/ BLOCK_SIZE + mouseY/ BLOCK_SIZE * WIDTH) ] = 20;
}
public void mouseDragged() {
  buffer1[(mouseX/ BLOCK_SIZE + mouseY/ BLOCK_SIZE * WIDTH) ] = 10;
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "redwater" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
