// GraphLambda
// Sam Gruber <scgruber@andrew.cmu.edu>

Abstraction a;

void setup() {
  size(640,480);
  background(255);
  strokeWeight(2);
  a = new Abstraction(new PVector(0.0,0.0,0.0), 100.0);
}

void draw() {
  translate(320, 240);
  a.disp();
}

class Abstraction {
  PVector pos;
  float diam;
  
  Abstraction(PVector p, float d) {
    this.pos = p;
    this.diam = d;
  }
  
  void disp() {
    stroke(0);
    fill(255);
    ellipse(pos.x, pos.y, diam, diam);
  }
}
