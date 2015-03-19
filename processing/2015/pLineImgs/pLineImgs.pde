PImage img;
int border = 200;

void setup() {
  println("Instructions: Add an image in setup().");
  img = loadImage("YOUR_IMAGE_HERE.jpg");
  size(img.width + border * 2, img.height + border * 2, P2D);
  noLoop();
  noStroke();
  fill(0);
}

void draw() {
  translate(border, border);
  background(240);
  fill(32);
  int h = 30;

  for (int y = 0; y < img.height; y += h) {
    line(0, y, width, y);
    img.loadPixels();
    beginShape(TRIANGLE_STRIP);
    int yWidth = y * img.width;
    for (int x = 0; x < img.width; x += 1) {
      if (x + yWidth < img.width * img.height) {
        color c = img.pixels[x + yWidth];
        float b = (255 - brightness(c)) / 255.0 * (h / 2.0);
        b = max(1, b);
        vertex(x, y + b);
        vertex(x, y - b);
      }
    }
    endShape();
    img.updatePixels();
  }

  noiseify();
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
