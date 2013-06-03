package mycompany.towerdefense.components;

import ash.fsm.EntityStateMachine;

class FsmController 
{
	public var fsm:EntityStateMachine;

	public function new(fsm:EntityStateMachine)
	{
		this.fsm = fsm;
	}
}