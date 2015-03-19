PImage img;

void setup() {
  println("Instructions: Add image in setup()");
  img = loadImage("YOUR_IMAGE_HERE.jpg");
  size(img.width, img.height);
  image(img, 0, 0);
}

void draw() {
  loadPixels();

  for (int y = 1; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int index = x + y * width;
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

  for (int y = 0; y < height; y++) {
    for (int x = 1; x < width; x++) {
      int index = x + y * width;
      color c = pixels[index];
      color c1 = pixels[index - 1];

      if (brightness(c) < brightness(c1)) {
        //      if (hue(c) < hue(c1)) {
        //      if (saturation(c) < saturation(c1)) {
        pixels[index] = c1;
        pixels[index - 1] = c;
      }
    }
  }


  updatePixels();
}
