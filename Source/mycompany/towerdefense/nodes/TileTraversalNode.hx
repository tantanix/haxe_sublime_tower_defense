package mycompany.towerdefense.nodes;

import ash.core.Node;
import mycompany.towerdefense.components.Tile;
import mycompany.towerdefense.components.Position;
import mycompany.towerdefense.components.TileDisplay;
import mycompany.towerdefense.components.Vector2;
/**
 * ...
 * @author christiannoelmascarinas
 */
class TileTraversalNode extends Node<TileTraversalNode> {
	public var tile:Tile;
	public var position:Position;
	public var direction:Vector2;
}
