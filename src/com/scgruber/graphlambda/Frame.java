package com.scgruber.graphlambda;

import com.scgruber.graphlambda.TokenString.TokenStringException;

import processing.core.*;

public class Frame {

	private String name;
	private TokenString tokens;
	private LambdaText text;
	private DrawingInstance drawing;
	
	public Frame(PApplet parent, String name, String lambda) {
		this.name = name;
		try {
			this.tokens = new TokenString(lambda);
		} catch (TokenString.TokenStringException e) {
			this.tokens = null;
		}
		this.text = new LambdaText(parent, this, lambda, 40);
		this.drawing = new DrawingInstance(parent, this, 40);
		
	}
	
	public void dirty() {
		text.dirty();
		drawing.dirty();
	}
	
	public void display(Context c) {
		text.display(c == Context.TEXTFIELD);
		drawing.display(c == Context.DRAWING);
	}
	
	public void generateTokenString(String lambda) {
		try {
			tokens = new TokenString(lambda);
			text.setValid();
			Group grp = new Group(null, null);
			tokens.produceDrawing(grp);
			drawing.setDrawing(grp);
			drawing.dirty();
		} catch (TokenStringException e) {
			text.setInvalid();
		}
	}
	
	/* Interaction passing methods */
	
	public void insertChar(char c) {
		text.insertChar(c);
	}

	public void deleteChar() {
		text.deleteChar();
	}

	public void moveTextLeft() {
		text.moveLeft();
	}
	
	public void moveTextRight() {
		text.moveRight();
	}
}
