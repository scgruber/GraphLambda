// GraphLambda
// Sam Gruber <scgruber@andrew.cmu.edu>

Abstraction a;
String lcString = "\\xy.x";

void setup() {
  size(640,480);
  background(255);
  strokeWeight(2);
  
  // Build the lambda expression object
  a = new Abstraction(new PVector(0,0), 100.0);
  a.parseLambdaString(lcString);
}

void draw() {
  background (255);
  smooth();
  
  // Draw the lambda expressions
  pushMatrix();
  translate(320, 240);
  a.display();
  
  popMatrix();
  
  // Draw the lambda string
  textSize(32);
  fill(0,102,153);
  text(lcString, 10, 30);
}
