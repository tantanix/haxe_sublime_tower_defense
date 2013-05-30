package mycompany.towerdefense;

import flash.geom.Rectangle;
import minject.Injector;
import mycompany.towerdefense.events.ScreenEvent;
import mycompany.towerdefense.GameConfig;
import mycompany.towerdefense.screens.GameScreen;
import mycompany.towerdefense.screens.MainScreen;
import starling.core.Starling;
import starling.display.Sprite;
import mycompany.towerdefense.screens.Screen;
import starling.events.Event;
import starling.events.ResizeEvent;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.utils.AssetManager;

class TowerDefense extends Sprite
{
	private var _currentScreen:Screen;
	private var _am:AssetManager;
	private var _injector:Injector;
	
	public function new()
	{
		super();
		init();
	}

	private function init():Void
	{
		_injector = new Injector();
		_injector.mapValue(Injector, _injector);
		_injector.mapSingleton(GameConfig);
		
		var config:GameConfig = _injector.getInstance(GameConfig);
		var viewPort:Rectangle = Starling.current.viewPort;
		config.width = viewPort.width;
		config.height = viewPort.height;
		
		var monsterData:String = haxe.Resource.getString("monster_data");
		var monsterDataXml:flash.xml.XML = new flash.xml.XML(monsterData);
		_am = new AssetManager(1, false);
		_am.addTexture("monster", Texture.fromBitmapData(new MonsterSpriteSheet()));
		_am.addTexture("game-background", Texture.fromBitmapData(new GameScreenBackground()));
		_am.addTextureAtlas("monsterAtlas", new TextureAtlas(_am.getTexture("monster"), monsterDataXml));
		_injector.mapValue(AssetManager, _am);
		
		currentScreen = _injector.instantiate(MainScreen);

		Starling.current.stage.addEventListener(ResizeEvent.RESIZE, onResize);
	}

	private function onResize(event:ResizeEvent):Void
	{
		var config:GameConfig = _injector.getInstance(GameConfig);
		var viewPort:Rectangle = Starling.current.viewPort;
		config.width = viewPort.width;
		config.height = viewPort.height;

		currentScreen.update();
	}

	private function onScreenEvent(event:Event):Void 
	{
		switch (event.type) {
			case ScreenEvent.SHOW_GAMESCREEN: currentScreen = _injector.instantiate(GameScreen);
		}
	}

	public var currentScreen(get_currentScreen, set_currentScreen):Screen;
	function get_currentScreen():Screen { return _currentScreen; }
	function set_currentScreen(value:Screen):Screen 
	{
		if (currentScreen != null) {
			currentScreen.removeEventListener(ScreenEvent.SHOW_GAMESCREEN, onScreenEvent);
			currentScreen.dispose();
			removeChild(currentScreen);
			currentScreen = null;
		}

		_currentScreen = value;
		if (_currentScreen != null) {
			_currentScreen.addEventListener(ScreenEvent.SHOW_GAMESCREEN, onScreenEvent);
			//_injector.injectInto(_currentScreen);
			addChild(_currentScreen);
		}
		return _currentScreen;
	}

}

@:bitmap("Assets/monster.png")
class MonsterSpriteSheet extends flash.display.BitmapData {
	public function new() {
		super(0, 0);
	}
}

@:bitmap("Assets/game-background.jpg")
class GameScreenBackground extends flash.display.BitmapData {
	public function new() {
		super(0, 0);
	}
}