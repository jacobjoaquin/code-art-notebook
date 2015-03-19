float distance = 1;
float angle = 0;
float phase = 0;
float phase2 = 0;

void setup() {
  size(500, 500);
  colorMode(HSB);
}

void draw() {
  pushMatrix();
  background(255, 0, 0);
  distance = 10;
  translate(width / 2.0, height / 2.0);
  float x = 0;
  float y = 0;
  float thisAngle = angle;
  thisAngle = 0;
  beginShape(TRIANGLE_STRIP);
  float thisPhase = phase;
  while (distance <= 500) {
    fill(thisPhase * 32, 255, 255);
    thisPhase += 1 / 7.0;
    if (thisPhase >= 1.0) {
      thisPhase -= 1.0;
    }
    x = distance * sin(thisAngle);
    y = distance * cos(thisAngle);
    distance *= 1.025;
    thisAngle += PI / 4.0;
    vertex(x, y);
  }
  endShape();
  int nFrames = 32;
  phase += 1 / float(nFrames);
  if (phase >= 1.0) {
    phase -= 1.0;
  }

  angle -= PI / 256.0;

  if (angle < 0) {
    angle += TWO_PI;
  }
  popMatrix();

  phase2 += 1 / 4096.0;
  if (phase2 >= 1.0) {
    phase2 -= 1.0;
  }
};
