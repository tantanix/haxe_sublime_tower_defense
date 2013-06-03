package mycompany.towerdefense.systems;

import ash.tools.ListIteratingSystem;
import mycompany.towerdefense.components.Motion;
import mycompany.towerdefense.components.Position;
import mycompany.towerdefense.nodes.MovementNode;

class MovementSystem extends ListIteratingSystem<MovementNode> 
{
	public function new()
	{
		super(MovementNode, updateNode);
	}

	private function updateNode(node:MovementNode, time:Float):Void
	{
		var position:Position = node.position;
        var motion:Motion = node.motion;
        
        position.position.x += motion.velocityX * time;
        position.position.y += motion.velocityY * time;
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