package com.scgruber.graphlambda;

import java.util.ArrayList;
import processing.core.*;

public class Input extends Node {
	private Group appliedGroup;
	private float radius;
	private char arg;
	
	public Input(char arg) {
		this.pos = new PVector(0,0);
		this.in = new ArrayList();
		this.out = new ArrayList();
		this.movable = false;
		this.appliedGroup = null;
		this.radius = 10.0f;
		this.arg = arg;
	}
	
	/* Getters and setters */
	public void setGroup(Group grp) {
		appliedGroup = grp;
		grp.setPos(pos);
		radius = grp.getRadius() + 5.0f;
	}
	
	public void setPos(PVector pos) {
		this.pos = pos.get();
		if (appliedGroup != null) {
			appliedGroup.setPos(pos);
		}
	}
	
	public float getRadius() {
		return radius;
	}
	
	public char getArg() {
		return arg;
	}
	
	public void display(PGraphics buf) {
		buf.fill(255);
		buf.stroke(0);
		buf.strokeWeight(2);
		
		buf.ellipse(pos.x, pos.y, 2*radius, 2*radius);
		
		if (appliedGroup != null) {
			appliedGroup.display(buf);
		}
	}
}
