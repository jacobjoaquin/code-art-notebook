float t = 0.0;
float d = 1.0;
float a = 0.0;
float boundary;

void setup() {
  size(500, 500, P2D);
  noStroke();
  boundary = sqrt(2) * width;
}

void draw() {
  background(32);
  pushMatrix();
  translate(width / 2, height / 2);

  float thisAngle = a;
  float thisTime = t;  

  beginShape(TRIANGLE_STRIP);

  while (d < boundary) {
    float x = sin(thisAngle);
    float y = cos(thisAngle);
    PVector p = new PVector(x, y);
    p.mult(d + d * sin(thisTime * PI / 2.0) * 0.125);

    float x2 = sin(thisAngle + PI / 3.0);
    float y2 = cos(thisAngle + PI / 3.0);
    PVector p2 = new PVector(x2, y2);
    p2.mult(map(d, 0, boundary, 1, 80));
    p2.add(p);

    fill(map(d, 0, boundary, 255, 32), 0, 128);    

    vertex(p.x, p.y);
    vertex(p2.x, p2.y);

    thisAngle += map(d, 0, boundary, PI / 20, PI / 220);
    d *= 1.008;
    thisTime += 0.15 + d * 0.0006;
  }
  endShape();
  popMatrix();

  a += PI / 64.0;
  d = 1;
  t += 1 / 8.0;
}
