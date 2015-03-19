int nPoints = 2048;
int nBranches = 3;
float minLineSize = 2.0;

ArrayList<LineSegment> lines;
ArrayList<PVector> points;
ArrayList<Figure> figures;
Phasor anglePhasor;
Phasor distancePhasor;
Phasor spiralPhasor;

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

class Figure {
  PVector v;
  ArrayList<LineSegment> lineSegments;

  Figure() {
    lineSegments = new ArrayList<LineSegment>();
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

void reset() {
  lines = new ArrayList<LineSegment>();
  lines.add(new LineSegment(0, 0, width - 1, 0));
  lines.add(new LineSegment(0, 0, 0, height - 1));
  lines.add(new LineSegment(width - 1, 0, width - 1, height - 1));
  lines.add(new LineSegment(width - 1, height - 1, 0, height - 1));
  anglePhasor = new Phasor(1.0 / 8.0);
  distancePhasor = new Phasor(0.0305);
  spiralPhasor = new Phasor(0.00620112);

  for (int i = 0; i < height; i++) {
    float l = (float) i / height;
    color c = lerpColor(color(255), color(128), l);
    stroke(c);
    line(0, i, width, i);
  }
}

void generatePoints() {
  for (int i = 0; i < nPoints; i++) {
    PVector c = new PVector(width / 2, height / 2);
    PVector p = getVCoordinates(c, 
    map(sin(distancePhasor.phase * TWO_PI), -1.0, 1.0, width / 2, 0), 
    spiralPhasor.phase * TWO_PI);
    float a = anglePhasor.phase * TWO_PI;
    points.add(new PVector(p.x, p.y, a));

    anglePhasor.update();
    distancePhasor.update();
    spiralPhasor.update();
  }
}

void generateLineSegments() {
  for (PVector p : points) {
    float a = p.z;

    ArrayList<PVector> vectors = new ArrayList<PVector>();
    ArrayList<PVector> endPoints = new ArrayList<PVector>();
    ArrayList<LineSegment> tempLines = new ArrayList<LineSegment>();
    float[] shortestDistances = new float[nBranches];

    for (int i = 0; i < nBranches; i++) {
      vectors.add(getVCoordinates(p, width * 2, a + TWO_PI * (float) i / nBranches));
      endPoints.add(new PVector(-1, -1));
      tempLines.add(new LineSegment(p, vectors.get(i)));
      shortestDistances[i] = width * 2;
    }

    for (LineSegment L : lines) {
      for (int i = 0; i < nBranches; i++) {
        PVector intersection = getIntersection(tempLines.get(i), L);
        if (intersection != null) {
          float distanceFromCenter = dist(intersection.x, intersection.y, p.x, p.y);

          if (distanceFromCenter < shortestDistances[i]) {
            shortestDistances[i] = distanceFromCenter;
            endPoints.set(i, intersection);
          }
        }
      }
    }

    boolean areEndPointsValid = true;

    for (int i = 0; i < nBranches; i++) {
      PVector ep = endPoints.get(i);

      if (!(dist(ep.x, ep.y, p.x, p.y) > minLineSize &&
        ep.x >= 0 && ep.y >= 0)) {
        areEndPointsValid = false;
      }
    }

    if (areEndPointsValid) {
      Figure thisFigure = new Figure();
      thisFigure.v = p;

      for (PVector ep : endPoints) {
        LineSegment finalLine = new LineSegment(p, ep);
        lines.add(finalLine);
        thisFigure.lineSegments.add(finalLine);
      }

      figures.add(thisFigure);
    }
  }
}

void setup() {
  points = new ArrayList<PVector>();
  figures = new ArrayList<Figure>();
  size(800, 800);
  reset();
  generatePoints();
  generateLineSegments();
}

void draw() {
  background(250, 235, 215);
  noLoop();

  for (Figure f : figures) {
    for (int i = 0; i < nBranches; i++) {
      LineSegment l1 = f.lineSegments.get(i);
      LineSegment l2 = f.lineSegments.get((i + 1) % nBranches);
      pushStyle();
      fill(random(255), 0, random(255), 32);
      noStroke();
      beginShape();
      vertex(f.v.x, f.v.y);
      vertex(l1.v2.x, l1.v2.y);
      vertex(l2.v2.x, l2.v2.y);
      endShape();
      popStyle();
    }
  }

  for (Figure f : figures) {
    for (LineSegment l : f.lineSegments) {
      pushStyle();
      stroke(129, 69, 19, 180);
      l.draw();
      popStyle();
    }
  }
}
