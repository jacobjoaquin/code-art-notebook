void setup() {
  size(1000, 1000);
  noLoop();
}

void draw() {
  rectMode(CENTER);
  int n = 1;
  translate(width / float(n) * 0.5, height / float(n) * 0.5);
  background(57, 75, 100);
  fill(0, 16);
  stroke(0);
  noStroke();

  for (int y = 0; y < n; y++) {
    pushMatrix();
    translate(0, y * width / float(n));
    for (int x = 0; x < n; x++) {
      pushMatrix();
      translate(x * width / float(n), 0);
      scale(1 / (float)n);
      r(width, PI / 32.0, 200);
      popMatrix();
    }
    popMatrix();
  }
}

void r(float s, float angle, int iterations) {
  rect(0, 0, s, s);

  rotate(angle);
  if (--iterations >= 1) {
    r(s * 0.915, angle, iterations);
  }
}
