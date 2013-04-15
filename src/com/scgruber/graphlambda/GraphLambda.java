package com.scgruber.graphlambda;

import java.util.ArrayList;

import processing.core.*;

public class GraphLambda extends PApplet {

	/**
	 * Application variables
	 */
	PFont cantarell;
	ArrayList<Frame> frames;
	Frame active;
	Context uiContext;
	
	String[] demoStrings = {
		"(\\xy.x)"	
	};
	
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
		uiContext = Context.DRAWING;
		
		active = new Frame(this, "NONAME", demoStrings[0]);
	}
	
	/**
	 * Draw the frame
	 */
	public void draw() {
		background(255);
		strokeWeight(2);
		stroke(0);
		
		
		active.display(uiContext);
	}
	
	/* Interaction events */
	
	public void keyPressed() {
		switch (uiContext) {
		case TEXTFIELD:
			switch(key) {
			case CODED:
				switch(keyCode) {
				case LEFT:
					active.moveTextLeft();
					break;
				case RIGHT:
					active.moveTextRight();
					break;
				default:
					break;
				}
				break;
			case BACKSPACE:
			case DELETE:
				active.deleteChar();
				break;
			case RETURN:
			case ENTER:
				uiContext = Context.DRAWING;
				active.dirty();
				break;
			default:
				active.insertChar(key);
			}
			break;
		case DRAWING:
			switch(key) {
			case RETURN:
			case ENTER:
				uiContext = Context.TEXTFIELD;
				active.dirty();
				break;
			default:
				break;
			}
			break;
		case TOOLBAR:
			break;
		}
	}
	
	public void mouseClicked() {
		if (mouseY > 40) {
			uiContext = Context.DRAWING;
		} else {
			uiContext = Context.TEXTFIELD;
		}
		active.dirty();
	}
}
