
package mycompany.towerdefense.views;

import mycompany.towerdefense.enums.TileDirection;

interface ITileView {
	var direction(get_direction, set_direction):TileDirection;
}