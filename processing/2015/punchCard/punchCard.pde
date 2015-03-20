import java.util.Scanner;
HashMap<String, String> p;

String message = "THE ONLY WINNING MOVE IS NOT TO PLAY";
Dimension punch = new Dimension(14, 36);
Dimension spacer = new Dimension(26, 76);

class Dimension {
  float w;
  float h;
  
  Dimension(float w, float h) {
    this.w = w;
    this.h = h;
  }
}

void initPunchCodes() {
  p = new HashMap<String, String>();
  p.put(" ", "000000000000");
  p.put("A", "100100000000");
  p.put("B", "100010000000");
  p.put("C", "100001000000");
  p.put("D", "100000100000");
  p.put("E", "100000010000");
  p.put("F", "100000001000");
  p.put("G", "100000000100");
  p.put("H", "100000000010");
  p.put("I", "100000000001");
  p.put("J", "010100000000");
  p.put("K", "010010000000");
  p.put("L", "010001000000");
  p.put("M", "010000100000");
  p.put("N", "010000010000");
  p.put("O", "010000001000");
  p.put("P", "010000000100");
  p.put("Q", "010000000010");
  p.put("R", "010000000001");
  p.put("/", "001100000000");
  p.put("S", "001010000000");
  p.put("T", "001001000000");
  p.put("U", "001000100000");
  p.put("V", "001000010000");
  p.put("W", "001000001000");
  p.put("X", "001000000100");
  p.put("Y", "001000000010");
  p.put("Z", "001000000001");
}

void setup() {
  size(1500, 1500);
  noLoop();
  initPunchCodes();
  fill(32);
  noStroke();
}

void draw() {
  background(255);
  float x = 0;
  float xOffset = (width - ((message.length() - 1) * spacer.w + punch.w)) * 0.5;
  float yOffset = (height - (11 * spacer.h + punch.h * 1.5)) * 0.5;
  translate(xOffset, yOffset);
  
  for (char letter : message.toCharArray()) {
    pushStyle();
    fill(0);
    for (int i = 2; i < 12; i++) {
      pushMatrix();
      translate(punch.w / 2.0, punch.h / 2.0 + 8);
      ellipse(x, i * spacer.h, 5, 5);
      popMatrix();
    }
    popStyle();
    
    String code = p.get(Character.toString(letter));

    for (int i = 0; i < code.length(); i++) {
      float y = i * spacer.h;
      char digit = code.charAt(i);
      if (digit == '1') {
        pushMatrix();
        translate(0, 8);
        rect(x, y, punch.w, punch.h);
        popMatrix();
      }
    }
    x += spacer.w;
  }

  noiseify();  
}

void noiseify() {
  loadPixels();
  float imgSize = width * height;
  for (int i = 0; i < imgSize; i++) {
    color c = pixels[i];  
    float bright = brightness(c);
    float amt = 10;
    float rnd = random(-amt, amt);
    pixels[i] = color(bright + rnd);
  }
  updatePixels();
}
