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

void draw() {
  loadPixels();
  int tileSize = 100;

  if (frameCount <= tileSize) {
    for (int y = 0; y < height; y += tileSize) {
      for (int x = 0; x < width; x += tileSize) {
        sortThing(x, y, tileSize, tileSize);
      }
    }
  } else {
    for (int y = 0; y < height; y += tileSize) {
      for (int x = 0; x < width; x += tileSize) {
        //        sortThingX(x, y, tileSize, tileSize);
      }
    }
  }

  updatePixels();
}
