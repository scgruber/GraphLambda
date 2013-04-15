package com.scgruber.graphlambda;

import processing.core.*;

public class DrawingInstance {
	private static PApplet parentApplet;
	private int heightOffset;
	private PGraphics buf;
	private Group drawing;
	private String name;
	private boolean isDirty;
	
	/*
	 * Blank constructor
	 * @param parent
	 * @param width
	 * @param height
	 */
	public DrawingInstance(PApplet parent, int heightOffset) {
		this.parentApplet = parent;
		this.heightOffset = heightOffset;
		this.buf = parent.createGraphics(parent.width, parent.height - heightOffset);
		this.drawing = new Group(null, null);
		this.name = "";
		this.isDirty = true;
		
		/* Preload the buffer */
		buf.beginDraw();
		buf.background(100);
		buf.endDraw();
	}
	
	/*
	 * Name getter and setter
	 */
	public void setName(String name) {
		this.name = name;
	}
	
	public String getName() {
		return this.name;
	}
	
	/*
	 * Update drawing buffer if necessary
	 * Display the drawing
	 */
	public void display(boolean hasFocus) {
		if (isDirty) {
			/* Update the drawing buffer */
			buf.beginDraw();
			
			buf.background(255);
			buf.stroke(100);
			
			buf.translate(buf.width/2, buf.height/2);
			
			drawing.display(buf);
			
			buf.endDraw();
			
			isDirty = false;
		}
		parentApplet.image(buf, 0, heightOffset);
	}
	
	public void dirty() {
		isDirty = true;
	}
}
