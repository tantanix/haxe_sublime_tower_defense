package mycompany.towerdefense.systems;

import ash.tools.ListIteratingSystem;
import mycompany.towerdefense.components.Vector2;
import mycompany.towerdefense.enums.TileDirection;
import mycompany.towerdefense.nodes.TileMovementNode;
import mycompany.towerdefense.components.Position;
import mycompany.towerdefense.components.Motion;
/**
 * ...
 * @author christiannoelmascarinas
 */
class TileMovementSystem extends ListIteratingSystem<TileMovementNode> {
	
	public function new () {
		super(TileMovementNode, updateNode);
	}		

	private function updateNode(node:TileMovementNode, time:Float):Void {
		var position:Position = node.position;
        var motion:Motion = node.motion;
        var direction:Vector2 = node.direction.getNormalized();
        
        position.position.x += direction.x * motion.velocityX * time;
        position.position.y += direction.y * motion.velocityY * time;
        position.rotation += motion.angularVelocity * time;
	}
}
