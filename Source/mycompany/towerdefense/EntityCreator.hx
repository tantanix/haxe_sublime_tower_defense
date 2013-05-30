package mycompany.towerdefense;
import flash.geom.Point;
import minject.Injector;
import mycompany.towerdefense.components.Bullet;
import mycompany.towerdefense.components.Collision;
import mycompany.towerdefense.GameConfig;
import mycompany.towerdefense.components.GameState;
import mycompany.towerdefense.components.Monster;
import mycompany.towerdefense.components.TileDisplay;
import mycompany.towerdefense.components.Tower;
import mycompany.towerdefense.components.Position;
import mycompany.towerdefense.components.Motion;
import mycompany.towerdefense.components.Display;
import mycompany.towerdefense.components.Tile;
import mycompany.towerdefense.components.Vector2;
import mycompany.towerdefense.views.BulletView;
import mycompany.towerdefense.views.MonsterView;
import mycompany.towerdefense.views.TileView;
import mycompany.towerdefense.views.TowerView;
import mycompany.towerdefense.enums.TowerType;
import mycompany.towerdefense.pathfinder.INode;
import mycompany.towerdefense.pathfinder.SearchHelper;
import ash.core.Engine;
import ash.core.Entity;
import starling.display.MovieClip;
import starling.display.Sprite;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.utils.AssetManager;
/**
 * ...
 * @author christiannoelmascarinas
 */
class EntityCreator {
	@inject
	public var engine:Engine;
	
	@inject("goalTile")
	public var goalTile:INode;
	
	@inject
	public var map:IsoMap;

	@inject
	public var am:AssetManager;

	@inject
	public var config:GameConfig;

	@inject
	public var injector:Injector;
	
	public function new() {
	}

	public function destroyEntity(entity:Entity):Void {
		engine.removeEntity(entity);
	}		

	public function createGame():Entity {
		var game:Entity = new Entity()
			.add(new GameState(3, 3));
		engine.addEntity(game);
		return game;
	}

	public function createIsoTile(currentTile:INode):Entity 
	{
		var monsterAtlas:TextureAtlas = am.getTextureAtlas("monsterAtlas");
		var view:TileView = new TileView(monsterAtlas.getTexture("tile"), currentTile.row, currentTile.col);

		var isoTile:Entity = new Entity()
			.add(new Position(currentTile.x, currentTile.y))
			.add(new Display(view));
		engine.addEntity(isoTile);
		return isoTile;
	}

	public function createMonster(currentTile:INode, collisionRadius:Float):Entity 
	{
		var pathNodes:Array<INode> = SearchHelper.findPath(currentTile, goalTile, map.findConnectedTiles);
		map.drawPath(pathNodes);

		var view:MonsterView = new MonsterView();
		injector.injectInto(view);
		
		var monster:Entity = new Entity()
			.add(new Monster(5))
			.add(new Position(currentTile.x, currentTile.y))
			.add(new Collision(collisionRadius))
			.add(new Tile(currentTile, pathNodes))
			.add(new Vector2(0, 0))
			.add(new Motion(40, 40, 0, 0))
			.add(new TileDisplay(view));
		engine.addEntity(monster);
		return monster;
	}

	public function createTower(currentTile:INode, towerType:TowerType, level:Int, collisionRadius:Float):Entity 
	{
		var minimumShotInterval:Float = switch (towerType) {
			case TowerType.FIRE : 1 / level;
			case TowerType.ICE : 2 / level;
			case TowerType.LIGHTNING : 0.5 / level;
		}

		var view:TowerView = new TowerView(towerType, level);
		injector.injectInto(view);
		
		var tower:Entity = new Entity()
			.add(new Tower(towerType, level, minimumShotInterval))
			.add(new Position(currentTile.x, currentTile.y))
			.add(new Collision(collisionRadius))
			.add(new Tile(currentTile))
			.add(new Vector2(0, 0))
			.add(new TileDisplay(view));
		engine.addEntity(tower);
		return tower;
	}

	public function createBullet(currentTile:INode, towerType:TowerType, level:Int, collisionRadius:Float):Entity
	{
		var motion:Motion = switch (towerType) {
			case TowerType.FIRE : new Motion(10, 10, 0, 0);
			case TowerType.ICE : new Motion(5, 5, 0, 0);
			case TowerType.LIGHTNING : new Motion(0, 0, 0, 0);
		}

		var view:BulletView = new BulletView(towerType, level);
		injector.injectInto(view);

		var bullet:Entity = new Entity()
			.add(new Bullet())
			.add(new Position(currentTile.x, currentTile.y))
			.add(new Collision(collisionRadius))
			.add(motion)
			.add(new Tile(currentTile))
			.add(new Vector2(0, 0))
			.add(new TileDisplay(view));
		engine.addEntity(bullet);
		return bullet;
	}
}
