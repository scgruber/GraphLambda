class Abstraction {
  Abstraction parent;
  // This class produces enclosing circles for Lambda abstractions
}

class Input {
  // This class produces inputs on abstractions
  Abstraction parent;
  Merge exterior;
  Merge interior;
}

class Output {
  // This class produces outputs of abstractions
  Abstraction parent;
  Merge interior;
  Merge exterior;
}

class Branch {
  // This class creates branches of identical elements
  Abstraction parent;
  Merge source;
  Merge left;
  Merge right;
}

class Application {
  // This class creates applications of objects to functions
  Abstraction parent;
  Merge fn;
  Merge arg;
  Merge result;
}

class Merge {
  // This class defines a connection between two other nodes
  Abstraction parent;
  ControlPoint start;
  ControlPoint end;
}

class ControlPoint {
  // This class defines control points for nodes
  PVector pos;
  PVector dir;
}
