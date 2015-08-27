boolean captureFrames = false;
int nFrames = 32;

float nxInc = 0.01;
float nyInc = nxInc;
float nx = 0;
float ny = 1000;

float phase = 0.0;
float phaseInc = 1.0 / float(nFrames);

void setup() {
  size(500, 500, P2D);
  colorMode(HSB);
}

void draw() {
  loadPixels();

  for (int y = 0; y < height; y++) {
    int yOffset = y * width;

    for (int x = 0; x < width; x++) {
      float d = dist(x, y, width / 2.0, height / 2.0);
      d /= 100.0;
      float n = noise(nx + x * nxInc * d, ny + y * nyInc * d);
      n += phase;
      n *= 4;      
      n -= int(n);
      pixels[x + yOffset] = color(n * 255.0, 80, 255);
    }
  }  
  updatePixels();

  phase += phaseInc;
  phase -= int(phase);

  if (captureFrames) {  
    saveFrame("./gif/frame#####.gif");
    if (frameCount == nFrames / 4) {
      exit();
    }
  }
}

