int nFrames = 256;
float phasor = 0.0;
float phasorInc = 1.0 / (float) nFrames;
ArrayList shapes;

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


void updatePhasor() {
  phasor += phasorInc;

  if (phasor >= 1.0) {
    phasor -= 1.0;
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

  int nShapes = 128; 
  for (int i = 0; i < nShapes; i++) {
    PVector v = getVCoordinates(width * 0.5, height * 0.5, width * 0.35, (float) i / (float) nShapes * TWO_PI * 42);
    shapes.add(new Ring(v.x, v.y, 2));
  }
}

void draw() {
  // Fade last frame
  noStroke();
  fill(0, 8);
  rect(0, 0, width, height);

  // Draw Shapes
  fill(lerpColor(color(255, 64, 0), color(32, 128, 255), (sin(phasor * TWO_PI) + 1.0) / 2.0));

  noStroke();

  int lsSize = shapes.size();

  for (int i = 0; i < lsSize; i++) {
    pushMatrix();
    float xOffset = 60.0 * (sin(((float) i / (float) lsSize + phasor) * TWO_PI));
    float yOffset = 60.0 * (cos(((float) i / (float) lsSize + phasor) * TWO_PI));
    translate(xOffset, yOffset);

    Shapes thisShape = (Shapes) shapes.get(i);
    thisShape.update();
    popMatrix();
  }

  updatePhasor();
}
