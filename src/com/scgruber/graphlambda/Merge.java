package com.scgruber.graphlambda;

import java.util.ArrayList;

import processing.core.PGraphics;
import processing.core.PVector;

public class Merge extends Node {

	
	public Merge(Node fn, Node arg, Node res) {
		this.pos = new PVector(0,0);
		this.in = new ArrayList();
		in.add(fn);
		if (arg != null) in.add(arg);
		this.out = new ArrayList();
		out.add(res);
		this.movable = true;
	}
	
	public void display(PGraphics buf) {
		buf.fill(255);
		buf.stroke(0);
		
		/* Reposition to dead center between in and out */
		pos = PVector.lerp(in.get(0).getPos(), out.get(0).getPos(), 0.5f);
		
		for (int i = in.size()-1; i >= 0; i--) {
			PVector to = in.get(i).getPos();
			buf.line(pos.x, pos.y, to.x, to.y);
		}
		for (int i = out.size()-1; i >= 0; i--) {
			PVector to = out.get(i).getPos();
			buf.line(pos.x, pos.y, to.x, to.y);
		} 
	}
}
