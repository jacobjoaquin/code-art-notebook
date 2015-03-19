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

  s = 25;
  n = int(width / s);
  
  for (int x = 0; x < n; x++) {
    for (int y = 0; y < n; y++) {
      PVector p = new PVector(x * s, y * s, dist(width / 2.0, height / 2.0, x * s, y * s) / 512.0);
      pvs.add(p);
    }
  }

  lights();
  noStroke();
  pointLights.add(new MyPointLight(color(255, 0, 128), width * 0.617, height * 0.617, width * 0.617));
  pointLights.add(new MyPointLight(color(255, 128, 0), width * 0.617, height * 0.317, width * 0.317));
  pointLights.add(new MyPointLight(color(0, 0, 128), width * 0.0, height * 0.317, width * 2.317));
}

void draw() {
  background(0);
 
  for (MyPointLight pl : pointLights) {
    pl.draw();
  } 
  
  for (PVector p : pvs) {
    pushMatrix();
    float z = sin((phase + p.z) * TWO_PI);
    translate(p.x, p.y, z * s * 8);
    sphere(s * 0.717);
    popMatrix();
  }
  
  phase += 1.0 / 64.0;
  if (phase >= 1.0) {
    phase -= 1.0;
  }
}
