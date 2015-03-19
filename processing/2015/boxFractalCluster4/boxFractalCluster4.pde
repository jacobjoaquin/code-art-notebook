int nFrames = 96;
Phasor phasor = new Phasor(1.0 / float(nFrames));

void setup() {
  size(500, 500, P3D);
  fill(255, 0, 128);
  stroke(128, 0, 64);
  sphereDetail(12, 12);
}

void draw() {

  background(32);
  translate(width / 2.0, height / 2.0, -width / 2.0);
  float s = 200;
  drawThing(3, s * 0.5, s, 0.5);
  phasor.update();
}

void drawThing(int counter, float boxSize, float distance, float boxScale) {
  pushMatrix();
  ArrayList<PVector> offsets = new ArrayList<PVector>();

  offsets.add(new PVector(1, 0, 0));
  offsets.add(new PVector(-1, 0, 0)) ;
  offsets.add(new PVector(0, 1, 0));
  offsets.add(new PVector(0, -1, 0));
  offsets.add(new PVector(0, 0, 1));
  offsets.add(new PVector(0, 0, -1));

  int temp = 0;

  if (counter >= 1) {  
    for (PVector o : offsets) {
      pushMatrix();
      PVector c = o.get();
      c.mult(distance);
      translate(c.x, c.y, c.z);

      rotateY(o.y * HALF_PI + phasor.radians());
      rotateZ(temp * HALF_PI + phasor.radians());
      temp++;
      drawThing(counter - 1, boxSize * boxScale, distance * boxScale, boxScale);
      box(boxSize);
      popMatrix();
    }
  }
  popMatrix();
}
