package com.scgruber.graphlambda;

import processing.core.*;

public class DrawingInstance {
	private static PApplet parent;
	private int heightOffset;
	private PGraphics buf;
	private String name;
	private boolean isDirty;
	
	/*
	 * Blank constructor
	 * @param parent
	 * @param width
	 * @param height
	 */
	public DrawingInstance(PApplet parent, int heightOffset) {
		this.parent = parent;
		this.heightOffset = heightOffset;
		this.buf = parent.createGraphics(parent.width, parent.height - heightOffset);
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
	public void display() {
		if (isDirty) {
			/* Update the drawing buffer */
			buf.beginDraw();
			
			buf.background(255);
			buf.stroke(100);
			
			buf.line(0, 0, 50, 50);
			System.out.println("Executed display draw for DrawingInstance");
			
			buf.endDraw();
			
			isDirty = false;
		}
		parent.image(buf, 0, heightOffset);
	}
}
