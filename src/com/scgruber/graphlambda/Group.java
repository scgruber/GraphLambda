package com.scgruber.graphlambda;

import java.util.ArrayList;
import processing.core.*;

public class Group {
	private PVector pos;
	private float radius;
	private ArrayList<Group> inputs;
	private ArrayList<Node> interior;
	private boolean isDirty;
	
	public Group() {
		this.pos = new PVector(0,0);
		this.radius = 10.0f;
		this.inputs = new ArrayList();
		this.interior = new ArrayList();
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
	
	public void addInput(Group inInput) {
		inputs.add(inInput);
		isDirty = true;
	}
	
	public void addInteriorNode(Node inNode) {
		interior.add(inNode);
		isDirty = true;
	}
	
	/* Getters and setters */
	
	public float getRadius() {
		return radius;
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
