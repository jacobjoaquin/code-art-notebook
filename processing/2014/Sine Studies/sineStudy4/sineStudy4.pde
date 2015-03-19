float phase = 0.0;

void sineLine(float x1, float y1, float x2, float y2, float nCycles, float amp) {
  float d = dist(x1, y1, x2, y2);
  int d2 = ceil(d);
  beginShape();

  for (int i = 0; i <= d2; i++) {
    float p = float(i) / d;
    float v = lerp(x1, x2, p);
    float v2 = lerp(y1, y2, p);

    float thisPhase = phase;

    float s = sin((p + thisPhase) * nCycles * TWO_PI) * amp;
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
  colorMode(HSB);
  background(32);
}

void draw() {
  background(32);
  noFill();
  stroke(190, 221, 50, 128);

  for (int i = 0; i < 1; i++) {
    pushMatrix();    
    translate(width / 2.0, height / 2.0);

    rotate(i * PI / 2.0);
    circleWithSines(0, 0, width / 2.125, 12, 0.047, 3);
    popMatrix();
  }

  float nFrames = 50.0;

  phase += 1.0 / 3.0 * (1.0 / nFrames);
  if (phase >= 1.0) {
    phase -= 1.0;
  }
}

void circleWithSines(float xpos, float ypos, float r, int nLines, float amp, float xfreq) {
  for (int i = 0; i < nLines; i++) {
    float d = float(i) / float(nLines - 1);
    float y2 = lerp(-r, r, d);
    stroke(d * 40 + 210, 212, 255, 180);
    pushMatrix();
    translate(xpos, ypos);
    float x2 = sqrt(r * r - y2 * y2);
    float amp2 = dist(-x2, y2, x2, y2) * amp;
    if (i % 2 == 0) {
      x2 *= -1;
    }
    sineLine(-x2, y2, x2, y2, xfreq, amp2); 
    pushMatrix();    
    rotate(PI / 2.0);
    sineLine(-x2, y2, x2, y2, xfreq, amp2);
    popMatrix();
    popMatrix();
  }
}
