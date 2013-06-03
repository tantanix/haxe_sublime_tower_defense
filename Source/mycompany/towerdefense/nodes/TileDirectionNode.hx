package mycompany.towerdefense.nodes;

import ash.core.Node;
import mycompany.towerdefense.components.FsmController;
import mycompany.towerdefense.components.Vector2;

class TileDirectionNode extends Node<TileDirectionNode> 
{
	public var fsm:FsmController;
	public var direction:Vector2;
}