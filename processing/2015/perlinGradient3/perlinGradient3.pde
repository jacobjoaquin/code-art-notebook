boolean captureFrames = false;
int nFrames = 128;

Gradient gradient;
float nInc = 0.01;
float nx = 0;
float ny = 100000;
float phase = 0.0;
float phaseInc = 1.0 / nFrames;

void setup() {
  size(500, 500, P2D);
  frameRate(30);

  color c1 = color(0);
  color c2 = color(255, 30, 180);
  float amt1 = 0;
  gradient = new Gradient();
  gradient.add(c2, amt1);
  gradient.add(c2, 10);
  gradient.add(c2, amt1);
  gradient.add(c1, amt1);
  gradient.add(c1, 10);
  gradient.add(c1, amt1);
}

void draw() {
  background(0);

  loadPixels();
  for (int y = 0; y < height; y++) {
    int yOffset = y * width;
    for (int x = 0; x < width; x++) {
      float inc1 = y * nInc + map(sin(y * TWO_PI * nInc), -1, 1, 0, 2);
      float inc2 = x * nInc + map(sin(x * TWO_PI * nInc), -1, 1, 0, 2);
      float v = noise(inc2, inc1);
      v *= 12;
      v += phase;
      v -= int(v);     
      pixels[yOffset + x] = gradient.getColor(v);
    }
  }

  updatePixels();

  phase += phaseInc;
  phase -= int(phase);

  if (captureFrames) {
    saveFrame("./gif/frame#####.gif");
    if (frameCount == nFrames) {
      exit();
    }
  }
}

