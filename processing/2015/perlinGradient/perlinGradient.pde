boolean captureFrames = false;
int nFrames = 64;

Gradient gradient;
float nInc = 0.1;
float nx = 0;
float ny = 100000;
float phase = 0.0;
float phaseInc = 1.0 / nFrames;

void setup() {
  size(500, 500, P2D);
  frameRate(30);
  
  color c = color(255, 32, 80);
  float amt = 0.3;
  gradient = new Gradient();
  gradient.add(color(0), amt);
  gradient.add(c, amt);
  gradient.add(c, 10);
  gradient.add(c, amt);
  gradient.add(color(0), amt);
}

void draw() {
  background(0);
  
  loadPixels();
  for (int y = 0; y < height / 2; y++) {
    int yOffset = y * width;
    for (int x = 0; x < width / 2; x++) {
      float inc = nInc * pow(dist(0, 0, x, y) / width, 4);
      float v = noise(x * inc, y * inc);
      v *= 2;
      v += phase;
      v -= int(v);     
      pixels[yOffset + x] = gradient.getColor(v);
    }
  }
  
  for (int y = 0; y < height / 2; y++) {
    int yOffset = y * width;
    for (int x = 0; x < width / 2; x++) {
      pixels[yOffset + width - x - 1] = pixels[yOffset + x];
    }
  }

  for (int y = 0; y < height / 2; y++) {
    int yOffset = y * width;
    for (int x = 0; x < width; x++) {
      pixels[((height - 1) * width - y * width - 1) + x] = pixels[yOffset + x];
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
