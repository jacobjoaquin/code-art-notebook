void vGrid(PVector p1, PVector p2, PVector p3, int n) {
  vGrid(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, n);
}

void vGrid(float x1, float y1, float x2, float y2, float x3, float y3, int n) {
  beginShape(LINES);  
  for (int i = 0; i < n; i++) {
    float interp = float(i) / float(n - 1);
    float px1 = lerp(x1, x2, interp);    
    float py1 = lerp(y1, y2, interp);    
    float px2 = lerp(x2, x3, interp);    
    float py2 = lerp(y2, y3, interp);
    vertex(px1, py1);
    vertex(px2, py2);
  }
  endShape();
}

void setup() {
  size(1000, 1000);
  noLoop();
  int nGrids = 48;
  int nLines = 8;
  background(224);
  stroke(128, 17, 35, 96);

  float r = width / 1.414;
  float angleOffset = TWO_PI / float(nGrids);
  PVector pCenter = new PVector(0, 0);

  pushMatrix();
  translate(width / 2.0, height / 2.0);    
  for (int i = 0; i < nGrids; i++) {
    PVector p1 = PVector.fromAngle(angleOffset * i);
    p1.mult(r);
    PVector p2 = PVector.fromAngle(angleOffset * (i + 1));
    p2.mult(r);
    vGrid(p1, pCenter, p2, nLines);
  }
  popMatrix();
}
