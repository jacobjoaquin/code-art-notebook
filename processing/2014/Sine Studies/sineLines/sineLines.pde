void sineLine(float x1, float y1, float x2, float y2, float nCycles, float amp) {
  float d = dist(x1, y1, x2, y2);
  int d2 = ceil(d);
  noFill();
  beginShape();

  for (int i = 0; i <= d2; i++) {
    float p = float(i) / d;
    float v = lerp(x1, x2, p);
    float v2 = lerp(y1, y2, p);

    float s = sin(p * nCycles * TWO_PI) * amp;
    float x3 = v;
    float y3 = v2;

    float a2 = atan2(y2 - y1, x2 - x1);
    x3 = x3 + s * cos(PI / 2.0 + a2);
    y3 = y3 + s * sin(PI / 2.0 + a2);
    vertex(x3, y3);
  }
  endShape();
}

void setup() {
  size(500, 500);
  noLoop();
}

void draw() {
  background(236, 206, 200);
  stroke(221, 50, 50, 96);
  circleWithSines(width / 2.0, height / 2.0, width / 2.125, 128);
}

void circleWithSines(float x, float y, float r, int nLines) {
  for (int i = 0; i < nLines; i++) {
    float d = float(i) / float(nLines - 1);
    float v = lerp(-r, r, d);

    pushMatrix();
    translate(width / 2.0, height / 2.0);
    float x2 = sqrt(r * r - v * v);
    float amp = dist(-x2, v, x2, v) * 0.05;
    sineLine(-x2, v, x2, v, 3.5, -amp);
    popMatrix();
  }
}
