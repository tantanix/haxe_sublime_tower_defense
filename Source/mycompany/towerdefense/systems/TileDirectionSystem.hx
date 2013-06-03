package mycompany.towerdefense.systems;

import ash.fsm.EntityStateMachine;
import ash.tools.ListIteratingSystem;
import mycompany.towerdefense.components.Vector2;
import mycompany.towerdefense.nodes.TileDirectionNode;

class TileDirectionSystem extends ListIteratingSystem<TileDirectionNode> 
{
	public function new()
	{
		super(TileDirectionNode, updateNode);
	}

	private function updateNode(node:TileDirectionNode, time:Float):Void 
	{
		var direction:Vector2 = node.direction;
		var fsm:EntityStateMachine = node.fsm.fsm;

		// Change FSM state according to direction
        if (direction.x > 0) {
            if (direction.y > 0) {
                fsm.changeState("walkingE");
            } else if (direction.y < 0) {
                fsm.changeState("walkingN");
            } else {
                fsm.changeState("walkingNE");
            }
        } else if (direction.x < 0) {
            if (direction.y > 0) {
                fsm.changeState("walkingS");
            } else if (direction.y < 0) {
                fsm.changeState("walkingW");
            } else {
                fsm.changeState("walkingSW");
            }
        } else {
            if (direction.y > 0) {
                fsm.changeState("walkingSE");
            } else if (direction.y < 0) {
                fsm.changeState("walkingNW");
            } else {
                fsm.changeState("walkingSE");
            }
        }
	}
}