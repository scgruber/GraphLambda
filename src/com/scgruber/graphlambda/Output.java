package com.scgruber.graphlambda;

import java.util.ArrayList;

import processing.core.PVector;

public class Output extends Node {

	public Output(Node output) {
		this.pos = new PVector(0,0);
		this.in = new ArrayList();
		this.out = new ArrayList();
		this.movable = false;
		out.add(output);
	}
}
