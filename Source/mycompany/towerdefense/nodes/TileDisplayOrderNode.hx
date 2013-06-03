package mycompany.towerdefense.nodes;

import ash.core.Node;
import mycompany.towerdefense.components.Display;
import mycompany.towerdefense.components.Tile;

class TileDisplayOrderNode extends Node<TileDisplayOrderNode> 
{
	public var tile:Tile;
	public var display:Display;
}