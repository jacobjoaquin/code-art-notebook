int nFrames = 32;
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

ArrayList<PVector> points;

void setup() {
  size(500, 500, P3D);
  points = new ArrayList<PVector>();

  int nVertices = 8192;
  for (int i = 0; i < nVertices; i++) {
    PVector p = new PVector(random(-width, width), random(-height, height), random(-width, width));
    points.add(p);
  }
  frameRate(10);
}

void draw() {
  background(0);
  fill(8, 32, 8);
  strokeWeight(1);
  float d = 1000;
  translate(width / 2.0, height / 2.0);
  camera(d * 0.95, -d * 0.8, d, 
  0, 120, 0, 
  0, 1, 0);

  beginShape(TRIANGLE_STRIP);
  for (PVector p : points) {
    stroke(0, int(random(8)) * 16 + 128, 0);
    vertex(p.x, p.y, p.z);
  }
  endShape();
  noFill();
  strokeWeight(2);
  box(width * 2);
  phasor.update();
}
