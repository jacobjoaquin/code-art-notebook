void sineLine(float x1, float y1, float x2, float y2, float nCycles, float amp) {
  float d = dist(x1, y1, x2, y2);
  int d2 = ceil(d);
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
  size(1000, 1000, P2D);
  noLoop();
  blendMode(ADD);
}

void draw() {
  background(0);
  fill(0, 190, 170, 8);
  stroke(190, 221, 50, 8);
  circleWithSines(width / 2.0, height / 2.0, width, 128, 0.15, 1, -3.);
  fill(0, 190, 170, 32);
  stroke(190, 221, 50, 128);
  circleWithSines(width / 2.0, height / 2.0, width / 2.5, 196, -0.06, -1.5, -2);
}

void circleWithSines(float xpos, float ypos, float r, int nLines, float amp, float xfreq, float yfreq) {
  for (int i = 0; i < nLines; i++) {
    float d = float(i) / float(nLines - 1);
    float y2 = lerp(-r, r, d);
    
    pushMatrix();
    translate(xpos, ypos);
    float x2 = sin(d * TWO_PI * yfreq) * r;
    float amp2 = dist(-x2, y2, x2, y2) * amp;
    sineLine(-x2, y2, x2, y2, xfreq, amp2);
    popMatrix();
  }
}
