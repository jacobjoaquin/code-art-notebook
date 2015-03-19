int nFrames = 256;
Phasor phasor = new Phasor(1.0 / float(nFrames));

void simpleTriangle(float x, float y, float midLength, float angle) {
  PVector p1 = PVector.fromAngle(-PI / 2.0);
  PVector p2 = PVector.fromAngle(-PI / 2.0 + TWO_PI / 3.0);
  PVector p3 = PVector.fromAngle(-PI / 2.0 - TWO_PI / 3.0);
  p1.mult(midLength);
  p2.mult(midLength);
  p3.mult(midLength);

  pushMatrix();
  translate(x, y);
  rotate(angle);
  beginShape();
  vertex(p1.x, p1.y);
  vertex(p2.x, p2.y);
  vertex(p3.x, p3.y);
  endShape();
  popMatrix();
}

void setup() {
  size(500, 500);
}

void draw() {
  background(255);
  fill(0);
  noStroke();
  int nShapes = 40;
  float tileSize = width / (float) nShapes;

  for (float y = 0; y <= height; y+= tileSize) {
    for (float x = 0; x <= width; x += tileSize) {
      float angle = TWO_PI * phasor.phase;
      angle += map(dist(x, y, width / 2.0, height / 2.0), 0, sqrt(2) * width / 2.0, 0, 1);
      simpleTriangle(x, y, tileSize * 1, angle);
    }
  }
  phasor.update();
}
