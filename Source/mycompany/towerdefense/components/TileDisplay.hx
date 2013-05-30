
package mycompany.towerdefense.components;
import mycompany.towerdefense.views.ITileView;

class TileDisplay {
	public var displayObject:ITileView;
	
	public function new (displayObject:ITileView) {
		this.displayObject = displayObject;
	}
}