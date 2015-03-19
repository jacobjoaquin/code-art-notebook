PImage img;

void setup() {
  println("Instructions: Add an image in setup().");
  img = loadImage("YOUR_IMAGE_HERE.jpg");
  size(img.width, img.height);
  image(img, 0, 0);
}

void sortThing(int xPos, int yPos, int tileX, int tileY) {
  for (int y = 1; y < tileY; y++) {
    for (int x = 0; x < tileX; x++) {
      int index = x + xPos + (y + yPos) * width;
      color c = pixels[index];
      color c1 = pixels[index - width];

      //      if (brightness(c) < brightness(c1)) {
      if (hue(c) < hue(c1)) {
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

      //      if (brightness(c) < brightness(c1)) {
      if (hue(c) < hue(c1)) {
        //      if (saturation(c) < saturation(c1)) {
        pixels[index] = c1;
        pixels[index - 1] = c;
      }
    }
  }
}

void draw() {
  loadPixels();
  int tileSize = 50;
  for (int y = 0; y < height; y += tileSize) {
    for (int x = 0; x < width; x += tileSize) {
      sortThing(x, y, tileSize, tileSize);
      sortThingX(x, y, tileSize, tileSize);
    }
  } 
  updatePixels();
}
