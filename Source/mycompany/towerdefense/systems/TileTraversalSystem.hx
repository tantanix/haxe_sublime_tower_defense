package mycompany.towerdefense.systems;

import ash.core.Engine;
import ash.tools.ListIteratingSystem;
import mycompany.towerdefense.nodes.TileTraversalNode;
import mycompany.towerdefense.components.Position;
import mycompany.towerdefense.pathfinder.SearchHelper;
import mycompany.towerdefense.pathfinder.INode;
import mycompany.towerdefense.IsoMap;
import mycompany.towerdefense.EntityCreator;
import mycompany.towerdefense.enums.TileDirection;
import flash.geom.Point;

/**
 * ...
 * @author christiannoelmascarinas
 */
class TileTraversalSystem extends ListIteratingSystem<TileTraversalNode> {
	
	@inject
	public var creator:EntityCreator;
	
	@inject
	public var map:IsoMap;
	
	@inject("startTile")
	public var startTile:INode;
	
	@inject("goalTile")
	public var goalTile:INode;
	
	public function new () {
		super(TileTraversalNode, updateNode);
	}		

	private function updateNode(node:TileTraversalNode, time:Float):Void {
		if (node.tile.pathNodes != null) {
			node.tile.currentTile.traversable = true; // Set the previous tile back to traversable
			node.tile.currentTile = map.getHitTile(node.position.position);
			node.tile.currentTile.traversable = false; // Set the same/new tile not traversable since it is stepping on it
			
			if (Point.distance(node.position.position, new Point(node.tile.currentTile.x, node.tile.currentTile.y)) < 0.5) {
				//trace("Stepped tile: " + node.tile.currentTile.row + ", " + node.tile.currentTile.col);
					
				if (node.tile.currentTile == goalTile) {
					// We have reached our goal tile...hurray!
					creator.destroyEntity(node.entity);
					return;
				}

				var targetTile:INode = getTargetTile(node);
				if (targetTile != null) {
		
					// Calculate direction
					node.direction.x = (targetTile.x - node.tile.currentTile.x);
					node.direction.y = (targetTile.y - node.tile.currentTile.y);
				}
			} else {

			}
			
		}
	}
	
	private function getTargetTile(node:TileTraversalNode):INode {
		var currentTile:INode = node.tile.currentTile;
		var position:Position = node.position;
		var pathNodes:Array<INode> = node.tile.pathNodes;
		
		var isNextTile:Bool = false;
		var targetTile:INode = null;
		if (pathNodes != null) {
			var pathTile;
			var nextTile;
			for (i in 0...pathNodes.length) {
				pathTile = pathNodes[i];
				
				if (pathTile.row == currentTile.row && pathTile.col == currentTile.col) {
					
					nextTile = pathNodes[i + 1];
					
					// There is no more next tile
					if (nextTile == null)
						break;

					// If the next tile is traversable, make sure to get new path nodes only when it's close to the center of the tile.
					if (!nextTile.traversable && Point.distance(new Point(pathTile.x, pathTile.y), node.position.position) < 5) {
						node.tile.pathNodes = SearchHelper.findPath(currentTile, goalTile, map.findConnectedTiles);
						return getTargetTile(node);
					}

					return nextTile;
				}
			}
		}
		return null;
	}

	override public function removeFromEngine(engine:Engine):Void
	{
		creator = null;
		map = null;
		startTile = null;
		goalTile = null;
	}
}
