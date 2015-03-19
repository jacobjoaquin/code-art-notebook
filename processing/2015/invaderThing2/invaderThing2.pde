ArrayList<Invader> invaders;
int[] offsets;
int nInvaders = 20;
float phase = 0.0;
int nFrames = 80;
float phaseInc = 1.0 / float(nFrames);

class Invader {
  PVector position;
  int w = 11;
  int h = 8;
  int[][] data = new int[][] {
    {
      0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0
    }
    , 
    {
      0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0
    }
    , 
    {
      0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0
    }
    , 
    {
      0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0
    }
    , 
    {
      1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    }
    , 
    {
      1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1
    }
    , 
    {
      1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1
    }
    , 
    {
      0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0
    }
  };

  float size = 1;

  Invader(float x, float y) {
    position = new PVector(x, y);
  }

  void setPosition(PVector p) {
    position.set(p);
  }

  void update() {
  }

  void display() {
    pushMatrix();
    pushStyle();
    translate(position.x, position.y);
    noStroke();
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        if (data[y][x] == 1) {
          rect((x - 5) * size, (y - 4) * size, 1, 1);
        }
      }
    }
    popStyle();
    popMatrix();
  }
}

void setup() {
  size(500, 500);
  invaders = new ArrayList<Invader>();
  offsets = new int[nInvaders];

  for (int i = 0; i < nInvaders; i++) {
    Invader invader = new Invader(int(random(width)), int(random(height)));
    offsets[i] = int(random(1, 300));
    invaders.add(invader);
  }
}

void draw() {
  background(0);
  stroke(255);  
  int nTiles = 16;
  float tileSize = float(width) / float(nTiles);
  translate(tileSize / 2.0, tileSize / 2.0);
  boring();

  phase += phaseInc;
  if (phase >= 1.0) {
    phase -= 1.0;
  }
}

void boring() {
  int nTiles = 7;
  float tileSize = float(width) / float(nTiles);
  PVector center = new PVector((width - tileSize) / 2.0, (height - tileSize) / 2.0);
  pushMatrix();
  translate(tileSize / 4.0, tileSize / 4.0);
  pushStyle();
  colorMode(HSB);
  for (float y = -tileSize; y < height + tileSize; y += tileSize) {
    for (float x = -tileSize; x < width + tileSize; x += tileSize) {
      float d = dist(x, y, center.x, center.y);
      float waveAmount = 4.0;
      Invader invader = new Invader(x, y + map(sin((phase + x / float(width)) * TWO_PI * 2), -1, 1, -waveAmount, waveAmount));
      float m1 = map(d, 0, sqrt(2) * width * 0.5, 0, 1);
      float theMax = d / 10.0;
      float s1 = map(sin(((1 - phase) + m1) * TWO_PI * 1), -1, 1, 0.5, theMax);
      s1 = max(s1, 1.0);
      fill(int(random(4)) * 20, map(s1, 1, theMax, 0, 500), 255);

      invader.size = s1;
      invader.display();
      invader.display();
    }
  }
  popStyle();
  popMatrix();
}
