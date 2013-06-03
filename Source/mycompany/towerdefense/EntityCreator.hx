package mycompany.towerdefense;
import ash.fsm.EntityStateMachine;
import flash.geom.Point;
import minject.Injector;
import mycompany.towerdefense.components.Bullet;
import mycompany.towerdefense.components.Collision;
import mycompany.towerdefense.components.FsmController;
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

		var monsterAtlas:TextureAtlas = am.getTextureAtlas("monsterAtlas");
		var walkingN = new MovieClip(monsterAtlas.getTextures("walking n0"), 8);
		var walkingNW = new MovieClip(monsterAtlas.getTextures("walking nw"), 8);
		var walkingNE = new MovieClip(monsterAtlas.getTextures("walking ne"), 8);
		var walkingS = new MovieClip(monsterAtlas.getTextures("walking s0"), 8);
		var walkingSE = new MovieClip(monsterAtlas.getTextures("walking se"), 8);
		var walkingSW = new MovieClip(monsterAtlas.getTextures("walking sw"), 8);
		var walkingE = new MovieClip(monsterAtlas.getTextures("walking e0"), 8);
		var walkingW = new MovieClip(monsterAtlas.getTextures("walking w0"), 8);

		var monster:Entity = new Entity();

		// Setup the state machine
		var fsm:EntityStateMachine = new EntityStateMachine(monster);
		fsm.createState("walkingN")
			.add(Display).withInstance(new Display(new MonsterView(walkingNE)));
		fsm.createState("walkingNW")
			.add(Display).withInstance(new Display(new MonsterView(walkingN)));
		fsm.createState("walkingNE")
			.add(Display).withInstance(new Display(new MonsterView(walkingE)));
		fsm.createState("walkingS")
			.add(Display).withInstance(new Display(new MonsterView(walkingSW)));
		fsm.createState("walkingSE")
			.add(Display).withInstance(new Display(new MonsterView(walkingS)));
		fsm.createState("walkingSW")
			.add(Display).withInstance(new Display(new MonsterView(walkingW)));
		fsm.createState("walkingE")
			.add(Display).withInstance(new Display(new MonsterView(walkingSE)));
		fsm.createState("walkingW")
			.add(Display).withInstance(new Display(new MonsterView(walkingNW)));

		// Add the rest of the components that are common to each state
		monster.add(new Monster(5))
			.add(new Position(currentTile.x, currentTile.y))
			.add(new Collision(collisionRadius))
			.add(new Tile(currentTile, pathNodes))
			.add(new Vector2(0, 0))
			.add(new Motion(40, 40, 0, 0))
			.add(new FsmController(fsm));
		
		fsm.changeState("walkingNE");

		engine.addEntity(monster);
		return monster;
	}

	public function createTower(currentTile:INode, towerType:TowerType, level:Int, collisionRadius:Float):Entity 
	{
		var view:TowerView = new TowerView(towerType, level);
		injector.injectInto(view);
		
		var tower:Entity = new Entity()
			.add(new Tower(towerType, level, switch (towerType) {
												case TowerType.FIRE : 1 / level;
												case TowerType.ICE : 2 / level;
												case TowerType.LIGHTNING : 0.5 / level;
											}))
			.add(new Position(currentTile.x, currentTile.y))
			.add(new Collision(collisionRadius))
			.add(new Tile(currentTile))
			.add(new Vector2(0, 0))
			.add(new Display(view));
		engine.addEntity(tower);
		return tower;
	}

	public function createBullet(position:Position, currentTile:INode, towerType:TowerType, level:Int, collisionRadius:Float):Entity
	{
		var view:BulletView = new BulletView(towerType, level);
		injector.injectInto(view);

		var bullet:Entity = new Entity()
			.add(new Bullet())
			.add(new Position(position.position.x, position.position.y))
			.add(new Collision(collisionRadius))
			.add(switch (towerType) {
					case TowerType.FIRE : new Motion(40, 40, 0, 0);
					case TowerType.ICE : new Motion(1, 1, 0, 0);
					case TowerType.LIGHTNING : new Motion(1, 1, 0, 0);
				})
			.add(new Tile(currentTile))
			.add(new Vector2(0, 0))
			.add(new Display(view));
		engine.addEntity(bullet);
		return bullet;
	}
}
