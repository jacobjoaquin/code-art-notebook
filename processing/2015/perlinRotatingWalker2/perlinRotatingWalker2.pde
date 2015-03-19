PVector position;
float angle;
float perlinInc = 0.0003;
float perlinValue = 0;
float perlinInc2 = 0.0000003;
float perlinValue2 = 1000;
int w = 1200;
int h = 1200;
int border = 300;
PShader blur;
int nFrames = 30;

void setup() {
  size(w + border * 2, h + border * 2);
  position = new PVector(random(w), random(h));
  angle = random(TWO_PI);
  noStroke();
  fill(0, 32);
  background(0);
}

void draw() {
  translate(border, border);
  PGraphics pg = createGraphics(w, h);
  pg.beginDraw();
  pg.noStroke();
  pg.fill(32, 128, 0, map(frameCount, 1, nFrames, 1, 48));
  for (int i = 0; i < 80000; i++) {
    doThing(pg);
  }
  pg.filter(BLUR, abs(map(frameCount, 1, nFrames, -30, 0))); 
  pg.endDraw();
  image(pg, 0, 0);
  if (frameCount >= 10) {
    noiseify(12);
    noLoop();
  }
}

void doThing(PGraphics pg) {
  pg.ellipse(position.x, position.y, 2, 2);
  angle += noise(perlinValue, perlinValue2) - 0.5;
  perlinValue += perlinInc;

  float s = map(noise(perlinValue2), 0, 1, 0.25, 1);
  perlinValue2 += perlinInc2;
  s = 0.5;

  PVector p = PVector.fromAngle(angle);
  p.mult(s);
  position.add(p);
  if (position.x < 0) {
    position.x += w;
  }
  if (position.x >= w) {
    position.x -= w;
  }
  if (position.y < 0) {
    position.y += h;
  }
  if (position.y >= h) {
    position.y -= h;
  }
}

void noiseify(float amt) {
  loadPixels();
  float imgSize = width * height;
  for (int i = 0; i < imgSize; i++) {
    color c = pixels[i];  
    float bright = brightness(c);
    float rnd = random(-amt, amt);
    pixels[i] = color(bright + rnd);
  }
  updatePixels();
}
