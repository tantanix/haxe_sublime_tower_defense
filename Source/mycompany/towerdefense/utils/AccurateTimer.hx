package mycompany.towerdefense.utils;
import haxe.Timer;
/**
 * ...
 * @author christiannoelmascarinas
 */
class AccurateTimer
{
	private var _timer:Timer;
	private var _lastTime:Date;
	private var _delay:Int;
	private var _currentCount:Int;
	
	public function new(delay:Int) {
		_delay = delay;
		_timer = new Timer(delay);
	}
	
	public function start():Void {
		_currentCount = 0;
		_timer.run = onTimer;
	}
	
	public function reset():Void {
		
	}
	
	public function stop():Void {
		_timer.run = null;
	}
	
	private function onTimer():Void {
		_currentCount++;
	}
	
	public var delay(get_delay, set_delay):Int;
	function get_delay():Int {
		return _delay;
	}
	function set_delay(value:Int):Int {
		return _delay = value;
	}
	
	public var currentCount(get_currentCount, set_currentCount):Int;
	function get_currentCount():Int {
		return _currentCount;
	}
	function set_currentCount(value:Int):Int {
		return _currentCount = value;
	}
}

