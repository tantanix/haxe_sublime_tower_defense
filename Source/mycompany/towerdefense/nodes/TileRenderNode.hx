package mycompany.towerdefense.nodes;

import ash.core.Node;
import mycompany.towerdefense.components.Position;
import mycompany.towerdefense.components.TileDisplay;
import mycompany.towerdefense.components.Vector2;

class TileRenderNode extends Node<TileRenderNode>
{
	public var position:Position;
	public var display:TileDisplay;
	public var direction:Vector2;
}