int nFrames = 16;
float phasor = 0.0;
float phasorInc = 1.0 / (float) nFrames;
ArrayList circles;

void setup() {
  size(500, 500);

  circles = new ArrayList();
  float nCircles = 32.0;

  for (int i = 0; i < (int) nCircles; i++) {
    float n = (float) i / nCircles;
    float d = n * 64 + 1;

    circles.add(new CirclesOnALine(new PVector(n * width, n * height), 
    n * 5 + 0.5, 
    d, 
    n * TWO_PI));
  }
}

void draw() {
  background(0);
  noStroke();

  int lsSize = circles.size();

  for (int i = 0; i < lsSize; i++) {
    float n = (float) i / lsSize;
    float offset = -PI * 1.0 * n + PI * 0.25;
    CirclesOnALine thisCircle = (CirclesOnALine) circles.get(i);
    float a = thisCircle.a;
    thisCircle.a = a + n * PI * 0.5;
    thisCircle.draw();
    thisCircle.a = a;
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
      color c;

      if (random(1.0) < 0.5) {
        c = color(64, 255, 255);
      } else {
        c = color(64, 64, 255);
      }

      fill(c);
      ellipse(v1.x, v1.y, r, r);
      stroke(c, 32);

      PVector v2 = getVCoordinates(v1, d, a);
      line(v1.x, v1.y, v2.x, v2.y);
      v1 = getVCoordinates(v1, d, a);
    } 
    while (v1.x > -r && v1.x < width + r
      && v1.y > -r && v1.y < height + r);
  }
}
