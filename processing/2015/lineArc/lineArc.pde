void setup() {
  size(1000, 1000);
  noLoop();
}

void draw() {
  translate(width / 2.0, height / 2.0);
  noFill();
  background(16);
  colorMode(HSB);
  
  float d = 1.125;
  while (d < 2.5) {
    stroke((255 - 64) + random(64), 255, 255, 128);
    stroke(255, 128);
    stroke(random(120, 138), 255, 255, 96);
    makeThing(d);
    d += random(0.08, 0.12);
  }
  stroke(80, 255, 255, 128);
  makeThing(2.03);
  stroke(80, 255, 255, 128);
  makeThing(1.6);
  stroke(80, 255, 255, 128);
  makeThing(2.9);
}

void makeThing(float inc) {
  float angle = random(TWO_PI);
  float d = 1;
  float d1 = 1;
  float maxDistance = sqrt(2) * width;    
  
  while(d < maxDistance) {
    float thisAngle = angle;
    angle += random(-TWO_PI, TWO_PI);
    PVector p = PVector.fromAngle(thisAngle);
    PVector p1 =   p.get();
    p.mult(d);
    p1.mult(d1);
  
    strokeWeight(map(d, 0, maxDistance, 0.125, 3));
    line(p.x, p.y, p1.x, p1.y);
 
    if (angle > thisAngle) {
      arc(0, 0, d * 2, d * 2, thisAngle, angle);      
    }
    else {
      arc(0, 0, d * 2, d * 2, angle, thisAngle);
    }
    d1 = d;
    if (random(1) > 0.25) {
      d *= inc;
    }
    else {
      d *= 1.0 / (inc / 2.0);
    }
  }
}
