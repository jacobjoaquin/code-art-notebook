void setup() {
  size(500, 500);
}

void draw() {
  translate(width / 2.0, height / 2.0);
  background(0);
  float distance = 0;
  float inc = 10;
  int divs = 1;
  noStroke();
  float count = 0;
  float angleOffset = 0;
  int plusDivs = 6;

  for (int i = 0; i < 30; i++) {
    float angle = TWO_PI / float(divs);
    for (int j = 0; j < divs; j++) {
      pushMatrix();
      rotate(angle * j);
      PVector p = PVector.fromAngle(angle + angleOffset);
      p.mult(distance);
      ellipse(p.x, p.y, 5, 5);
      popMatrix();
      count++;
    }
    divs += plusDivs;
    distance += inc;
  }
}
