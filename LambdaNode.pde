class LambdaNode {
  char label;
  PVector posCached;
  float radius;
  boolean isDirty;
  boolean isDrawn;
  color fillColor;
  LambdaNode nextNode;
  
  void display(PVector inParentCenter, float inParentRadius) {
    if (!isDrawn) {
      isDrawn = true;
      
      if (isDirty) {
        updatePosition();
        isDirty = false;
      }
      
      if (nextNode != null) {
        line(posCached.x, posCached.y, nextNode.posCached.x, nextNode.posCached.y);
        nextNode.display(inParentCenter, inParentRadius);
      }
      
      // Actually draw the node
      stroke(0);
      fill(fillColor);
      ellipse(posCached.x, posCached.y, 2*radius, 2*radius);
      if (label != '\0') {
        textSize(16);
        fill(0);
        text(label, posCached.x-4, posCached.y+4);
      }
    }
  }
  
  void setNextNode(LambdaNode inNextNode) {
    nextNode = inNextNode;
  }
  
  void updatePosition() {
    return;
  }
}

class EntryPointNode extends LambdaNode{
  float angle;
  PVector parentCenter;
  float parentRadius;
  
  EntryPointNode(char inArgChar, PVector inParentCenter, float inParentRadius) {
    this.label = inArgChar;
    this.radius = 10;
    this.angle = 0;
    this.nextNode = null;
    this.posCached = new PVector(0,0);
    this.parentCenter = inParentCenter.get();
    this.parentRadius = inParentRadius;
    this.fillColor = color(255);
  }
  
  char getLabel() {
    return label;
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
  
  void updatePosition() {
    PVector locVector = new PVector(-parentRadius, 0);
    locVector.rotate(angle);
    posCached = PVector.add(locVector, parentCenter);
  }
}

class BranchNode extends LambdaNode {
}

class ApplicationNode extends LambdaNode {
  LambdaNode originNode;
  
  ApplicationNode(PVector inInitialPosition) {
    this.label = '\0';
    this.originNode = null;
    this.radius = 2;
    this.posCached = new PVector(inInitialPosition.x, inInitialPosition.y);
    this.fillColor = color(0);
  }  
  
  void updatePosition() {
    return;
  }
}

class ExitPointNode extends LambdaNode {
  float angle;
  PVector parentCenter;
  float parentRadius;
  
  ExitPointNode(PVector inParentCenter, float inParentRadius) {
    this.label = '\0';
    this.angle = HALF_PI;
    this.radius = 5;
    this.posCached = new PVector(0,0);
    this.isDirty = true;
    this.parentCenter = inParentCenter.get();
    this.parentRadius = inParentRadius;
    this.fillColor = color(0);
  }
  
  void updatePosition() {
    PVector locVector = new PVector(parentRadius, 0);
    locVector.rotate(angle);
    posCached = PVector.add(locVector, parentCenter);
  }
}
