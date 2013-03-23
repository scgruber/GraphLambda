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
