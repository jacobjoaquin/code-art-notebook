int nFrames = 96;
Phasor phasor = new Phasor(1.0 / float(nFrames));
float nPos = 0;
float nPosInc = 5.5;
float border = 50;
ArrayList<PVector> theYs;

void setup() {
  size(1500, 1500, P2D);
  noLoop();
  theYs = new ArrayList<PVector>();

  float nn = 0.0;

  for (int y = -55; y < height + 205 * 3; y += 10 * 3) {
    float y1 = map(noise(nn), 0, -1, -150, 150);
    float y2 = map(noise(nn + 100), 0, -1, -150, 150);
    theYs.add(new PVector(y + y1, y + y2));

    nn += 0.3;
  }
}

void draw() {
  background(32);
  fill(240);
  nPos = 0;

  for (PVector p : theYs) {  
    pLine(0, p.x, width, p.y, 1, 4, 0.005);
  }

  phasor.update();
  noiseify();
}

void pLine(float x1, float y1, float x2, float y2, float wMin, float wMax, float perlinInc) {
  float perlin = nPos;
  nPos += nPosInc;
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

    PVector warp = warp3(x, y);

    vertex(x + p.x + warp.x, y + p.y + warp.y);
    dir = 1 - dir;
  }
  endShape();
  popStyle();
}

PVector warp3(float x, float y) {
  PVector center = new PVector(width / 2.0, height / 2.0);
  center.add(new PVector(0, cos(phasor.radians())));
  float a = atan2(y - center.y, x - center.x);
  float r = width / 3.0;
  float d = dist(x, y, center.x, center.y);
  if (d > r) {
    return new PVector(0, 0);
  }

  PVector p = PVector.fromAngle(a);
  p.mult((r - d) / r * 120 * 3);
  return new PVector(p.x / 150.0, p.y);
}

PVector warp2(float x, float y) {
  PVector center = new PVector(width / 2.0, height / 2.0);
  float r = width / 3.0;
  float d = dist(x, y, center.x, center.y);
  if (d > r) {
    return new PVector(0, 0);
  }

  return new PVector(0, random(5));
}

PVector warp1(float x, float y) {
  float warpAmount = 120;
  PVector center = new PVector(width / 2.0, height / 2.0);
  center.add(new PVector(sin(phasor.radians()) * warpAmount, cos(phasor.radians()) * warpAmount));
  float warpAngle = atan2(y - center.y, x - center.x);
  float distFromCenter = dist(x, y, center.x, center.y);
  distFromCenter = width / 2.0 - distFromCenter;
  float warpY = cos(warpAngle) * distFromCenter;
  float warpX = sin(warpAngle) * distFromCenter;
  return new PVector(warpX, warpY);
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
