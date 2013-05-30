package mycompany.towerdefense.nodes;

import ash.core.Node;
import mycompany.towerdefense.components.Tile;
import mycompany.towerdefense.components.TileDisplay;

class TileDisplayOrderNode extends Node<TileDisplayOrderNode> 
{
	public var tile:Tile;
	public var display:TileDisplay;
}