int nLines = 48;
int theNoiseSeed = 0;

void setup() {
  size(1500, 1500, P2D);
  noLoop();
  noiseSeed(0);
}

void draw() {
  background(16);
  fill(240, 0, 128);
  translate(width / 2.0, height / 2.0);
  for (int j = 0; j < 4; j++) {
    pushMatrix();
    rotate(j * HALF_PI);
    for (int i = 0; i < nLines / 4; i++) {
      PVector p1 = PVector.fromAngle(-QUARTER_PI + i / float(nLines) * TWO_PI);
      PVector p2 = p1.get();

      p1.mult(0);
      p2.mult(sqrt(2) * width / 2.0);
      pLine(p1.x, p1.y, p2.x, p2.y, 0.0, 4.0, 0.05);
    }
    popMatrix();
  }

  noiseifyColor(12);
}

void keyPressed() {
  if (key == 's') {
    //    saveFrame("./output/foo######.tiff");
  }
  noLoop();
}

void noiseify() {
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

void noiseifyColor(float amt) {
  loadPixels();

  float imgSize = width * height;
  for (int i = 0; i < imgSize; i++) {  
    color c = pixels[i];  
    float r = c >> 16 & 0xFF;
    float g = c >> 8 & 0xFF;
    float b = c & 0xFF;
    float rnd = random(-amt, amt);
    r += rnd;
    g += rnd;
    b += rnd;
    r = constrain(r, 0, 255);
    g = constrain(g, 0, 255);
    b = constrain(b, 0, 255);

    pixels[i] = (int(r) << 16) + (int(g) << 8) + (int(b));
  }
  updatePixels();
}

void pLine(float x1, float y1, float x2, float y2, float wMin, float wMax, float perlinInc) {
  float perlin = random(10000);
  int d = ceil(dist(x1, y1, x2, y2));
  int dir = 1;
  float angle = atan2(y1 - y2, x1 - x2);
  pushStyle();
  noStroke();
  beginShape(TRIANGLE_STRIP);
  for (int i = 0; i <= d; i++) {
    float x = lerp(x1, x2, i / float(d));
    float y = lerp(y1, y2, i / float(d));
    PVector p = PVector.fromAngle(angle + HALF_PI + PI * dir);
    p.mult(map(noise(perlin), 0, 1, wMin, wMax));
    perlin += perlinInc;
    vertex(x + p.x, y + p.y);
    dir = 1 - dir;
  }
  endShape();
  popStyle();
}
