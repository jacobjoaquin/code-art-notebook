import java.util.Collections;

int nTiles = 5;

void setup() {
  size(1200, 1200, P2D);
  noLoop();
}

void draw() {
  background(255);
  noStroke();
  fill(0);
  float tileSize = width / float(nTiles);
  float scaleAmount = 0.617;
  scale(scaleAmount);
  translate(0, tileSize / 2.0);
  translate(width * (scaleAmount / 2.0), height * (scaleAmount / 2.0));
  int h = 1;
  for (int y = 0; y < height; y += tileSize) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < width; x += tileSize) {
      pushMatrix();
      drawWave2(x, y, makeWave(h), tileSize, tileSize / 2.0 * -1 * 0.75);
      popMatrix();
      h++;
    }
    endShape();
  }

  loadPixels();
  float imgSize = width * height;
  for (int i = 0; i < imgSize; i++) {
    color c = pixels[i];  
    float bright = brightness(c);
    float amt = 12;
    float rnd = random(-amt, amt);
    pixels[i] = color(bright + rnd);
  }
  updatePixels();
}

float n = 0;

void drawWave2(float tx, float ty, ArrayList<Float> sample, float w, float h) {
  float nInc = 0.03;

  int L = sample.size();
  int dir = 1;  
  for (int i = 0; i < L + 1; i++) {
    int nextPoint = (i + 1) % L;
    float x = i / float(L) * w;    
    float xn = nextPoint / float(L) * w;
    float y = sample.get(i % L) * h;
    float yn = sample.get(nextPoint) * h;
    float angle = atan2(yn - y, xn - x) + HALF_PI + PI * dir;
    PVector p = PVector.fromAngle(angle);
    p.mult(noise(n) * 10);
    vertex(p.x + x + tx, p.y + y + ty);

    dir = 1 - dir;
    n += nInc;
  }
}

ArrayList<Float> makeWave(int n) {
  ArrayList<Float> sample = new ArrayList<Float>();
  int points = 128;
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
