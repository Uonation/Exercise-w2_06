/*
 * Creative Coding
 * Week 2, 06 - Moving Patterns 2
 * Excercise trying to modify the color and interaction from keyboard to mouse
 *
 * Similar to the previous sketch, this sketch draws a grid of oscillating circles. Each circle has a "lifetime"
 * over which it grows and changes intensity and opacity. At the end of each lifetime the circle begins again.
 * Pressing the left and right mouse button changes the lifetime of all the circles globally and colour.
 * 
 */

int frameRateValue; // variable used to store the current frame rate value
int gridSize = 20;
int backgroundValue = 0;
int margin = 0;
float gutter = 0; //distance between each cell
float cellsize; //declare cellsize
float change_color = 0;

void setup() {

  // make the display window the full size of the screen
  size(displayWidth, displayHeight);


  frameRateValue = 12;
  rectMode(CENTER);
  background(0);
  cellsize = ( width - (2 * margin) - gutter * (gridSize - 1) ) / (gridSize - 1); //define cellsize
  backgroundValue = (255 + 255 + 255);
}



void draw() {

  background(backgroundValue);
  int circleNumber = 0; // counter
  for (int i=0; i<gridSize; i++) {
    for (int j=0; j<gridSize; j++) {
      circleNumber = (i * gridSize) + j; // different way to calculate the circle number from w2_04

      float tx = margin + cellsize * i + gutter * i;
      float ty = margin + cellsize * j + gutter * j;

      movingCircle(tx, ty, cellsize, circleNumber);
    }
  }
  if (mousePressed) {
    println("The mouse button was pressed");
    // right button -- change color?
    backgroundValue++;

    // save your drawing when you press keyboard 's'
    if (keyPressed == true && key == 's') {
      saveFrame("yourName.jpg");
    }
  }
} //end of draw 


void movingCircle(float x, float y, float size, int offset) {

  float circlePeriod = (float)frameRateValue;
  float circleAge = (float)((frameCount + offset) %  (int)circlePeriod) / circlePeriod; // % is modulo operator 
  float circleSize = size * 2.0 * sin(circleAge * HALF_PI + PI);

  strokeWeight(2);
  stroke(255, lerp(255, 0, circleAge));
  fill(lerp(128, 0, circleAge), lerp(120, 0, circleAge));
  ellipse(x-size/2, y-size/2, circleSize, circleSize);
}

/*
 * mouseReleased function
 *
 * called automatically by Processing when the mouse is pressed or released
 */




void mouseClicked() {
  println("The mouse button was clicked");
  if (mouseButton == RIGHT && frameRateValue < 120) {
    frameRateValue++;
    backgroundValue = mouseY*20;
  }
  if (mouseButton == LEFT && frameRateValue > 2) {
    frameRateValue--;
    backgroundValue = mouseX*20;
  } else {
    fill(random(255), random(255), random(255));
  }
}

void mouseDragged() {
  println("The mouse is being dragged");
  backgroundValue = mouseX*105;
}