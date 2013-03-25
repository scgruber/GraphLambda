class Group {
  // This class produces enclosing circles for Lambda abstractions or groups
  Group parent;
  PVector center;
  float radius;
  ArrayList<Input> inputs;
  
  Group(PVector initialCenter, float initialRadius, Group parentGroup) {
    this.parent = parentGroup;
    this.center = initialCenter;
    this.radius = initialRadius;
    this.inputs = new ArrayList();
  }
  
  void display() {
    ellipse(center.x, center.y, 2*radius, 2*radius);
  }
}

class Input {
  // This class produces inputs on abstractions
  Group parent;
  Merge exterior;
  Merge interior;
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
