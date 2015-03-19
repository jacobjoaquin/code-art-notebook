void setup() {
  size(500, 500);
  pushStyle();
  colorMode(HSB);
  for (int i = 0; i < 2000; i++) {
    fill(int(random(8)) * 4, 255, random(255));
    ellipse(random(width), random(height), 50, 50);
  }
  popStyle();
}

void draw() {
  loadPixels();

  int s = 1;
  int totalSize = width * height;
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int index = x + y * width;
      color c = pixels[index];

      int x1 = -s;
      int x2 = s;
      int y1 = -s;
      int y2 = s;

      if (brightness(c) < 128) {
        y1 *= 2;
        y2 = 0;
      }

      int r = round(random(x1, x2)) + round(random(y1, y2)) * width;
      r += index;

      if (r >= 0 && r < totalSize) {
        pixels[index] = pixels[r];
        pixels[r] = c;
      }
    }
  }

  updatePixels();
}
