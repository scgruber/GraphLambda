package com.scgruber.graphlambda;

import processing.core.*;

public class Group {
	private PVector pos;
	private float radius;
	
	public Group() {
		this.pos = new PVector(0,0);
		this.radius = 10.0f;
	}
	
	public void display(PGraphics buf) {
		buf.stroke(0);
		buf.strokeWeight(2);
		
		buf.ellipse(pos.x, pos.y, 2*radius, 2*radius);
	}
}
