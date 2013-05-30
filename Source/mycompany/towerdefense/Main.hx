package mycompany.towerdefense;

import flash.display.Sprite;
import flash.Lib;
import flash.events.Event;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.geom.Rectangle;
import starling.core.Starling;
import mycompany.towerdefense.TowerDefense;
/**
 * ...
 * @author christiannoelmascarinas
 */
class Main extends Sprite {
	private var _starlingApp:Starling;
	
	public function new () {
		super();
		this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onEnterFrame(event:Event):Void {
		if (stage.stageWidth != 0 && stage.stageHeight != 0) {
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			 
			init();
		}
	}
	
	private function init():Void {
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		stage.addEventListener(Event.DEACTIVATE, deactivate);
		
		Starling.multitouchEnabled = true;  // useful on mobile devices
		Starling.handleLostContext = false; // not necessary on iOS. Saves a lot of memory!
				
		_starlingApp = new Starling(TowerDefense, this.stage, getViewPort());
		_starlingApp.simulateMultitouch = false;
		_starlingApp.enableErrorChecking = false;
		_starlingApp.antiAliasing = 0;
		_starlingApp.showStats = true;
		_starlingApp.simulateMultitouch = true;
		_starlingApp.start();

		stage.addEventListener(Event.RESIZE, onResize);
	}

	private function onResize(event:Event):Void
	{
		Starling.current.viewPort = getViewPort();

		// Avoid scaling up the content so adjust the starling instance stage size.
		_starlingApp.stage.stageWidth = stage.stageWidth;
		_starlingApp.stage.stageHeight = stage.stageHeight;
	}

	private function getViewPort():Rectangle
	{
		var viewPort:Rectangle =  new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
		if (viewPort.width == 768) // iPad 1+2
			viewPort.setTo(64, 32, 640, 960);
		else if (viewPort.width == 1536) // iPad 3
			viewPort.setTo(128, 64, 1280, 1920);
		else
			viewPort.setTo(0, 0, stage.stageWidth, stage.stageHeight);

		return viewPort;
	}
	
	private function deactivate(e:Event):Void
	{
		// auto-close
		//NativeApplication.nativeApplication.exit();
	}

	static function main () {
		Lib.current.addChild (new Main ());
	}
}
