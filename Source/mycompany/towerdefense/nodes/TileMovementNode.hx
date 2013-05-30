package mycompany.towerdefense.nodes;

import ash.core.Node;
import mycompany.towerdefense.components.Position;
import mycompany.towerdefense.components.Motion;
import mycompany.towerdefense.components.Vector2;
/**
 * ...
 * @author christiannoelmascarinas
 */
class TileMovementNode extends Node<TileMovementNode> {
	public var position:Position;
	public var motion:Motion;
	public var direction:Vector2;
}
