ArrayList dots;
PVector center;

float offset = 0;
float length = 354;
float odds = 0.125;
int strips = 128;
color color_out = color(255, 128);
color color_in = color(255, 96);
float pointSize = 2;

class Dot {
  PVector start;
  PVector end;
  float nLEDs = 60;
  float inc = 1;
  float location = 0;
  boolean hasCompleted = false;
  color c = color(255, 212);
  PVector last;
  PVector current;

  Dot(PVector start, PVector end) {
    this.start = start;
    this.end = end;
    last = start.get();
    current = start.get();
  }

  void update() {
    last = current;
    location += inc;
    current = getLocation();
    hasCompleted = location >= nLEDs;
  }

  PVector getLocation() {
    float w = location / nLEDs;
    float x = lerp(start.x, end.x, w);
    float y = lerp(start.y, end.y, w);
    return new PVector(x, y);
  }

  void display() {
    if (!hasCompleted) {
      pushStyle();
      stroke(c);
      strokeWeight(pointSize);
      line(current.x, current.y, last.x, last.y);
      popStyle();
    }
  }
}

PVector distAngle(float d, float a) {
  return new PVector(d * cos(a), d * sin(a));
}

void setup() {
  size(500, 500, P2D);
  frameRate(30);
  dots = new ArrayList();
  //center = new PVector(width / 2, height - (height - (length + offset)) / 2 );
  center = new PVector(width / 2, height / 2);
}


void draw() {
  background(0);

  for (int i = 0; i < strips; i++) {
    float angle = (float) i / (float) (strips) * -TWO_PI;
    PVector start = center.get();
    start.add(distAngle(offset, angle));
    PVector end = start.get();
    end.add(distAngle(length, angle));

    if (random(1.0) < odds) {
      Dot d = new Dot(start, end);
      d.c = color_out;
      dots.add(d);
    }

    if (random(1.0) < odds) {
      Dot d = new Dot(end, start);
      d.c = color_in;
      dots.add(d);
    }
  }

  int L = dots.size();
  for (int i = L - 1; i >= 0; i--) {
    Dot d = (Dot) dots.get(i);
    PVector dLocation = d.getLocation();
    float distance = dist(center.x, center.y, dLocation.x, dLocation.y);
    d.inc = norm(distance, 0, length + offset) * 6 + 0.125 + random(0.1);
    d.update();
    d.display();
    if (d.hasCompleted) {
      dots.remove(i);
    }
  }
}
