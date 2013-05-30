package mycompany.towerdefense.systems;
import ash.core.System;
import ash.core.Engine;
import ash.core.NodeList;
import mycompany.towerdefense.GameConfig;
import mycompany.towerdefense.EntityCreator;
import mycompany.towerdefense.nodes.GameNode;
import mycompany.towerdefense.nodes.MonsterNode;
import mycompany.towerdefense.components.GameState;
import mycompany.towerdefense.utils.AccurateTimer;
import mycompany.towerdefense.pathfinder.INode;
import mycompany.towerdefense.pathfinder.SearchHelper;
/**
 * ...
 * @author christiannoelmascarinas
 */
class GameSystem extends System {
	@inject("startTile")
	public var startTile:INode;
	
	@inject("goalTile")
	public var goalTile:INode;
	
	@inject
	public var creator:EntityCreator;
	
	@inject
	public var config:GameConfig;
	
	private var _gameNodes:NodeList<GameNode>;
	private var _monsterNodes:NodeList<MonsterNode>;
	private var _creator:EntityCreator;
	private var _config:GameConfig;
	private var _timer:AccurateTimer;
	
	public function new() {
		super();		
	}

	override public function addToEngine(engine:Engine):Void {
		_gameNodes = engine.getNodeList(GameNode);
		_monsterNodes = engine.getNodeList(MonsterNode);
	}

	override public function update(time:Float):Void {
		var gameState:GameState;
		for (node in _gameNodes) {
			gameState = node.state;
			if (gameState.life > 0) {
				if (gameState.currentWave != gameState.wavesPerMonsterSet) {
					if (_monsterNodes.empty) {
						creator.createMonster(startTile, 10);
					} else {
						
					}
				} else {
					// game over, player won
				}
			} else {
				// game over, player lost
			}
		}
	}
	
	override public function removeFromEngine(engine:Engine):Void
    {
        _gameNodes = null;
        _monsterNodes = null;
    }
}
