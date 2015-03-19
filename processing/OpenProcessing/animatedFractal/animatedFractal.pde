int nBranches = 6;
float startingLength = 290;
float phasor = 0.0;
float rate = 0.0005;
color bg = color(0, 8);

PVector getVCoordinates(PVector v, float d, float a) {
  return new PVector(v.x + d * cos(a), v.y + d * sin(a));
}

void setup() {
  size(500, 500);
  smooth();
  strokeWeight(1);
  fill(bg);
}

void draw() {
  noStroke();
  rect(0, 0, width, height);

  float sine = sin(phasor * TWO_PI);
  float angle = map(sine, -1.0, 1.0, -HALF_PI, HALF_PI);
  float divPoint = map(sine, -1.0, 1.0, 1.0, 0.5);

  for (int i = 0; i < nBranches; i++) {
    float L = startingLength;
    float a = TWO_PI / (float) nBranches * (float) i;
    PVector v1 = new PVector(width / 2, height / 2);
    PVector v2 = getVCoordinates(v1, L, a);

    while (L > 2) {
      stroke(random(255), 255, 0, 32);
      L *= 0.95;

      line(v1.x, v1.y, v2.x, v2.y);
      a += angle;

      v1.x = lerp(v1.x, v2.x, divPoint);
      v1.y = lerp(v1.y, v2.y, divPoint);

      v2 = getVCoordinates(v1, L, a);
    }
  }

  phasor += rate;
  if (phasor >= 1.0) {
    phasor -= 1.0;
  }
}
