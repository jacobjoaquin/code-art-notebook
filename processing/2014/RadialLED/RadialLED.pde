int totalLEDs = 0;

void setup() {
  size(800, 800);
  noLoop();
  background(0);
  noStroke();
  translate(width / 2.0, height / 2.0);
  doTheThing(6, 2, 0, TWO_PI / 2.0, 6);
}

void doTheThing(int iterations, int nLines, float angle, float arcAngle, float distance) {
  iterations--;

  for (int i = 0; i < nLines; i++) {
    float thisAngle = angle + i * arcAngle;
    PVector p1 = PVector.fromAngle(thisAngle);
    PVector p2 = p1.get();
    p1.mult(distance);
    p2.mult(distance * 2);
    float d = dist(p1.x, p1.y, p2.x, p2.y);
    int dd = int(d / 8.0);
    println(dd);

    for (int j = 0; j < dd; j++) {
      float x = lerp(p1.x, p2.x, float(j) / float(dd));
      float y = lerp(p1.y, p2.y, float(j) / float(dd));
      ellipse(x, y, 3, 3);
      totalLEDs++;
    }

    if (iterations > 0) {    
      float angleOffset = arcAngle * 0.5;
      doTheThing(iterations, 2, thisAngle + angleOffset, arcAngle / 2.0, distance * 2);
    }
  }
}
