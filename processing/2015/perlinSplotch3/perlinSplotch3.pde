float angleInc = 1.0 / 64.0;
float offset = 0.0;
float offsetInc = 0.001;
float r;

void setup() {
  size(500, 500);
  noiseSeed(3);
  r = width / 1.5;
  noStroke();
}

void draw() {
  background(255);
  float angle = 0;
  ArrayList<PVector> vectors = new ArrayList<PVector>();
  
  while (angle < TWO_PI) {    
    float xn = sin(angle * 2);
    float yn = cos(angle * 3);
    float n = noise(xn + offset, yn + offset);
    PVector p = new PVector(sin(angle), cos(angle));
    p.mult(n);
    vectors.add(new PVector(p.x, p.y));
    angle += angleInc;
  }

  float d = width * 4;
  int c = 255;
  
  translate(width / 2.0, height / 2.0);
  while(d > 1) {
    fill(c);
    beginShape();
    for (PVector p : vectors) {
      PVector p1 = p.get();
      p1.mult(d);
      vertex(p1.x, p1.y);
    }
    endShape();
    d *= 0.6;
    c = 255 - c;
  }

  offset += offsetInc;
}
