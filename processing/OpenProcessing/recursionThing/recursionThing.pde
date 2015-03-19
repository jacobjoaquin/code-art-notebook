/*
Recursion Thing
 
 Jacob Joaquin
 jacobjoaquin@gmail.com
 twitter @jacobjoaquin
 */

int nRecursions = 7;
float theScale = 0.6;
float gScale = 10;
float distance;
float theSize;

void setup() {
  size(800, 450);
  smooth();
  noLoop();
  ellipseMode(CENTER);
  background(#6f000b);
  theSize = width / 12;
  distance = (float) width / -5.0;
}

void draw() {
  translate(width / 2.0, height / 2.0);
  scale(gScale);
  doIt(nRecursions);
}

void doIt(int n) {
  // Circle
  stroke(0, 180);
  fill(#fe6b0c, 30);
  strokeWeight(2.0);
  ellipse(0, 0, theSize, theSize);

  // Line
  color c1 = color(255, 0, 0, 16);
  color c2 = color(255, 255, 0, 16);

  if (n != nRecursions) {
    cLine(0, theSize / 2.0, 0, distance  - (theSize * theScale / 2.0) - 8.0, 4, 4, c1, c2);
  }

  // Recurse
  pushMatrix();
  scale(theScale);

  for (int i = 0; i < n; i++) {
    if (n > 0) {
      pushMatrix();
      translate(0, distance);
      doIt(n - 1);
      popMatrix();
      rotate(TWO_PI / (float) n);
    }
  }

  popMatrix();
}

void cLine(float x0, float y0, float x1, float y1, int nLines, float sw, color c1, color c2) {
  sw *= 0.5;

  for (int i = 0; i < nLines; i++) {
    float r0 = random(-sw, sw);
    float r1 = random(-sw, sw);
    float r2 = random(-sw, sw);
    float r3 = random(-sw, sw);

    pushStyle();
    stroke(color(lerpColor(c1, c2, random(1.0f))));
    strokeWeight(1);
    line(x0 + r0, y0 + r1, x1 + r2, y1 + r3);
    popStyle();
  }
}
