package mycompany.towerdefense.nodes;

import ash.core.Node;
import mycompany.towerdefense.components.Motion;
import mycompany.towerdefense.components.Position;

class MovementNode extends Node<MovementNode> 
{
	public var position:Position;
	public var motion:Motion;
}