package com.scgruber.graphlambda;

import processing.core.*;

public class GraphLambda extends PApplet {

	/**
	 * Application variables
	 */
	PFont cantarell;
	
	/**
	 * @param args
	 * Calls the Processing presentation runtime
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
	}
	
	/**
	 * Draw the frame
	 */
	public void draw() {
		background(255);
		strokeWeight(2);
		stroke(0);
	}

}
