package mycompany.towerdefense.nodes;

import ash.core.Node;
import mycompany.towerdefense.components.Collision;
import mycompany.towerdefense.components.Monster;
import mycompany.towerdefense.components.Position;
import mycompany.towerdefense.components.Tile;

class MonsterCollisionNode extends Node<MonsterCollisionNode> 
{
	public var monster:Monster;
	public var position:Position;
	public var tile:Tile;
	public var collision:Collision;
}