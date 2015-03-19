float L = 20;
float offset = 0;

void setup() {
  size(1000, 1000);
  noLoop();
  noStroke();
  background(0);
  translate(width / 2.0, height / 2.0);
  makeTheDots(150, 0, 1);
}

void makeTheDots(int countdown, float distance, int points) {
  float angle = TWO_PI / float(points);
  fill(offset);
  offset = (offset + 12) % 256;

  for (int i = 0; i < points; i++) {
    PVector p = PVector.fromAngle(angle * i);
    p.mult(distance);
    float s = sin(i / float(points) * TWO_PI * 256 + offset);
    s = map(s, -1, 1, 0, 10);
    ellipse(p.x, p.y, s, s);
  }

  if (--countdown > 0) {
    makeTheDots(countdown, distance + L * 0.5, points + 6);
  }
}
