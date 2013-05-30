package mycompany.towerdefense.screens;

import flash.display.Stage;
import flash.Vector;
import minject.Injector;
import motion.Actuate;
import mycompany.towerdefense.enums.GameMode;
import mycompany.towerdefense.events.ScreenEvent;
import mycompany.towerdefense.GameConfig;
import mycompany.towerdefense.screens.Screen;
import starling.core.Starling;
import starling.display.Button;
import starling.display.Sprite;
import starling.events.ResizeEvent;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.TextureAtlas;
import starling.utils.AssetManager;

class MainScreen extends Screen
{
	inline private static var PADDING:Float = 15;

	private var _injector:Injector;
	private var _am:AssetManager;

	private var _survivalButton:Button;
	private var _adventureButton:Button;

	@inject
	public var config:GameConfig;

	@inject
	public function new(injector:Injector)
	{
		super();
		init(injector);
	}

	public function init(injector:Injector):Void {
		_injector = injector;
		_am = _injector.getInstance(AssetManager);
		
		_adventureButton = createButton("Adventure");
		_survivalButton = createButton("Survival");
		
		addChild(_adventureButton);
		addChild(_survivalButton);

		_adventureButton.addEventListener(TouchEvent.TOUCH, onAdventureTouched);
		_survivalButton.addEventListener(TouchEvent.TOUCH, onSurvivalTouched);

		update();
	}

	public override function update():Void
	{
		var config:GameConfig = _injector.getInstance(GameConfig);

		_adventureButton.x = (config.width - _adventureButton.width) / 2;
		_adventureButton.y = (config.height - _adventureButton.height) / 2;
		_survivalButton.x = _adventureButton.x;
		_survivalButton.y = _adventureButton.y + _adventureButton.height + PADDING;
	}

	private function createButton(label:String):Button
	{
		var ta:TextureAtlas = _am.getTextureAtlas("monsterAtlas");
		var btn:Button = new Button(ta.getTexture("button-a"), label, ta.getTexture("button-b"));
		btn.fontColor = 0xFFFFFF;
		btn.scaleWhenDown = 1.1;

		return btn;
	}

	private function onAdventureTouched(event:TouchEvent):Void
	{
		var touch:Touch = event.getTouch(_adventureButton, TouchPhase.BEGAN);
		if (touch != null) {
			config.gameMode = GameMode.ARCADE;
			this.dispatchEventWith(ScreenEvent.SHOW_GAMESCREEN, false);
		}
	}

	private function onSurvivalTouched(event:TouchEvent):Void
	{
		var touch:Touch = event.getTouch(_survivalButton, TouchPhase.BEGAN);
		if (touch != null) {
			config.gameMode = GameMode.SURVIVAL;
			this.dispatchEventWith(ScreenEvent.SHOW_GAMESCREEN, false);
		}
	}

}