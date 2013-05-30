package mycompany.towerdefense.pathfinder;

/**
 * ...
 * @author christiannoelmascarinas
 */
interface INode {
	var f(get_f, set_f):Float;
	var g(get_g, set_g):Float;
	var h(get_h, set_h):Float;
	
	var row(get_row, set_row):Int;
	var col(get_col, set_col):Int;
	
	var parentNode(get_parentNode, set_parentNode):INode;
	
	var traversable(get_traversable, set_traversable):Bool;
	
	var x:Float;
	var y:Float;
}

