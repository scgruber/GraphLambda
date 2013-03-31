class Node {
  Group parent;
  Node in;
  Node out;
  BoundingCircle bound;
  
  BoundingCircle getBoundingCircle() {
    return bound.get();
  }
  
  void setIn(Node newIn) {
    in = newIn;
  }
  
  Node getIn() {
    return in;
  }
  
  void setOut(Node newOut) {
    out = newOut;
  }
  
  Node getOut() {
    return out;
  }
}

class Group extends Node {
  // This class produces enclosing circles for Lambda abstractions or groups
  ArrayList<Input> inputs;
  float maxInputRadius;
  Output output;
  
  Group(PVector initialCenter, float initialRadius, Group parentGroup) {
    this.parent = parentGroup;
    this.bound = new BoundingCircle(initialCenter, initialRadius);
    this.inputs = new ArrayList();
    this.maxInputRadius = 0;
    this.output = new Output(this, initialRadius);
  }
  
  void display() {
    pushMatrix();
    translate(bound.getX(), bound.getY());
    
    ellipse(0, 0, bound.getDiam(), bound.getDiam());
    for (int i=inputs.size()-1; i >= 0; i--) {
      inputs.get(i).display();
    }
    output.display();
    
    popMatrix();
  }
  
  void addInput(Input inInput) {
    inputs.add(inInput);
    float inc = PI/(inputs.size()+1);
    
    if (inInput.bound.getRadius() > maxInputRadius) {
      maxInputRadius = inInput.bound.getRadius();
      bound.setRadius((maxInputRadius*5)/inc);
    }
    
    for (int i = inputs.size()-1; i >= 0; i--) {
      inputs.get(i).bound.setCenter(new PVector(bound.getRadius() * cos(inc*(i+1)),
        bound.getRadius() * -sin(inc*(i+1))));
    }
    
    output.setParentRadius(bound.getRadius());
  }
  
  Input getInput(char inArg) {
    for (int i = inputs.size()-1; i >= 0; i--) {
      if (inputs.get(i).getArg() == inArg) return inputs.get(i);
    }
    if (parent != null) return parent.getInput(inArg);
    else return null;
  }
  
  BoundingCircle getOuterBound() {
    BoundingCircle outer = bound.get();
    outer.alterRadius(maxInputRadius);
    return outer;
  }
}

class Input extends Node{
  // This class produces inputs on abstractions
  Group assignedGroup;
  char arg;
  
  Input(char inArg) {
    this.arg = inArg;
    this.bound = new BoundingCircle(new PVector(0,0),10);
  }
  
  void display() {
    pushMatrix();
    translate(bound.getX(), bound.getY());
    
    ellipse(0, 0, bound.getDiam(), bound.getDiam());
    if (assignedGroup != null) {
      assignedGroup.display();
    }
    
    popMatrix();
  }
  
  void assignArgument(Group inAssignedGroup) {
    assignedGroup = inAssignedGroup;
    bound = inAssignedGroup.getOuterBound();
    bound.alterRadius(10);
  }
  
  Group getArgument() {
    return assignedGroup;
  }
  
  char getArg() {
    return arg;
  }
}

class Output extends Node{
  // This class produces outputs of abstractions
  
  Output(Group inParent, float inParentRadius) {
    this.parent = inParent;
    this.bound = new BoundingCircle(new PVector(0,inParentRadius), 5);
  }
  
  void display() {
    fill(0);
    ellipse(bound.getX(), bound.getY(), bound.getDiam(), bound.getDiam());
  }
  
  void setParentRadius(float inParentRadius) {
    bound.setY(inParentRadius);
  }
}

class Branch extends Node{
  // This class creates branches of identical elements
}

class Application extends Node{
  // This class creates applications of objects to functions
}

class BoundingCircle {
  // This class defines a generic bounding circle
  PVector center;
  float radius;
  
  BoundingCircle(PVector inCenter, float inRadius) {
    this.center = inCenter;
    this.radius = inRadius;
  }
  
  void set(BoundingCircle inBC) {
    this.center = inBC.getCenter();
    this.radius = inBC.getRadius();
  }
  
  BoundingCircle get() {
    return new BoundingCircle(center, radius);
  }
  
  void setCenter(PVector inCenter) {
    center = inCenter;
  }
  
  PVector getCenter() {
    return center.get();
  }
  
  void setX(float inX) {
    center.x = inX;
  }
  
  float getX() {
    return center.x;
  }
  
  void setY(float inY) {
    center.y = inY;
  }
  
  float getY() {
    return center.y;
  }
  
  void setRadius(float inRadius) {
    radius = inRadius;
  }
  
  float getRadius() {
    return radius;
  }
  
  void alterRadius(float change) {
    radius += change;
  }
  
  void setDiam(float inDiam) {
    radius = inDiam/2;
  }
  
  float getDiam() {
    return radius*2;
  }
}
