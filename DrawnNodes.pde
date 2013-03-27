class Group {
  // This class produces enclosing circles for Lambda abstractions or groups
  Group parent;
  BoundingCircle bound;
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
  
  BoundingCircle getBoundingCircle() {
    return bound.get();
  }
  
  BoundingCircle getOuterBound() {
    BoundingCircle outer = bound.get();
    outer.alterRadius(maxInputRadius);
    return outer;
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

class Output {
  // This class produces outputs of abstractions
  Group parent;
  Merge interior;
  Merge exterior;
  BoundingCircle bound;
  
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
