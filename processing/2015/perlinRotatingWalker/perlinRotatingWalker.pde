PVector position;
float angle;
float perlinInc = 0.003;
float perlinValue = 0;

void setup() {
  size(1500, 1500);  
  position = new PVector(width / 2.0, height / 2.0);
  angle = random(TWO_PI);
  noStroke();
  fill(0, 32);
  background(240);
}

void draw() {
  for (int i = 0; i < 50000; i++) {
    doThing();
  }

  if (frameCount >= 10) {
    noiseify(12);
    noLoop();
  }
}

void doThing() {
  ellipse(position.x, position.y, 2, 2);
  angle += noise(perlinValue) - 0.5;
  perlinValue += perlinInc;
  PVector p = PVector.fromAngle(angle);
  p.mult(0.5);
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
