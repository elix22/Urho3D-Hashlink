package samplygame;

import actions.*;
import actions.ActionManager;
import actions.ActionManager.ActionID;
import urho3d.*;
import samplygame.Globals.CollisionLayers;

class Enemies extends LogicComponent {
	var player_:Player;
	var enemies:Array<SpawnEntry> = [];

	var spwanManager:Array<SpawnArray> = [];
	var spawnIndex:Int = 0;
	var spawnInterval:Float = 0.0;
	var spawnIntervalThreshold:Float = 15.0;

	public function new(player:Player = null) {
		super();
		player_ = player;
		spawnIndex = 0;
		var spawnArray:SpawnArray = new SpawnArray();

		spawnArray.Push(new SpawnEntry(EnemySlotMachine, this.CreateObject, 0));
		spawnArray.Push(new SpawnEntry(EnemyBat, this.CreateObject, 0, 1000));
		spawnArray.Push(new SpawnEntry(EnemyBat, this.CreateObject, 0, 2000));
		spawnArray.Push(new SpawnEntry(EnemyBat, this.CreateObject, 0, 5000));
		spwanManager.push(spawnArray);


        spawnArray = new SpawnArray();
        spawnArray.Push(new SpawnMonitorScreenEntry(false,this.CreateEnemyMonitorScreenObject));
        spawnArray.Push(new SpawnMonitorScreenEntry(true,(this.CreateEnemyMonitorScreenObject)));
        spwanManager.push(spawnArray);

        spawnArray = new SpawnArray();
        spawnArray.Push(new SpawnEntry(EnemySlotMachine,(this.CreateObject),0));
        spawnArray.Push(new SpawnEntry(EnemyBat,(this.CreateObject),0));
        spawnArray.Push(new SpawnEntry(EnemyBat,(this.CreateObject),0));
        spwanManager.push(spawnArray);

        spawnArray = new SpawnArray();
        spawnArray.Push(new SpawnEntry(EnemyBat,(this.CreateObject),0,1000));
        spawnArray.Push(new SpawnEntry(EnemyBat,(this.CreateObject),0,2000));
        spawnArray.Push(new SpawnEntry(EnemySlotMachine,(this.CreateObject),0));
        spwanManager.push(spawnArray);

        spawnArray = new SpawnArray();
        spawnArray.Push(new SpawnEntry(EnemyBat,(this.CreateObject),0,1000));
        spawnArray.Push(new SpawnMonitorScreenEntry(false,(this.CreateEnemyMonitorScreenObject),0));
        spawnArray.Push(new SpawnMonitorScreenEntry(true,(this.CreateEnemyMonitorScreenObject),0));
        spwanManager.push(spawnArray);

        spawnArray = new SpawnArray();
        spawnArray.Push(new SpawnEntry(EnemyBat,(this.CreateObject),0,1000));
        spawnArray.Push(new SpawnEntry(EnemyBat,(this.CreateObject),0,2000));
        spawnArray.Push(new SpawnMonitorScreenEntry(false,(this.CreateEnemyMonitorScreenObject),0));
        spawnArray.Push(new SpawnMonitorScreenEntry(true,(this.CreateEnemyMonitorScreenObject),0));
        spwanManager.push(spawnArray);

        spawnArray = new SpawnArray();
        spawnArray.Push(new SpawnEntry(EnemySlotMachine,(this.CreateObject),0,1000));
        spawnArray.Push(new SpawnMonitorScreenEntry(false,(this.CreateEnemyMonitorScreenObject),0));
        spawnArray.Push(new SpawnMonitorScreenEntry(true,(this.CreateEnemyMonitorScreenObject),0));
        spwanManager.push(spawnArray);

	}

	public function SetPlayer(player:Player) {
		player_ = player;
	}

	public function RemovePlayer() {
		player_ = null;
	}

	public function CreateObject(spawnEntry:SpawnEntry):Dynamic {
        var enemy = null;

		var enemyNode = scene.CreateChild(spawnEntry.name);

		var enemy = LogicComponent.CreateFactory(spawnEntry.name);
		enemyNode.AddLogicComponent(enemy);
		enemy.Play();

		if (spawnEntry.msDelay > 0) {
			enemyNode.enabled = false;
			ActionManager.AddAction(new DelayTime(spawnEntry.msDelay / 1000.0), enemyNode, this.StartDelayedPlay);
		}

		return enemy;
	}

	public function StartDelayedPlay(actionID:ActionID) {
		// log.Warning("Enemy StartPlay delayed ");
		for (i in 0...actionID._action.length) {
			if (actionID._action[i].Target != null) {
				actionID._action[i].Target.enabled = true;
			}
		}
	}

	public function CreateEnemyMonitorScreenObject(spawnEntry:SpawnEntry):Enemy {

    
		var spawnMonitorScreenEntry:SpawnMonitorScreenEntry = cast(spawnEntry, SpawnMonitorScreenEntry);
        
		var enemyNode = scene.CreateChild("EnemyMonitorScreen");
        var enemy = new EnemyMonitorScreen(spawnMonitorScreenEntry.fromLeftSide);
        enemyNode.AddLogicComponent(enemy);
		enemy.Play();
		if (spawnEntry.msDelay > 0) {
			enemyNode.enabled = false;
			ActionManager.AddAction(new DelayTime(spawnEntry.msDelay / 1000.0), enemyNode, (this.StartDelayedPlay));
		}

		return enemy;
	}

	public override function Update(timeStep:Float) {
		spawnInterval += timeStep;
		// log.Warning("totalTime : " + spawnInterval);

		if (player_ != null && player_.IsAlive()) {
			for (i in 0...enemies.length) {
				if (enemies[i]!= null && enemies[i].enemy != null && enemies[i].enemy.IsAlive() == false) {
					if (enemies[i].isRepeat == true) {
						enemies[i].CreateObject();
					} else {
						enemies.remove(enemies[i]);
					}
				}
			}

			if (enemies.length == 0) {
				spawnInterval = 0;
				spawnNext();
			} else if (spawnInterval > spawnIntervalThreshold) {
                trace("spawnNext");
				spawnNext();
				spawnInterval = 0;
			}
		}
	}

	public function KillAll() {
		for (i in 0...enemies.length) {
			enemies[i].enemy.Explode();
		}
	}

	public function spawnNext() {
		if (player_ != null && player_.IsAlive()) {
			if (spawnIndex >= spwanManager.length) {
				spawnIndex = 0;
				spawnIntervalThreshold -= 0.5;
				if (spawnIntervalThreshold < 10.0) {
					spawnIntervalThreshold = 10.0;
				}
			}

			var array:SpawnArray = spwanManager[spawnIndex];
			for (i in 0...array.length) {
                var entry = array.At(i);
				entry.ResetRepeatCounter();
				entry.CreateObject();
				enemies.push(entry);
			}

			if (array.isRepeat == true) {
				array.repeatCounter = array.repeatCounter + 1;
			} else {
				spawnIndex++;
				array.ResetRepeatCounter();
			}
		}
	}

	public function StartSpawning() {
		if (player_ != null && player_.IsAlive()) {
			spawnNext();
		}
	}
}
