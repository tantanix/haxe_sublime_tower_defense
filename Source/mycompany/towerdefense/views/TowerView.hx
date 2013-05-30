package mycompany.towerdefense.views;

import mycompany.towerdefense.enums.TileDirection;
import mycompany.towerdefense.enums.TowerType;
import mycompany.towerdefense.views.ITileView;
import starling.core.Starling;
import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.utils.AssetManager;

class TowerView extends Sprite, implements ITileView
{
	@inject
	public var am:AssetManager;

	// Tower type
	public var type(get_type, set_type):TowerType;
	private var _type:TowerType;
	
	function get_type():TowerType { return _type; }
	function set_type(value:TowerType):TowerType 
	{
		return _type = value;
	}

	// Tower level
	public var level(get_level, set_level):Int;
	private var _level:Int;
	
	function get_level():Int { return _level; }
	function set_level(value:Int):Int 
	{
		return _level = value;
	}

	public var direction(get_direction, set_direction):TileDirection;
	private var _direction:TileDirection;
	
	function get_direction():TileDirection { return _direction; }
	function set_direction(value:TileDirection):TileDirection 
	{
		return _direction = value;
	}

	public function new(type:TowerType, level:Int)
	{
		super();
		_type = type;
		_level = level;

		this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}

	private function onAddedToStage(event:Event) :Void
	{
		this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

		if (am != null) {
			var towerTextureName:String = "";
			var gemTextureName:String = "";
			this.pivotX = 0;
			this.pivotY = 0;

			switch (_type) {
				case TowerType.FIRE :
					towerTextureName = "tower-fire";
					gemTextureName = "gem-fire-";
					this.pivotX = 27;
					this.pivotY = 69;
				case TowerType.ICE : 
					towerTextureName = "tower-ice";
					gemTextureName = "gem-ice";
					this.pivotX = 27;
					this.pivotY = 69;
				case TowerType.LIGHTNING :
					towerTextureName = "tower-lightning";
					gemTextureName = "gem-lightning-";
					this.pivotX = 27;
					this.pivotY = 69;
			}
			
			var atlas:TextureAtlas = am.getTextureAtlas("monsterAtlas");
			var towerDisplay:Image = new Image(atlas.getTexture(towerTextureName));
			var towerGem:MovieClip = new MovieClip(atlas.getTextures(gemTextureName), 10);
			this.addChild(towerDisplay);
			this.addChild(towerGem);
			towerGem.x = 19;
			towerGem.y = this.pivotY - 83;

			Starling.juggler.add(towerGem);
			
			if (this.pivotX == 0 || this.pivotY == 0) {
				trace("Warning: BasicIceTower pivot point not set.");
			}
		} else {
			trace("Warning: Inject into this object first before adding to the stage.");
		}
	}
}