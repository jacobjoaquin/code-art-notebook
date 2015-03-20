float phasor = 0.0;
float phasorInc;

float nFrames = 60;
void setup() {
  size(500, 500); 
  phasorInc = 1 / nFrames;
}

void draw() {
  background(0);
  fill(255, 128, 255);
  noStroke();
  int nPacs = 33;
  float s = 1.0 / float(nPacs);
  float offset = s * width * 0.5;
  translate(offset, offset);

  for (int y = 0; y < nPacs; y++) {
    for (int x = 0; x < nPacs; x++) {
      pushMatrix();
      float x1 = float(x) / float(nPacs) * width;
      float y1 = float(y) / float(nPacs) * height;
      translate(x1, y1);
      float s2 = 0.617;
      scale(s * s2, s * s2);
      float d = dist((nPacs - 1) * 0.5, (nPacs - 1) * 0.5, x, y);
      d = map(d, 0, nPacs * 0.5, 0, 1);
      float d2 = d * 180;
      fill(255 - d2, 0, 255 - d2);
      d *= 1;
      pac((1 - phasor) + d, PI + atan2(y1 - height / 2.0 + offset, x1 - width / 2.0 + offset));
      popMatrix();
    }
  }
  phasor += phasorInc;
  if (phasor >= 1.0) {
    phasor -= 1.0;
  }
}

void pac(float phase, float angleOffset) {
  float maximum = PI;
  float amount = map(sin(phase * TWO_PI), -1.0, 1.0, 0, maximum);
  arc(0, 0, width, height, amount + angleOffset, TWO_PI - amount + angleOffset);
}
