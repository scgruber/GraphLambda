class ApplicationNode extends LambdaNode {
  LambdaNode originNode;
  
  ApplicationNode(PVector inInitialPosition) {
    this.label = '\0';
    this.originNode = null;
    this.nextNode = null;
    this.radius = 2;
    this.posCached = inInitialPosition.get();
    this.fillColor = color(0);
    this.isDirty = true;
  }
  
  void setOriginNode(LambdaNode inOriginNode) {
    originNode = inOriginNode;
  }
  
  LambdaNode getOriginNode() {
    return originNode;
  }
  
  void updatePosition() {
    PVector oldPos = posCached.get();
    posCached = PVector.lerp(originNode.posCached, nextNode.posCached, 0.5);
    if (oldPos == posCached) {
      originNode.isDirty = true;
      nextNode.isDirty = true;
    }
  }
}
