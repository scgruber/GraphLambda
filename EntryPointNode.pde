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
  
  void updatePosition() {
    PVector locVector = new PVector(-parentRadius, 0);
    locVector.rotate(angle);
    posCached = PVector.add(locVector, parentCenter);
  }
}
