package mycompany.towerdefense.nodes;

import ash.core.Node;
import mycompany.towerdefense.components.Collision;
import mycompany.towerdefense.components.Position;
import mycompany.towerdefense.components.Tower;

class TowerCollisionNode extends Node<TowerCollisionNode> 
{
	public var tower:Tower;
	public var position:Position;
	public var collision:Collision;
}