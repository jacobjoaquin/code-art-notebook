int colorCounter = 0;
color colors[] = {
  color(255, 128, 0), 
  color(255, 0, 255), 
  color(0, 0, 0), 
  color(255, 0, 128),
};


void setup() {
  size(2000, 2000);
  noLoop();

  int nLines = 40;
  float tileWidth = width / float(nLines);
  float tx = 0.0;
  float ty = 0.0;
  float tz = 0.0;
  background(255);
  stroke(0, 128);
  for (int y = height / -2; y <= height; y += tileWidth) {
    fill(colors[colorCounter]);
    colorCounter = (colorCounter + 1) % colors.length;
    beginShape();
    tx = 0.0;
    tz = 0.0;
    for (int x = 0; x <= width; x++) {
      float ny = noise(tx, ty, tz);
      vertex(x, y + ny * 500 * (height / 1000.));      
      tx += 0.0005;
      tz += 0.001;
    }
    vertex(width, height);
    vertex(0, height);
    endShape();
    ty += 0.1;
  }
}
