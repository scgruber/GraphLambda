// GraphLambda
// Sam Gruber <scgruber@andrew.cmu.edu>

Group root;
String lcString = "(\\nfx.n(\\gh.h(gf))(\\u.x)(\\u.u))(\\fx.fx)";
TokenString lambdaTokens;
PFont cantarell;

void setup() {
  size(800,600);
  background(255);
  strokeWeight(2);
  
  // Build the lambda expression object
  try {
    lambdaTokens = new TokenString(lcString);
    root = lambdaTokens.produceDrawing(null);
  } catch (TokenStringException e) {
    lambdaTokens = null;
  }
  cantarell = loadFont("Cantarell-Bold-48.vlw");
  textFont(cantarell, 32);
}

void draw() {
  background (255);
  smooth();
  
  // Draw the lambda expressions
  pushMatrix();
  translate(width/2, height/2);
  
  fill(255);
  stroke(0);
  strokeWeight(2);
  
  if (root != null) {
    root.display();
  }
  
  popMatrix();
  
  // Draw the lambda string
  textSize(32);
  fill(0,102,153);
  text(lcString, 10, 30);
}

void keyTyped() {
  if (('a' <= key && key <= 'z') || key == '\\' || key == '(' || key == ')' || key == '.') {
    lcString += key;
  } else if (key == BACKSPACE) {
    lcString = lcString.substring(0,lcString.length()-1);
  }
  
  // Build the new lambda expression object
  try {
    lambdaTokens = new TokenString(lcString);
    root = lambdaTokens.produceDrawing(null);
  } catch (TokenStringException e) {
    lambdaTokens = null;
  }
}
