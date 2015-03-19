int nFrames = 256;
float phasor = 0.0;
float phasorInc = 1.0 / (float) nFrames;
ArrayList lineSegments;
boolean recordOn = true;

void setup() {
  size(500, 500);
  background(255);
  smooth();
  lineSegments = new ArrayList();
  int nLines = 256;

  for (int i = 0; i < nLines; i++) {
    PVector v = getVCoordinates(width / 2, height / 2, width / 6, (float) i / (int) nLines * TWO_PI * 2);
    lineSegments.add(new LineSegment(v.x, v.y, 200, (float) i / (float) nLines * TWO_PI * -1));
  }
}

void draw() {
  // Fade last frame
  noStroke();
  background(250, 235, 215);

  // Draw lines
  stroke(129, 69, 19, 96);
  strokeWeight(1);

  int lsSize = lineSegments.size();

  for (int i = 0; i < lsSize; i++) {
    pushMatrix();
    float xOffset = 80.0 * (sin(((float) i / (float) lsSize + phasor) * TWO_PI));
    float yOffset = 80.0 * (cos(((float) i / (float) lsSize + phasor) * TWO_PI));
    translate(xOffset, yOffset);

    LineSegment thisLineSeg = (LineSegment) lineSegments.get(i);
    thisLineSeg.update();
    popMatrix();
  }

  updatePhasor();
}

void updatePhasor() {
  phasor += phasorInc;

  if (phasor >= 1.0) {
    phasor -= 1.0;
  }
}

class LineSegment {
  float x, y, d, a;  // x position, y position, distance, angle

  LineSegment(float x_, float y_, float d_, float a_) {
    x = x_;
    y = y_;
    d = d_;
    a = a_;
  }

  void update() {
    float a1 = a + phasor * TWO_PI;
    float x1 = x + d * cos(a1);
    float y1 = y + d * sin(a1);
    line(x, y, x1, y1);
  }
}

PVector getVCoordinates(float x, float y, float d, float a) {
  return new PVector(x + d * cos(a), y + d * sin(a));
}
