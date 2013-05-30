package mycompany.towerdefense.components;

/**
 * ...
 * @author christiannoelmascarinas
 */
class GameState {
	public var life:Float;
	public var currentWave:Int;
	public var wavesPerMonsterSet:Int;
	public var monsterSets:Int;
	
	public function new (wavesPerMonsterSet:Int, monsterSets:Int) {
		this.life = 100;
		this.currentWave = 1;
		this.wavesPerMonsterSet = wavesPerMonsterSet;
		this.monsterSets = monsterSets;
	}		
}
