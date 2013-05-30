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
class MonsterView extends Sprite, implements ITileView {
	@inject
	public var am:AssetManager;
	
	private var _animation:AnimatedSprite;
	private var _walkingN:MovieClip;
	private var _walkingNE:MovieClip;
	private var _walkingE:MovieClip;
	private var _walkingSE:MovieClip;
	private var _walkingS:MovieClip;
	private var _walkingSW:MovieClip;
	private var _walkingW:MovieClip;
	private var _walkingNW:MovieClip;
	
	public function new () {

		super();

		this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}

	private function onAddedToStage(event:Event) :Void
	{
		this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		
		var monsterAtlas:TextureAtlas = am.getTextureAtlas("monsterAtlas");
		_walkingN = new MovieClip(monsterAtlas.getTextures("walking n0"), 8);
		_walkingNW = new MovieClip(monsterAtlas.getTextures("walking nw"), 8);
		_walkingNE = new MovieClip(monsterAtlas.getTextures("walking ne"), 8);
		_walkingS = new MovieClip(monsterAtlas.getTextures("walking s0"), 8);
		_walkingSE = new MovieClip(monsterAtlas.getTextures("walking se"), 8);
		_walkingSW = new MovieClip(monsterAtlas.getTextures("walking sw"), 8);
		_walkingE = new MovieClip(monsterAtlas.getTextures("walking e0"), 8);
		_walkingW = new MovieClip(monsterAtlas.getTextures("walking w0"), 8);

		_walkingN.touchable = false;
		_walkingNE.touchable = false;
		_walkingE.touchable = false;
		_walkingSE.touchable = false;
		_walkingS.touchable = false;
		_walkingSW.touchable = false;
		_walkingW.touchable = false;
		_walkingNW.touchable = false;

		addChild(_walkingN);
		addChild(_walkingNE);
		addChild(_walkingE);
		addChild(_walkingSE);
		addChild(_walkingS);
		addChild(_walkingSW);
		addChild(_walkingW);
		addChild(_walkingNW);

		Starling.juggler.add(_walkingN);
		Starling.juggler.add(_walkingNE);
		Starling.juggler.add(_walkingE);
		Starling.juggler.add(_walkingSE);
		Starling.juggler.add(_walkingS);
		Starling.juggler.add(_walkingSW);
		Starling.juggler.add(_walkingW);
		Starling.juggler.add(_walkingNW);

		hideAllAnimations();

		this.pivotX = 65;
		this.pivotY = 90;

		direction = TileDirection.NE;
	}

	public var direction(get_direction, set_direction):TileDirection;
	private var _direction:TileDirection;
	
	function get_direction():TileDirection { return _direction; }
	function set_direction(value:TileDirection):TileDirection 
	{
		hideAllAnimations();
		
		switch (value) {
			case N: _walkingNE.visible = true; 
			case NE: _walkingE.visible = true;
			case E: _walkingSE.visible = true;
			case SE: _walkingS.visible = true;
			case S: _walkingSW.visible = true;
			case SW: _walkingW.visible = true;
			case W: _walkingNW.visible = true;
			case NW: _walkingN.visible = true;
			case NONE: hideAllAnimations();
		}
		
		return _direction = value;
	}

	private function hideAllAnimations():Void {
		_walkingN.visible = false;
		_walkingNE.visible = false;
		_walkingE.visible = false;
		_walkingSE.visible = false;
		_walkingS.visible = false;
		_walkingSW.visible = false;
		_walkingW.visible = false;
		_walkingNW.visible = false;
	}
}

