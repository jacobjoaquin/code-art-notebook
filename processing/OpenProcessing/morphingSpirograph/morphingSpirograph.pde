int nFrames = 512;
ArrayList shapes;
Phasor phasor;
Phasor phasorAmp;

class Phasor {
  float phase = 0.0;
  float inc;

  Phasor(float inc_) {
    inc = inc_;
  }

  void update() {
    phase += inc;

    if (phase >= 1.0) {
      phase -= 1.0;
    }
  }
}

class Shapes {
  PVector v;

  Shapes() {
    v = new PVector();
  }

  void update() {
  }
}


class Ring extends Shapes {
  float r;  // Radius

  Ring(float x, float y, float r_) {
    v.x = x;
    v.y = y;
    r = r_;
  }

  void update() {
    ellipse(v.x, v.y, r, r);
  }
}

PVector getVCoordinates(PVector v, float d, float a) {
  return new PVector(v.x + d * cos(a), v.y + d * sin(a));
}

PVector getVCoordinates(float x, float y, float d, float a) {
  return new PVector(x + d * cos(a), y + d * sin(a));
}

void setup() {
  size(500, 500);
  background(0);
  smooth();
  shapes = new ArrayList();
  phasor = new Phasor(1.0 / (float) nFrames);
  phasorAmp = new Phasor(1.0 / (float) nFrames / 4);

  int nShapes =  128; 
  for (int i = 0; i < nShapes; i++) {
    PVector v = getVCoordinates(width * 0.5, height * 0.5, width * 0.25, (float) i / (float) nShapes * TWO_PI * 37);  // 37
    shapes.add(new Ring(v.x, v.y, 2));
  }
}

void draw() {
  // Fade last frame
  noStroke();
  fill(0, 8);
  rect(0, 0, width, height);

  // Draw Shapes
  fill(lerpColor(color(64, 255, 0), color(0, 255, 64), (sin(phasor.phase * TWO_PI * 8) + 1.0) / 2.0));

  noStroke();

  int lsSize = shapes.size();

  for (int i = 0; i < lsSize; i++) {
    pushMatrix();
    float amp = 120.0 * ((cos(phasorAmp.phase * TWO_PI) + 1.0) / 2.0) + 60;
    PVector v = getVCoordinates(0, 0, amp, ((float) i / (float) lsSize + phasor.phase) * TWO_PI);
    translate(v.x, v.y);

    Shapes thisShape = (Shapes) shapes.get(i);
    thisShape.update();
    popMatrix();
  }

  phasor.update();
  phasorAmp.update();
}
