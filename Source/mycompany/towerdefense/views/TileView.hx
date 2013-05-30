package mycompany.towerdefense.views;

import starling.display.Image;
import starling.textures.Texture;

class TileView extends Image 
{
	public var row:Int;
	public var column:Int;

	public function new(texture:Texture, row:Int, column:Int)
	{
		super(texture);
		this.row = row;
		this.column = column;
		this.pivotX = this.width / 2;
		this.pivotY = this.height / 2;
	}

}