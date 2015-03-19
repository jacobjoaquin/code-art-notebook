PImage img;

void setup() {
  println("Instructions: Add an image in setup().");
  img = loadImage("YOUR_IMAGE_HERE.jpg");
  size(img.width, img.height);
  image(img, 0, 0);
}

int cbrightness(color c) {
  return ((c >> 16) & 0xFF) + ((c >> 8) & 0xFF) + (c & 0xFF);
}

void sortThing(int xPos, int yPos, int tileX, int tileY) {
  for (int y = 1; y < tileY; y++) {
    for (int x = 0; x < tileX; x++) {
      int index = x + xPos + (y + yPos) * width;
      color c = pixels[index];
      color c1 = pixels[index - width];

      if (cbrightness(c) < cbrightness(c1)) {
        //      if (brightness(c) < brightness(c1)) {
        //      if (hue(c) < hue(c1)) {
        //      if (saturation(c) < saturation(c1)) {
        pixels[index] = c1;
        pixels[index - width] = c;
      }
    }
  }
}

void sortThingX(int xPos, int yPos, int tileX, int tileY) {
  for (int y = 0; y < tileY; y++) {
    for (int x = 1; x < tileX; x++) {
      int index = x + xPos + (y + yPos) * width;
      color c = pixels[index];
      color c1 = pixels[index - 1];

      if (cbrightness(c) < cbrightness(c1)) {
        //      if (brightness(c) < brightness(c1)) {
        //      if (hue(c) < hue(c1)) {
        //      if (saturation(c) < saturation(c1)) {
        pixels[index] = c1;
        pixels[index - 1] = c;
      }
    }
  }
}

void sortColorY(int xPos, int yPos, int tileX, int tileY) {
  for (int y = 1; y < tileY; y++) {
    for (int x = 0; x < tileX; x++) {
      int index = x + xPos + (y + yPos) * width;
      color c = pixels[index];
      color c1 = pixels[index - width];

      int r = (c >> 16) & 0xFF;
      int r1 = (c1 >> 16) & 0xFF;           
      if (r < r1) {
        pixels[index] = (r1 << 16) | (c1 & 0xFF00FFFF);
        pixels[index - width] = (r1 << 16) | (c & 0xFF00FFFF);
      }

      r = (c >> 8) & 0xFF;
      r1 = (c1 >> 8) & 0xFF;           
      if (r < r1) {
        pixels[index] = (r1 << 8) | (c1 & 0xFFFF00FF);
        pixels[index - width] = (r1 << 8) | (c & 0xFFFF00FF);
      }

      r = c & 0xFF;
      r1 = c1 & 0xFF;           
      if (r < r1) {
        pixels[index] = (r1 << 0) | (c1 & 0xFFFFFF00);
        pixels[index - width] = (r1 << 0) | (c & 0xFFFFFF00);
      }
    }
  }
}

void sortColorX(int xPos, int yPos, int tileX, int tileY) {
  for (int y = 0; y < tileY; y++) {
    for (int x = 1; x < tileX; x++) {
      int index = x + xPos + (y + yPos) * width;
      color c = pixels[index];
      color c1 = pixels[index - 1];

      int r = (c >> 16) & 0xFF;
      int r1 = (c1 >> 16) & 0xFF;           
      if (r < r1) {
        pixels[index] = (r1 << 16) | (c1 & 0xFF00FFFF);
        pixels[index - 1] = (r1 << 16) | (c & 0xFF00FFFF);
      }

      r = (c >> 8) & 0xFF;
      r1 = (c1 >> 8) & 0xFF;           
      if (r < r1) {
        pixels[index] = (r1 << 8) | (c1 & 0xFFFF00FF);
        pixels[index - 1] = (r1 << 8) | (c & 0xFFFF00FF);
      }

      r = c & 0xFF;
      r1 = c1 & 0xFF;           
      if (r < r1) {
        pixels[index] = (r1 << 0) | (c1 & 0xFFFFFF00);
        pixels[index - 1] = (r1 << 0) | (c & 0xFFFFFF00);
      }
    }
  }
}


void draw() {
  loadPixels();
  int tileSize = 100;

  if (frameCount <= tileSize) {
    for (int y = 0; y < height; y += tileSize) {
      for (int x = 0; x < width; x += tileSize) {
        sortColorX(x, y, tileSize, tileSize);
      }
    }
  } else {
    for (int y = 0; y < height; y += tileSize) {
      for (int x = 0; x < width; x += tileSize) {
        sortColorY(x, y, tileSize, tileSize);
      }
    }
  }

  updatePixels();
}
