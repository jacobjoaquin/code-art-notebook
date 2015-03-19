float phasorInc = 1.0 / 40000.0;
int nReflections = 5;
int nPointsPerFrame = 100;
int nAngles = 32;

Walker w;
Phasor p;
float[] angles;

PVector getVCoordinates(PVector v, float d, float a) {
  return new PVector(v.x + d * cos(a), v.y + d * sin(a));
}

float getAngleFromCenter(PVector v) {
  return atan2(v.y - height / 2, v.x - width / 2);
}

class Phasor {
  float inc;
  float phase;

  Phasor(float inc) {
    this.inc = inc;
  }

  void update() {
    phase += inc;

    while (phase >= 1.0) {
      phase -= 1.0;
    }
    while (phase < 0) {
      phase += 1.0;
    }
  }
}

class Walker {
  PVector v;

  Walker(float x, float y) {
    v = new PVector(x, y);
  }

  void update() {
    v = getVCoordinates(v, 1, angles[int(random(angles.length))]);

    if (v.x >= width) {
      v.x -= width;
    }

    if (v.x < 0) {
      v.x += width;
    }

    if (v.y >= height) {
      v.y -= height;
    }

    if (v.y < 0) {
      v.y += height;
    }

    float a = getAngleFromCenter(v);
    float d = dist(v.x, v.y, width / 2, height / 2);
    PVector center = new PVector(width / 2, height / 2);

    for (int i = 0; i < nReflections; i++) {
      float thisAngle = a + (TWO_PI / (float) nReflections) * i;
      PVector thisV = getVCoordinates(center, d, thisAngle);
      point(thisV.x, thisV.y);
    }
  }
}

void setup() {
  size(600, 600);

  angles = new float[nAngles];
  for (int i = 0; i < angles.length; i++) {
    angles[i] = ((float) i / (float) nAngles) * TWO_PI;
  }

  w = new Walker(width / 2, height / 2);
  p = new Phasor(phasorInc);
  colorMode(HSB);
  background(0);
}

void draw() {
  for (int i = 0; i < nPointsPerFrame; i++) {
    stroke(p.phase * 255, 255, 255, 32);
    p.update();
    w.update();
  }
}

void keyPressed() {
  background(0);
}
