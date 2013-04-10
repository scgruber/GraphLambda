package com.scgruber.graphlambda;

import processing.core.*;

public class DrawingInstance {
	private static PApplet parent;
	private PGraphics buf;
	private String name;
	
	/*
	 * Blank constructor
	 * @param parent
	 * @param width
	 * @param height
	 */
	public DrawingInstance(PApplet parent, int width, int height) {
		this.parent = parent;
		this.buf = parent.createGraphics(width, height);
		this.name = "";
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
}
