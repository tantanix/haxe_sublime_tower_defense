package mycompany.towerdefense.components;
import flash.geom.Point;
/**
 * ...
 * @author christiannoelmascarinas
 */
class Motion {
	public var velocityX:Float;
	public var velocityY:Float;
	public var angularVelocity:Float;
	public var damping:Float;
	
	public function new (velocityX:Float, velocityY:Float, angularVelocity:Float, damping:Float) {
		this.velocityX = velocityX;
		this.velocityY = velocityY;
		this.angularVelocity = angularVelocity;
		this.damping = damping;
	}		

}
