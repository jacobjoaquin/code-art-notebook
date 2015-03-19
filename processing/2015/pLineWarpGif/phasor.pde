/* Phasor
// Create
Phasor p = new Phasor(inc, initialPhase);

// Place at end of draw()
p.update();

// Use
p.phase;
p.inc;
p.radians();
p.sine();

Phasor phasor = new Phasor(0.125);

void draw() {
  phasor.update();
}
*/

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
