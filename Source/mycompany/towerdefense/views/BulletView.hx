package mycompany.towerdefense.views;

import mycompany.towerdefense.enums.TileDirection;
import mycompany.towerdefense.enums.TowerType;
import mycompany.towerdefense.views.ITileView;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.textures.TextureAtlas;
import starling.utils.AssetManager;

class BulletView extends Sprite, implements ITileView
{
	@inject
	public var am:AssetManager;
	
	public var towerType:TowerType;
	public var level:Int;

	
	public var direction(get_direction, set_direction):TileDirection;
	private var _direction:TileDirection;
	
	function get_direction():TileDirection { return _direction; }
	function set_direction(value:TileDirection):TileDirection 
	{
		return _direction = value;
	}

	public function new(towerType:TowerType, level:Int)
	{
		super();
		trace(towerType, level);
		this.towerType = towerType;
		this.level = level;
		this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}

	private function onAddedToStage(event:Event):Void 
	{
		this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

		trace("added: " + am + ", " + [towerType, level]);
		var atlas:TextureAtlas = am.getTextureAtlas("monsterAtlas");
		var bulletImage:Image = new Image(atlas.getTexture("bullet-fire"));
		bulletImage.touchable = false;
		this.addChild(bulletImage);
		this.pivotX = this.width / 2;
		this.pivotY = this.height / 2;
	}
}