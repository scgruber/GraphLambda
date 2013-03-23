class LambdaStringTree {
  String lambdaString;
  LambdaStringTree left;
  LambdaStringTree right;
  LambdaNode node;
  
  LambdaStringTree(String inLambdaString, LambdaNode inParentNode, PVector inCenter) {
    print("Processing string: ");
    println(inLambdaString);
    this.lambdaString = inLambdaString;
    this.left = null;
    this.right = null;
    if (inLambdaString.length() == 1) {
      LambdaNode entry = a.findEntryPoint(inLambdaString.charAt(0));
      if (entry != null) {
        if (entry.getNextNode() != null) {
          BranchNode bNode = new BranchNode(inCenter, entry.getNextNode(), inParentNode);
          entry.setNextNode(bNode);
          bNode.setOriginNode(entry);
          this.node = bNode;
          a.addNode(bNode);
        } else {
          this.node = entry;
          entry.setNextNode(inParentNode);
        }
      }
    } else {
      this.node = new ApplicationNode(inCenter);
      a.addNode(this.node);
      this.node.setNextNode(inParentNode);
      
      int splitIndex = inLambdaString.length()-1;
      int parenDepth = 0;
      String leftLambdaString = "";
      String rightLambdaString = "";
      while (splitIndex > 0) {
        switch(inLambdaString.charAt(splitIndex)) {
          case ')':
            parenDepth++;
          case '(':
            if (parenDepth == 0) {
              println("mismatched parentheses");
              exit();
            }
            parenDepth--;
          case '\\':
            println("unhandled lambda");
            exit();
          default:
            if (parenDepth == 0) {
              leftLambdaString = inLambdaString.substring(0,splitIndex);
              rightLambdaString = inLambdaString.substring(splitIndex);
            }
        }
        splitIndex--;
      }
      
      print("Split into: '");
      print(leftLambdaString);
      print("' and '");
      print(rightLambdaString);
      println("'");
      this.left = new LambdaStringTree(leftLambdaString, this.node, inCenter);
      ((ApplicationNode)this.node).setOriginNode(this.left.node);
      this.right = new LambdaStringTree(rightLambdaString, this.node, inCenter);
    }
  }
}
