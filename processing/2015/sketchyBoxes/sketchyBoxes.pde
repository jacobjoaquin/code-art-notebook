void setup() {
  size(1500, 1500, P2D);
}

void draw() {
  background(248);
  noStroke();
  fill(32);
  noLoop();

  int nTiles = 5;
  boolean doRotate = true;
  float tileSize = width / float(nTiles);
  for (float y = 0; y < height; y += tileSize) {
    for (float x = 0; x < width; x += tileSize) {
      pushMatrix();
      float offset = width / 2.0;
      scale(0.5);
      translate(offset, offset);
      translate(x, y);
      if (doRotate) {
        rotate(-HALF_PI);
        translate(tileSize * -1, 0);
      }
      doRotate = !doRotate;
      drawSquare(3, tileSize, 0.003);
      popMatrix();
    }
    if (nTiles % 2 == 0) {
      doRotate = !doRotate;
    }
  }

  noiseify();
}

void drawSquare(int nLines, float w, float perlinInc) {
  float coef = w / float(nLines);
  float n = random(1000);
  float ny = 0.13;

  for (int y = 0; y < nLines; y++) {
    float s = w * 0.25;
    float y1 = (noise(n) - 0.5) * s + coef / 2.0;
    n += ny;
    float y2 = (noise(n) - 0.5) * s + coef / 2.0;
    n += ny;
    pLine(0.0, y * coef + y1, w, y * coef + y2, 2.0, 18.0, perlinInc);
  }
}


void pLine(float x1, float y1, float x2, float y2, float wMin, float wMax, float perlinInc) {
  float perlin = random(10000);
  int d = ceil(dist(x1, y1, x2, y2));
  int dir = 1;
  float angle = atan2(y1 - y2, x1 - x2);
  pushStyle();
  noStroke();
  beginShape(TRIANGLE_STRIP);
  for (int i = 0; i <= d; i++) {
    float x = lerp(x1, x2, i / float(d));
    float y = lerp(y1, y2, i / float(d));
    PVector p = PVector.fromAngle(angle + HALF_PI + PI * dir);
    p.mult(map(noise(perlin), 0, 1, wMin, wMax));
    perlin += perlinInc;
    vertex(x + p.x, y + p.y);
    dir = 1 - dir;
  }
  endShape();
  popStyle();
}

void noiseify() {
  loadPixels();
  float imgSize = width * height;
  for (int i = 0; i < imgSize; i++) {
    color c = pixels[i];  
    float bright = brightness(c);
    float amt = 12;
    float rnd = random(-amt, amt);
    pixels[i] = color(bright + rnd);
  }
  updatePixels();
}
