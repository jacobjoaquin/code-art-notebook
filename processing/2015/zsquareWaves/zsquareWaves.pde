int nFrames = 48;
Phasor phasor = new Phasor(1.0 / float(nFrames));
Phasor phasor2 = new Phasor(1.0 / float(nFrames));

void setup() {
  size(500, 500, P3D);
  noStroke();
  fill(0);
}

void draw() {
  background(255);

  pushMatrix();
  translate(0, height * 1.5);
  makeThing();
  popMatrix();

  pushMatrix();
  translate(0, height / -1.5);
  makeThing();
  popMatrix();

  phasor.update();
  phasor2.update();
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
      y += sin(x / 32.0 * TWO_PI + phasor2.radians()) * tileSize * 2;
      beginShape();
      PVector p = new PVector(x * tileSize, y, z * -tileSize);
      vertex(p.x, p.y, p.z);
      vertex(p.x + tileSize, p.y, p.z);
      vertex(p.x + tileSize, p.y, p.z - tileSize);
      vertex(p.x, p.y, p.z - tileSize);      
      endShape(CLOSE);
    }
  }
}
