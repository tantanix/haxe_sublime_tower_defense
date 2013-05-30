package mycompany.towerdefense.screens;

import flash.display.BitmapData;
import flash.display.Shape;
import flash.geom.Point;
import flash.Vector;
import haxe.Timer;
import flash.geom.Rectangle;
import mycompany.towerdefense.enums.TowerType;
import mycompany.towerdefense.GameConfig;
import mycompany.towerdefense.IsoTile;
import mycompany.towerdefense.screens.Screen;
import mycompany.towerdefense.systems.CollisionSystem;
import mycompany.towerdefense.systems.TileDisplayOrderSystem;
import mycompany.towerdefense.systems.TileRenderSystem;
import mycompany.towerdefense.views.TileView;
import mycompany.towerdefense.views.TowerView;
import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;
import starling.display.Image;
import starling.display.Sprite;
import starling.core.Starling;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.utils.AssetManager;
import starling.textures.TextureAtlas;
import starling.textures.Texture;
import ash.core.Engine;
import ash.tick.FrameTickProvider;
import minject.Injector;
import mycompany.towerdefense.pathfinder.INode;
import mycompany.towerdefense.utils.AccurateTimer;
import mycompany.towerdefense.systems.GameSystem;
import mycompany.towerdefense.systems.TileTraversalSystem;
import mycompany.towerdefense.systems.TileMovementSystem;
import mycompany.towerdefense.systems.RenderSystem;
import mycompany.towerdefense.pathfinder.SearchHelper;

/**
 * ...
 * @author christiannoelmascarinas
 */
class GameScreen extends Screen {
	
	private var _engine:Engine;
	private var _map:IsoMap;
	private var _injector:Injector;
	private var _timer:AccurateTimer;
	private var _tickProvider:FrameTickProvider;
	private var _am:AssetManager;
	private var _buildingPanel:Sprite;
	private var _touchedTower:Image;
	private var _floatingTower:TowerView;
	private var _config:GameConfig;
	private var _background:Image;
	private var _towerButtonContainer:Sprite;
	private var _targetTile:INode;
	private var _creator:EntityCreator;

	@inject
	public function new(injector:Injector)
	{
		super();
		init(injector);
	}

	private function init(injector:Injector):Void {
		_injector = injector;
		_injector.mapSingleton(IsoMap);
		_injector.mapSingleton(Engine);
		_injector.mapSingleton(EntityCreator);
		_injector.mapValue(DisplayObjectContainer, new Sprite());

		_config = _injector.getInstance(GameConfig);
		_am = _injector.getInstance(AssetManager);

		createUI();
		prepare();
		start();
	}

	private function createUI():Void {
		_background = new Image(_am.getTexture("game-background"));
		addChild(_background);

		// Get a sample of the tile to be used for dimensions
		var tileView:TileView = new TileView(_am.getTextureAtlas("monsterAtlas").getTexture("tile"), 1, 1);
		
		// Create the map
		_map = _injector.getInstance(IsoMap);
		_map.tileWidth = tileView.width;
		_map.tileHeight = tileView.height;
		_map.rows = 20;
		_map.columns = 20;
		_map.drawMap();
		_map.enableTiles();
		_map.alpha = 0;
		Starling.current.nativeOverlay.addChild(_map);

		// The container for all map elements
		addChild(_injector.getInstance(DisplayObjectContainer));
		
		// Create the tower options panel
		var s:Shape = new Shape();
		s.graphics.beginFill(0xA43717, 0.5);
		s.graphics.drawRect(0, 0, 400, 60);
		s.graphics.endFill();
		
		var bmd:BitmapData = new BitmapData(Std.int(s.width), Std.int(s.height), true, 0xFFFFFF);
		bmd.draw(s);
		
		var buildingPanelBG:Image = new Image(Texture.fromBitmapData(bmd, false, true, 1));
		_buildingPanel = new Sprite();
		_buildingPanel.addChild(buildingPanelBG);
		addChild(_buildingPanel);

		var towerSpacing:Float = 10;
		_towerButtonContainer = new Sprite();
		
		// Create the tower buttons
		var towerFire:Image = createTowerButton(0xFF0000);
		towerFire.name = "tower-fire";
		towerFire.x = 0;
		_towerButtonContainer.addChild(towerFire);

		var towerIce:Image = createTowerButton(0x00FF00);
		towerIce.name = "tower-ice";
		towerIce.x = (towerFire.width + towerSpacing) * 1;
		_towerButtonContainer.addChild(towerIce);

		var towerLightning:Image = createTowerButton(0xFFFFFF);
		towerLightning.name = "tower-lightning";
		towerLightning.x = (towerIce.width + towerSpacing) * 2;
		_towerButtonContainer.addChild(towerLightning);

		_buildingPanel.addChild(_towerButtonContainer);

		update();

		this.addEventListener(TouchEvent.TOUCH, onTouch);
	}

	private function prepare():Void
	{
		// Set the startile and goal tile
		var startTile:INode = _map.getTile(20, 10);
		var goalTile:INode = _map.getTile(1, 10);

		_injector.mapValue(INode, startTile, "startTile");
		_injector.mapValue(INode, goalTile, "goalTile");
		
		_map.startTile = startTile;
		_map.endTile = goalTile;
		
		// cast(startTile, IsoTile).highlight(0xFF0000);
		// cast(goalTile, IsoTile).highlight(0x00FF00);
		
		// Set the path finding heuristic
		SearchHelper.heuristic = SearchHelper.euclidianHeuristic;
		
		_timer = new AccurateTimer(1000);
		
		// Setup the entity system
		_engine = _injector.getInstance(Engine);
		var gameSystem:GameSystem = new GameSystem();
		var tileTraversalSystem:TileTraversalSystem = new TileTraversalSystem();
		var tileMovementSystem:TileMovementSystem = new TileMovementSystem();
		var collisionSystem:CollisionSystem = new CollisionSystem();
		var tileRenderSystem:TileRenderSystem = new TileRenderSystem();
		var renderSystem:RenderSystem = new RenderSystem();
		var tileDisplayOrderSystem:TileDisplayOrderSystem = new TileDisplayOrderSystem();
		_injector.injectInto(gameSystem);
		_injector.injectInto(tileTraversalSystem);
		_injector.injectInto(tileMovementSystem);
		_injector.injectInto(collisionSystem);
		_injector.injectInto(tileRenderSystem);
		_injector.injectInto(renderSystem);
		_injector.injectInto(tileDisplayOrderSystem);
		
		_engine.addSystem(gameSystem, 1);
		_engine.addSystem(tileTraversalSystem, 3);
		_engine.addSystem(tileMovementSystem, 4);
		_engine.addSystem(collisionSystem, 5);
		_engine.addSystem(tileRenderSystem, 6);
		_engine.addSystem(renderSystem, 6);
		_engine.addSystem(tileDisplayOrderSystem, 7);
		
		// Create the game
		_creator = _injector.getInstance(EntityCreator);
		_creator.createGame();

		if (false) {
			// Create the tiles
			for (tile in _map.tiles) {
				_creator.createIsoTile(tile);
			}
		}
	}

	private function createTowerButton(color:Int):Image {
		var s:Shape = new Shape();
		s.graphics.beginFill(color, 0.5);
		s.graphics.drawRect(0, 0, 50, 50);
		s.graphics.endFill();
		
		var bmd:BitmapData = new BitmapData(Std.int(s.width), Std.int(s.height), true, 0xFFFFFF);
		bmd.draw(s);

		return new Image(Texture.fromBitmapData(bmd));
	}

	private function onTouch(event:TouchEvent):Void {
		var touches:Vector<Touch> =  event.getTouches(this);
		for (touch in touches) {
			if (touch.phase == TouchPhase.BEGAN) {
				if (Std.is(touch.target, Image)) {
					var targetImage:Image = cast(touch.target, Image);
					if (targetImage.name == "tower-fire" || targetImage.name == "tower-ice" || targetImage.name == "tower-lightning") {
						_touchedTower = targetImage;
					}
				}
			} else if (touch.phase == TouchPhase.MOVED) {
				if (_touchedTower != null) {
					if (_floatingTower == null) {
						var towerType:TowerType = null;
						switch (_touchedTower.name) {
							case "tower-fire": towerType = TowerType.FIRE;
							case "tower-ice" : towerType = TowerType.ICE;
							case "tower-lightning" : towerType = TowerType.LIGHTNING;
						}
						_floatingTower = new TowerView(towerType, 1); // It is always level 1
						_floatingTower.touchable = false;
						_injector.injectInto(_floatingTower);
						this.addChild(_floatingTower);
					}
					_targetTile = _map.getHitTile(touch.getLocation(this));
					if (_targetTile != null) {
						_floatingTower.x = _targetTile.x;
						_floatingTower.y = _targetTile.y;
					}
				}
			} else if (touch.phase == TouchPhase.ENDED) {
				if (_touchedTower != null) {
					_touchedTower = null;	
				}

				if (_targetTile != null) {
					if (_targetTile.traversable) {
						_targetTile.traversable = false;
						_creator.createTower(_targetTile, _floatingTower.type, _floatingTower.level, 180);
					}
				}
				if (_floatingTower != null) {
					this.removeChild(_floatingTower);
					_floatingTower = null;
				}
			}
		}
	}

	public override function update():Void
	{
		var config:GameConfig = _injector.getInstance(GameConfig);

		_buildingPanel.x = (config.width - _buildingPanel.width) / 2;
		_buildingPanel.y = config.height - _buildingPanel.height;

		_towerButtonContainer.x = (_buildingPanel.width - _towerButtonContainer.width) / 2;
		_towerButtonContainer.y = (_buildingPanel.height - _towerButtonContainer.height) / 2;
	}
	
	public function start():Void {
		_timer.start();
		
		_tickProvider = new FrameTickProvider(Starling.current.nativeStage);
		_tickProvider.add(_engine.update);
		_tickProvider.start();
	}
}