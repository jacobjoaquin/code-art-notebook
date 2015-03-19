int nFrames = 112;
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
  float rAmt = 0.3;
  translate(width / 2.0, height / 2.0);
  translate(width * rAmt * phasor.sine(), 
  height * -rAmt * sin(phasor.phase * TWO_PI + PI / 2.0));

  float s = 20;
  float d = (s * 12) + 0;
  float a = 0;
  float angleUpdate = PI / 8.0;

  while (d > -10000) {
    PVector p = PVector.fromAngle(a);
    p.mult(width / 2.0);

    pushMatrix();
    float offset = d + s * 16 * phasor.phase;
    translate(p.x, p.y, offset);

    float d2 = dist(0, 0, -200, p.x, p.y, offset) * 0.006125;
    rotateX(phasor.phase * TWO_PI + d2);
    rotateY(phasor.phase * TWO_PI + d2);

    box(s * 1.5);
    popMatrix();

    d -= s * 1;
    a += angleUpdate;
  }

  phasor.update();
}
