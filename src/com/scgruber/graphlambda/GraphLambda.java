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
		background(255);
		strokeWeight(2);
		
		cantarell = loadFont("Cantarell-Bold-48.vlw");
		textFont(cantarell, 32);
	}

}
