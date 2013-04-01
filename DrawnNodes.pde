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
  
  void display() {
  }
  
  void update() {
  }
  
  boolean isDescendant(Group grp) {
    Group p = parent;
    while (p != null) {
      if (p == grp) {
        return true;
      }
      p = p.parent;
    }
    return false;
  }
}

class Group extends Node {
  // This class produces enclosing circles for Lambda abstractions or groups
  ArrayList<Input> inputs;
  ArrayList<Node> interior;
  float maxInputRadius;
  Output output;
  
  Group(PVector initialCenter, float initialRadius, Group parentGroup) {
    this.parent = parentGroup;
    this.bound = new BoundingCircle(initialCenter, initialRadius);
    this.inputs = new ArrayList();
    this.interior = new ArrayList();
    this.maxInputRadius = 0;
    this.output = new Output(this, initialRadius);
  }
  
  void display() {
    pushMatrix();
    translate(bound.getX(), bound.getY());
    
    fill(255);
    stroke(0);
    ellipse(0, 0, bound.getDiam(), bound.getDiam());
    
    for (int i=interior.size()-1; i >= 0; i--) {
      interior.get(i).display();
    }
    for (int i=inputs.size()-1; i >= 0; i--) {
      inputs.get(i).display();
    }
    if (out != null) {
      line(output.bound.getX(), output.bound.getY(), out.bound.getX(), out.bound.getY());
    }
    output.display();
    
    popMatrix();
  }
  
  void addInput(Input inInput) {
    inInput.parent = this;
    inputs.add(inInput);
    float inc = PI/(inputs.size()+1);
    
    float newInputRadius;
    if (inInput.bound.getRadius() == 0) {
      newInputRadius = 10;
    } else {
      newInputRadius = inInput.bound.getRadius();
    }
    
    if (newInputRadius > maxInputRadius) {
      maxInputRadius = newInputRadius;
      bound.setRadius((maxInputRadius*5)/inc);
    }
    
    for (int i = inputs.size()-1; i >= 0; i--) {
      inputs.get(i).angle = inc*(i+1);
      inputs.get(i).update();
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
    BoundingCircle outer = bound.get();
    outer.alterRadius(maxInputRadius);
    return outer;
  }
  
  void makeApplication(Node in, Node app, Node out) {
    Application appNode = new Application(this);
    
    if (in.getOut() == null) {
      appNode.setIn(in);
      in.setOut(appNode);
    } else {
      Branch b = new Branch(this);
      b.setOut(in.getOut());
      in.getOut().setIn(b);
      b.setIn(in);
      in.setOut(b);
      b.setBranch(appNode);
      appNode.setIn(b);
      interior.add(b);
    }
    appNode.setOut(out);
    if (out.getIn() == null) {
      out.setIn(appNode);
    } else {
      // Error
      //println("Error: multiple assignment of destination input");
      //exit();
    }
    if (app != null) {
      appNode.setApp(app);
      if (app.getOut() == null) {
        app.setOut(appNode);
      } else {
        // Error
        println("Error: multiple assignment of applied argument output");
        exit();
      }
    }
    
    interior.add(appNode);
  }
  
  void addGroup(Group grp, Node out) {
    grp.setOut(out);
    
    interior.add(grp);
  }
  
  void update() {
    PVector newPos = new PVector(0,0);
    for (int i = interior.size()-1; i >= 0; i--) {
      interior.get(i).update();
      newPos.add(PVector.mult(interior.get(i).bound.getCenter(), 1/interior.size()));
    }
    bound.setCenter(newPos);
    float innerRadius = 0;
    for (int i = interior.size()-1; i >= 0; i--) {
      innerRadius = max(innerRadius, interior.get(i).bound.getRadius());
    }
    float outerRadius = (maxInputRadius * 2) / (PI / inputs.size()-1);
    bound.setRadius(max(innerRadius,outerRadius)+(25/drawingScale));
    for (int i = inputs.size()-1; i >= 0; i--) {
      inputs.get(i).update();
    }
    output.setParentRadius(bound.getRadius());
  }
}

class Input extends Node{
  // This class produces inputs on abstractions
  Group assignedGroup;
  char arg;
  float angle;
  
  Input(char inArg) {
    this.arg = inArg;
    this.bound = new BoundingCircle(new PVector(0,0),0);
  }
  
  void display() {
    pushMatrix();
    translate(bound.getX(), bound.getY());
    
    fill(255);
    stroke(0);
    float drawDiam;
    if (bound.getRadius() == 0) {
      drawDiam = 20/drawingScale;
    } else {
      drawDiam = bound.getDiam();
    }
    ellipse(0, 0, drawDiam, drawDiam);
    if (assignedGroup != null) {
      assignedGroup.display();
    }
    
    popMatrix();
  }
  
  void assignArgument(Group inAssignedGroup) {
    assignedGroup = inAssignedGroup;
    bound = assignedGroup.getBoundingCircle();
    bound.alterRadius(10);
  }
  
  Group getArgument() {
    return assignedGroup;
  }
  
  char getArg() {
    return arg;
  }
  
  void update() {
    bound.setCenter(new PVector(parent.bound.getRadius() * cos(angle), parent.bound.getRadius() * -sin(angle)));
  }
}

class Output extends Node{
  // This class produces outputs of abstractions
  float angle;
  
  Output(Group inParent, float inParentRadius) {
    this.parent = inParent;
    this.bound = new BoundingCircle(new PVector(0,inParentRadius), 0);
    this.angle = PI;
  }
  
  void display() {
    
    fill(0);
    float drawDiam;
    if (bound.getRadius() == 0) {
      drawDiam = 10/drawingScale;
    } else {
      drawDiam = bound.getDiam();
    }
    ellipse(bound.getX(), bound.getY(), drawDiam, drawDiam);
  }
  
  void setParentRadius(float inParentRadius) {
    bound.setY(inParentRadius);
  }
  
  void setOut(Node newOut) {
    out = newOut;
    
    PVector dir = PVector.sub(parent.bound.getCenter(), out.bound.getCenter());
    angle = dir.heading();
  }
  
  void update() {
    //bound.setCenter(new PVector(parent.bound.getRadius()*cos(angle), parent.bound.getRadius()*sin(angle)));
  }
}

class Branch extends Node{
  // This class creates branches of identical elements
  Node branch;
  
  Branch(Group inParent) {
    this.parent = inParent;
    this.bound = new BoundingCircle(new PVector(0,0), 10);
  }
  
  void setBranch(Node newBranch) {
    branch = newBranch;
  }
  
  Node getBranch() {
    return branch;
  }
  
  void display() {
    if (in != null) {
      line(bound.getX(), bound.getY(), in.bound.getX(), in.bound.getY());
    }
    if (branch != null) {
      line(bound.getX(), bound.getY(), branch.bound.getX(), branch.bound.getY());
    }
    if (out != null) {
      line(bound.getX(), bound.getY(), out.bound.getX(), out.bound.getY());
    }
  }
  
  void update() {
    PVector newPos = PVector.lerp(in.bound.getCenter(), out.bound.getCenter(), 0.5);
    newPos.lerp(branch.bound.getCenter(), 0.66);
    bound.setCenter(newPos);
  }
}

class Application extends Node{
  // This class creates applications of objects to functions
  Node app;
  
  Application(Group inParent) {
    this.parent = inParent;
    this.bound = new BoundingCircle(new PVector(0,0), 10);
  }
  
  void setApp(Node newApp) {
    app = newApp;
  }
  
  Node getApp() {
    return app;
  }
  
  void display() {
    if (in != null) {
      line(bound.getX(), bound.getY(), in.bound.getX(), in.bound.getY());
    }
    if (app != null) {
      line(bound.getX(), bound.getY(), app.bound.getX(), app.bound.getY());
    }
    if (out != null) {
      line(bound.getX(), bound.getY(), out.bound.getX(), out.bound.getY());
    }
  }
  
  void update() {
    if (in != null && out != null) {
      bound.setCenter(PVector.lerp(in.bound.getCenter(), out.bound.getCenter(), 0.5));
    }
  }
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
