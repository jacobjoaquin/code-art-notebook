void drawRange(float elevation, float deviation, float inc, float offset, float c) {
  float t = offset;
  for (int x = 0; x < width; x++) {
    float y = noise(t) * deviation + elevation;
    stroke(c);
    line (x, y, x, height);

    for (int i = 0; i < 10; i++) {
      stroke(random(5), 0, 0, 32);
      point(x, random(y, height));
    }
    t += inc;
  }
};

void setup() {
  noLoop();
  size(500, 500);
  background(0);
  float tCloud = 0.0;
  float tCloud2 = 10000.0;
  for (float y = 0; y < 300; y++) {
    tCloud += 0.001;
    for (float x = 0; x < width; x++) {
      stroke(255, 255, 255, noise(tCloud, tCloud2) * 128 + y);
      point(x, y);
      tCloud2 += 0.01;
    }
  }

  // Mountains
  stroke(255, 0, 0);
  float d = 100;
  float nLayers = 5;
  for (float i = 0; i < nLayers; i++) {
    float c = 100 - i * (100 / nLayers);
    drawRange(i * d + 0, 310 - i * 50, 0.015 - i * 0.004, i * 19, c);
    d *= 0.9;
    fill(186, 96, 200, 8);
    rect(0, 0, width, height);
  }
}
