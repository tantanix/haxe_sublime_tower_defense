package mycompany.towerdefense.systems;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;
import flash.geom.Point;
import mycompany.towerdefense.EntityCreator;
import mycompany.towerdefense.nodes.BulletCollisionNode;
import mycompany.towerdefense.nodes.MonsterCollisionNode;
import mycompany.towerdefense.nodes.TowerCollisionNode;

class CollisionSystem extends System 
{
	@inject
	public var creator:EntityCreator;

	private var _bulletCollisionNodes:NodeList<BulletCollisionNode>;
	private var _monsterCollisionNodes:NodeList<MonsterCollisionNode>;
	private var _towerCollisionNodes:NodeList<TowerCollisionNode>;

	public function new()
	{
		super();
	}

	override public function addToEngine(engine:Engine):Void
	{
		_bulletCollisionNodes = engine.getNodeList(BulletCollisionNode);
		_monsterCollisionNodes = engine.getNodeList(MonsterCollisionNode);
		_towerCollisionNodes = engine.getNodeList(TowerCollisionNode);
	}

	override public function removeFromEngine(engine:Engine):Void 
	{
		_bulletCollisionNodes = null;
		_monsterCollisionNodes = null;
		_towerCollisionNodes = null;
	}

	override public function update(time:Float):Void 
	{
		for (towerNode in _towerCollisionNodes) {
			for (monsterNode in _monsterCollisionNodes) {				
				if (Point.distance(monsterNode.position.position, towerNode.position.position) <= monsterNode.collision.radius + towerNode.collision.radius) {
					towerNode.tower.timeSinceLastShot += time;
					//trace(towerNode.tower.timeSinceLastShot);
					if (towerNode.tower.timeSinceLastShot >= towerNode.tower.minimumShotInterval) {
						creator.createBullet(monsterNode.tile.currentTile, towerNode.tower.type, towerNode.tower.level, 10);
						towerNode.tower.timeSinceLastShot = 0;
					}
				}
			}
		}
	}
}