package com.scgruber.graphlambda;

import processing.core.*;

public class LambdaText {
	private static PApplet parent;
	private String text;
	private int pos;
	private boolean isDirty;
	private PGraphics buf;
	
	/*
	 * Blank constructor
	 * @param parent
	 * @param height
	 */
	public LambdaText(PApplet parent, int height) {
		this.parent = parent;
		this.text = "";
		this.pos = 0;
		this.isDirty = false;
		this.buf = parent.createGraphics(parent.width, height);
		
		/* Preload the buffer */
		buf.beginDraw();
		buf.background(100);
		buf.endDraw();
	}
	
	/*
	 * Creates a LambdaText with an initial string value
	 * @param parent 
	 * @param text
	 * @param height
	 */
	public LambdaText(PApplet parent, String text, int height) {
		this.parent = parent;
		this.text = text;
		this.pos = 0;
		this.isDirty = true;
		this.buf = parent.createGraphics(parent.width, height);
		
		/* Preload the buffer */
		buf.beginDraw();
		buf.background(100);
		buf.endDraw();
	}
	
	/*
	 * Updates the text by inserting a character at pos
	 */
	public void insertChar(char c) {
		String ins = Character.toString(c);
		String prefix = text.substring(0, pos);
		String suffix = text.substring(pos);
		this.text = "".concat(prefix).concat(ins).concat(suffix);
		pos++;
		this.isDirty = true;
	}
	
	/*
	 * Redraws to the draw buffer if the text is dirty
	 * Then draws the buffer on the screen
	 */
	public void display() {
		if (isDirty) {
			/* We need to recreate the draw buffer */
			buf.beginDraw();
		
			buf.textSize(24);
			buf.background(100);
			
			/* Splice in the position marker to the text */
			String drawnText = text.substring(0, pos+1) + "\u0332" + text.substring(pos+1);
			
			buf.text(drawnText, 10, 30);
		
			buf.endDraw();
			
			isDirty = false;
		}
		/* Finally draw the buffer to the screen */
		parent.image(buf, 0, 0);
	}
}
