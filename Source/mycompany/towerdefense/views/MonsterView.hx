package mycompany.towerdefense.views;

import com.eclecticdesignstudio.spritesheet.importers.BitmapImporter;
import com.eclecticdesignstudio.spritesheet.Spritesheet;
import haxe.Resource;
import mycompany.towerdefense.enums.TileDirection;
import mycompany.towerdefense.views.ITileView;
import starling.display.Image;
import starling.core.Starling;
import starling.events.Event;
import starling.textures.Texture;
import starling.display.Sprite;
import flash.display.BitmapData;
import flash.display.Shape;
import nme.Assets;
import com.eclecticdesignstudio.spritesheet.AnimatedSprite;
import com.eclecticdesignstudio.spritesheet.data.BehaviorData;
import starling.display.MovieClip;
import starling.textures.TextureAtlas;
import starling.utils.AssetManager;
/**
 * ...
 * @author christiannoelmascarinas
 */
class MonsterView extends Sprite
{
	private var _animation:MovieClip;
	
	public function new (animation:MovieClip) 
	{
		super();
		_animation = animation;

		this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}

	private function onAddedToStage(event:Event) :Void
	{
		this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		
		_animation.touchable = false;
		addChild(_animation);
		Starling.juggler.add(_animation);
		
		this.pivotX = 65;
		this.pivotY = 90;
	}
}

