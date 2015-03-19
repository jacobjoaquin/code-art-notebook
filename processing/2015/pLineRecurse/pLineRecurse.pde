void setup() {
  size(1000, 1000, P2D);
  noLoop();
  noStroke();
  fill(240);
  println("Wait for it. This one takes time.");
}

void draw() {
  background(32);
  float d = 5;
  translate(width / 2.0, height / 2.0);
  rotate(-HALF_PI);
  doThing(0, PI, d, sqrt(2) * width / 2.0);
  doThing(PI, PI, d, sqrt(2) * width / 2.0);
  noiseify();
}

void doThing(float a, float aDiv, float d, float dMax) {
  float dInc = 50;
  PVector p = PVector.fromAngle(a);
  PVector p2 = p.get();
  p.mult(d);
  d += dInc;
  p2.mult(d);
  aDiv /= 2.0;
  float arc1 = a - aDiv;
  float arc2 = a + aDiv;
  pLine(p.x, p.y, p2.x, p2.y, 0, 2, 0.1);
  pArc(0, 0, arc1, arc2, p2.mag(), 0, 2, 0.01);

  if (d < dMax) {
    doThing(arc1, aDiv, d, dMax);
    doThing(arc2, aDiv, d, dMax);
  }
}

void pArc(float x, float y, float a1, float a2, float r, float wMin, float wMax, float perlinInc) {
  float perlin = random(10000);
  float d = ceil(r * abs(a1 - a2));
  int dir = 1;

  beginShape(TRIANGLE_STRIP);
  for (int i = 0; i <= d + 1; i++) {
    float a = lerp(a1, a2, i / d);
    PVector p1 = PVector.fromAngle(a);
    p1.mult(r);
    PVector p = PVector.fromAngle(a + PI * dir);
    p.mult(map(noise(perlin), 0, 1, wMin, wMax));
    p.add(p1);
    perlin += perlinInc;
    vertex(p.x, p.y);
    dir = 1 - dir;
  }
  endShape();
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
    float amt = 8;
    float rnd = random(-amt, amt);
    pixels[i] = color(bright + rnd);
  }
  updatePixels();
}
