package mycompany.towerdefense.systems;

import ash.core.Engine;
import ash.core.System;
import ash.core.NodeList;
import mycompany.towerdefense.components.Vector2;
import mycompany.towerdefense.enums.TileDirection;
import mycompany.towerdefense.views.ITileView;
import starling.display.DisplayObjectContainer;
import starling.display.DisplayObject;
import mycompany.towerdefense.components.Position;
import mycompany.towerdefense.nodes.TileRenderNode;

/**
 * ...
 * @author christiannoelmascarinas
 */
class TileRenderSystem extends System {
	@inject
	public var container:DisplayObjectContainer;
	
	private var _renderNodes:NodeList<TileRenderNode>;
	
	public function new() {
		super();
	}
	
	override public function addToEngine(engine:Engine):Void {
		_renderNodes = engine.getNodeList(TileRenderNode);
		for (node in _renderNodes) {
			addToDisplay(node);
		}
		_renderNodes.nodeAdded.add(addToDisplay);
		_renderNodes.nodeRemoved.add(removeFromDisplay);
	}
	
	private function addToDisplay(node:TileRenderNode):Void {
		container.addChild(cast(node.display.displayObject, DisplayObject));
	}
	
	private function removeFromDisplay(node:TileRenderNode):Void {
		container.removeChild(cast(node.display.displayObject, DisplayObject));
	}
	
	override public function update(time:Float):Void {
		for (node in _renderNodes) {
			var displayObject:ITileView = node.display.displayObject;
			var position:Position = node.position;
			var direction:Vector2 = node.direction;
			
			cast(displayObject, DisplayObject).x = position.position.x;
			cast(displayObject, DisplayObject).y = position.position.y;
		}
	}
	
	override public function removeFromEngine(engine:Engine):Void {
		_renderNodes = null;
		container = null;
	}
}
