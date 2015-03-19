float L = 20;
float offset = 0;

void setup() {
  size(800, 800, "processing.core.PGraphicsRetina2D");
  noLoop();
  noStroke();
  background(0);
  translate(width / 2.0, height / 2.0);
  makeTheDots(150, 0, 1);
}

void makeTheDots(int countdown, float distance, int points) {
  float angle = TWO_PI / float(points);

  for (int i = 0; i < points; i++) {
    PVector p = PVector.fromAngle(angle * i);
    p.mult(distance);
    float s = sin(i / float(points) * TWO_PI * 4 + offset);
    s = map(s, -1, 1, 2, 10);
    fill(lerpColor(color(255, 0, 128), color(255, 128, 0), random(0, 1)));
    ellipse(p.x, p.y, s, s);
  }

  offset += angle / 0.1;

  if (--countdown > 0) {
    makeTheDots(countdown, distance + L * 0.5, points + 6);
  }
}
