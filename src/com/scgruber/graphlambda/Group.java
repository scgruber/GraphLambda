package com.scgruber.graphlambda;

import java.util.ArrayList;
import processing.core.*;

public class Group {
	private Group parent;
	private PVector pos;
	private float radius;
	private ArrayList<Input> inputs;
	private ArrayList<Node> interior;
	private ArrayList<Group> groups;
	private Output output;
	private boolean isDirty;
	
	public Group(Group parent, Node output) {
		this.parent = parent;
		this.pos = new PVector(0,0);
		this.radius = 10.0f;
		this.inputs = new ArrayList();
		this.interior = new ArrayList();
		this.groups = new ArrayList();
		this.output = new Output(output);
		this.isDirty = false;
	}
	
	/* Public methods */
	
	public void display(PGraphics buf) {
		if (isDirty) {
			/* Update all properties that could have changed */
			radius = calculateBestRadius();
		}
		
		buf.stroke(0);
		buf.strokeWeight(2);
		
		buf.ellipse(pos.x, pos.y, 2*radius, 2*radius);
	}
	
	public void addInput(Input inInput) {
		inputs.add(inInput);
		isDirty = true;
	}
	
	public void addInteriorNode(Node inNode) {
		interior.add(inNode);
		isDirty = true;
	}
	
	public void addGroup(Group grp) {
		groups.add(grp);
	}
	
	public Merge addMerge(Node fn, Node arg, Node out) {
		Merge m = new Merge(fn, arg, out);
		interior.add(m);
		return m;
	}
	
	/* Getters and setters */
	
	public float getRadius() {
		return radius;
	}
	
	public Group getParent() {
		return parent;
	}
	
	public Input getInput(char arg) {
		for (int i=inputs.size()-1; i >= 0; i--) {
			if (inputs.get(i).getArg() == arg) {
				return inputs.get(i);
			}
		}
		return null;
	}
	
	public Output getOutput() {
		return output;
	}
	
	/* Private methods */
	
	private float calculateBestRadius() {
		float defaultRadius = 10.0f;
		
		float totalInputDiams = 0.0f;
		for (int i = inputs.size(); i >= 0; i--) {
			totalInputDiams += inputs.get(i).getRadius();
		}
		/* The total size of the inputs cannot be more than PI * radius */
		float radiusByInputs = totalInputDiams/((float) Math.PI);
		
		
		return Math.max(defaultRadius, radiusByInputs);
	}
}
