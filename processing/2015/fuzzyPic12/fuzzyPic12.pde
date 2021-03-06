import java.util.Collections;
import java.util.Comparator;
PImage img;
Phasor phasor = new Phasor(1.0 / 64.0);
int tileSize = 100;

ArrayList<PVector> hotSpots;

void setup() {
  println("Instructions: Add an image in setup().");
  img = loadImage("YOUR_IMAGE_HERE.jpg");  
  size(img.width, img.height);
  image(img, 0, 0);
  hotSpots = new ArrayList<PVector>();

  for (int i = 0; i < 7; i++) {
    PVector p = new PVector(random(width), random(height));
    println(p);
    hotSpots.add(p);
  }

  loadPixels();
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      color c = pixels[x + y * width];
      int r = c >> 16 & 0xFF;
      int g = c >> 8 & 0xFF;
      int b = c & 0xFF;
      if (r == 255 && r == g && r ==b) {
        r--;
        pixels[x + y * width] = int(r) << 16 | int(g) << 8 | int(b);
      } else if (r == 0 && r == g && r ==b) {
        r++;
        pixels[x + y * width] = int(r) << 16 | int(g) << 8 | int(b);
      }
    }
  }
  updatePixels();
}


void draw() {
  noLoop();
  lineSense();  
  phasor.update();
}


void lineSense() {
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  pg.background(0);
  int nAngles = 64;
  float d = 6.0;
  int closest = 0;
  float bDiff = 500;

  stroke(0);
  PVector center = new PVector(width / 2.0, height / 2.0);

  int tSize = 4;
  for (int y = 0; y < height; y += tSize) {
    for (int x = 0; x < width; x += tSize) {
      closest = 0;
      bDiff = 500;

      center = new PVector(x, y);
      for (int a = 0; a < nAngles; a++) {
        float angle = float(a) / float(nAngles) * TWO_PI;
        PVector p = PVector.fromAngle(angle);
        p.mult(d);
        p.add(center);
        if (p.x >= 0 && p.x < width && p.y >= 0 && p.y < height) {
          float b = brightness(x + y * width);
          float b1 = brightness(pixels[int(p.x) + int(p.y) * width]);
          float tempBDiff = abs(b - b1);
          if (tempBDiff < bDiff) {
            closest = a;
            bDiff = tempBDiff;
          }
        }
      }
      PVector p = PVector.fromAngle(float(closest) / float(nAngles) * TWO_PI + phasor.phase * TWO_PI);
      p.mult(8);
      p.add(center);
      color c = pixels[x + y * width];
      pg.stroke(c);
      pg.line(x, y, p.x, p.y);
    }
  }

  pg.endDraw();
  image(pg, 0, 0);
}

PVector getClosestHotSpot(float x, float y) {
  PVector closest = new PVector(width * 2, height * 2);
  for (PVector hs : hotSpots) {
    if (dist(hs.x, hs.y, x, y) < dist(closest.x, closest.y, x, y)) {
      closest = hs.get();
    }
  }
  return closest;
}

void radialHotSpot() {
  for (int i = 0; i < 1; i++) {
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        PVector closest = getClosestHotSpot(x, y);
        PVector here = new PVector(x, y);
        float angle = atan2(closest.y - here.y, closest.x - here.x);
        int index = x + y * width;
        color c = pixels[index];      
        float h = hue(c) / 255.0;
        PVector p = PVector.fromAngle(h * TWO_PI + angle + 3.0 * PI / 2.0);
        float m = 2;
        p.mult(m);
        p.x = int(p.x + x);
        p.y = int(p.y + y);

        if (p.x >= 0 && p.x < width && p.y >= 0 && p.y < height && dist(x, y, p.x, p.y) < m + 1) {
          int index1 = int(p.x) + int(p.y) * width;
          color c1 = pixels[index1];
          if (cbrightness(c) > cbrightness(c1)) {
            //          if (hue(c) > hue(c1)) {
            pixels[index] = c1;
            pixels[index1] = c;
          }
        }
      }
    }
  }
}

void radialSort() {
  for (int i = 0; i < 10; i++) {
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
