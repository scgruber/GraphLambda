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
		this.radius = 0.0f;
		this.arg = arg;
	}
	
	/* Getters and setters */
	public void setGroup(Group grp) {
		this.appliedGroup = grp;
	}
	
	public float getRadius() {
		return radius;
	}
	
	public char getArg() {
		return arg;
	}
}
