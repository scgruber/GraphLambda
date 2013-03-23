class LambdaNode {
  char label;
  PVector posCached;
  float radius;
  boolean isDirty;
  boolean isDrawn;
  color fillColor;
  LambdaNode originNode;
  LambdaNode nextNode;
  
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
  
  void setOriginNode(LambdaNode inOriginNode) {
    originNode = inOriginNode;
  }
  
  LambdaNode getOriginNode() {
    return originNode;
  }
  
  void setNextNode(LambdaNode inNextNode) {
    nextNode = inNextNode;
  }
  
  LambdaNode getNextNode() {
    return nextNode;
  }
  
  void updatePosition() {
    return;
  }
}
