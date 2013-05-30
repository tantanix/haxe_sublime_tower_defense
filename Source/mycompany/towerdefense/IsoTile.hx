package mycompany.towerdefense;

import flash.display.Sprite;
import flash.geom.Point;
import flash.display.Shape;
import flash.display.BitmapData;
import mycompany.towerdefense.IsoMap;
import mycompany.towerdefense.pathfinder.INode;
/**
 * ...
 * @author christiannoelmascarinas
 */
import starling.display.Sprite;

class IsoTile extends Sprite, implements INode {
	
	inline private static var W: Int = 15;
	inline private static var H:Int = 15;
	
	//Our interface variables since we inherit from MovieClip x and y are already set
	private var _parentNode:INode;		
	private var _f:Float;
	private var _g:Float;
	private var _h:Float;
	private var _x:Float;
	private var _y:Float;
	private var _row:Int;
	private var _col:Int;
	private var _traversable:Bool;
	private var _isoMap:IsoMap;
	
	//
	// The row number of this node.
	//
	public var row(get_row, set_row):Int;
	function get_row():Int {
		return _row;
	}
	function set_row(value:Int):Int {
		return _row = value;
	}
	
	//
	// The column number of this node.
	//
	public var col(get_col, set_col):Int;
	function get_col():Int {
		return _col;
	}
	function set_col(value:Int):Int {
		return _col = value;
	}
	
	//
	// The total cost of the specific node (g + h)
	//
	public var f(get_f, set_f):Float;
	function get_f():Float {
		return _f;
	}
	function set_f(value:Float):Float {
		return _f = value;
	}
	
	//
	// The cost to get to this node from the starting node
	//
	public var g(get_g, set_g):Float;
	function get_g():Float {
		return _g;
	}
	function set_g(value:Float):Float {
		return _g = value;
	}
	
	//
	// The cost to get from this node to the final node.
	//
	public var h(get_h, set_h):Float;
	function get_h():Float {
		return _h;
	}
	function set_h(value:Float):Float {
		return _h = value;
	}
	
	//
	// The parent node of the path finder
	//
	public var parentNode(get_parentNode, set_parentNode):INode;
	function get_parentNode():INode {
		return _parentNode;
	}
	function set_parentNode(value:INode):INode {
		return _parentNode = value;
	}
	
	//
	// Traversable
	//
	public var traversable(get_traversable, set_traversable):Bool;
	function get_traversable():Bool {
		return _traversable;
	}
	function set_traversable(value:Bool):Bool {
		return _traversable = value;
	}
	
	public function new(map:IsoMap) 
	{
		super();
		init(map);
	}
	
	private function init(map:IsoMap):Void {
		_isoMap = map;
		_traversable = true;

		this.graphics.clear();
		this.graphics.beginFill(0xFF0000, 0.2);
		this.graphics.lineStyle(1, 0x000000);
		this.graphics.moveTo(0, -(_isoMap.tileHeight / 2));
		this.graphics.lineTo(_isoMap.tileWidth / 2, 0);
		this.graphics.lineTo(0, _isoMap.tileHeight / 2);
		this.graphics.lineTo(-(_isoMap.tileWidth / 2), 0);
		this.graphics.lineTo(0, -(_isoMap.tileHeight / 2));
		this.graphics.endFill();
	}
	
	public function reset():Void {
		_parentNode = null;
		_f = 0;
		_g = 0;
		_h = 0;
	}
	
	public override function toString():String {
		return "IsoTile {row=" + _row + ", col=" + _col + "}\n";
	}
}

