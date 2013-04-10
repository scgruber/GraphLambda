package com.scgruber.graphlambda;

import processing.core.*;

public class TokenString {
	private static PApplet parentApplet;
	
	private String val;
	private TokenString next;
	private TokenString child;
	
	/**
	 * Blank constructor
	 * @param parent
	 */
	public TokenString(PApplet parent) {
		this.parentApplet = parent;
		this.val = "";
	}
	
	/**
	 * Creates a TokenString chain given a string of lambda calculus
	 * @param parent
	 * @param lambdaString
	 * @throws TokenStringException
	 */
	public TokenString(PApplet parent, String lambdaString) throws TokenStringException {
		/* Initial values */
		this.parentApplet = parent;
		this.val = "";
		this.next = null;
		this.child = null;
		
	    if (lambdaString.length() == 0) {
	        throw new TokenStringException("Empty lambda string");
	    }
	    if (lambdaString.charAt(0) == '(') {
	        if (lambdaString.length() < 2) {
	        	throw new TokenStringException("Lambda string ends with '('");
	        }
	        if (lambdaString.charAt(1) == '\\') { // Lambda abstraction
	        	int i = 2;
	        	this.val = "";
	        	if (i >= lambdaString.length()) {
	        		throw new TokenStringException("Abstraction has no arguments");
	        	}
	        	while (lambdaString.charAt(i) != '.') {
	        		this.val += lambdaString.charAt(i);
	        		i++;
	        		if (i == lambdaString.length()) {
	        			throw new TokenStringException("Abstraction has no dot");
	        		}
	        	}
	        	int startIndex = ++i;
	        	int depth = 1;
	        	while (depth > 0) {
	        		if (i == lambdaString.length()) {
	        			throw new TokenStringException("Mismatched parentheses");
	        		}
	        		if (lambdaString.charAt(i) == '(') depth++;
	        		else if (lambdaString.charAt(i) == ')') depth--;
	        		i++;
	        	}
	        	int finishIndex = i;
	        	String childLambdaString = lambdaString.substring(startIndex, finishIndex-1);
	        	if (childLambdaString.length() > 0) {
	        		System.out.print("Parsing Child: ");
	        		System.out.println(childLambdaString);
	        		this.child = new TokenString(parent, childLambdaString);
	        	}
	        	String nextLambdaString = lambdaString.substring(finishIndex);
	        	if (nextLambdaString.length() > 0) {
	        		System.out.print("Parsing Next: ");
	        		System.out.println(nextLambdaString);
	        		this.next = new TokenString(parent, nextLambdaString);
	        	}
	        } else { // Group
	        	int startIndex = 1;
	        	int i = 1;
	        	int depth = 1;
	        	while (depth > 0) {
	        		if (i == lambdaString.length()) {
	        			throw new TokenStringException("Mismatched parentheses");
	        		}
	        		if (lambdaString.charAt(i) == '(') depth++;
	        		else if (lambdaString.charAt(i) == ')') depth--;
	        		i++;
	        	}
	        	int finishIndex = i;
	        	String childLambdaString = lambdaString.substring(startIndex, finishIndex-1);
	        	if (childLambdaString.length() > 0) {
	        		System.out.print("Parsing Child: ");
	        		System.out.println(childLambdaString);
	        		this.child = new TokenString(parent, childLambdaString);
	        	}
	        	String nextLambdaString = lambdaString.substring(finishIndex);
	        	if (nextLambdaString.length() > 0) {
	        		System.out.print("Parsing Next: ");
	        		System.out.println(nextLambdaString);
	        		this.next = new TokenString(parent, nextLambdaString);
	        	}
	        }
	    } else { // Normal token
	        this.val = "" + lambdaString.charAt(0);
	        String nextLambdaString = lambdaString.substring(1);
	        if (nextLambdaString.length() > 0) {
	        	System.out.print("Parsing Next: ");
	        	System.out.println(nextLambdaString);
	        	this.next = new TokenString(parent, nextLambdaString);
	        }
	    }
	}
	
	public String toString() {
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
	
	public static class TokenStringException extends Exception {
		public TokenStringException(String msg) {
			super(msg);
		}
	}

}