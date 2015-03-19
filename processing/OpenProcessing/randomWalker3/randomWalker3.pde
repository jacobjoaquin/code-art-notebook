float phasorInc = 1.0 / 53030.0;
float phasorInc2 = 1.0 / 90000.0;
int nReflections = 4;
int nPointsPerFrame = 1000;
int nAngles = 8;

Walker w;
Phasor p;
Phasor p2;
float[] angles;
Palette palette;

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
    float gauss = p2.phase * random(2);
    v = getVCoordinates(v, gauss, angles[int(random(angles.length))]);

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
    noStroke();
    fill(palette.getNorm(p.phase), map(d, 0, width, 64, 12));
    gauss = max(0.5, gauss / 2);

    for (int i = 0; i < nReflections; i++) {
      float thisAngle = a + (TWO_PI / (float) nReflections) * i;

      PVector thisV = getVCoordinates(center, d, thisAngle);
      ellipse(thisV.x, thisV.y, gauss, gauss);

      thisV = getVCoordinates(center, d, PI - thisAngle);
      ellipse(thisV.x, thisV.y, gauss, gauss);
    }
  }
}

class Palette {
  ArrayList<Integer> colors;

  Palette() {
    colors = new ArrayList<Integer>();
  }

  void add(color c) {
    colors.add(c);
  }

  color getNorm(float p) {
    int index = (int) (p * colors.size());
    color c1 = colors.get(index);
    color c2 = colors.get((index + 1) % colors.size());

    return lerpColor(c1, c2, p * colors.size() - index);
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
  p2 = new Phasor(phasorInc2);

  palette = new Palette();
  /*
  The Scream
   Palette by COLOURlover
   http://www.colourlovers.com/palette/85378/The_Scream
   */
  palette.add(color(11, 17, 13));
  palette.add(color(44, 77, 86));
  palette.add(color(195, 170, 114));
  palette.add(color(220, 118, 18));
  palette.add(color(189, 50, 0));

  color c = palette.getNorm(0.0);
  for (int i = 0; i < height; i++) {
    stroke(lerpColor(color(32), color(0), (float) i / (float) height));
    line(0, i, width, i);
  }
}

void draw() {
  for (int i = 0; i < nPointsPerFrame; i++) {
    p.update();
    p2.update();
    w.update();
  }
}
