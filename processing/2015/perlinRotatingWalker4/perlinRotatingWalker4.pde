PVector origin;
PVector position;
float angle;
float perlinInc = 0.0005;
float perlinValue = 0;
int nFrames = 24;
Phasor phasor = new Phasor(1.0 / float(nFrames));
float thingSize = 0;
PGraphics pg;
PGraphics pgBlur;

void setup() {
  size(500, 500);
  origin = new PVector(noise(0), noise(0, 2));
  noStroke();
  fill(0);
  noiseSeed(22);
  pg = createGraphics(width, height);
  pgBlur = createGraphics(width, height);
}

void draw() {
  background(0);
  perlinValue = 0;
  angle = 0;
  position = origin.get();
  phasor.update();
  float phaseOffset = phasor.phase;

  pgBlur.beginDraw();
  pg.beginDraw();
  pgBlur.clear();
  pgBlur.noStroke();
  pgBlur.fill(255, 64, 64);  
  pg.clear();
  pg.noStroke();
  pg.fill(255);
  
  for (int i = 0; i < 25000; i++) {
    float s = 1;
    thingSize = sin(phaseOffset * TWO_PI) * s + s;
    thingSize = max(thingSize, 0);
    pg.ellipse(position.x, position.y, thingSize, thingSize);

    s = 4;
    thingSize = sin(phaseOffset * TWO_PI) * s + s;
    thingSize = max(thingSize, 1);
    pgBlur.ellipse(position.x, position.y, thingSize, thingSize);

    angle += noise(perlinValue) - 0.5;
    perlinValue += perlinInc;
    PVector p = PVector.fromAngle(angle);
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

    phaseOffset += 0.005;
    if (phaseOffset >= 1.0) {
      phaseOffset -= 1.0;
    }
  }
  pg.endDraw();
  pgBlur.filter(BLUR, 2);
  pgBlur.endDraw();
  image(pgBlur, 0, 0);  
  image(pg, 0, 0);  

//  saveFrame("./output/frame####.gif");
//  if (frameCount >= nFrames) {
//    exit();
//  }
}
