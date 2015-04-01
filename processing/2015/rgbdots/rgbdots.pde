int nFrames = 12;
Phasor phasor = new Phasor(1 / float(nFrames));
float offset = 2;
PGraphics src;

void setup() {
  size(500, 500);

  src = createGraphics(width, height);
  src.beginDraw();
  src.fill(255);
  src.noStroke();
  for (int i = 0; i < 2000; i++) {
    float s = random(2, 10);
    src.ellipse(random(width), random(height), s, s);
  }
  src.endDraw();
}

void draw() {
  PGraphics output = doThing(src);
  image(output, 0, 0);
  phasor.update();
  
//  saveFrame("./output/ani####.gif");
//  if (frameCount >= nFrames) {
//    exit();
//  }
}

PGraphics doThing(PGraphics pg) {
    PGraphics pgR = createGraphics(pg.width, pg.height);
    PGraphics pgG = createGraphics(pg.width, pg.height);
    PGraphics pgB = createGraphics(pg.width, pg.height);
    PGraphics pgOut = createGraphics(pg.width, pg.height);
    
    PVector rOffset = PVector.fromAngle(phasor.radians());    
    rOffset.mult(offset);
    PVector gOffset = PVector.fromAngle(phasor.radians() + TWO_PI / 3.0);    
    gOffset.mult(offset);
    PVector bOffset = PVector.fromAngle(phasor.radians() + TWO_PI * 2.0 / 3.0);    
    bOffset.mult(offset);
    
    pgR.beginDraw();
    pgG.beginDraw();
    pgB.beginDraw();
    pgOut.beginDraw();
    pgR.image(pg, rOffset.x, rOffset.y);
    pgG.image(pg, gOffset.x, gOffset.y);
    pgB.image(pg, bOffset.x, bOffset.y);
    
    int nPixels = pg.width * pg.height;
    
    pgR.loadPixels();
    pgG.loadPixels();
    pgB.loadPixels();
    pgOut.loadPixels();
    
    for (int i = 0; i < nPixels; i++) {
      int r = (pgR.pixels[i] >> 24) & 0xFF;
      int g = (pgG.pixels[i] >> 24) & 0xFF;
      int b = (pgB.pixels[i] >> 24) & 0xFF;
      pgOut.pixels[i] = (r << 16) | (g << 8) | b | 0xFF000000;
      
    }
    
    pgOut.updatePixels();
    pgOut.endDraw();
    pgB.endDraw();
    pgG.endDraw();
    pgR.endDraw();

    return pgOut;
}
