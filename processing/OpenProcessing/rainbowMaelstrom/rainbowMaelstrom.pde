/*
Rainbow Maelstrom
 
 Jacob Joaquin
 jacobjoaquin@gmail.com
 twitter @jacobjoaquin
 */

float hue = 0.0;
float rads = 0.0;
float inc = 0.025;
int nDots = 25;
int nOrbits = 10;
float nDotsInv;
float dotRotate;
float nDotsInvDiv8;

void setup() {
  size(300, 300);
  smooth();
  frameRate(30);
  ellipseMode(CENTER);
  colorMode(HSB);
  strokeWeight(0.5);
  stroke(255, 64);
  nDotsInv = 1.0 / nDots;
  dotRotate = TWO_PI * nDotsInv;
  nDotsInvDiv8 = nDotsInv / 8.0;
}

void draw() {
  float fromCenter = 3;
  float radius = 10.0;

  translate(150, 150);
  rotate(rads);
  rads += inc;
  hue += 3;

  if (rads >= TWO_PI) {
    rads -= TWO_PI;
  }

  if (hue > 255) {
    hue -= 255;
  }

  for (int i = 0; i < nDots * nOrbits; i++) {
    float diameter = radius * 2;
    float c = (hue + i * 7) % 255;

    fill(c, 255, 255, 32);
    ellipse(0, fromCenter, diameter, diameter);
    radius = radius + radius * nDotsInvDiv8;
    fromCenter += radius * nDotsInv;
    rotate(dotRotate);
  }
}
