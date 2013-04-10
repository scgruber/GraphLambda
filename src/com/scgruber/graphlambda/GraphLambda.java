package com.scgruber.graphlambda;

import processing.core.*;

public class GraphLambda extends PApplet {

	/**
	 * Application variables
	 */
	PFont cantarell;
	TokenString ts;
	LambdaText text;
	
	String[] demoStrings = {
		"\\xy.x"	
	};
	int textHeight;
	
	/**
	 * Calls the main processing presentation runtime
	 * @param args
	 */
	public static void main(String[] args) {
		PApplet.main(new String[] { "--present", "com.scgruber.graphlambda.GraphLambda" });

	}
	
	/**
	 * Sets up the drawing context
	 */
	public void setup() {
		size(800,600);
		
		cantarell = loadFont("Cantarell-Bold-48.vlw");
		textFont(cantarell, 32);
		textHeight = 40;
		
		try {
			ts = new TokenString(this, demoStrings[0]);
			text = new LambdaText(this, ts.toString(), textHeight);
		} catch(TokenString.TokenStringException e) {
			System.exit(1);
		}
	}
	
	/**
	 * Draw the frame
	 */
	public void draw() {
		background(255);
		strokeWeight(2);
		stroke(0);
		
		text.display();
	}

}
