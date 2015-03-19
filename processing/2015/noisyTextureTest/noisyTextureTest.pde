float phase = 0;
float segs = 16;
int nFrames = 256;
float phaseInc = 1.0 / float(nFrames);

void setup() {
  size(1000, 1000);
}

void draw() {
  noLoop();
  color c = color(180, 20, 64);
  loadPixels();

  float imgSize = width * height;
  for (int i = 0; i < imgSize; i++) {  
    float r = c >> 16 & 0xFF;
    float g = c >> 8 & 0xFF;
    float b = c & 0xFF;
    float vr = 0.1;
    float vg = 0.02;
    float vb = 0.05;
    r *= random(1 - vr, 1 + vr);
    g *= random(1 - vg, 1 + vg);
    b *= random(1 - vb, 1 + vb);
    r = constrain(r, 0, 255);
    g = constrain(g, 0, 255);
    b = constrain(b, 0, 255);

    pixels[i] = (int(r) << 16) + (int(g) << 8) + (int(b));
  }
  updatePixels();

  fill(0, 64);
  float tileSize = 100;
  pushMatrix();
  translate(tileSize / 2.0, tileSize / 2.0);
  for (int y = 0; y < height; y += tileSize) {
    for (int x = 0; x < width; x += tileSize) {
      ellipse(x, y, tileSize * 0.717, tileSize * 0.717);
    }
  }
  popMatrix();

  pushMatrix();
  translate(width / 2.0, height / 2.0);
  noStroke();
  color c2 = changeBrightness(c, 0.5);
  fill(c2, 128);
  ellipse(0, 0, width / 2.0, height / 2.0);
  popMatrix();
}

color changeBrightness(color c, float amt) {
  float r = red(c);
  float g = green(c);
  float b = blue(c);
  float a = alpha(c);
  return color(r * amt, g * amt, b * amt, a);
}
