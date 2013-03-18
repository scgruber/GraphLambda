class LambdaNode {
  PVector posCached;
  boolean isDirty;
  boolean isDrawn;
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
    isDirty = true;
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
    if (!isDrawn) {
      if (isDirty) {
        PVector locVector = new PVector(-inParentRadius, 0);
        locVector.rotate(angle);
        posCached = PVector.add(locVector, inParentCenter);
        isDirty = false;
      }
      
      // Actually draw the node
      stroke(0);
      fill(255);
      ellipse(posCached.x, posCached.y, 2*radius, 2*radius);
      textSize(16);
      fill(0);
      text(arg, posCached.x-4, posCached.y+4);
      
      isDrawn = true;
    }
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
    this.posCached = new PVector(0,0);
    this.isDirty = true;
  }
  
  void display(PVector inParentCenter, float inParentRadius) {
    if (!isDrawn) {
      if (isDirty) {
        PVector locVector = new PVector(inParentRadius, 0);
        locVector.rotate(angle);
        posCached = PVector.add(locVector, inParentCenter);
        isDirty = false;
      }
      
      // Actually draw the node
      stroke(0);
      fill(0);
      ellipse(posCached.x, posCached.y, 2*radius, 2*radius);
      
      isDrawn = true;
    }
  }
}
