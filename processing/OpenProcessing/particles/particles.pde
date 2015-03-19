int nFrames = 16;
float phasor = 0.0;
float phasorInc = 1.0 / (float) nFrames;
ArrayList circles;

void setup() {
  size(500, 500);

  circles = new ArrayList();
  float nCircles = 18.0;

  for (int i = 0; i < (int) nCircles; i++) {
    float n = (float) i / nCircles;
    float d = 32;

    PVector foo = getVCoordinates(new PVector(width / 2, height / 2), 128, n * TWO_PI);
    circles.add(new CirclesOnALine(new PVector(foo.x, foo.y), 
    2, 
    d, 
    n * TWO_PI + HALF_PI));
  }

  background(0);
}

void draw() {
  fill(0, 60);
  noStroke();
  rect(0, 0, width, height);

  int lsSize = circles.size();

  for (int i = 0; i < lsSize; i++) {
    CirclesOnALine thisCircle = (CirclesOnALine) circles.get(i);
    thisCircle.draw();
  }

  updatePhasor();

  /*
  // For creating animated gif
   if (true) {
   int fc = frameCount - 1;
   if (fc >= nFrames * 2 && fc < nFrames * 3) {
   saveFrame("output-####.gif");
   println(frameCount);
   }
   
   if (fc == nFrames * 3) {
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
        c = color(252, 23, 218);
      } else {
        c = color(254, 63, 96);
      }

      stroke(c, 10);
      fill(c);
      ellipse(v1.x, v1.y, r, r);
      v1 = getVCoordinates(v1, d, a);
    } 
    while (v1.x > -r && v1.x < width + r
      && v1.y > -r && v1.y < height + r);
  }
}
