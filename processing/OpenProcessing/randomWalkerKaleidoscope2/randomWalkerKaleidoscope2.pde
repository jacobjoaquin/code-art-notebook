float phasorInc = 1.0 / 40000.0;
int nReflections = 6;
int nPointsPerFrame = 100;
int nAngles = 128;

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

    float offset = width / 4;

    if (v.x >= width + offset) {
      v.x -= width + offset;
    }

    if (v.x < -offset) {
      v.x += width + offset;
    }

    if (v.y >= height + offset) {
      v.y -= height + offset;
    }

    if (v.y < 0) {
      v.y += height + offset;
    }

    float a = getAngleFromCenter(v);
    float d = dist(v.x, v.y, width / 2, height / 2);
    PVector center = new PVector(width / 2, height / 2);
    float rAngle = PI / (float) nReflections;
    stroke(p.phase * 255, 255, 255, map(d, 0, width, 2, 48));

    for (int i = 0; i < nReflections; i++) {
      float thisAngle = a + (TWO_PI / (float) nReflections) * i;

      PVector thisV = getVCoordinates(center, d, thisAngle);
      point(thisV.x, thisV.y);

      thisV = getVCoordinates(center, d, PI - thisAngle);
      point(thisV.x, thisV.y);
    }
  }
}

void setup() {
  size(500, 500);

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
    p.update();
    w.update();
  }
}
