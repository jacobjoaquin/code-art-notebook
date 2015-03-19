float phase = 0.0;
float phaseInc = 1.0 / 120.0;
float trackX = 0;
float trackY = 0;
ArrayList eyes;

void setup() {
  size(500, 500);
  eyes = new ArrayList();
  for (int i = 0; i < 4000; i++) {
    float r1 = random(10, 50);
    float r2 = r1 * random(0.3, 0.6);
    float x = random(r1, width - r1);
    float y = random(r1, height - r1);

    if (i == 0) {
      eyes.add(new Eye(x, y, r1, r2));
    } else {
      boolean fits = true;
      int s = eyes.size();     
      for (int j = 0; j < s; j++) {
        Eye e = (Eye) eyes.get(j);
        float d = dist(x, y, e.x, e.y);

        if (d < r1 + e.r1) {
          fits = false;
          break;
        }
      }
      if (fits) {
        eyes.add(new Eye(x, y, r1, r2));
      }
    }
  }
}

void draw() {
  background(0);
  float a = TWO_PI * phase;
  phase += phaseInc;
  if (phase >= 1.0) {
    phase -= 1.0;
  }
  trackX = width / 2 * cos(a) + width / 2;
  trackY = height / 2 * sin(a) + height / 2;

  int s = eyes.size();
  for (int i = 0; i < s; i++) {
    Eye e = (Eye) eyes.get(i);
    e.draw();
  }
}

class Eye {
  float x;
  float y;
  float r1;
  float r2;
  float vx;
  float vy;

  Eye(float x, float y, float r1, float r2) {
    this.x = x;
    this.y = y;
    this.r1 = r1;
    this.r2 = r2;
    vx = x;
    vy = y;
  }

  void draw() {
    fill(255);
    stroke(0);
    ellipse(x, y, r1 * 2, r1 * 2);

    pushStyle();
    fill(0);
    noStroke();

    float a = atan2(trackY - y, trackX - x);

    float x2 = x + (r1 - r2) * cos(a);
    float y2 = y + (r1 - r2) * sin(a);

    if (dist(x, y, trackX, trackY) < r1 - r2) {
      x2 = trackX;
      y2 = trackY;
    }

    vx = lerp(vx, x2, 0.1);
    vy = lerp(vy, y2, 0.1);

    ellipse(vx, vy, r2 * 2, r2 * 2);
    popStyle();
  }
}
