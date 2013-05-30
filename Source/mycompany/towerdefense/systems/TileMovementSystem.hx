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
        
        // Apply motion damping
        if (motion.damping > 0)
        {
            var xDamp:Float = Math.abs(Math.cos(position.rotation) * motion.damping * time);
            var yDamp:Float = Math.abs(Math.sin(position.rotation) * motion.damping * time);
            if (motion.velocityX > xDamp)
            {
                motion.velocityX -= xDamp;
            }
            else if (motion.velocityX < -xDamp)
            {
                motion.velocityX += xDamp;
            }
            else
            {
                motion.velocityX = 0;
            }
            if (motion.velocityY > yDamp)
            {
                motion.velocityY -= yDamp;
            }
            else if (motion.velocityY < -yDamp)
            {
                motion.velocityY += yDamp;
            }
            else
            {
                motion.velocityY = 0;
            }
        }
	}
}
