int nFrames = 128;
Phasor phasor = new Phasor(1.0 / float(nFrames));
float nPos = 0;
float nPosInc = 5.5;

void setup() {
  size(500, 500);
}

void draw() {
  background(255);
  fill(0);
  nPos = 0;
  for (int y = 5; y < height; y += 10) {
    pLine(0, y, width, y, 0, 4, 0.01);
  }
  phasor.update();
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
    PVector warp = warp2(x, y);    
    vertex(x + p.x + warp.x, y + p.y + warp.y);
    dir = 1 - dir;
  }
  endShape();
  popStyle();
}

PVector warp2(float x, float y) {
  PVector center = new PVector(width / 2.0, height / 2.0);
  float r = 130;
  float d = dist(x, y, center.x, center.y);
  if (d > r) {
    return new PVector(0, 0);
  }

  return new PVector(0, random(5));
}

PVector warp1(float x, float y) {
  float warpAmount = 20;
  PVector center = new PVector(width / 2.0, height / 2.0);
  center.add(new PVector(sin(phasor.radians()) * warpAmount, cos(phasor.radians()) * warpAmount));
  float warpAngle = atan2(y - center.y, x - center.x);
  float distFromCenter = dist(x, y, center.x, center.y);
  distFromCenter = width / 2.0 - distFromCenter;
  float warpY = cos(warpAngle) * distFromCenter;
  float warpX = sin(warpAngle) * distFromCenter;
  return new PVector(warpX, warpY);
}
