void setup() {
  //  size(500, 500, "processing.core.PGraphicsRetina2D");
  size(1000, 1000);
  noLoop();
  translate(width / 2.0, height / 2.0);

  stroke(0, 64);
  float d = 1;
  float a = 0;
  for (int i = 0; i < 1024; i++) {
    PVector p1 = PVector.fromAngle(a);
    p1.mult(d);
    PVector p2 = PVector.fromAngle(a + PI / 2.0);
    p2.mult(d);

    noFill();
    fill(255, 64);
    stroke(128, 17, 35, 180);

    arc(p1.x, p1.y, d, d, a - PI / 4.7, a + PI / 1.98);
    d *= 1.02;
    a += PI / 8.0;
  }
}
