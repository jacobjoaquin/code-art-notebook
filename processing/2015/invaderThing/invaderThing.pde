float phase = 0.0;
float phaseInc = 1.0 / 64.0;

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

  void update() {
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y);
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        if (data[y][x] == 1) {
          point((x - 4) * size, (y - 4) * size);
        }
      }
    }
    popMatrix();
  }
}

ArrayList<Invader> invaders;
int[] offsets;
int nInvaders = 20;
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
  background(16);
  stroke(255);

  int nTiles = 16;
  float tileSize = float(width) / float(nTiles);
  translate(tileSize / 2.0, tileSize / 2.0);
  PVector center = new PVector((width - tileSize) / 2.0, (height - tileSize) / 2.0);
  for (float y = 0; y < height; y += tileSize) {
    for (float x = 0; x < width; x += tileSize) {
      stroke(random(16) * 8 + 128);
      Invader invader = new Invader(x, y);
      float m1 = map(dist(x, y, center.x, center.y), 0, sqrt(2) * width * 0.5, 0, 1);
      float s1 = map(sin((phase + m1) * TWO_PI * 2), -1, 1, 0.5, 6);
      invader.size = max(s1, 1.0);
      invader.display();
    }
  }

  phase += phaseInc;
  if (phase >= 1.0) {
    phase -= 1.0;
  }
}
