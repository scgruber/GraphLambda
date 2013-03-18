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
    this.exitPoint = new ExitPointNode();
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