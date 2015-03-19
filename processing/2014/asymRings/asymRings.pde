ArrayList<AsymRing> aRings;


class AsymRing {
  class Slice {
    float a1, a2;

    Slice (float a1, float a2) {
      this.a1 = a1;
      this.a2 = a2;
    }
  }

  float startDistance;
  float endDistance;
  float offset = 0;
  float minWidth = PI / 16.0;
  float maxWidth = PI / 2.0;
  private ArrayList<Slice> slices;
  float spacer = 0;


  AsymRing(float startDistance, float endDistance) {
    this.startDistance = startDistance;
    this.endDistance = endDistance;
    offset = random(TWO_PI);
    generateSlices();
  }

  private void generateSlices() {
    slices = new ArrayList<Slice>();

    float angleCount = 0;

    while (angleCount < TWO_PI) {
      float dWidth = random(minWidth, maxWidth);
      float a1 = angleCount + offset;
      float a2 = a1 + dWidth;
      if (a2 > offset + TWO_PI - spacer) {
        a2 = offset + TWO_PI - spacer;
      }
      Slice s = new Slice(a1, a2);
      slices.add(s);      
      angleCount += dWidth + spacer;
    }
  }

  void update() {
    generateSlices();
  }

  void draw() {
    for (Slice s : slices) {
      beginShape();
      PVector p1 = PVector.fromAngle(s.a1);
      PVector p2 = PVector.fromAngle(s.a2);
      PVector p3 = PVector.fromAngle(s.a2);
      PVector p4 = PVector.fromAngle(s.a1);
      p1.mult(startDistance);
      p2.mult(startDistance);
      p3.mult(endDistance);
      p4.mult(endDistance); 
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
      vertex(p3.x, p3.y);
      vertex(p4.x, p4.y);
      vertex(p1.x, p1.y);
      endShape();
    }
  }
}

void setup() {
  size(500, 500);
  aRings = new ArrayList<AsymRing>();

  float d = 0.1;
  float offset = 0;
  while (d < (width / 2.0 * sqrt (2))) {
    AsymRing ar = new AsymRing(d, d * 1.05);
    ar.spacer = PI / 32.0;
    ar.minWidth = PI / 2.0 - ar.spacer;
    ar.maxWidth = PI / 2.0 - ar.spacer;
    ar.offset = offset;
    offset += PI / 64.0;    
    ar.update();
    aRings.add(ar);
    d *= 1.1;
  }
}

void draw() {
  background(0);
  stroke(0, 128);

  translate(width / 2.0, height / 2.0);
  int counter = 0;

  for (AsymRing ar : aRings) {
    pushMatrix();
    float direction = counter++ % 2 == 0 ? 1 : -1; 
    rotate(float(frameCount - 1) / 120.0 * TWO_PI * direction);
    ar.draw();
    popMatrix();
  }

  if (false) {
    if ((frameCount - 1) < 30) {
      saveFrame("gif/ani_#####.gif");
    } else {
      exit();
    }
  }
}
