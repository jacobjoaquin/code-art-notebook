float phase = 0;
float segs = 16;
int nFrames = 256;
float phaseInc = 1.0 / float(nFrames);

void setup() {
  size(500, 500);
  noiseSeed(9);
}

void draw() {
  background(16);
  float tileSize = 10;
  float diameter = sqrt(2) * tileSize * 0.5;
  float m = 0.002;
  noStroke();
  colorMode(HSB);
  translate(tileSize / 2.0, tileSize / 2.0);

  for (float y = 0; y < height; y += tileSize) {
    for (float x = 0; x < width; x += tileSize) {
      float n = noise(x * m, y * m);
      float b = map(n, -1, 1, 0, 1);
      b = constrain(b, 0, 1);
      b += phase;
      if (b >= 1.0) {
        b -= 1.0;
      }
      fill(212, 192, ((b * segs) * 128) % 128 * 2);
      ellipse(x, y, diameter, diameter);
    }
  }

  phase += phaseInc;
  if (phase >= 1.0) {
    phase -= 1.0;
  }
}
