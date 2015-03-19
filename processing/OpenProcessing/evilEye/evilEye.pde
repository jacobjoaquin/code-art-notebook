int nFrames = 512;
ArrayList shapes;
Phasor phasor;
Phasor phasorAmp;
Phasor phasorWidth;
Phasor phasorHeight;
Phasor phasorRandomness;
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


class VertexShape extends Shapes {

  VertexShape(float x, float y) {
    v.x = x;
    v.y = y;
  }

  void update() {
    vertex(v.x + offsetX, v.y + offsetY);
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
  phasorAmp = new Phasor(1.0 / (float) nFrames * 1.3, 0.5);
  phasorWidth = new Phasor(1.0 / (float) nFrames * 1.7);
  phasorHeight = new Phasor(1.0 / (float) nFrames * 1.9);
  phasorRandomness = new Phasor(1.0 / (float) nFrames / 1.5, 0.75);

  int nShapes = 1024;
  for (int i = 0; i < nShapes; i++) {
    PVector v = getVCoordinates(width * 0.5, height * 0.5, width * 0.125, (float) i / (float) nShapes * TWO_PI * 31);
    shapes.add(new VertexShape(v.x, v.y));
  }
}

void draw() {
  // Fade last frame
  noStroke();
  fill(0, 16);
  rect(0, 0, width, height);

  int lsSize = shapes.size();

  stroke(lerpColor(color(255, 0, 0), color(255, 128, 0), (sin(phasor.phase * TWO_PI * 16) + 1.0) / 2.0));
  strokeWeight(0.5);
  noFill();
  beginShape();
  float amp = 180.0 * ((cos(phasorAmp.phase * TWO_PI) + 1.0) / 2.0) + 60;
  for (int i = 0; i < lsSize; i++) {
    float foo = (float) i / (float) lsSize;
    PVector v = getVCoordinates(0, 0, amp, ((float) i / (float) lsSize + phasor.phase) * TWO_PI);
    float randomness = (sin(phasorRandomness.phase * TWO_PI) + 1.0) / 2.0;
    offsetX = v.x * sin(phasorWidth.phase * TWO_PI) + randomness * random(-10, 10);
    offsetY = v.y * cos(phasorHeight.phase * TWO_PI) + randomness * random(-10, 10);
    Shapes thisShape = (Shapes) shapes.get(i);
    thisShape.update();
  }
  endShape(CLOSE);

  phasor.update();
  phasorAmp.update();
  phasorWidth.update();
  phasorHeight.update();
  phasorRandomness.update();
}
