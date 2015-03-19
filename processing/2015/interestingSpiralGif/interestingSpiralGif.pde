float t = 0.0;
float d = 1.0;
float a = 0.0;
float boundary;

void setup() {
  size(500, 500);
  noStroke();
  boundary = sqrt(2) * width;
}

void draw() {
  background(0);
  pushMatrix();
  translate(width / 2, height / 2);

  float thisAngle = a;
  float thisTime = t;  

  beginShape(TRIANGLE_STRIP);
  while (d < boundary) {
    float x = sin(thisAngle);
    float y = cos(thisAngle);
    PVector p = new PVector(x, y);

    fill(map(d, 0, boundary, 255, 32), 0, 128);    
    p.mult(d + d * sin(thisTime * PI / 2.0) * 0.125);
    vertex(p.x, p.y);

    thisAngle += map(d, 0, boundary, PI / 20, PI / 2200);
    d *= 1.008;
    thisTime += 0.15 + d * 0.0006;
  }
  endShape();
  popMatrix();

  a += PI / 64.0;
  d = 1;  
  t += 1 / 8.0;
}
