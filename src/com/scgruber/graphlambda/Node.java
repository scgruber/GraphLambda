package com.scgruber.graphlambda;

import processing.core.*;

public class Node {
	private PVector pos;
	
	public Node() {
		this.pos = new PVector(0,0);
	}
	
	public void display(PGraphics buf) {
		buf.fill(0);
		buf.stroke(0);
		
		buf.ellipse(pos.x, pos.y, 5.0f, 5.0f);
	}
}
