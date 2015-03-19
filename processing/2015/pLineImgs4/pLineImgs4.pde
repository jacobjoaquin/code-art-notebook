PImage img;
PImage img2;
int border = 25;
int m = 1;         // Times larger than original image
int h = 8;         // Space between rows
int nFrames = 256;
Phasor p = new Phasor(1.0 / float(nFrames));
Phasor p2 = new Phasor(1.0 / float(nFrames));

void setup() {
  println("Instructions: Add an image in setup().");
  img = loadImage("YOUR_IMAGE_HERE.jpg");
  size(img.width * m + border * 2, img.height * m + border * 2, P2D);
  noStroke();
  fill(32);
}

void draw() {
  background(240);
  translate(border, border + h / 2.0);    

  for (int y = 0; y < img.height; y += h) {
    line(0, y, width, y);
    img.loadPixels();
    img2.loadPixels();
    beginShape(TRIANGLE_STRIP);
    int yWidth = y * img.width;
    for (int x = 0; x < img.width; x += 1) {
      if (x + yWidth < img.width * img.height) {
        float xPhase = float(x) / float(img.width);
        color c = img.pixels[x + yWidth];
        float thickness = (255 - brightness(c)) / 255.0 * (h / 2.0);
        thickness = max(1, thickness);

        color c2 = img2.pixels[x + yWidth];
        float thickness2 = (255 - brightness(c2)) / 255.0 * (h / 1.5);
        thickness2 = max(1, thickness2);

        float t = lerp(thickness, thickness2, map(sin(p.radians() + xPhase * TWO_PI * 2), -1, 1, 0, 1));
        vertex(x * m, y * m + t * m);
        vertex(x * m, y * m - t * m);
      }
    }
    endShape();
    img.updatePixels();
    img2.updatePixels();
  }

  p.update();  
  p2.update();  
}

void noiseify() {
  loadPixels();
  float imgSize = width * height;
  for (int i = 0; i < imgSize; i++) {
    color c = pixels[i];  
    float bright = brightness(c);
    float amt = 12;
    float rnd = random(-amt, amt);
    pixels[i] = color(bright + rnd);
  }
  updatePixels();
}
