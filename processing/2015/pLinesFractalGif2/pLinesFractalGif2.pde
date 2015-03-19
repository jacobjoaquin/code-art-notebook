int nFrames = 112;
Phasor phasor = new Phasor(1.0 / float(nFrames));
int nBranches = 7;
float dInc = 45;
float theNoise = 0.0;
float theNoiseInc = 3.23;

void setup() {
  size(500, 500, P2D);
  noStroke();
  fill(32);
}

void draw() {
  background(240);
  theNoise = 0.0;
  float d = 1;
  translate(width / 2.0, height / 2.0);
  rotate(-HALF_PI);
  float anglePlus = phasor.radians();
  doThing(anglePlus, TWO_PI / 3.0, d, nBranches);
  doThing(anglePlus + TWO_PI / 3.0, TWO_PI / 3, d, nBranches);
  doThing(anglePlus + 2 * TWO_PI / 3.0, TWO_PI / 3, d, nBranches);
  phasor.update();
}

void doThing(float a, float aDiv, float d, float counter) {
  PVector p = PVector.fromAngle(a);
  PVector p2 = p.get();
  p.mult(d);
  d += dInc;
  p2.mult(d);
  aDiv /= 2.0;

  float phaseOffset =  HALF_PI * counter / float(nBranches);
  float foo = 1;
  float aMinus = map((sin(phasor.radians() + PI + phaseOffset) * foo), -1, 1, 0, aDiv);
  float aPlus = map((sin(phasor.radians()+ phaseOffset) * foo), -1, 1, 0, aDiv);

  float arc1 = a - aMinus;
  float arc2 = a + aPlus;
  pushStyle();
  stroke(0);
  popStyle();
  pLine(p.x, p.y, p2.x, p2.y, 1, 2, 0.1);
  pArc(0, 0, arc1, arc2, p2.mag(), 0, 2, 0.01);
  
  if (counter > 0) {
    doThing(arc1, aDiv, d, counter - 1);
    doThing(arc2, aDiv, d, counter - 1);
  }
}

void pArc(float x, float y, float a1, float a2, float r, float wMin, float wMax, float perlinInc) {
  float perlin = theNoise;
  theNoise += theNoiseInc;
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
  float perlin = theNoise;
  theNoise += theNoiseInc;
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
