int nFrames = 196;
Phasor phasor = new Phasor(1.0 / float(nFrames));
Phasor phasor2 = new Phasor(1.0 / float(nFrames));

void setup() {
  size(500, 500, P3D);
  fill(0);
  stroke(255, 128, 0);
}

void draw() {
  background(32);
  translate(width / 2.0, height / 2.0, -width / 2.0);

  float s = 80;
  drawThing(5, s, s, 0.5);
  phasor.update();
  phasor2.update();
}

void drawThing(int counter, float boxSize, float distance, float boxScale) {
  ArrayList<PVector> offsets = new ArrayList<PVector>();

  offsets.add(new PVector(1, 0, 0));
  offsets.add(new PVector(-1, 0, 0));
  offsets.add(new PVector(0, 1, 0));
  offsets.add(new PVector(0, -1, 0));
  offsets.add(new PVector(0, 0, 1));
  offsets.add(new PVector(0, 0, -1));

  for (PVector o : offsets) {
    pushMatrix();
    PVector c = o.get();
    c.mult(distance);
    translate(c.x, c.y, c.z);

    if (counter > 1) {
      float m = 1;
      translate(c.x * m, c.y * m, c.z * m);    
      rotateX(o.x * phasor.phase * TWO_PI);
      rotateY(o.y * phasor.phase * TWO_PI);
      rotateZ(o.z * phasor.phase * TWO_PI);
      box(boxSize);
      drawThing(counter - 1, boxSize * boxScale, distance * boxScale, boxScale);
    }
    popMatrix();
  }
}
