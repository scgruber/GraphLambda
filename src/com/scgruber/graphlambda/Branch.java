package com.scgruber.graphlambda;

import java.util.ArrayList;

import processing.core.*;

public class Branch extends Node{
	
	public Branch(Node origin, Node left, Node right) {
		this.pos = new PVector(0,0);
		this.in = new ArrayList();
		in.add(origin);
		this.out = new ArrayList();
		out.add(left);
		out.add(right);
		this.movable = true;
	}
	
	public void display(PGraphics buf) {
		buf.fill(0);
		buf.stroke(0);
		
		/* Invariant: in.size() == 1; out.size() == 2 */
		PVector toOrigin = PVector.sub(in.get(0).getPos(), pos);
		PVector toLeft = PVector.sub(out.get(0).getPos(), pos);
		PVector toRight = PVector.sub(out.get(1).getPos(), pos);

		buf.line(pos.x, pos.y, pos.x+toOrigin.x, pos.y+toOrigin.y);
		buf.line(pos.x, pos.y, pos.x+toLeft.x, pos.y+toLeft.y);
		buf.line(pos.x, pos.y, pos.x+toRight.x, pos.y+toRight.y);
		
		toOrigin.normalize();
		toLeft.normalize();
		toRight.normalize();
		buf.triangle((5*toOrigin.x) + pos.x, (5*toOrigin.y) + pos.y,
				(5*toLeft.x) + pos.x, (5*toLeft.y) + pos.y,
				(5*toRight.x) + pos.x, (5*toRight.y) + pos.y);  
	}
}
