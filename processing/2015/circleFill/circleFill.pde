ArrayList<Circle> circles;
float maxSize = 50;
float minSize = 5;  
int border = 100;

class Circle {
  float x;
  float y;
  float r;

  Circle(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }

  void update() {
  }

  void draw() {
    ellipse(x, y, r * 2, r * 2);
  }
}

Circle createCircle() {
  boolean found = true;
  Circle c = new Circle(0, 0, 0);
  int maxSearch = 256;
  int counter = 0;  

  do {
    counter++;
    if (counter > maxSearch) {
      noLoop();
      break;
    }
    found = true;
    c.x = random(width);
    c.y = random(height);
    c.r = random(minSize, maxSize);

    for (Circle circle : circles) {
      float d = dist(c.x, c.y, circle.x, circle.y); 
      if (d < c.r + circle.r) {
        found = false;
        break;
      }
    }
  } 
  while (!found);

  return c;
}

Circle createCircleClosest() {
  boolean found = true;
  Circle c = new Circle(0, 0, 0);
  int maxSearch = 256;
  int counter = 0;  

  do {
    counter++;
    if (counter > maxSearch) {
      noLoop();
    }

    found = true;
    c.x = random(width);
    c.y = random(height);
    c.r = random(minSize, maxSize);

    // Find Closest
    Circle closest = circles.get(0);
    float cDist = dist(c.x, c.y, closest.x, closest.y);
    for (int i = 1; i < circles.size (); i++) {
      Circle circle = circles.get(i);
      float d = dist(c.x, c.y, circle.x, circle.y);
      if (cDist > d) {
        closest = circle;
        cDist = d;
      }
    }

    float a = atan2(closest.y - c.y, closest.x - c.x);
    PVector p = PVector.fromAngle(a);
    p.mult(c.r + closest.r);
    c.x = p.x + closest.x;
    c.y = p.y + closest.y;

    // Check intersection
    for (Circle circle : circles) {
      float d = dist(c.x, c.y, circle.x, circle.y); 
      if (d < c.r + circle.r) {
        found = false;
        break;
      }
    }
  } 
  while (!found);

  return c;
}

void setup() {
  size(800, 800);
  noFill();
  strokeWeight(1);
  circles = new ArrayList<Circle>();
  Circle c = new Circle(random(width) - 2 * maxSize, random(height) - 2 * maxSize, random(minSize, maxSize));
  circles.add(c);
  c.draw();
}

void draw() {
  for (int i = 0; i < 50; i++) {
    Circle c = createCircle();
    circles.add(c);
    c.draw();
  }
}
