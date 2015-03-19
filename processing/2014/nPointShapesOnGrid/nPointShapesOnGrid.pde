float size = 0.5;
float phase = 0.0;

void setup() {
  size(500, 500);
  noStroke();
}

void draw() {
  phase += 1.0 / 120.0;
  if (phase >= 1.0) {
    phase -= 1.0;
  }

  color c1 = color(255);
  color c2 = color(0);
  background(c2);
  pattern(24, 3, 4, c1, c2);
}

void pattern(int nMatrix, int nPoints, float nRots, color c1, color c2) {
  pushMatrix();
  float r = width / (float) nMatrix;
  translate(r / 2.0, r / 2.0);
  fill(c1);
  float p = phase * TWO_PI;
  for (int y = -1; y < nMatrix + 1; y++) {
    float angle = p + 1 / (float) nPoints * y / (float) nMatrix * TWO_PI * nRots;
    for (int x = -1; x < nMatrix + 1; x++) {
      pushMatrix();
      translate(x * r, y * r);
      scale(1 / (float) nMatrix);
      float angle2 = angle + 1 / (float) nPoints * x / (float) nMatrix * TWO_PI * nRots;
      fill(c1);
      poly(nPoints, size, angle2);
      popMatrix();
    }
  }
  popMatrix();
}

void poly(int nPoints, float r, float angle) {
  r = r * width;
  beginShape();

  for (int i = 0; i < nPoints; i++) {
    PVector p = PVector.fromAngle((float) i / (float) nPoints * TWO_PI + angle);
    p.mult(r);
    vertex(p.x, p.y);
  }  
  endShape(CLOSE);
}
