package mycompany.towerdefense.components;
import flash.geom.Point;
import mycompany.towerdefense.enums.TileDirection;
/**
 * ...
 * @author christiannoelmascarinas
 */
class Position {
	
	public var position:Point;
	public var rotation:Float;
	public var direction:TileDirection;
		
	public function new (?x:Float = 0, ?y:Float = 0) {
		this.position = new Point(x, y);
		this.rotation = 0;
		this.direction = TileDirection.NONE;
	}		
}
