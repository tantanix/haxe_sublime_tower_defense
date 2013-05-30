package mycompany.towerdefense.systems;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;
import mycompany.towerdefense.nodes.TileDisplayOrderNode;
import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;

class TileDisplayOrderSystem extends System
{
	@inject
	public var container:DisplayObjectContainer;
	
	private var _tileDisplayOrderNodes:NodeList<TileDisplayOrderNode>;

	public function new()
	{
		super();
	}

	override public function addToEngine(engine:Engine):Void
	{
		_tileDisplayOrderNodes = engine.getNodeList(TileDisplayOrderNode);
	}
	
	override public function update(time:Float):Void
	{
		_tileDisplayOrderNodes.insertionSort(sortByTileOrder);
		var s:String = "";
		for (node in _tileDisplayOrderNodes) {
			s += "[" + node.display.displayObject + "]" + ", ";
			container.addChild(cast(node.display.displayObject, DisplayObject));
		}
		//trace(s);
	}
	
	override public function removeFromEngine(engine:Engine):Void 
	{
		_tileDisplayOrderNodes = null;
	}

	function sortByTileOrder(node1:TileDisplayOrderNode, node2:TileDisplayOrderNode):Int {
		var node1XY:Int = node1.tile.currentTile.row * node1.tile.currentTile.col;
		var node2XY:Int = node2.tile.currentTile.row * node2.tile.currentTile.col;
		if (node1XY < node2XY)
			return -1;
		else if (node1XY > node2XY)
			return 1;
		else
			return 0;
	}
}