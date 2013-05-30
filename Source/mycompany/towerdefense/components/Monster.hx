package mycompany.towerdefense.components;

/**
 * ...
 * @author christiannoelmascarinas
 */
class Monster {
	public var life:Float;
	public var direction:Int;
	public var speed:Float;
	
	public function new (speed:Float) {
		this.life = 100;
		this.direction = 1;
		this.speed = speed;
	}		
}
