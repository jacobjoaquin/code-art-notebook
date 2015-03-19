/*
10 PRINT ABSTRACT
 Inspired by: 10 PRINT CHR$(205.5+RND(1)); : GOTO 10
 
 Jacob Joaquin
 jacobjoaquin@gmail.com
 twitter @jacobjoaquin
 */

int tileSize = 80;
int nTiles_x;
int nTiles_y;
float odds = 0.5;
float strokeMin = 3;
float strokeMax = 32;
int nDraws = 15;

void setup() {
  size(800, 800);
  nTiles_x = width / tileSize;
  nTiles_y = height / tileSize;
  frameRate(30);
  strokeCap(PROJECT);
}

void keyPressed() {
  switch(key) {
  case 's':
    //            save("cap.jpg");
    break;
  case 'l':
    loop();
    nDraws = 999;
    break;
  case 'n':
    noLoop();
    break;
  case 'd':
    redraw();
    break;
  }
}

void draw() {
  for (int i = 0; i < nTiles_x * nTiles_y; i++) {
    drawTile((int) random(nTiles_x) * tileSize, (int) random(nTiles_y) * tileSize);
  }

  if (--nDraws <= 0) {
    noLoop();
  }
}

void drawTile(int x_, int y_) {
  pushMatrix();
  translate(x_, y_);

  // Tile color
  pushStyle();
  noStroke();
  float fade = y_ / (float) height;
  fill(255, 80 - 60 * fade, 64 + random(32), 180);
  rect(0, 0, tileSize, tileSize);
  popStyle();

  // Texture
  pushStyle();
  strokeWeight(1);

  for (int i = 0; i < tileSize; i++) {
    float r = random(48);
    float r2 = random(16);
    stroke(0, 20 + random(120), 64 + random(80), 8);
    line(i + random(-5, 5), 0, i + random(-5, 5), tileSize);
  }

  popStyle();

  // Line
  pushStyle();
  strokeWeight(random(strokeMin, strokeMax));
  stroke(0, random(216, 248));

  if (random(1.0) < odds) {
    line(0, 0, tileSize, tileSize);
  } else {
    line(tileSize, 0, 0, tileSize);
  }

  popStyle();
  popMatrix();
}
