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

  for (int i = 0; i < 70; i++) {
    PVector v = getVCoordinates(width * 0.5, height * 0.5, random(width * 0.25, width * 0.333), random(TWO_PI));
    shapes.add(new Ring(v.x, v.y, random(width / 12.0, width / 5.0)));
  }
}

void draw() {
  // Fade last frame
  noStroke();
  fill(0, 16);
  rect(0, 0, width, height);

  // Draw Shapes
  noFill();
  strokeWeight(1);

  int lsSize = shapes.size();

  for (int i = 0; i < lsSize; i++) {
    if (random(1.0) > 0.5) {
      stroke(252, 23, 218, 96);
    } else {
      stroke(254, 63, 96);
    }
    pushMatrix();
    float xOffset = 25.0 * (sin(((float) i / (float) lsSize + phasor) * TWO_PI));
    float yOffset = 25.0 * (cos(((float) i / (float) lsSize + phasor) * TWO_PI));
    translate(xOffset, yOffset);

    Shapes thisShape = (Shapes) shapes.get(i);
    thisShape.update();
    popMatrix();
  }

  updatePhasor();
}
