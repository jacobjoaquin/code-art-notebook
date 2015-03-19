int counter = 0;

void setup() {
  size(500, 500);
  noLoop();
  background(224);
  fill(0, 40);
  noStroke();
  for (int i = 0; i < 64 * 360; i++) {
    pushMatrix();
    translate(width / 2.0, height / 2.0);
    float x = sin((counter % 213) / 255.0 * TWO_PI);
    float y = cos((counter % 255) / 255.0 * TWO_PI);
    ellipse(x * 200, y * 200, 3, 3);
    popMatrix();
    counter++;
  }
}
