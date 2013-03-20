class Abstraction {
  PVector pos;
  float rad;
  ArrayList<LambdaNode> allNodes;
  ArrayList<EntryPointNode> entryPoints;
  ExitPointNode exitPoint;
  
  Abstraction(PVector inCreatePos, float inCreateRad) {
    this.pos = inCreatePos;
    this.rad = inCreateRad;
    this.allNodes = new ArrayList();
    this.entryPoints = new ArrayList();
    this.exitPoint = new ExitPointNode(pos, rad);
    this.allNodes.add(this.exitPoint);
  }
  
  void display() {
    // Mark all nodes as undrawn
    for (int i=allNodes.size()-1; i >= 0; i--) {
      allNodes.get(i).isDrawn = false;
    }
    
    stroke(0);
    fill(255);
    ellipse(pos.x, pos.y, 2*rad, 2*rad);
    for (int i = entryPoints.size()-1; i >= 0; i--) {
      entryPoints.get(i).display(pos, rad);
    }
  }
  
  void addEntryPoint(EntryPointNode inEntryPoint) {
    allNodes.add(inEntryPoint);
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
      if (entryPoints.get(i).getLabel() == inArg) {
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
      a.addEntryPoint(new EntryPointNode(arg, pos, rad));
    }
    LambdaStringTree lcTree = new LambdaStringTree(list[1], a.exitPoint, pos);
  }
}

class LambdaStringTree {
  String lambdaString;
  LambdaStringTree left;
  LambdaStringTree right;
  
  LambdaStringTree(String inLambdaString, LambdaNode inParentNode, PVector inCenter) {
    this.lambdaString = inLambdaString;
    this.left = null;
    this.right = null;
    if (inLambdaString.length() == 1) {
      LambdaNode entry = a.findEntryPoint(inLambdaString.charAt(0));
      if (entry != null) {
        entry.setNextNode(inParentNode);
      }
    } else {
      ApplicationNode appNode = new ApplicationNode(inCenter);
      appNode.setNextNode(inParentNode);
      
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
              leftLambdaString = inLambdaString.substring(0,splitIndex-1);
              rightLambdaString = inLambdaString.substring(splitIndex);
            }
        }
        splitIndex--;
      }
      if (splitIndex == 0) {
        return;
      }
      
      this.left = new LambdaStringTree(leftLambdaString, appNode, inCenter);
      this.right = new LambdaStringTree(rightLambdaString, appNode, inCenter);
    }
  }
}
