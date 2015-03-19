int tileSize = 250;
float phasor = 0.0;
float phasorInc = 1.0 / 120.0;
OLine oline;

class OLine {
  int nOLines;
  float[] offsets;

  OLine() {
    nOLines = 96;
    offsets = new float[nOLines];
    for (int i = 0; i < nOLines; i++) {
      offsets[i] = random(1);
    }
  }

  void draw() {
    for (int i = 0; i < nOLines; i++) {
      float a = (float) i / (float) nOLines * TWO_PI;
      PVector start = distAngle(1, a);
      start.mult(tileSize / 2);
      PVector end = distAngle(1, a);
      float phase = phasor + offsets[i];
      if (phase >= 1.0) {
        phase -= 1.0;
      }
      float v = sin(phase * TWO_PI) + 1.0;
      v *= 0.5;
      end.mult(tileSize * v);
      line(start.x, start.y, end.x, end.y);
      fill(0);
      ellipse(end.x, end.y, 3, 3);
    }
  }
}

PVector distAngle(float d, float a) {
  return new PVector(d * cos(a), d * sin(a));
}

void setup() {
  size(500, 500);
  oline = new OLine();
}

void draw() {
  background(180);
  pushMatrix();
  translate(width / 2, height / 2);
  oline.draw();
  popMatrix();
  phasor += phasorInc;
  if (phasor >= 1.0) {
    phasor -= 1.0;
  }
}
