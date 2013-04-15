package com.scgruber.graphlambda;

import java.util.ArrayList;

import processing.core.PGraphics;
import processing.core.PVector;

public class Merge extends Node {

	
	public Merge(Node fn, Node arg, Node res) {
		this.pos = new PVector(0,0);
		this.in = new ArrayList();
		in.add(fn);
		in.add(arg);
		this.out = new ArrayList();
		out.add(res);
		this.movable = true;
	}
	
	public void display(PGraphics buf) {
		buf.fill(255);
		buf.stroke(0);
		
		/* Invariant: in.size() == 2; out.size() == 1 */
		PVector toFn = PVector.sub(in.get(0).getPos(), pos);
		PVector toArg = PVector.sub(in.get(1).getPos(), pos);
		PVector toRes = PVector.sub(out.get(0).getPos(), pos);

		buf.line(pos.x, pos.y, pos.x+toFn.x, pos.y+toFn.y);
		buf.line(pos.x, pos.y, pos.x+toArg.x, pos.y+toArg.y);
		buf.line(pos.x, pos.y, pos.x+toRes.x, pos.y+toRes.y);
		
		toFn.normalize();
		toArg.normalize();
		toRes.normalize();
		buf.triangle((5*toFn.x) + pos.x, (5*toFn.y) + pos.y,
				(5*toArg.x) + pos.x, (5*toArg.y) + pos.y,
				(5*toRes.x) + pos.x, (5*toRes.y) + pos.y);  
	}
}
