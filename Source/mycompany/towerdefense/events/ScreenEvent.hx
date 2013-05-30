package mycompany.towerdefense.events;

import starling.events.Event;
class ScreenEvent extends Event 
{
	inline public static var SHOW_GAMESCREEN:String = "ShowGameScreen";

	public function new(type:String, result:Bool, ?bubbles:Bool = false)
	{
		super(type, result, bubbles);
	}
}