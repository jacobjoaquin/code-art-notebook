ArrayList<PVector> pvs;
ArrayList<MyPointLight> pointLights;

float s = 0;
int n = 0;
float phase = 0.0;

class MyPointLight {
  color c;
  float x;
  float y;
  float z;

  MyPointLight(color c, float x, float y, float z) {
    this.c = c;
    this.x = x;
    this.y = y;
    this.z = z;
  }

  void draw() {
    pointLight(red(c), green(c), blue(c), x, y, z);
  }
}

void setup() {
  size(500, 500, P3D);
  pvs = new ArrayList<PVector>();
  pointLights = new ArrayList<MyPointLight>();

  s = 20;
  n = int(width / s);

  float a = TWO_PI;
  float d = 1;
  for (int x = 0; x < n; x++) {
    for (int y = 0; y < n; y++) {
      PVector p = PVector.fromAngle(a);
      p.mult(d);
      a *= 1.004;
      d *= 1.013;
      p.z = a;
      pvs.add(p);
    }
  }

  lights();
  noStroke();
  pointLights.add(new MyPointLight(color(0, 255, 0), width * 0.617, height * 0.617, width * 0.617));
  pointLights.add(new MyPointLight(color(255, 128, 0), width * 0.617, height * 0.317, width * 0.317));
  pointLights.add(new MyPointLight(color(255, 0, 0), width, height, width / 2.0));
}

void draw() {
  background(0);
  translate(width / 2.0, height / 2.0);

  for (MyPointLight pl : pointLights) {
    pl.draw();
  } 

  for (PVector p : pvs) {
    pushMatrix();
    float z = sin((phase + p.z) * TWO_PI);
    translate(p.x, p.y, z * s * 3);
    sphere(s * dist(0, 0, p.x, p.y) / 180.0);
    popMatrix();
  }

  phase += 1.0 / 24.0;
  if (phase >= 1.0) {
    phase -= 1.0;
  }
}
