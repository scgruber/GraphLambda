class Group {
  // This class produces enclosing circles for Lambda abstractions or groups
  Group parent;
  BoundingCircle bound;
  ArrayList<Input> inputs;
  
  Group(PVector initialCenter, float initialRadius, Group parentGroup) {
    this.parent = parentGroup;
    this.bound = new BoundingCircle(initialCenter, initialRadius);
    this.inputs = new ArrayList();
  }
  
  void display() {
    ellipse(bound.getX(), bound.getY(), bound.getDiam(), bound.getDiam());
  }
  
  void addInput(Input inInput) {
    inputs.add(inInput);
  }
  
  Input getInput(char inArg) {
    for (int i = inputs.size()-1; i >= 0; i--) {
      if (inputs.get(i).getArg() == inArg) return inputs.get(i);
    }
    if (parent != null) return parent.getInput(inArg);
    else return null;
  }
  
  BoundingCircle getBoundingCircle() {
    return bound.get();
  }
}

class Input {
  // This class produces inputs on abstractions
  Group parent;
  Merge exterior;
  Merge interior;
  Group assignedGroup;
  char arg;
  BoundingCircle bound;
  
  Input(char inArg) {
    this.arg = inArg;
    this.bound = new BoundingCircle(new PVector(0,0),10);
  }
  
  void display() {
    ellipse(bound.getX(), bound.getY(), bound.getDiam(), bound.getDiam());
  }
  
  void assignArgument(Group inAssignedGroup) {
    assignedGroup = inAssignedGroup;
    bound = inAssignedGroup.getBoundingCircle();
    bound.alterRadius(10);
  }
  
  Group getArgument() {
    return assignedGroup;
  }
  
  char getArg() {
    return arg;
  }
}

class Output {
  // This class produces outputs of abstractions
  Group parent;
  Merge interior;
  Merge exterior;
}

class Branch {
  // This class creates branches of identical elements
  Group parent;
  Merge source;
  Merge left;
  Merge right;
}

class Application {
  // This class creates applications of objects to functions
  Group parent;
  Merge fn;
  Merge arg;
  Merge result;
}

class Merge {
  // This class defines a connection between two other nodes
  Group parent;
  ControlPoint start;
  ControlPoint end;
}

class ControlPoint {
  // This class defines control points for nodes
  PVector pos;
  PVector dir;
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
