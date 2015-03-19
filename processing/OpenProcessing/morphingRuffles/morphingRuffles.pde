int nFrames = 512;
ArrayList shapes;
Phasor phasor;
Phasor phasorAmp;
Phasor phasorWidth;
Phasor phasorHeight;
Phasor phasorWeight;
float offsetX;
float offsetY;

class Phasor {
  float phase = 0.0;
  float inc;

  Phasor(float inc_) {
    inc = inc_;
  }

  Phasor(float inc_, float phase_) {
    inc = inc_;
    phase = phase_;
  }

  void update() {
    phase += inc;

    if (phase >= 1.0) {
      phase -= 1.0;
    }
    if (phase < 0.0) {
      phase += 1.0;
    }
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
    ellipse(v.x + offsetX, v.y + offsetY, r, r);
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
  phasorAmp = new Phasor(1.0 / (float) nFrames * 2.5, 0.5);
  phasorWidth = new Phasor(1.0 / (float) nFrames * 1.1);
  phasorHeight = new Phasor(1.0 / (float) nFrames * 1.617);
  phasorWeight = new Phasor(1.0 / (float) nFrames * 1.444, 0.75);

  int nShapes = 512;
  for (int i = 0; i < nShapes; i++) {
    float foo = (sin((float) i / (float) nShapes * TWO_PI * 8) + 1.0) * 0.5 * 25 + 80;
    PVector v = getVCoordinates(width * 0.5, height * 0.5, foo, (float) i / (float) nShapes * TWO_PI * 1);
    shapes.add(new Ring(v.x, v.y, 2));
  }
}

void draw() {
  // Fade last frame
  noStroke();
  fill(0, 6);
  rect(0, 0, width, height);

  int lsSize = shapes.size();

  color c = lerpColor(color(255, 0, 128), color(255, 0, 32), (sin(phasor.phase * TWO_PI * 4) + 1.0) / 2.0);
  noStroke();
  fill(c);

  float amp = 180.0 * ((cos(phasorAmp.phase * TWO_PI) + 1.0) / 2.0) + 80;
  for (int i = 0; i < lsSize; i++) {
    float foo = (float) i / (float) lsSize;
    PVector v = getVCoordinates(0, 0, amp, ((float) i / (float) lsSize + phasor.phase) * TWO_PI);
    float randomness = (sin(phasorWeight.phase * TWO_PI) + 1.0) / 2.0;
    offsetX = v.x * sin(phasorWidth.phase * TWO_PI);
    offsetY = v.y * cos(phasorHeight.phase * TWO_PI);
    Ring thisShape = (Ring) shapes.get(i);
    thisShape.update();
  }

  phasor.update();
  phasorAmp.update();
  phasorWidth.update();
  phasorHeight.update();
  phasorWeight.update();
}
