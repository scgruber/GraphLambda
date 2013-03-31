class TokenString {
  String val;
  TokenString next;
  TokenString child;
  
  TokenString() {
    this.val = "";
    this.next = null;
    this.child = null;
  }
  
  TokenString(String inLC) throws TokenStringException {
    this.val = "";
    this.next = null;
    this.child = null;
    if (inLC.length() == 0) {
      println("Passed empty Lambda string");
      throw new TokenStringException();
    }
    if (inLC.charAt(0) == '(') {
      if (inLC.length() < 2) {
        println("Lambda string ends with '('");
        throw new TokenStringException();
      }
      if (inLC.charAt(1) == '\\') { // Lambda abstraction
        int i = 2;
        this.val = "";
        if (i >= inLC.length()) {
          println("Abstraction has no arguments");
          throw new TokenStringException();
        }
        while (inLC.charAt(i) != '.') {
          this.val += inLC.charAt(i);
          i++;
          if (i == inLC.length()) {
            println("Abstraction has no dot");
            throw new TokenStringException();
          }
        }
        int startIndex = ++i;
        int depth = 1;
        while (depth > 0) {
          if (i == inLC.length()) {
            println("Mismatched parentheses");
            throw new TokenStringException();
          }
          if (inLC.charAt(i) == '(') depth++;
          else if (inLC.charAt(i) == ')') depth--;
          i++;
        }
        int finishIndex = i;
        String childLambdaString = inLC.substring(startIndex, finishIndex-1);
        if (childLambdaString.length() > 0) {
          print("Parsing Child: ");
          println(childLambdaString);
          this.child = new TokenString(childLambdaString);
        }
        String nextLambdaString = inLC.substring(finishIndex);
        if (nextLambdaString.length() > 0) {
          print("Parsing Next: ");
          println(nextLambdaString);
          this.next = new TokenString(nextLambdaString);
        }
      } else { // Group
        int startIndex = 1;
        int i = 1;
        int depth = 1;
        while (depth > 0) {
          if (i == inLC.length()) {
            println("Mismatched parentheses");
            throw new TokenStringException();
          }
          if (inLC.charAt(i) == '(') depth++;
          else if (inLC.charAt(i) == ')') depth--;
          i++;
        }
        int finishIndex = i;
        String childLambdaString = inLC.substring(startIndex, finishIndex-1);
        if (childLambdaString.length() > 0) {
          print("Parsing Child: ");
          println(childLambdaString);
          this.child = new TokenString(childLambdaString);
        }
        String nextLambdaString = inLC.substring(finishIndex);
        if (nextLambdaString.length() > 0) {
          print("Parsing Next: ");
          println(nextLambdaString);
          this.next = new TokenString(nextLambdaString);
        }
      }
    } else { // Normal token
      this.val = "" + inLC.charAt(0);
      String nextLambdaString = inLC.substring(1);
      if (nextLambdaString.length() > 0) {
        print("Parsing Next: ");
        println(nextLambdaString);
        this.next = new TokenString(nextLambdaString);
      }
    }
  }
  
  String toString() {
    String out = "";
    if (child != null) {
      out += "(";
      if (val != "") { // Abstraction
        out += "\\" + val + ".";
      }
      out += child.toString();
      out += ")";
    } else {
      out += val;
    }
    if (next != null) {
      out += next.toString();
    }
    return out;
  }
  
  // This function should be called on a TokenString representing a group only
  TokenString produceDrawing(Group inContainerGroup) {
    if (this.child == null) {
      println("Error: invalid target for produceDrawing call");
      exit();
    }
    
    TokenString nextToken = next;
    
    for (int i=0; i<val.length(); i++) {
      Input in = new Input(val.charAt(i));
      if (nextToken != null) {
        Group arg = new Group(new PVector(0,0), 10, inContainerGroup.parent);
        groups.add(arg);
        nextToken.makeSingleton().produceDrawing(arg);
        nextToken = nextToken.next;
        in.assignArgument(arg);
      }
      inContainerGroup.addInput(in);
    }
    
    TokenString nextChild = child;
    Node appliesTo = null;
    while (nextChild != null) {
      if (nextChild.child == null) {
        // Variable node
        println("Create application for "+nextChild.val);
        Input origin = inContainerGroup.getInput(nextChild.val.charAt(0));
        Node output;
        if (appliesTo != null) {
          output = appliesTo;
        } else {
          output = inContainerGroup.output;
        }
        inContainerGroup.makeApplication(origin, null, output);
        appliesTo = inContainerGroup.interior.get(inContainerGroup.interior.size()-1);
        nextChild = nextChild.next;
      } else {
        // Group node
        println("Create group with vars "+nextChild.val);
        Group grp = new Group(new PVector(0,0), 10, inContainerGroup);
        groups.add(grp);
        nextChild = nextChild.produceDrawing(grp);
        Node output;
        if (appliesTo != null) {
          output = appliesTo;
        } else {
          output = inContainerGroup.output;
        }
        inContainerGroup.addGroup(grp, output);
        break;
      }
    }
    
    return nextToken;
  }
  
  TokenString makeSingleton() {
    TokenString out = new TokenString();
    out.val = val;
    out.next = null;
    out.child = child;
    
    return out;
  }
}

class TokenStringException extends Exception {
}
