package mycompany.towerdefense.pathfinder;

/**
 * ...
 * @author christiannoelmascarinas
 */
import mycompany.towerdefense.IsoTile;
class SearchHelper {
	public static var heuristic = SearchHelper.manhattanHeuristic;
	
	public static function findPath( firstNode:INode, destinationNode:INode, connectedNodeFunction ):Array<INode> 
	{
		var openNodes:Array<INode> = [];
		var closedNodes:Array<INode> = [];			
		
		var currentNode:INode = firstNode;
		var testNode:INode;
		
		var l:Int;
		var i:Int;
	
		var connectedNodes:Array<INode>;
		var travelCost:Float = 1.0;
		
		var g:Float;
		var h:Float;
		var f:Float;
		
		currentNode.g = 0;
		currentNode.h = SearchHelper.heuristic(currentNode, destinationNode, travelCost);
		currentNode.f = currentNode.g + currentNode.h;
		
		while (currentNode != destinationNode) {
			
			connectedNodes = connectedNodeFunction( currentNode );			
			
			l = connectedNodes.length;
			
			for (i in 0...l) {
				
				testNode = connectedNodes[i];
				
				if (testNode == currentNode || testNode.traversable == false) continue;					
				
				//For our example we will test just highlight all the tested nodes
				//cast(testNode, IsoTile).highlight(0xFF80C0);
				
				//g = currentNode.g + SearchHelper.heuristic( currentNode, testNode, travelCost); //This is what we had to use here at Untold for our situation.
				//If you have a world where diagonal movements cost more than regular movements then you would need to determine if a movement is diagonal and then adjust
				//the value of travel cost accordingly here.
				g = currentNode.g + SearchHelper.heuristic( currentNode, testNode, travelCost);
				h = SearchHelper.heuristic( testNode, destinationNode, travelCost);
				f = g + h;
				
				if ( SearchHelper.isOpen(testNode, openNodes) || SearchHelper.isClosed( testNode, closedNodes) ) {
					if(testNode.f > f) {
						testNode.f = f;
						testNode.g = g;
						testNode.h = h;
						testNode.parentNode = currentNode;
					}
				} else {
					testNode.f = f;
					testNode.g = g;
					testNode.h = h;
					testNode.parentNode = currentNode;
					openNodes.push(testNode);
				}
			}
			closedNodes.push( currentNode );
			
			if (openNodes.length == 0) {
				return null;
			}
			
			var sortFunc:INode->INode->Int = function(nodeA:INode, nodeB:INode):Int {
				if (nodeA.f > nodeB.f)
					return 1;
				else if (nodeA.f < nodeB.f)
					return -1;
				else
					return 0;
			};
			
			openNodes.sort(sortFunc);
			//untyped openNodes.sortOn("f", Array.NUMERIC);
			currentNode = openNodes.shift();
		}
		return SearchHelper.buildPath(destinationNode, firstNode);
	}
	
	
	public static function buildPath(destinationNode:INode, startNode:INode):Array<INode> {			
		var path:Array<INode> = [];
		var node:INode = destinationNode;
		path.push(node);
		while (node != startNode) {
			node = node.parentNode;
			path.unshift( node );
		}
		
		return path;			
	}
	
	public static function isOpen(node:INode, openNodes:Array<INode>):Bool {
		for (openNode in openNodes) {
			if ( openNode == node ) return true;
		}
		
		return false;			
	}
	
	public static function isClosed(node:INode, closedNodes:Array<INode>):Bool {
		for (closedNode in closedNodes) {
			if (closedNode == node ) return true;
		}
		
		return false;
	}
	
	/****************************************************************************** 
	*
	*	These are our avaailable heuristics 
	*
	******************************************************************************/		
	public static function euclidianHeuristic(node:INode, destinationNode:INode, cost:Float = 1.0, ?diagonalCost:Float = 1.0):Float
	{
		var dx:Float = node.col - destinationNode.col;
		var dy:Float = node.row - destinationNode.row;
		
		return Math.sqrt( dx * dx + dy * dy ) * cost;
	}
	
	public static function manhattanHeuristic(node:INode, destinationNode:INode, cost:Float = 1.0, ?diagonalCost:Float = 1.0):Float
	{
		return Math.abs(node.col - destinationNode.col) * cost + 
			   Math.abs(node.row + destinationNode.row) * cost;
	}
	
	public static function diagonalHeuristic(node:INode, destinationNode:INode, cost:Float = 1.0, ?diagonalCost:Float = 1.0):Float
	{
		var dx:Float = Math.abs(node.col - destinationNode.col);
		var dy:Float = Math.abs(node.row - destinationNode.row);
		
		var diag:Float = Math.min( dx, dy );
		var straight:Float = dx + dy;
		
		return diagonalCost * diag + cost * (straight - 2 * diag);
	}
}