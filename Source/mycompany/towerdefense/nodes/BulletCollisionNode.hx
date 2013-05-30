package mycompany.towerdefense.nodes;

import ash.core.Node;
import mycompany.towerdefense.components.Bullet;
import mycompany.towerdefense.components.Position;
import mycompany.towerdefense.components.Collision;

/**
 * ...
 * @author christiannoelmascarinas
 */
class BulletCollisionNode extends Node<BulletCollisionNode> {
	
	public var bullet:Bullet;
	public var position:Position;
	public var collision:Collision;
}
