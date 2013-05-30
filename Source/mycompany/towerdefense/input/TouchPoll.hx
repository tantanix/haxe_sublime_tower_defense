import starling.display.DisplayObject;
import starling.events.TouchEvent;

class TouchPoll 
{
	private var _target:DisplayObject;

	function new(target:DisplayObject)
	{
		_target = target;

		_target.addEventListener(TouchEvent.TOUCH, onTouch);
	}

	function onTouch(event:TouchEvent):Void
	{
		
	}
}