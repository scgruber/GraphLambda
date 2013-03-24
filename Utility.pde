static class Utility {
  static String unWrapParentheses(String in) {
    if (in.length() <= 1) return in;
    if ((in.charAt(0) == '(') && (in.charAt(in.length()-1) == ')')) {
      return in.substring(1, in.length()-2);
    } else {
      return in;
    }
  }
  
  static String[] splitAtPosition(String in, int pos) {
    if (pos < 0 || pos >= in.length()) {
      println("Split index out of range");
      return null;
    }
    String[] halves = { in.substring(0, pos), in.substring(pos) };
    return halves;
  }
}
