int c = 255;

void setup() {
  size(500, 500);
  noStroke();
  noLoop();
}

void draw() {
  background(0);
  int nTiles = 6;
  float s = width / (float) nTiles;
  translate(s * 0.5, s * 0.5);

  float ratio = width / 500.0;
  for (int y = 0; y < nTiles; y++) {
    for (int x = 0; x < nTiles; x++) {
      pushMatrix();
      translate(s * x, s * y);
      scale(s / (float) width);
      c = 255;
      float foo = map(x, 0, nTiles, 50, 10) * ratio;
      float bar = map(y, 0, nTiles, -PI, PI / 3);
      cic(width / 2, foo, 0, bar);
      popMatrix();
    }
  }
}

void cic(float radius, float rSub, float angle, float aAdd) {
  pushMatrix();
  do {
    fill(c);
    c = 255 - c;
    ellipse(0, 0, radius * 2, radius * 2);
    radius -= rSub;
    angle += aAdd;
    float r = rSub * 0.6;
    float x = cos(angle + aAdd) * r;
    float y = sin(angle + aAdd) * r;
    translate(x, y);
  } 
  while (radius >= 1);
  popMatrix();
}
