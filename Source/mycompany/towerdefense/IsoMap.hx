package mycompany.towerdefense;

/**
 * ...
 * @author christiannoelmascarinas
 */
import flash.geom.Point;
import flash.Vector;
import mycompany.towerdefense.GameConfig;
import mycompany.towerdefense.pathfinder.INode;
import mycompany.towerdefense.pathfinder.SearchHelper;
import flash.display.Stage;
import flash.display.Sprite;

class IsoMap extends Sprite {
	
	@inject
	public var config:GameConfig;

	//
	// The number of row columns
	//
	private var _rows:Int;
	public var rows (getRows, setRows):Int;
	function getRows():Int {
		return _rows;
	}
	function setRows(value:Int):Int {
		return _rows = value;
	}
	
	//
	// The number of grid columns.
	//
	private var _columns:Int;
	public var columns (getColumns, setColumns):Int;
	function getColumns():Int {
		return _columns;
	}
	function setColumns(value:Int):Int {
		return _columns = value;
	}
	
	//
	// The start node of the path finder.
	//
	private var _startTile:INode;
	public var startTile(getStartTile, setStartTile):INode;
	function getStartTile():INode {
		return _startTile;
	}
	function setStartTile(value:INode):INode {
		return _startTile = value;
	}
	
	//
	// The end node of the path finder.
	//
	private var _endTile:INode;
	public var endTile(getEndTile, setEndTile):INode;
	function getEndTile():INode {
		return _endTile;
	}
	function setEndTile(value:INode):INode {
		return _endTile = value;
	}

	//
	// A reference to all the tiles in the map
	//
	private var _tiles:Array<INode>;
	public var tiles(get_tiles, null):Array<INode>;
	function get_tiles():Array<INode> 
	{
		return _tiles;
	}

	//
	// The width of each tile
	//
	public var tileWidth(get_tileWidth, set_tileWidth):Float;
	private var _tileWidth:Float = 0;
	
	function get_tileWidth():Float { return _tileWidth; }
	function set_tileWidth(value:Float):Float 
	{
		return _tileWidth = value;
	}	

	//
	// The height of each tile
	//
	public var tileHeight(get_tileHeight, set_tileHeight):Float;
	private var _tileHeight:Float = 0;
	
	function get_tileHeight():Float { return _tileHeight; }
	function set_tileHeight(value:Float):Float 
	{
		return _tileHeight = value;
	}

	private var _map:Array<Array<IsoTile>>;

	public function new(?rows:Int = 1, ?columns:Int = 1) {
		super();
		initialize(rows, columns);
	}
	
	private function initialize(rows:Int, columns:Int):Void {
		_rows = rows;
		_columns = columns;
		
		_map = [];
		_tiles = new Array<INode>();

		this.mouseChildren = false;
		this.mouseEnabled = false;
	}
	
	public function drawMap():Void {
		if (tileWidth == 0)
			trace("Warning: tileWidth is not set.");
		if (tileHeight == 0)
			trace("Warning: tileHeight is not set.");

		var topTileOffset:Float = rows / 2 * tileWidth;
		var tileMapWidth:Float = tileWidth * ((columns + rows) / 2);
		var tileMapHeight:Float = tileHeight * ((rows + columns) / 2);

		var tile_hor_offset:Float = (config.width - tileMapWidth) / 2;
		var tile_ver_offset:Float = (config.height - tileMapHeight) / 2 + (tileHeight / 2);
		trace([tileMapWidth, tileMapHeight, config.width, config.height]);
		for(i in 0..._rows) {
			if (_map[i] == null) {
				_map[i] = [];
			}
			for(j in 0..._columns) {
				var tile:IsoTile = new IsoTile(this);
				tile.row = i + 1;
				tile.col = j + 1;
				tile.x = tile_hor_offset + topTileOffset + ((j - i) * tileWidth / 2);
				tile.y = tile_ver_offset + ((i + j) * tileHeight / 2);
				addChild(tile);
				_map[i][j] = tile;
				_tiles.push(tile);
			}
		}
	}
	
	public function enableTiles():Void {
		//this.addEventListener(TouchEvent.TOUCH, onTouch);
	}
	
	public function disableTiles():Void {
		//this.removeEventListener(TouchEvent.TOUCH, onTouch);
	}
	
	// private function onTouch(event:TouchEvent):Void {
	// 	var touch:Touch = event.getTouch(this, TouchPhase.ENDED);
	// 	if (touch != null) {
	// 		var tile:IsoTile;
	// 		for (i in 0..._rows) {
	// 			for (j in 0..._columns) {
	// 				tile = _map[i][j];
	// 				if (tile != null) {
	// 					if (touch.isTouching(tile)) {
	// 						tile.traversable = false;
							
	// 						// Make sure there's a path for our monsters
	// 						var pathNodes:Array<INode> = SearchHelper.findPath(_startTile, _endTile, findConnectedTiles);
	// 						if (pathNodes != null) {
	// 							tile.highlight(0xCCCCCC);
	// 						} else {
	// 							tile.traversable = true;
	// 						}
	// 					}
	// 				}
	// 			}
	// 		}
	// 	}
	// }
	
	public function getTile(row:Int, col:Int):INode {
		return _map[row - 1][col - 1];
	}
	
	public function findConnectedTiles( tile:INode ):Array<INode> {
		var n:IsoTile = cast(tile, IsoTile);
		var connectedNodes:Array<INode> = [];			
		var testTile:IsoTile;
		for (i in 0..._rows) {
			for (j in 0..._columns) {
				testTile = _map[i][j];
				if (testTile.row < n.row - 1 || testTile.row > n.row + 1) continue;
				if (testTile.col < n.col - 1 || testTile.col > n.col + 1) continue;
			
				connectedNodes.push( testTile );
			}
		}	
		return connectedNodes;
	}
	
	public function reset():Void {
		for (i in 0..._rows) {
			for (j in 0..._columns) {
				_map[i][j].reset();
			}
		}	
	}
		
	public function drawPath(tiles:Array<INode>):Void 
	{
		if (tiles == null) return;
		
		// var n:IsoTile;
		// for (tile in tiles) {
		// 	n = cast(tile, IsoTile);
		// 	n.highlight(0x0000FF);
		// }
	}

	public function getHitTile(point:Point):INode
	{
		for (tile in _tiles) {
			var testTile:IsoTile = cast(tile, IsoTile);
			if (testTile.hitTestPoint( point.x, point.y, true)) {
				return tile;
			}
		}
		return null;
	}
}

