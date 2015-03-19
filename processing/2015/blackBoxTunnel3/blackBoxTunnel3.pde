int nFrames = 128;
Phasor phasor = new Phasor(1.0 / float(nFrames));

class Phasor {
  float inc = 0.0;
  float phase = 0.0;

  Phasor() {
    this(0, 0);
  }

  Phasor(float inc) {
    this(inc, 0);
  }

  Phasor(float inc, float phase) {
    this.inc = inc;
    this.phase = phase;
  }

  void update() {
    phase += inc;
    while (phase >= 1.0) {
      phase -= 1.0;
    }
    while (phase < 0.0) {
      phase += 1.0;
    }
  }

  float radians() {
    return phase * TWO_PI;
  }

  float sine() {
    return sin(phase * TWO_PI);
  }
}

void setup() {
  size(500, 500, P3D);
  fill(0);
  stroke(255);
  strokeWeight(1.5);
}

void draw() {
  background(255);

  pushMatrix();
  translate(0, 0);
  doThing();
  popMatrix();
  pushMatrix();
  translate(0, height);
  doThing();
  popMatrix();
  pushMatrix();
  translate(width, 0);
  doThing();
  popMatrix();
  pushMatrix();
  translate(width, height);
  doThing();
  popMatrix();

  phasor.update();
}

void doThing() {
  float s = 16;
  float d = (s * 20) + 0;
  float a = 0;
  float angleUpdate = PI / 8.0;

  while (d > -10000) {
    PVector p = PVector.fromAngle(a);
    p.mult(width / 2.5);

    pushMatrix();
    float offset = d + s * 16 * phasor.phase;
    translate(p.x, p.y, offset);
    box(s * 4, s * 1, s * 9);
    popMatrix();

    d -= s * 1;
    a += angleUpdate;
  }
}
