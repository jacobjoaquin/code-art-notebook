int nFrames = 128;
float phasor = 0.0;
float phasorInc = 1.0 / (float) nFrames;
ArrayList lineSegments;

void setup() {
  size(500, 500);
  background(255);
  smooth();
  lineSegments = new ArrayList();

  for (int i = 0; i < 160; i++) {
    lineSegments.add(new LineSegment(random(width), random(height), random(20, 70), random(TWO_PI)));
  }
}

void draw() {
  // Fade last frame
  noStroke();
  fill(255, 8);
  rect(0, 0, width, height);

  // Draw lines
  stroke(0, 64);
  strokeWeight(32);

  int lsSize = lineSegments.size();

  for (int i = 0; i < lsSize; i++) {
    pushMatrix();
    float xOffset = 80.0 * (sin(((float) i / (float) lsSize + phasor) * TWO_PI));
    float yOffset = 80.0 * (cos(((float) i / (float) lsSize + phasor) * TWO_PI));
    translate(xOffset + random(5), yOffset + random(5));

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
    float a1 = a + phasor * 2* TWO_PI;
    float x1 = x + d * cos(a1);
    float y1 = y + d * sin(a1);
    line(x, y, x1, y1);
  }
}
