package mycompany.towerdefense.components;

import flash.geom.Point;
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
	public var target:Point;
	
	public function new (type:TowerType, level:Int, minimumShotInterval:Float) {
		this.type = type;
		this.level = level;
		this.isShooting = false;
		this.timeSinceLastShot = 0;
		this.minimumShotInterval = minimumShotInterval;
	}		
}
