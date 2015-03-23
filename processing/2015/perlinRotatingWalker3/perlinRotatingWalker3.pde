PVector position;
float angle;
float perlinInc = 0.0003;
float perlinValue = 0;
int nFrames = 64;
Phasor phasor = new Phasor(1.0 / float(nFrames));
float thingSize = 0;
PVector origin;

void setup() {
  size(500, 500);
  origin = new PVector(random(width), random(height));
  angle = random(TWO_PI);
  noStroke();
  fill(0, 32);
  fill(0);
  background(240);
  noiseSeed(8);
}

void draw() {
  background(255);
  perlinValue = 0;
  angle = 0;
  position = origin.get();
  phasor.update();
  float phaseOffset = phasor.phase;
  for (int i = 0; i < 50000; i++) {
    doThing();
    phaseOffset += 0.002;
    if (phaseOffset >= 1.0) {
      phaseOffset -= 1.0;
    }
    thingSize = map(phaseOffset, 0, 1, 5, -5);
    thingSize = max(thingSize, 0);
  }
  
//  saveFrame("./output/frame####.gif");
//  if (frameCount > nFrames) {
//    exit();
//  }
}

void doThing() {
  ellipse(position.x, position.y, thingSize, thingSize);
  angle += noise(perlinValue) - 0.5;
  perlinValue += perlinInc;
  PVector p = PVector.fromAngle(angle);
  p.mult(1);
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
