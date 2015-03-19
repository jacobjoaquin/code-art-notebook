float maxDistFromCenter;
float phase = 0.0;
int nFrames = 128;
float phaseInc = 1.0 / float(nFrames);
ArrayList<RArc> t;
ArrayList<RArc> temp;

class RArc {
  float angle;
  float inc;
  RArc (float angle, float inc) {
    this.angle = angle;
    this.inc = inc;
  }
}

void setup() {
  size(500, 500);
  maxDistFromCenter = sqrt(width * width + height * height) * 0.5;
  t = makeArc(0.55, pow(2, 5.0 / 12.0), pow(2, 3.0 / 12.0));
  temp = makeArc(0.55, pow(3, 7.0 / 12.0), pow(2, 4.0 / 12.0));
}

void draw() {
  translate(width / 2.0, height / 2.0);
  background(16);
  pushStyle();
  noStroke();
  fill(0, 255, 255);
  ellipse(0, 0, 3, 3);  
  popStyle();
  noFill();
  stroke(255, 96);

  strokeWeight(1.5);
  stroke(0, 255, 255, 128);
  drawArcList2(t);
  stroke(0, 255, 0, 96);
  drawArcList2(temp);

  phase += phaseInc;
  if (phase >= 1.0) {
    phase -= 1.0;
  }
}

void drawArcList2(ArrayList<RArc> arcList) {
  float start = 1.0 * pow(2, phase);
  int counter = 0;
  int theSize = arcList.size();
  float angleOffset = 0;
  float m = 2;

  while (start < maxDistFromCenter * 1.1415) {
    angleOffset = map(start, 0, maxDistFromCenter, 4 * PI, 0);
    RArc thisRa = arcList.get(counter);
    RArc nextRa = arcList.get((counter + 1) % theSize);

    float nInc = nextRa.inc;
    float a1 = thisRa.angle + angleOffset;
    float a2 = nextRa.angle + angleOffset;

    PVector p = PVector.fromAngle(a1);
    PVector p1 = p.get();
    p.mult(start * thisRa.inc);
    p1.mult(start * nInc);

    line(p.x, p.y, p1.x, p1.y);

    if (nextRa.angle < thisRa.angle) {
      arc(0, 0, start * nInc * m, start * nInc * m, a2, a1);
    } else {
      arc(0, 0, start * nInc * m, start * nInc * m, a1, a2);
    }

    counter = (counter + 1) % theSize;
    if (counter == 0) {
      start *= 2;
    }
  }
}


void drawArcList(ArrayList<RArc> arcList) {
  float start = 1.0;
  int theSize = arcList.size();
  float angleOffset = 0;
  float m = 2;

  noFill();
  stroke(255, 80);
  while (start < maxDistFromCenter) {
    for (int i = 0; i < theSize; i++) {
      RArc thisRa = arcList.get(i);
      RArc nextRa = arcList.get((i + 1) % theSize);

      float nInc = nextRa.inc;

      if (i == theSize - 1) {
        nInc = 2.0;
      }

      float a1 = thisRa.angle + angleOffset;
      float a2 = nextRa.angle + angleOffset;

      PVector p = PVector.fromAngle(a1);
      PVector p1 = p.get();
      p.mult(start * thisRa.inc);
      p1.mult(start * nInc);

      line(p.x, p.y, p1.x, p1.y);

      if (nextRa.angle < thisRa.angle) {
        arc(0, 0, start * nInc * m, start * nInc * m, a2, a1);
      } else {
        arc(0, 0, start * nInc * m, start * nInc * m, a1, a2);
      }
    }

    start *= 2;
  }
}

ArrayList<RArc> makeArc(float odds, float inc, float dec) {
  ArrayList<RArc> arcList = new ArrayList<RArc>();

  float angle = random(TWO_PI);
  float d = 1.0;
  float d1 = 1.0;

  arcList.add(new RArc(angle, d));

  while (d < 2.0) {
    float thisAngle = angle;
    angle += random(-TWO_PI, TWO_PI);
    PVector p = PVector.fromAngle(thisAngle);
    PVector p1 = p.get();
    p.mult(d);
    p1.mult(d1);
    d1 = d;
    
    if (random(1) < odds) {
      d *= inc;
    } else {
      d /= dec;
    }

    if (d < 2.0) {
      arcList.add(new RArc(angle, d));
    }
  }
  return arcList;
}

void makeThing(float odds, float inc, float dec) {
  float angle = random(TWO_PI);
  float d = 1;
  float d1 = 1;
  float maxDistance = sqrt(2) * width;    

  while (d < maxDistance) {
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
    } else {
      arc(0, 0, d * 2, d * 2, angle, thisAngle);
    }
    d1 = d;
    if (random(1) < odds) {
      d *= inc;
    } else {
      d /= dec;
    }
  }
}
