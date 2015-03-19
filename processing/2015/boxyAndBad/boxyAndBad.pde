void setup() {
  size(500, 500, P3D);
  sphereDetail(32, 32);
  lights();
  background(0);
  noStroke();
}

void draw() {
  pushMatrix();
  fill(0, 4);
  translate(0, 0, -width);
  rect(-width, -height, width * 3, height * 3);
  popMatrix();
  fill(255);
  stroke(255, 64);

  if (frameCount % 2 == 0) {
    for (int i = 0; i < 3; i++) {
      pointLight(random(255), random(255), random(255), random(width), random(height), random(width));
    }
    for (int i = 0; i < 1; i++) {
      pushMatrix();
      translate(random(width), random(height), random(-width, 0));
      box(random(5, width * 0.25));
      popMatrix();
    }
  }
}
