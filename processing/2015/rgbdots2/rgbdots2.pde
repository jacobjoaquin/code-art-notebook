int nFrames = 12;
Phasor phasor = new Phasor(1 / float(nFrames));
PGraphics src;
ArrayList<RGBCircle> circles;

class RGBCircle {
  PVector position;
  float size;
  float distance;
  float offset;

  RGBCircle(PVector position, float size, float distance, float offset) {
    this.position = position;
    this.size = size;
    this.distance = distance;
    this.offset = offset;
  }

  void update() {
  }

  void draw() {
    PVector rOffset = PVector.fromAngle(phasor.radians() + offset);    
    rOffset.mult(offset);

    int n = 2;

    pushStyle();
    colorMode(HSB);
    noStroke();

    for (int i = 0; i < n; i++) {
      float phase = i / float(n);
      fill(phase * 255 + 20, 255, 255);
      PVector pr = PVector.fromAngle(phase * TWO_PI + offset + phasor.radians());
      pr.mult(distance);
      pr.add(position);
      ellipse(pr.x, pr.y, size, size);
    }    
    popStyle();
  }
}

void setup() {
  size(500, 500, P2D);
  blendMode(ADD);

  circles = new ArrayList<RGBCircle>();
  PVector center = new PVector(width / 2.0, height / 2.0);

  for (int i = 0; i < 4000; i++) {
    PVector p = new PVector(random(width), random(height));
    float d = dist(p.x, p.y, center.x, center.y);
    float offset = d / 1000.0 * TWO_PI;
    offset += atan2(p.y - center.y, p.x - center.x);
    RGBCircle rgb = new RGBCircle(p, random(1, 6), 0.5 + d / 100.0, offset);
    circles.add(rgb);
  }
}

void draw() {
  background(32);

  for (RGBCircle circle : circles) {
    circle.draw();
  }

  phasor.update();
  
//  saveFrame("./output/ani####.gif");
//  if (frameCount >= nFrames) {
//    exit();
//  }
}
