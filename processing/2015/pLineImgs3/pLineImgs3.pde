PImage img;
int border = 5;
int m = 3;         // Times larger than original image
int h = 10;        // Space between rows

void setup() {
  println("Instructions: Add an image in setup().");
  img = loadImage("YOUR_IMAGE_HERE.jpg");
  size(img.width * m + border * 2, img.height * m + border * 2, P2D);
  noLoop();
  noStroke();
  background(240);
  fill(32);
}

void draw() {
  translate(border, border);
  
  for (int y = 0; y < img.height; y += h) {
    line(0, y, width, y);
    img.loadPixels();
    beginShape(TRIANGLE_STRIP);
    int yWidth = y * img.width;
    for (int x = 0; x < img.width; x += 1) {
      if (x + yWidth < img.width * img.height) {
        color c = img.pixels[x + yWidth];
        float r = c >> 16 & 0xFF;
        float g = c >> 8 & 0xFF;
        float b = c & 0xFF;
        float thickness = (765 - (r + g + b)) / 765.0 * (h / 2.0);
        b = max(1, b);
        vertex(x * m, y * m + thickness * m);
        vertex(x * m, y * m - thickness * m);
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
