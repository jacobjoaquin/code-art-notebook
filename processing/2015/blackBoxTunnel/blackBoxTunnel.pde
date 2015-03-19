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
}

void draw() {
  background(0);
  fill(0);
  stroke(255);
  translate(width / 2.0, height / 2.0);
  translate(width * 0.2 * phasor.sine(), 
  height * 0.1 * sin(phasor.phase * TWO_PI + PI / 1.5));

  float s = 50;
  float d = (s * 4);
  float a = 0;
  float angleUpdate = PI / 8.0;

  while (d > -12000) {
    PVector p = PVector.fromAngle(a);
    p.mult(width / 2.0);

    pushMatrix();
    float offset = d + s * 16 * phasor.phase;
    translate(p.x, p.y, offset);
    rotate(PI / 2.0, 1, 1, 1);
    box(s);
    popMatrix();

    d -= s * 0.25;
    a += angleUpdate;
  }

  phasor.update();
}
