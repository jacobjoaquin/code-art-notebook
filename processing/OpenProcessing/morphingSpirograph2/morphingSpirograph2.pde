int nFrames = 256;
ArrayList shapes;
Phasor phasor;
Phasor phasorAmp;

class Phasor {
  float phase = 0.5;
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
    PVector v = getVCoordinates(width * 0.5, height * 0.5, width * 0.333, (float) i / (float) nShapes * TWO_PI * 16);  // 37
    shapes.add(new Ring(v.x, v.y, 3));
  }
}

void draw() {
  // Fade last frame
  noStroke();
  fill(0, 4);
  rect(0, 0, width, height);

  int lsSize = shapes.size();

  for (int i = 0; i < lsSize; i++) {
    pushMatrix();
    if (random(1.0) > 0.5) {
      fill(252, 23, 218);
    } else {
      fill(254, 63, 96);
    }

    float amp = 300.0 * ((cos(phasorAmp.phase * TWO_PI) + 1.0) / 2.0) + 10;
    PVector v = getVCoordinates(0, 0, amp, ((float) i / (float) lsSize + phasor.phase) * TWO_PI);
    translate(v.x, v.y);

    Shapes thisShape = (Shapes) shapes.get(i);
    thisShape.update();
    popMatrix();
  }

  phasor.update();
  phasorAmp.update();
}
