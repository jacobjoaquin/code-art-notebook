int nFrames = 32;
float phasor = 0.0;
float phasorInc = 1.0 / (float) nFrames;
ArrayList circles;
ArrayList shapes1 = new ArrayList();
ArrayList shapes2 = new ArrayList();

void setup() {
  size(500, 500);

  circles = new ArrayList();
  float nCircles = 96.0;
  float squareRadius = 180;
  float circleRadius = 128;
  float circleX = width / 2;
  float circleY = height / 2;
  float squareX = width / 2;
  float squareY = height / 2;

  for (int i = 0; i < (int) nCircles; i++) {
    float n = (float) i / nCircles;
    shapes1.add(getVCoordinates(new PVector(circleX, circleY), circleRadius, n * TWO_PI - QUARTER_PI * 6));
  }

  float nPoints = nCircles / 4;

  for (int i = 0; i < nPoints; i++) {
    float offset = squareY - squareRadius;
    PVector v = new PVector(squareX + squareRadius, offset + (float) i / nPoints * squareRadius * 2);
    shapes2.add(v);
  }

  for (int i = (int) nPoints; i > 0; i--) {
    float offset = squareX - squareRadius;
    PVector v = new PVector(offset + (float) i / nPoints * squareRadius * 2, squareY + squareRadius);
    shapes2.add(v);
  }

  for (int i = (int) nPoints; i > 0; i--) {
    float offset = squareY - squareRadius;
    PVector v = new PVector(squareX - squareRadius, offset + (float) i / nPoints * squareRadius * 2);
    shapes2.add(v);
  }

  for (int i = 0; i < nPoints; i++) {
    float offset = squareX - squareRadius;
    PVector v = new PVector(offset + (float) i / nPoints * squareRadius * 2, squareY - squareRadius);
    shapes2.add(v);
  }

  println(shapes1.size() + " - " + shapes2.size());
  for (int i = 0; i < shapes2.size (); i++) {
    PVector v = (PVector) shapes2.get(i);
    PVector v2 = (PVector) shapes1.get(i);
    float distance = dist(v.x, v.y, v2.x, v2.y);
    float angle = atan2(v2.y - v.y, v2.x - v.x);

    circles.add(new CirclesOnALine(v, 1, distance / 4.0, angle));
  }

  background(0);
}

void draw() {
  background(0);

  int listSize = circles.size();

  for (int i = 0; i < listSize; i++) {
    CirclesOnALine thisCircle = (CirclesOnALine) circles.get(i);
    thisCircle.draw();
  }

  updatePhasor();
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
      color c = color(255, random(255), 0);
      stroke(c, 32);
      fill(c);
      float d2 = dist(width / 2, height / 2, v1.x, v1.y);
      ellipse(v1.x, v1.y, r, r);
      PVector v2 = v1;
      v1 = getVCoordinates(v1, d, a);
      line(v1.x, v1.y, v2.x, v2.y);
    } 
    while (v1.x > -r && v1.x < width + r
      && v1.y > -r && v1.y < height + r);
  }
}
