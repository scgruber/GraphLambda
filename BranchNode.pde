class BranchNode extends LambdaNode {
  LambdaNode sideNode;
  
  BranchNode(PVector inInitialPosition, LambdaNode inNextNode, LambdaNode inSideNode) {
    this.label = '\0';
    this.nextNode = inNextNode;
    this.sideNode = inSideNode;
    this.originNode = null;
    this.radius = 2;
    this.posCached = inInitialPosition.get();
    this.fillColor = color(0);
    this.isDirty = true;
  }
  
  void updatePosition() {
    PVector oldPos = posCached.get();
    posCached = PVector.lerp(PVector.lerp(originNode.posCached, nextNode.posCached, 0.5), sideNode.posCached, 0.33);
    if (oldPos == posCached) {
      originNode.isDirty = true;
      nextNode.isDirty = true;
    }
  }
  
  void display(PVector inParentCenter, float inParentRadius) {
    if (!isDrawn) {
      isDrawn = true;
      
//      if (isDirty) {
        updatePosition();
        isDirty = false;
//      }
      
      if (nextNode != null) {
        line(posCached.x, posCached.y, nextNode.posCached.x, nextNode.posCached.y);
        nextNode.display(inParentCenter, inParentRadius);
      }
      if (sideNode != null) {
        line(posCached.x, posCached.y, sideNode.posCached.x, sideNode.posCached.y);
        sideNode.display(inParentCenter, inParentRadius);
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
}
