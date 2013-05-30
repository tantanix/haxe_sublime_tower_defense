package mycompany.towerdefense.systems;

import ash.core.Engine;
import ash.core.System;
import ash.core.NodeList;
import starling.display.DisplayObjectContainer;
import starling.display.DisplayObject;
import mycompany.towerdefense.components.Position;
import mycompany.towerdefense.nodes.RenderNode;

/**
 * ...
 * @author christiannoelmascarinas
 */
class RenderSystem extends System {
	@inject
	public var container:DisplayObjectContainer;
	
	private var _renderNodes:NodeList<RenderNode>;
	
	public function new() {
		super();
	}
	
	override public function addToEngine(engine:Engine):Void {
		_renderNodes = engine.getNodeList(RenderNode);
		for (node in _renderNodes) {
			addToDisplay(node);
		}
		_renderNodes.nodeAdded.add(addToDisplay);
		_renderNodes.nodeRemoved.add(removeFromDisplay);
	}
	
	private function addToDisplay(node:RenderNode):Void {
		container.addChild(node.display.displayObject);
	}
	
	private function removeFromDisplay(node:RenderNode):Void {
		container.removeChild(node.display.displayObject);
	}
	
	override public function update(time:Float):Void {
		for (node in _renderNodes) {
			var displayObject:DisplayObject = node.display.displayObject;
			var position:Position = node.position;
			
			displayObject.x = position.position.x;
			displayObject.y = position.position.y;
			displayObject.rotation = position.rotation * 180 / Math.PI;
		}
	}
	
	override public function removeFromEngine(engine:Engine):Void {
		_renderNodes = null;
	}
}
