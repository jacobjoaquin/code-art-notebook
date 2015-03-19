int nFrames = 256;
float phasor = 0.0;
float phasorInc = 1.0 / (float) nFrames;
ArrayList lineSegments;

void setup() {
  size(500, 500);
  background(255);
  smooth();
  lineSegments = new ArrayList();

  float nLines = 64.0;

  for (int i = 0; i < (int) nLines; i++) {
    PVector v = getVCoordinates(width / 2, height / 2, width / 6, (float) i / nLines * TWO_PI);
    lineSegments.add(new LineSegment(v.x, v.y, width, (float) i / nLines * TWO_PI));
  }
}

void draw() {
  noStroke();
  background(192);
  stroke(32);
  strokeWeight(1);

  int lsSize = lineSegments.size();

  for (int i = 0; i < lsSize; i++) {
    float xOffset = 80.0 * (sin(((float) i / (float) lsSize + phasor) * TWO_PI));
    float yOffset = 80.0 * (cos(((float) i / (float) lsSize + phasor) * TWO_PI));

    pushMatrix();
    translate(xOffset, yOffset);
    LineSegment thisLineSeg = (LineSegment) lineSegments.get(i);
    thisLineSeg.update();
    popMatrix();
  }

  updatePhasor();
}

PVector getVCoordinates(float x, float y, float d, float a) {
  return new PVector(x + d * cos(a), y + d * sin(a));
}

void updatePhasor() {
  phasor += phasorInc;

  if (phasor >= 1.0) {
    phasor -= 1.0;
  }
}

class LineSegment {
  float x, y, d, a;  // x position, y position, distance, angle in radians

  LineSegment(float x_, float y_, float d_, float a_) {
    x = x_;
    y = y_;
    d = d_;
    a = a_;
  }

  void update() {
    float a1 = a + phasor * 2* TWO_PI;
    float x1 = x + d * cos(a1);
    float y1 = y + d * sin(a1);
    line(x, y, x1, y1);
  }
}
