float nFrames = 60;
boolean captureOn = false;
PImage img;
int[] b;
int l;
int p = 0;
float phase = 0.0;

MetaPalette mp;

class MetaPalette {
  ArrayList<Integer> colors;

  MetaPalette() {
    colors = new ArrayList<Integer>();
  }

  void add(color c) {
    colors.add(c);
  }

  color get(float p) {
    int s = colors.size() - 1;
    p *= s;
    color c1 = colors.get(floor(p));
    color c2 = colors.get(ceil(p));
    float interp = (p - floor(p));
    return lerpColor(c1, c2, interp);
  }
}

void setup() {
  println("Instructions: Provide image in setup().");
  img = loadImage("YOUR_FILE_HERE.jpg");    
  size(img.width, img.height);
  l = width * height;
  b = new int[l];

  mp = new MetaPalette();

  mp.add(color(255));    
  mp.add(color(255, 128, 0));
  mp.add(color(255, 0, 128));
  mp.add(color(0));
  mp.add(color(255, 0, 255));
  mp.add(color(255));    

  image(img, 0, 0);

  loadPixels();
  for (int i = 0; i < l; i++) {
    b[i] = (int) brightness(pixels[i]);
  }
}

void draw() {
  background(0);
  loadPixels();
  for (int i = 0; i < l; i++) {
    float foo = b[i] / 256.0;
    foo += phase;
    if (foo >= 1.0) {
      foo -= 1.0;
    }

    color c = mp.get(foo); 
    pixels[i] = c;
  }

  updatePixels();
  p = (p + 16) % 256;

  phase += 1.0 / nFrames;
  if (phase >= 1.0) {
    phase -= 1.0;
  }


  // Capture frames 
  if (captureOn) {
    if ((frameCount - 1) < nFrames) {
      saveFrame("gif/ani_#####.gif");
    } else {
      exit();
    }
  }
}
