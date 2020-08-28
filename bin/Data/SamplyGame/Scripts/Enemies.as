/**
MIT License

Copyright (c) 2020 Xamarin
Copyright (c) 2020 Eli Aloni (https://github.com/elix22)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

#include "Scripts/Utilities/Sample.as"
#include "Scripts/EnemyBat.as" 
#include "Scripts/EnemyMonitorScreen.as"
#include "Scripts/EnemySlotMachine.as"
#include "Scripts/SpwanManager.as"

class Enemies: GameObject
{
 
	Player @ player_;
	Array<SpawnEntry @> enemies;
	
	Array<SpawnArray> spwanManager;
	uint spawnIndex;
	float spawnInterval = 0.0f;
	float spawnIntervalThreshold = 15.0f;

	Enemies()
	{
		spawnIndex = 0;
		SpawnArray spawnArray;
		
		spawnArray.Push(SpawnEntry("EnemySlotMachine",CREATE_OBJECT(this.CreateObject),0));
		spawnArray.Push(SpawnEntry("EnemyBat",CREATE_OBJECT(this.CreateObject),0,1000));
		spawnArray.Push(SpawnEntry("EnemyBat",CREATE_OBJECT(this.CreateObject),0,2000));
		spawnArray.Push(SpawnEntry("EnemyBat",CREATE_OBJECT(this.CreateObject),0,5000));
	
		spwanManager.Push(spawnArray);
		spawnArray.Clear();
		
		spawnArray.Push(SpawnMonitorScreenEntry(false,CREATE_OBJECT(this.CreateEnemyMonitorScreenObject)));
		spawnArray.Push(SpawnMonitorScreenEntry(true,CREATE_OBJECT(this.CreateEnemyMonitorScreenObject)));
		spwanManager.Push(spawnArray);
		spawnArray.Clear();


		spawnArray.Push(SpawnEntry("EnemySlotMachine",CREATE_OBJECT(this.CreateObject),0));
		spawnArray.Push(SpawnEntry("EnemyBat",CREATE_OBJECT(this.CreateObject),0));
		spawnArray.Push(SpawnEntry("EnemyBat",CREATE_OBJECT(this.CreateObject),0));
		spwanManager.Push(spawnArray);
		spawnArray.Clear();
		
		spawnArray.Push(SpawnEntry("EnemyBat",CREATE_OBJECT(this.CreateObject),0,1000));
		spawnArray.Push(SpawnEntry("EnemyBat",CREATE_OBJECT(this.CreateObject),0,2000));
		spawnArray.Push(SpawnEntry("EnemySlotMachine",CREATE_OBJECT(this.CreateObject),0));
		spwanManager.Push(spawnArray);
		spawnArray.Clear();
	
		spawnArray.Push(SpawnEntry("EnemyBat",CREATE_OBJECT(this.CreateObject),0,1000));
		spawnArray.Push(SpawnMonitorScreenEntry(false,CREATE_OBJECT(this.CreateEnemyMonitorScreenObject),0));
		spawnArray.Push(SpawnMonitorScreenEntry(true,CREATE_OBJECT(this.CreateEnemyMonitorScreenObject),0));
		spwanManager.Push(spawnArray);
		spawnArray.Clear();

		spawnArray.Push(SpawnEntry("EnemyBat",CREATE_OBJECT(this.CreateObject),0,1000));
		spawnArray.Push(SpawnEntry("EnemyBat",CREATE_OBJECT(this.CreateObject),0,2000));
		spawnArray.Push(SpawnMonitorScreenEntry(false,CREATE_OBJECT(this.CreateEnemyMonitorScreenObject),0));
		spawnArray.Push(SpawnMonitorScreenEntry(true,CREATE_OBJECT(this.CreateEnemyMonitorScreenObject),0));
		spwanManager.Push(spawnArray);
		spawnArray.Clear();	


		spawnArray.Push(SpawnEntry("EnemySlotMachine",CREATE_OBJECT(this.CreateObject),0,1000));
		spawnArray.Push(SpawnMonitorScreenEntry(false,CREATE_OBJECT(this.CreateEnemyMonitorScreenObject),0));
		spawnArray.Push(SpawnMonitorScreenEntry(true,CREATE_OBJECT(this.CreateEnemyMonitorScreenObject),0));
		spwanManager.Push(spawnArray);
		spawnArray.Clear();		
	}	
	
	Enemies(Player @ player)
	{
		@player_ = player;
	}
	
	void SetPlayer(Player @ player)
	{
		@player_ = player;
	}
	
	void RemovePlayer()
	{
		@player_ = null;
	}
	
	Enemy @  CreateObject(SpawnEntry @ spawnEntry)
	{

		Node @ enemyNode = scene.CreateChild(spawnEntry.name);
		Enemy @ enemy = cast<Enemy>(enemyNode.CreateScriptObject(scriptFile, spawnEntry.name));
		enemy.Play();
		
		if(spawnEntry.msDelay > 0)
		{
			enemyNode.enabled = false;
			actionManager.AddAction( DelayTime(spawnEntry.msDelay/1000.0f),enemyNode,CALLBACK(this.StartDelayedPlay));
		}

		return enemy;
	}
	
	void StartDelayedPlay(ActionID @ actionID)
	{
		//log.Warning("Enemy StartPlay delayed ");
		for(uint i = 0 ; i < actionID._action.length ; i++)
		{
			if(actionID._action[i].Target !is null)
			{
				actionID._action[i].Target.enabled = true;
			}
		}			
	}
	
	Enemy @   CreateEnemyMonitorScreenObject(SpawnEntry @ spawnEntry)
	{
	
			SpawnMonitorScreenEntry @ spawnMonitorScreenEntry = cast<SpawnMonitorScreenEntry>(spawnEntry);
			Node @ enemyNode = scene.CreateChild("EnemyMonitorScreen");
			Enemy @ enemy = cast<Enemy>(enemyNode.CreateScriptObject(scriptFile, "EnemyMonitorScreen"));
			EnemyMonitorScreen @ enemyMonitorScreen = cast<EnemyMonitorScreen>(enemy);
			enemyMonitorScreen.fromLeftSide = spawnMonitorScreenEntry.fromLeftSide;
			enemy.Play();	
			if(spawnEntry.msDelay > 0)
			{
				enemyNode.enabled = false;
				actionManager.AddAction( DelayTime(spawnEntry.msDelay/1000.0f),enemyNode,CALLBACK(this.StartDelayedPlay));
			}
			return enemy;
	}
	
	void Start()
	{
	}
 
 
	void Update(float timeStep)
	{
		//Base class  must be called first
		GameObject::Update(timeStep);

		spawnInterval += timeStep;
		//log.Warning("totalTime : " + spawnInterval);

		
		
		if(player_ !is null && player_.IsAlive)
		{
			for (uint i = 0; i < enemies.length ; i++)
			{
					if(enemies[i].enemy.IsAlive == false)
					{
						if(enemies[i].isRepeat == true)
						{					
							enemies[i].CreateObject();
						}
						else
						{
							enemies.Erase(i);
						}
					}
			}
			
			
			if(enemies.length == 0)
			{
				spawnInterval = 0;
				spawnNext();
			} 
			else if( spawnInterval > spawnIntervalThreshold )
			{
				spawnNext();
				spawnInterval = 0;
			}
		}
	}
	
	void KillAll()
	{
		for(uint i = 0 ; i < enemies.length ; i++)
		{
			enemies[i].enemy.Explode();
		}
		
	}
	
	
	void spawnNext()
	{
		if(player_ !is null && player_.IsAlive)
		{
			if(spawnIndex >= spwanManager.length)
			{
				spawnIndex =0;
				spawnIntervalThreshold -= 0.5f;
				if(spawnIntervalThreshold < 10.0f)
				{
					spawnIntervalThreshold = 10.0f;
				}
			}
			
			SpawnArray @ array = spwanManager[spawnIndex];
			
			
			
			for(uint i = 0 ; i < array.length;i++)
			{	
				array[i].ResetRepeatCounter();
				array[i].CreateObject();
				enemies.Push(array[i]);
			}
			
			if(array.isRepeat == true)
			{
				array.repeatCounter = array.repeatCounter + 1;
			}
			else
			{
				spawnIndex++;
				array.ResetRepeatCounter();
			}
		}
	}
	
	void StartSpawning()
	{
		if(player_ !is null && player_.IsAlive)
		{
			spawnNext();
		}
	}
	
	
}
