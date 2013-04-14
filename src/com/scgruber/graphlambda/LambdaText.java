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
	 * Methods for updating the text from user input
	 */
	public void insertChar(char c) {
		String ins = Character.toString(c);
		String prefix = text.substring(0, pos);
		String suffix = text.substring(pos);
		text = "".concat(prefix).concat(ins).concat(suffix);
		pos++;
		isDirty = true;
	}
	
	public void deleteChar() {
		if (pos == 0) {
			/* Delete the first character unless the string is empty */
			if (text.length() > 0) {
				text = text.substring(1);
			}
		} else if (pos == text.length()-1) {
			/* Delete the last character, pos becomes the new last character */
			text = text.substring(0, pos);
			pos--;
		} else {
			/* Delete at pos, pos becomes the character to the right */
			text = text.substring(0, pos) + text.substring(pos+1);
		}
		isDirty = true;
	}
	
	public void moveLeft() {
		if (pos != 0) {
			pos--;
			isDirty = true;
		}
	}
	
	public void moveRight() {
		if (pos != text.length()) {
			pos++;
			isDirty = true;
		}
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
			String drawnText = text + " ";
			drawnText = drawnText.substring(0, pos+1) + "\u0332" + drawnText.substring(pos+1);
			
			buf.text(drawnText, 10, 30);
		
			buf.endDraw();
			
			isDirty = false;
		}
		/* Finally draw the buffer to the screen */
		parent.image(buf, 0, 0);
	}
}
