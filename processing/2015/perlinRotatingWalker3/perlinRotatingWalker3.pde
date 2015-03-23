PVector position;
float angle;
float perlinInc = 0.003;
float perlinValue = 0;
int nFrames = 64;
Phasor phasor = new Phasor(1.0 / float(nFrames));

void setup() {
  size(500, 500);  
  position = new PVector(width / 2.0, height / 2.0);
  angle = random(TWO_PI);
  noStroke();
  fill(0, 32);
  background(240);
}

void draw() {
  background(255);
  perlinValue = 0;
  angle = 0;
  phasor.phase = 0;
  position.x = width / 2.0;
  position.y = height / 2.0;
  for (int i = 0; i < 10000; i++) {
    doThing();
    phasor.update();
  }
}

void doThing() {
  float s = map(phasor.phase, 0, 1, 10, 0);
  ellipse(position.x, position.y, s, s);
  angle += noise(perlinValue) - 0.5;
  perlinValue += perlinInc;
  PVector p = PVector.fromAngle(angle);
  p.mult(2);
  position.add(p);
  if (position.x < 0) {
    position.x += width;
  }
  if (position.x >= width) {
    position.x -= width;
  }
  if (position.y < 0) {
    position.y += height;
  }
  if (position.y >= height) {
    position.y -= height;
  }
}
