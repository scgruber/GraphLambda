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
		this.radius = 25.0f;
		this.inputs = new ArrayList();
		this.interior = new ArrayList();
		this.groups = new ArrayList();
		this.output = new Output(output);
		this.isDirty = true;
	}
	
	/* Public methods */
	
	public void display(PGraphics buf) {
		if (isDirty) {
			/* Update all properties that could have changed */
			radius = calculateBestRadius();
			distributeInputs();
			output.setPos(new PVector(pos.x, pos.y+radius));
			for (int i = interior.size()-1; i >= 0; i--) {
				if (PVector.dist(pos, interior.get(i).getPos()) > radius) {
					interior.get(i).setPos(pos.get());
				}
			}
			for (int i = groups.size()-1; i >= 0; i--) {
				if (PVector.dist(pos, groups.get(i).getPos()) > radius) {
					groups.get(i).setPos(pos.get());
					groups.get(i).dirty();
				}
			}
		}
		
		buf.fill(255);
		buf.stroke(0);
		buf.strokeWeight(2);
		
		buf.ellipse(pos.x, pos.y, 2*radius, 2*radius);
		
		for (int i = interior.size()-1; i >= 0; i--) {
			interior.get(i).display(buf);
		}
		for (int i = inputs.size()-1; i >= 0; i--) {
			inputs.get(i).display(buf);
		}
		for (int i = groups.size()-1; i >= 0; i--) {
			groups.get(i).display(buf);
		}
		output.display(buf);
	}
	
	public void dirty() {
		isDirty = true;
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
	
	public PVector getPos() {
		return pos.get();
	}
	
	public void setPos(PVector pos) {
		this.pos = pos.get();
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
		
		/* Search upwards */
		if (parent == null) {
			return null;
		} else {
			return parent.getInput(arg);
		}
	}
	
	public Output getOutput() {
		return output;
	}
	
	/* Private methods */
	
	private float calculateBestRadius() {
		float defaultRadius = 10.0f;
		
		float totalInputDiams = (inputs.size() == 1) ? 15.0f : 5.0f;
		for (int i = inputs.size()-1; i >= 0; i--) {
			totalInputDiams += (2*inputs.get(i).getRadius());
		}
		/* The total size of the inputs cannot be more than (PI/2) * radius */
		float radiusByInputs = totalInputDiams/((float) Math.PI/2);
		
		float groupArea = 1000.0f;
		for (int i = groups.size()-1; i >= 0; i--) {
			groupArea += Math.pow(groups.get(i).getRadius(), 2);
		}
		float radiusbyGroups = (float) Math.sqrt(groupArea);
		
		return Math.max(defaultRadius, Math.max(radiusByInputs, radiusbyGroups));
	}
	
	private void distributeInputs() {
		float totalInputDiams = 0.0f;
		for (int i = inputs.size()-1; i >= 0; i--) {
			totalInputDiams += (2*inputs.get(i).getRadius());
		}
		
		float angularPos = 0.0f;
		for (int i = inputs.size()-1; i >= 0; i--) {
			angularPos += (inputs.get(i).getRadius()/totalInputDiams) * Math.PI;
			inputs.get(i).setPos(new PVector(pos.x+((float)Math.cos(angularPos)*radius), 
					pos.y+((float)-Math.sin(angularPos)*radius)));
			angularPos += (inputs.get(i).getRadius()/totalInputDiams) * Math.PI;
		}
	}
}
