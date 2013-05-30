package mycompany.towerdefense.components;
import mycompany.towerdefense.pathfinder.INode;
/**
 * ...
 * @author christiannoelmascarinas
 */
class Tile {
	public var pathNodes:Array<INode>;
	public var currentTile:INode;
	
	public function new (currentTile:INode, ?pathNodes:Array<INode> = null) {
		this.currentTile = currentTile;
		this.pathNodes = pathNodes;
	}		
}
