class ColorObject {
  float r = 0.0;
  float g = 0.0;
  float b = 0.0;
  float a = 255.0;

  ColorObject() {
  }

  ColorObject(color c) {
    r = c >> 16 & 0xFF;
    g = c >> 8 & 0xFF;
    b = c & 0xFF;
    a = c >> 24 & 0XFF;
  }

  void setColor(color c) {
    r = c >> 16 & 0xFF;
    g = c >> 8 & 0xFF;
    b = c & 0xFF;
    a = c >> 24 & 0XFF;
  }

  void set(float white) {
    r = g = b = white;
    a = 255.0;
    constrainRGB();
  }

  void set(float white, float alpha) {
    r = g = b = white;
    a = alpha;
    constrainRGB();
  }

  void set(float r, float g, float b) {
    this.r = r;
    this.g = g;
    this.b = b;
    a = 255.0;
  }

  void set(float r, float g, float b, float a) {
    this.r = r;
    this.g = g;
    this.b = b;
    this.a = a;
  }

  color get() {
    return int(r) << 16 | int(g) << 8 | int(b) | int(a) << 24;
  }

  void addBrightness(float amt) {
    r += amt;
    g += amt;
    b += amt;
    constrainRGB();
  }

  void multBrightness(float amt) {
    r *= amt;
    g *= amt;
    b *= amt;
    constrainRGB();
  }

  void addHue(float amt) {
    color c = get();
    float h = hue(c);
    float s = saturation(c);
    float b1 = brightness(c);
    float a1 = alpha(c);
    h += amt;
    while (h >= 256.0) {
      h -= 256.0;
    }
    while (h < 0) {
      h += 256.0;
    }
    pushStyle();
    colorMode(HSB);
    c = color(h, s, b1, a1);
    popStyle();
    r = c >> 16 & 0xFF;
    g = c >> 8 & 0xFF;
    b = c & 0xFF;
    a = c >> 24 & 0XFF;
    constrainRGB();
  }

  void setAlpha(float a) {
    this.a = a;
  }

  private void constrainRGB() {
    r = r > 255.0 ? 255.0 : r;
    g = g > 255.0 ? 255.0 : g;
    b = b > 255.0 ? 255.0 : b;
    a = a > 255.0 ? 255.0 : a;
    r = r < 0.0 ? 255.0 : r;
    g = g < 0.0 ? 255.0 : g;
    b = b < 0.0 ? 255.0 : b;    
    a = a < 0.0 ? 255.0 : a;
  }
}
