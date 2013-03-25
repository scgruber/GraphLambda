// GraphLambda
// Sam Gruber <scgruber@andrew.cmu.edu>

Abstraction root;
String lcString = "(\\nfx.n(\\gh.h(gf))(\\u.x)(\\u.u))"; // Predecessor function
TokenString lambdaTokens;
PFont cantarell;

void setup() {
  size(640,480);
  background(255);
  strokeWeight(2);
  
  // Build the lambda expression object
  TokenString ts = new TokenString(lcString);
  cantarell = loadFont("Cantarell-Bold-48.vlw");
  textFont(cantarell, 32);
}

void draw() {
  background (255);
  smooth();
  
  // Draw the lambda expressions
  pushMatrix();
  translate(320, 240);
  
  popMatrix();
  
  // Draw the lambda string
  textSize(32);
  fill(0,102,153);
  text(lcString, 10, 30);
}
