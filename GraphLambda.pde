// GraphLambda
// Sam Gruber <scgruber@andrew.cmu.edu>

Group root;
String lcString = "(\\xyz.x(yz))";
TokenString lambdaTokens;
PFont cantarell;
float drawingScale;

void setup() {
  size(800,600);
  background(255);
  strokeWeight(2);
  
  // Build the lambda expression object
  try {
    lambdaTokens = new TokenString(lcString);
    root = new Group(new PVector(0,0), 10, null);
    lambdaTokens.produceDrawing(root);
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
  translate(width/2, height/2+20);
  
  fill(255);
  stroke(0);
  
  if (root != null) {
    // Determine appropriate window scale
    drawingScale = height/(root.getBoundingCircle().getDiam());
    pushMatrix();
    scale(drawingScale);
    strokeWeight(2/drawingScale);
    
    root.display();
    popMatrix();
  }
  
  popMatrix();
  
  // Draw the lambda string
  fill(200);
  strokeWeight(0);
  rect(0,0, width, 40);
  textSize(32);
  fill(0,102,153);
  text(lcString, 10, 30);
}

void keyTyped() {
  if (('a' <= key && key <= 'z') || key == '\\' || key == '(' || key == ')' || key == '.') {
    lcString += key;
  } else if (key == BACKSPACE && lcString.length() > 0) {
    lcString = lcString.substring(0,lcString.length()-1);
  }
  
  // Build the new lambda expression object
  try {
    lambdaTokens = new TokenString(lcString);
    root = new Group(new PVector(0,0), 0, null);
    lambdaTokens.produceDrawing(root);
  } catch (TokenStringException e) {
    lambdaTokens = null;
  }
}
