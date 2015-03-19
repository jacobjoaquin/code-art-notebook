import java.util.Collections;
import java.util.Comparator;
PImage img;
int tileSize = 100;

void setup() {
  println("Instructions: Add an image in setup().");
  img = loadImage("YOUR_IMAGE_HERE.jpg");  
  size(img.width, img.height);
  image(img, 0, 0);
}

void draw() {
  loadPixels();
  radialSort();  
  updatePixels();
}

void radialSort() {
  for (int i = 0; i < 1; i++) {
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        int index = x + y * width;
        color c = pixels[index];      
        float h = cbrightness(c) / (3.0 * 255.0);
        PVector p = PVector.fromAngle(h * TWO_PI + PI / 2.0);
        float m = random(2.0, 5.0);
        p.mult(m);
        p.x = int(p.x + x);
        p.y = int(p.y + y);

        if (p.x >= 0 && p.x < width && p.y >= 0 && p.y < height && dist(x, y, p.x, p.y) < m + 1) {
          int index1 = int(p.x) + int(p.y) * width;
          color c1 = pixels[index1];
          if (hue(c) > hue(c1)) {
            pixels[index] = c1;
            pixels[index1] = c;
          }
        }
      }
    }
  }
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
