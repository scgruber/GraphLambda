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

class Abstraction {
  PVector pos;
  float rad;
  ArrayList<EntryPointNode> entryPoints;
  ExitPointNode exitPoint;
  
  Abstraction(PVector inCreatePos, float inCreateRad) {
    this.pos = inCreatePos;
    this.rad = inCreateRad;
    this.entryPoints = new ArrayList();
    this.exitPoint = new ExitPointNode();
  }
  
  void display() {
    stroke(0);
    fill(255);
    ellipse(pos.x, pos.y, 2*rad, 2*rad);
    for (int i = entryPoints.size()-1; i >= 0; i--) {
      entryPoints.get(i).display(pos, rad);
    }
    exitPoint.display(pos, rad);
  }
  
  void addEntryPoint(EntryPointNode inEntryPoint) {
    entryPoints.add(inEntryPoint);
    
    // Relocate all entry points along the curve
    int numEntryPoints = entryPoints.size();
    float step = PI / (numEntryPoints+1);
    for (int i = entryPoints.size()-1; i >= 0; i--) {
      entryPoints.get(i).setAngle(step * (i+1));
    }
  }
  
  EntryPointNode findEntryPoint(char inArg) {
    for (int i = entryPoints.size()-1; i >= 0; i--) {
      if (entryPoints.get(i).getArg() == inArg) {
        return entryPoints.get(i);
      }
    }
    
    // If we didn't find it
    return null;
  }
  
  void parseLambdaString(String inLambdaString) {
    String[] list = split(inLambdaString, '.');
    String argset = list[0].substring(1);
    for (int i = argset.length()-1; i >= 0; i--) {
      char arg = argset.charAt(i);
      a.addEntryPoint(new EntryPointNode(arg));
    }
    String fnBody = list[1];
    if (fnBody.length() == 1) {
      a.findEntryPoint(fnBody.charAt(0)).setNextNode(exitPoint);
    }
  }
}

class LambdaNode {
}

class EntryPointNode extends LambdaNode{
  char arg;
  float angle;
  float radius;
  LambdaNode nextNode;
  
  EntryPointNode(char inArgChar) {
    this.arg = inArgChar;
    this.radius = 10;
    this.angle = 0;
    this.nextNode = null;
  }
  
  char getArg() {
    return arg;
  }
  
  void setAngle(float inAngle) {
    angle = inAngle;
  }
  
  float getAngle() {
    return angle;
  }
  
  void setNextNode(LambdaNode inNextNode) {
    nextNode = inNextNode;
  }
  
  LambdaNode getNextNode() {
    return nextNode;
  }
  
  void display(PVector inParentCenter, float inParentRadius) {
    PVector locVector = new PVector(-inParentRadius, 0);
    locVector.rotate(angle);
    PVector pos = PVector.add(locVector, inParentCenter);
    
    // Actually draw the node
    stroke(0);
    fill(255);
    ellipse(pos.x, pos.y, 2*radius, 2*radius);
    textSize(16);
    fill(0);
    text(arg, pos.x-4, pos.y+4);
  }
}

class BranchNode extends LambdaNode {
}

class ApplicationNode extends LambdaNode {
}

class ExitPointNode extends LambdaNode {
  float angle;
  float radius;
  
  ExitPointNode() {
    this.angle = HALF_PI;
    this.radius = 5;
  }
  
  void display(PVector inParentCenter, float inParentRadius) {
    PVector locVector = new PVector(inParentRadius, 0);
    locVector.rotate(angle);
    PVector pos = PVector.add(locVector, inParentCenter);
    
    // Actually draw the node
    stroke(0);
    fill(0);
    ellipse(pos.x, pos.y, 2*radius, 2*radius);
  }
}
