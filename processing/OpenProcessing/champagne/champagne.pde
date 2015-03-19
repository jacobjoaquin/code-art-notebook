/*
Champagne
 
 Jacob Joaquin
 jacobjoaquin@gmail.com
 twitter @jacobjoaquin
 */

ArrayList bubbles;
int nBubbles = 7;
float QUARTER_PI = PI * 0.25;
color bg1 = color(171, 82, 39, 16);
color bg2 = color(141, 81, 24, 16);
float interp = 0.0;

void setup() {
  size(500, 500);
  frameRate(15);
  smooth();
  background(bg1);
  bubbles = new ArrayList();

  for (int i = 0; i < nBubbles; i++) {
    Bubble d = new Bubble();
    bubbles.add(d);
  }
}

void draw() {
  // Blur
  filter(BLUR, 0.7);

  // Fade screen
  noStroke();
  //fill(171, 82, 39, 16);
  fill(lerpColor(bg1, bg2, sin(interp * TWO_PI) * 0.5 + 0.5));
  rect(0, 0, width, height);

  for (int i = 0; i < nBubbles; i++) {
    Bubble d = (Bubble) bubbles.get(i);
    d.update();
  }

  interp += 0.005;

  if (interp >= 1.0) {
    interp -= 1.0;
  }
}

class Bubble {
  float posX;
  float posY;
  float s;     // Size
  float sw;    // Stroke weight


  Bubble() {
    init();
  }

  void init() {
    s = random(5, 50);
    sw = (s - 5) / 45 * 2 + 0.5;
    posY = height + s;
    posX = random(-s, width + s);
  }

  void update() {
    pushStyle();
    noFill();
    fill(237, 120, 100, 64);
    stroke(255, 240, 240, 80);
    strokeWeight(sw);

    ellipse(posX, posY, s, s);

    float angle = PI + random(-QUARTER_PI, QUARTER_PI);
    posX += sin(angle) * s;
    posY += cos(angle) * s;

    if (posY <= -s) {
      init();
    }

    popStyle();
  }
}
