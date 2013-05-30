package mycompany.towerdefense.components;

import mycompany.towerdefense.enums.TowerType;
/**
 * ...
 * @author christiannoelmascarinas
 */
class Tower {
	public var type:TowerType;
	public var level:Int;
	public var isShooting:Bool;
	public var timeSinceLastShot:Float;
	public var minimumShotInterval:Float;
	
	public function new (type:TowerType, level:Int, minimumShotInterval:Float) {
		this.type = type;
		this.level = level;
		this.isShooting = false;
		this.timeSinceLastShot = 0;
		this.minimumShotInterval = minimumShotInterval;
	}		
}
