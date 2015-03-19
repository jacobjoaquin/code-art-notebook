float phase = 0.0;
float mfoo = 0;

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

    float dfc = dist(0, 0, x3, y3);
    s = map(dfc, 0, 500, 0, 1) * s;

    if (abs(dfc) > mfoo) {
      println(dfc);
      mfoo = dfc;
    }
    
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
  background(250);
  noFill();
  stroke(190, 221, 50, 128);

  float the_freq = 3.0;

  for (int i = 0; i < 1; i++) {
    pushMatrix();    
    translate(width / 2.0, height / 2.0);
    rotate(i * PI / 2.0);
    circleWithSines(0, 0, width / 5.0, 12, 0.1, the_freq);
    popMatrix();
  }
  
  float nFrames = 50.0;
  
  phase += 1.0 / the_freq * (1.0 / nFrames);
  if (phase >= 1.0) {
    phase -= 1.0;
  }
}

void circleWithSines(float xpos, float ypos, float r, int nLines, float amp, float xfreq) {
  for (int i = 0; i < nLines; i++) {
    float d = float(i) / float(nLines - 1);
    float y2 = lerp(-r, r, d);
    
    stroke(0, 0, 32 + d * 120, 255);
    pushMatrix();
    translate(xpos, ypos);
    float x2 = width / 2.0;
    float amp2 = dist(-x2, y2, x2, y2) * amp;
    
    sineLine(-x2, y2, x2, y2, xfreq, amp2); 
    pushMatrix();    
    rotate(PI / -2.0);
    sineLine(-x2, y2, x2, y2, xfreq, amp2);
    popMatrix();
    popMatrix();
  }
}
