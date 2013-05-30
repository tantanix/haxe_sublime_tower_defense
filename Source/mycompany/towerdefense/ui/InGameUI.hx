package mycompany.towerdefense.ui;
import flash.geom.Point;
import flash.Vector;
import mycompany.towerdefense.IsoMap;
import mycompany.towerdefense.IsoTile;
import mycompany.towerdefense.pathfinder.INode;
import starling.display.DisplayObject;
import starling.display.Sprite;
import starling.display.Image;
import flash.display.Shape;
import flash.display.BitmapData;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;
import starling.core.Starling;
import flash.display.Stage;
import starling.utils.AssetManager;

class InGameUI {
	@inject
	public var am:AssetManager;

	@inject("startTile")
	public var startTile:INode;

	@inject
	public var map:IsoMap;

	
	public function new(targetContainer:Sprite) {
		_targetContainer = targetContainer;
		
		createUI();
	}
	
	
}
