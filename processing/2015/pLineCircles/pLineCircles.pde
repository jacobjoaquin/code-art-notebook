float gScale;

void setup() {
  size(1500, 1500, P2D);
  gScale = width / 500.0;
  noLoop();
}


float xn = 0;
float yn = 1000.0;
float nInc = 0.01;

void draw() {
  background(240);
  fill(0);
  noStroke();
  translate(width / 2.0, height / 2.0);
  float radius = sqrt(2) * width / 4.0;
  int nPoints = int(radius * TWO_PI);
  float rAngle = TWO_PI / 6.0;

  float s = 10 * gScale;
  while (radius >= 1) {      
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i <= nPoints; i++) {
      float a = i / float(nPoints) * TWO_PI;
      PVector p = PVector.fromAngle(a);
      PVector p1 = PVector.fromAngle(a - PI);
      PVector p2 = PVector.fromAngle(a);
      float fInc = 2;
      float s1 = noise(sin(p.x + rAngle) * fInc + xn) * s;
      p.mult(radius);
      p1.mult(s1);
      p2.mult(s1);
      p1.add(p);
      p2.add(p);
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
    }
    endShape(CLOSE);
    radius *= 0.9;
    s *= 0.9;
  }

  xn += nInc;
  yn += nInc;
}
