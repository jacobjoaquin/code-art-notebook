import java.util.Collections;

int nFrames = 16;
int nTiles = 5;
int resolution = 500;

void setup() {
  size(500, 500, P2D);
}

void draw() {
  background(255);
  noStroke();
  fill(0);
  translate(width / 4.0, height / 2.0);
  scale(0.5);
  drawWave2(makeWave(frameCount), width, height / -2.0);
}

void drawWave2(ArrayList<Float> sample, float w, float h) {
  int L = sample.size();
  int dir = 1;  
  beginShape(TRIANGLE_STRIP);
  for (int i = 0; i < L; i++) {
    int nextPoint = (i + 1) % L;
    float x = i / float(L) * w;    
    float xn = nextPoint / float(L) * w;
    float y = sample.get(i) * h;
    float yn = sample.get(nextPoint) * h;
    float angle = atan2(yn - y, xn - x) + HALF_PI + PI * dir;
    PVector p = PVector.fromAngle(angle);
    p.mult(3);
    vertex(p.x + x, p.y + y);
    dir = 1 - dir;
  }
  vertex(w, sample.get(0) * h);
  endShape();
}

void drawWave(ArrayList<Float> sample, float w, float h) {
  int L = sample.size();

  beginShape();
  for (int i = 0; i < L; i++) {
    float x = i / float(L) * w;    
    vertex(x, sample.get(i) * h);
  }
  vertex(w, sample.get(0) * h);
  endShape();
}

ArrayList<Float> makeWave(int n) {
  ArrayList<Float> sample = new ArrayList<Float>();
  int points = resolution;
  float pInv = 1.0 / float(points);

  // Create zero-ed out arraylist  
  for (int i = 0; i < points; i++) {
    sample.add(0.0);
  }

  // Generate waveform data
  for (int i = 0; i < points; i++) {
    for (int j = 1; j <= n; j++) {
      Float s = sample.get(i);
      sample.set(i, s + sin(i * pInv * TWO_PI * j) * (1.0 / float(j)));
    }
  }

  // Normalize
  Float f = Collections.max(sample);

  for (int i = 0; i < points; i++) {
    Float s = sample.get(i);
    sample.set(i, s / f);
  }

  return sample;
}
