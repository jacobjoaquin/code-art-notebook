float L = 20;
float offset = 0;

float phase = 0.0;
MetaPalette mp;

class MetaPalette {
  ArrayList<Integer> colors;

  MetaPalette() {
    colors = new ArrayList<Integer>();
  }

  void add(color c) {
    colors.add(c);
  }

  color get(float p) {
    while (p >= 1.0) {
      p -= 1.0;
    }
    while (p < 0) {
      p += 1.0;
    }
    int s = colors.size() - 1;
    p *= s;
    color c1 = colors.get(floor(p));
    color c2 = colors.get(ceil(p));
    float interp = (p - floor(p));
    return lerpColor(c1, c2, interp);
  }
}

void setup() {
  size(1000, 1000);
  noLoop();
  noStroke();
  background(16);
  mp = new MetaPalette();

  mp.add(color(255));    
  mp.add(color(255, 128, 0));
  mp.add(color(255, 0, 128));
  mp.add(color(255, 0, 255));
  mp.add(color(255));    
  mp.add(color(255, 128, 0));
  mp.add(color(255, 0, 128));
  mp.add(color(255, 0, 255));
  mp.add(color(255));    

  translate(width / 2.0, height / 2.0);
  makeTheDots(150, 0, 1);
}

void makeTheDots(int countdown, float distance, int points) {
  float angle = TWO_PI / float(points);
  for (int i = 0; i < points; i++) {
    PVector p = PVector.fromAngle(angle * i);
    p.mult(distance);
    float s = sin(i / float(points) * TWO_PI * 1 + offset);
    s = map(s, -1, 1, 5, 10);
    color c = mp.get(float(i) / float(points) + phase); 
    fill(c);

    ellipse(p.x, p.y, s, s);
    phase += 1.0 / 20000.0;
    if (phase >= 1.0) {
      phase -= 1.0;
    }
  }

  offset += angle / 0.125;

  if (--countdown > 0) {
    makeTheDots(countdown, distance + L * 0.5, points + 6);
  }
}
