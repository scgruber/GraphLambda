// GraphLambda
// Sam Gruber <scgruber@andrew.cmu.edu>

Group root;
String lcString = "(\\nfx.n(\\gh.h(gf))(\\u.x)(\\u.u))"; // Predecessor function
TokenString lambdaTokens;
PFont cantarell;

void setup() {
  size(640,480);
  background(255);
  strokeWeight(2);
  
  // Build the lambda expression object
  lambdaTokens = new TokenString(lcString);
  root = lambdaTokens.produceDrawing(null);
  cantarell = loadFont("Cantarell-Bold-48.vlw");
  textFont(cantarell, 32);
}

void draw() {
  background (255);
  smooth();
  
  // Draw the lambda expressions
  pushMatrix();
  translate(320, 240);
  
  fill(255);
  stroke(0);
  strokeWeight(2);
  
  root.display();
  
  popMatrix();
  
  // Draw the lambda string
  textSize(32);
  fill(0,102,153);
  text(lcString, 10, 30);
}
