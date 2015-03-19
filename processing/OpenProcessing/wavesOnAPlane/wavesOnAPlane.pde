int nFrames = 180;
float phasor = 0.0;
float phasorInc = 1.0 / (float) nFrames;
ArrayList circles;
CirclesOnALine coal;

void setup() {
  size(500, 500);

  circles = new ArrayList();
  float nCircles = 128.0;

  for (int i = 0; i < (int) nCircles; i++) {
    float n = (float) i / nCircles;
    float d = n * 64 + 1;
    float randomAngle = 0.25 * (1 - n);

    circles.add(new CirclesOnALine(new PVector(width / 2, n * height * 0.618 + height * (1 - 0.618)), 
    n * 2 + 0.5, 
    d, 
    i % 2 * PI * random(-randomAngle, randomAngle)));
  }
}

void draw() {
  background(0);
  noStroke();

  int lsSize = circles.size();

  for (int i = 0; i < lsSize; i++) {
    float n = (float) i / lsSize;
    float offset = PI * 0.7 * n + 0.05;
    CirclesOnALine thisCircle = (CirclesOnALine) circles.get(i);
    thisCircle.a = (sin((1 - phasor + n) * TWO_PI * 2) + 1.0) * 0.5 * offset - (offset / 2);
    thisCircle.draw();
  }

  updatePhasor();

  /*
  // For creating animated gif
   if (true) {
   if (frameCount - 1 < nFrames) {
   saveFrame("output-####.gif");
   println(frameCount);
   }
   
   if (frameCount - 1 == nFrames) {
   exit();
   }
   }
   */
}

PVector getVCoordinates(PVector v, float d, float a) {
  return new PVector(v.x + d * cos(a), v.y + d * sin(a));
}

void updatePhasor() {
  phasor += phasorInc;

  if (phasor >= 1.0) {
    phasor -= 1.0;
  }
}

class CirclesOnALine {
  PVector v;
  float r, d, a;  // radius, distance, angle

  CirclesOnALine(PVector v_, float r_, float d_, float a_) {
    v = v_;
    r = r_;
    d = d_;
    a = a_;
  }

  void draw() {
    PVector v1 = getVCoordinates(v, d * phasor, a + PI);

    while (v1.x > -r && v1.x < width + r
      && v1.y > -r && v1.y < height + r) {
      v1 = getVCoordinates(v1, d, a + PI);
    }

    do {
      if (random(1.0) < 0.5) {
        fill(0, 255, 0);
      } else {
        fill(255, 255, 0);
      }

      ellipse(v1.x, v1.y, r, r);
      v1 = getVCoordinates(v1, d, a);
    } 
    while (v1.x > -r && v1.x < width + r
      && v1.y > -r && v1.y < height + r);
  }
}

boolean inBounds(float x, float y) {
  return (x > 0 && x <= width && y > 0 && y < height);
}
