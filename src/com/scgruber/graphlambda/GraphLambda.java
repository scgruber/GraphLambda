package com.scgruber.graphlambda;

import processing.core.*;

public class GraphLambda extends PApplet {

	/**
	 * Application variables
	 */
	PFont cantarell;
	LambdaText activeText;
	DrawingInstance activeDrawing;
	Context uiContext;
	
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
		uiContext = Context.DRAWING;
		
		activeText = new LambdaText(this, demoStrings[0], textHeight);
		activeDrawing = new DrawingInstance(this, textHeight);
	}
	
	/**
	 * Draw the frame
	 */
	public void draw() {
		background(255);
		strokeWeight(2);
		stroke(0);
		
		
		activeText.display(uiContext == Context.TEXTFIELD);
		activeDrawing.display(uiContext == Context.DRAWING);
	}
	
	/* Interaction events */
	
	public void keyPressed() {
		switch (uiContext) {
		case TEXTFIELD:
			switch(key) {
			case CODED:
				switch(keyCode) {
				case LEFT:
					activeText.moveLeft();
					break;
				case RIGHT:
					activeText.moveRight();
					break;
				default:
					break;
				}
				break;
			case BACKSPACE:
			case DELETE:
				activeText.deleteChar();
				break;
			case RETURN:
			case ENTER:
				uiContext = Context.DRAWING;
				activeText.dirty();
				activeDrawing.dirty();
				break;
			default:
				activeText.insertChar(key);
			}
			break;
		case DRAWING:
			switch(key) {
			case RETURN:
			case ENTER:
				uiContext = Context.TEXTFIELD;
				activeText.dirty();
				activeDrawing.dirty();
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
		if (mouseY > textHeight) {
			uiContext = Context.DRAWING;
		} else {
			uiContext = Context.TEXTFIELD;
		}
		activeText.dirty();
		activeDrawing.dirty();
	}
	
	/*
	 * Enumerated possible contexts for user interaction
	 */
	private enum Context {
		TEXTFIELD, DRAWING, TOOLBAR
	}

}
