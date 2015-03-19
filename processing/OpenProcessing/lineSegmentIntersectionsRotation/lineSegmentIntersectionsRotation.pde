int nLines = 256;
int nAngles = 6;
float angleInc = 1.0 / 1024.0;
float minLineSize = 0.0001;

ArrayList<PVector> points;
ArrayList lines;
Phasor anglePhasor;


class LineSegment {
  PVector v1, v2;

  LineSegment(float x1, float y1, float x2, float y2) {
    v1 = new PVector(x1, y1);
    v2 = new PVector(x2, y2);
  }

  LineSegment(PVector v1, PVector v2) {
    this.v1 = new PVector(v1.x, v1.y);
    this.v2 = new PVector(v2.x, v2.y);
  }

  void draw() {
    line(v1.x, v1.y, v2.x, v2.y);
  }
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

PVector getVCoordinates(PVector v, float d, float a) {
  return new PVector(v.x + d * cos(a), v.y + d * sin(a));
}

PVector getIntersection(LineSegment linseg1, LineSegment linseg2) {
  float x1 = linseg1.v1.x;
  float y1 = linseg1.v1.y;
  float x2 = linseg1.v2.x;
  float y2 = linseg1.v2.y;
  float x3 = linseg2.v1.x;
  float y3 = linseg2.v1.y;
  float x4 = linseg2.v2.x;
  float y4 = linseg2.v2.y;
  float d = (y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1);

  if (d == 0) {
    return null;
  }

  float ua = ((y4 - y3) * (x3 - x1) - (x4 - x3) * (y3 - y1)) / d;
  float ub = ((y2 - y1) * (x3 - x1) - (x2 - x1) * (y3 - y1)) / d;

  if (ua < 0.0 || ua > 1.0 || ub < 0.0 || ub > 1.0) {
    return null;
  }

  return new PVector(x1 + ua * (x2 - x1), y1 + ua * (y2 - y1));
}

void setup() {
  size(500, 500);
  points = new ArrayList<PVector>();
  anglePhasor = new Phasor(angleInc);

  for (int i = 0; i < nLines; i++) {
    points.add(new PVector(random(width), random(height), ((float) (i % nAngles) / (float) nAngles) * TWO_PI));
  }
}

void draw() {
  lines = new ArrayList();
  lines.add(new LineSegment(0, 0, width - 1, 0));
  lines.add(new LineSegment(0, 0, 0, height - 1));
  lines.add(new LineSegment(width - 1, 0, width - 1, height - 1));
  lines.add(new LineSegment(width - 1, height - 1, 0, height - 1));

  noStroke();
  fill(0, 48);
  rect(0, 0, width, height);

  for (PVector p : points) {
    stroke(255, random(1.0) < 0.5 ? 0 : 255, 0, 128);
    PVector vCenter = new PVector(p.x, p.y);
    float a = p.z + anglePhasor.phase * TWO_PI;
    PVector v1 = getVCoordinates(vCenter, width * 2, a);
    PVector v2 = getVCoordinates(vCenter, width * 2, a + PI);
    PVector startPoint = new PVector(-1, -1);
    PVector endPoint = new PVector(-1, -1);
    LineSegment t1 = new LineSegment(vCenter, v1);
    LineSegment t2 = new LineSegment(vCenter, v2);

    float distShortest1 = width * 2;
    float distShortest2 = width * 2;

    for (int i = 0; i < lines.size (); i++) {
      LineSegment L = (LineSegment) lines.get(i);
      PVector p1 = getIntersection(t1, L);
      PVector p2 = getIntersection(t2, L);

      if (p1 != null) {
        float distFromCenter = dist(p1.x, p1.y, vCenter.x, vCenter.y);

        if (distFromCenter < distShortest1) {
          distShortest1 = distFromCenter;
          startPoint = p1;
        }
      } else if (p2 != null) {
        float distFromCenter = dist(p2.x, p2.y, vCenter.x, vCenter.y);

        if (distFromCenter < distShortest2) {
          distShortest2 = distFromCenter;
          endPoint = p2;
        }
      }
    }

    if (dist(startPoint.x, startPoint.y, endPoint.x, endPoint.y) > minLineSize &&
      startPoint.x >= 0 && startPoint.y >= 0 && endPoint.x >= 0 && endPoint.y >= 0) {
      v1 = startPoint;
      v2 = endPoint;
      LineSegment finalLine = new LineSegment(v1, v2);
      finalLine.draw();
      lines.add(finalLine);
    }
  }
  anglePhasor.update();
}
