float nFrames = 60;
boolean captureOn = false;

float phase = 0.0;
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
  float minWidth = PI / 2.0;
  float maxWidth = PI / 2.0;
  private ArrayList<Slice> slices;
  float spacer = 0;
  int arcResolution = 6;

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
      beginShape(TRIANGLE_STRIP);
      for (int i = 0; i < arcResolution; i++) {
        float interp = float(i) / float(arcResolution - 1);        
        float angle = lerp(s.a1, s.a2, interp);
        PVector p1 = PVector.fromAngle(angle);
        PVector p2 = PVector.fromAngle(angle);
        p1.mult(startDistance);
        p2.mult(endDistance);
        vertex(p1.x, p1.y);
        vertex(p2.x, p2.y);
      }
      endShape();
    }
  }
}

void setup() {
  size(500, 500, P2D);
  aRings = new ArrayList<AsymRing>();

  float d = 0.1;
  float offset = 0;
  while (d < (width / 2.0 * sqrt (2))) {
    AsymRing ar = new AsymRing(d, d * 1.05);
    ar.spacer = PI / 12.0;
    ar.minWidth = PI / 5.0 - ar.spacer;
    ar.maxWidth = PI / 5.0 - ar.spacer;
    ar.offset = offset;
    offset += PI / 5.0;    
    ar.update();
    aRings.add(ar);
    d *= 1.05;
  }
}

void draw() {
  background(255);
  noStroke();
  fill(245, 0, 0);

  translate(width / 2.0, height / 2.0);

  int counter = 0; 
  for (AsymRing ar : aRings) {
    float thisPhase = sin(((1 - phase) + (float(counter++) / 45.0)) * TWO_PI);
    pushMatrix();
    rotate(thisPhase * TWO_PI / 8.0);
    ar.draw();
    popMatrix();
  }

  phase += 1.0 / nFrames;
  if (phase >= 1.0) {
    phase -= 1.0;
  }

  // Capture frames 
  if (captureOn) {
    if ((frameCount - 1) < nFrames) {
      saveFrame("gif/ani_#####.gif");
    } else {
      exit();
    }
  }
}
