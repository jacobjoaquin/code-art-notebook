class Phasor {
  float inc = 0.0;
  float phase = 0.0;
  
  Phasor() {
    this(0, 0);
  }
  
  Phasor(float inc) {
    this(inc, 0);
  }
  
  Phasor(float inc, float phase) {
    this.inc = inc;
    this.phase = phase;
  }
  
  void update() {
    phase += inc;
    while(phase >= 1.0) {
      phase -= 1.0;
    }
    while(phase < 0.0) {
      phase += 1.0;
    }
  }
  
  float radians() {
    return phase * TWO_PI;
  }
  
  float sine() {
    return sin(phase * TWO_PI);
  }  
}
