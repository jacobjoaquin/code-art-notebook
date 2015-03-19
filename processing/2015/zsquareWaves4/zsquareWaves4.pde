int nFrames = 256;
Phasor phasor = new Phasor(1.0 / float(nFrames));
Phasor phasor2 = new Phasor(1.0 / float(nFrames));

void setup() {
  size(500, 500, P3D);
  fill(0);
}

void draw() {
  background(255);
  stroke(255);

  pushMatrix();
  translate(width / 2.0, height / 2.0);
  rotate(0.1);
  scale(2);
  weirdBox(3);
  popMatrix();

  phasor.update();
  phasor2.update();
}

void weirdBox(int counter) {
  float offset = 50 + 25 * phasor.sine();
  float s = 25;
  pushMatrix();
  translate(offset, 0, 0);
  rotateX(TWO_PI * phasor.phase);
  rotateY(TWO_PI * phasor.phase);
  rotateZ(TWO_PI * phasor.phase);
  box(s);
  scale(0.5);
  if (counter > 0) {
    weirdBox(counter - 1);
  }
  popMatrix();

  pushMatrix();
  translate(0, 0, offset);
  rotateX(TWO_PI * phasor.phase);
  rotateY(TWO_PI * phasor.phase);
  rotateZ(TWO_PI * phasor.phase);
  box(s);
  scale(0.5);
  if (counter > 0) {
    weirdBox(counter - 1);
  }
  popMatrix();

  pushMatrix();
  translate(0, offset, 0);
  rotateX(TWO_PI * phasor.phase);
  rotateY(TWO_PI * phasor.phase);
  rotateZ(TWO_PI * phasor.phase);
  box(s);
  scale(0.5);
  if (counter > 0) {
    weirdBox(counter - 1);
  }
  popMatrix();

  pushMatrix();
  translate(-offset, 0, 0);
  rotateX(TWO_PI * phasor.phase);
  rotateY(TWO_PI * phasor.phase);
  rotateZ(TWO_PI * phasor.phase);
  box(s);
  scale(0.5);
  if (counter > 0) {
    weirdBox(counter - 1);
  }
  popMatrix();

  pushMatrix();
  translate(0, 0, -offset);
  rotateX(TWO_PI * phasor.phase);
  rotateY(TWO_PI * phasor.phase);
  rotateZ(TWO_PI * phasor.phase);
  box(s);
  scale(0.5);
  if (counter > 0) {
    weirdBox(counter - 1);
  }
  popMatrix();

  pushMatrix();
  translate(0, -offset, 0);
  rotateX(TWO_PI * phasor.phase);
  rotateY(TWO_PI * phasor.phase);
  rotateZ(TWO_PI * phasor.phase);
  box(s);
  scale(0.5);
  if (counter > 0) {
    weirdBox(counter - 1);
  }
  popMatrix();
}

void makeThing() {
  int tileSize = 50;
  int nTiles = width / tileSize;
  float y = height;
  int w = 50;
  int dm = 12;

  for (int x = -w; x < nTiles + w; x++) {
    for (int z = 0; z < nTiles * dm; z++) {
      y = sin(z / 32.0 * TWO_PI + phasor.radians()) * tileSize * 2;
      y += sin(x / 32.0 * TWO_PI + phasor2.radians()) * tileSize * 2 + x * 16;

      PVector p = new PVector(x * tileSize, y, z * -tileSize);
      pushMatrix();
      translate(p.x, p.y, p.z);
      rotateX(PI / 4.0);
      rotateY(PI / 4.0);
      stroke(255);
      box(tileSize / 2.0);
      popMatrix();
    }
  }
}
