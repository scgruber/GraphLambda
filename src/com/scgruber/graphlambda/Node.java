package com.scgruber.graphlambda;

import java.util.ArrayList;
import processing.core.*;

public class Node {
	protected PVector pos;
	protected ArrayList<Node> in;
	protected ArrayList<Node> out;
	protected boolean movable;
	
	public Node() {
		this.pos = new PVector(0,0);
		this.in = new ArrayList();
		this.out = new ArrayList();
		this.movable = false;
	}
	
	public void display(PGraphics buf) {
		buf.fill(0);
		buf.stroke(0);
		
		buf.ellipse(pos.x, pos.y, 5.0f, 5.0f);
	}

	/* Getters and setters */
	public void setPos(PVector inPos) {
		pos = inPos.get();
	}
	
	public PVector getPos() {
		return pos.get();
	}
	
	public boolean getMovable() {
		return movable;
	}
}
