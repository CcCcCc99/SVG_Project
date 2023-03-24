using Godot;
using System;
using System.Collections.Generic;

/**
A random variable.
name (string) - name of the variable
domain (list) - a list of the values for the variable.
Variables are ordered according to their name.
*/
public class Variable
{
	private String name;
	private var domain = List<int>;
	private int size;
	//private Object position;
	
	/**
	Variable
	name a string
	domain a list of printable values
	position of form (x,y) 
	*/
	Variable(String name, List<int> domain) {
		this.name = name;   //# string
		this.domain = domain; //# list of values
		this.size = domain.Count;
	}
	/*	
	Variable(String name, List<int> domain, Object position) {
		this.name = name;   //# string
		this.domain = domain; //# list of values
		this.position = position; //if position else (random.random(), random.random())
		this.size = domain.Count;
	}*/

	void toString() {
		return this.name;
	}
	
	void __repr__() {
		return self.name; //# f"Variable({self.name})"
	}
}
