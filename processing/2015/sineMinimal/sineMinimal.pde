import java.util.Collections;

int nTiles = 5;

void setup() {
  size(1000, 1000);
  noLoop();
}

void draw() {
  background(255);

  for (int y = 0; y < nTiles; y++) {
    for (int x = 0; x < nTiles; x++) {
    }
  }

  noFill();
  strokeWeight(2);

  float tileSize = width / float(nTiles);
  float scaleAmount = 0.617;
  scale(scaleAmount);
  translate(0, tileSize / 2.0);
  translate(width * (scaleAmount / 2.0), height * (scaleAmount / 2.0));
  int h = 1;
  for (int y = 0; y < height; y += tileSize) {
    for (int x = 0; x < width; x += tileSize) {
      pushMatrix();
      translate(x, y);
      drawWave(makeWave(h), tileSize, tileSize / 2.0 * -1 * 0.75);
      popMatrix();
      h++;
    }
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
