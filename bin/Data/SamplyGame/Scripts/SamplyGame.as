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
#include "Scripts/Globals.as"
#include "Scripts/MachineGun.as"
#include "Scripts/Missile.as"
#include "Scripts/BigWhiteCube.as"
#include "Scripts/SmallPlates.as"
#include "Scripts/StartMenu.as"
#include "Scripts/Player.as"
#include "Scripts/Coin.as"
#include "Scripts/Enemies.as" 

class SamplyGame: GameObject
{
 
 		private String CoinsString = " Coins";
		 private String HealthString = "Health : ";
		private int coins = 0;
		Text@ coinsText;
		Text@ healthText;
	

		bool playing   =false;
		Enemies @ enemies_;
		Player  @ player_;
		StartMenu@ startMenu_;
		Node @ startMenuNode_;

	void Start()
	{
			node.name = "SamplyGameNode";

			@enemies_ = null;
		    @player_ = null;
			@startMenu_ = null;

		    log.Warning("SamplyGame Start");
			coinsText =  Text();
			coinsText.text = coins + CoinsString;
			coinsText.horizontalAlignment = HA_RIGHT;
			coinsText.SetFont(cache.GetResource("Font","Fonts/Font.ttf"), graphics.width / 30);
			ui.root.AddChild(coinsText);

			healthText =  Text();
			healthText.text = HealthString + 100 + "%";
			healthText.horizontalAlignment = HA_LEFT;
			healthText.SetFont(cache.GetResource("Font","Fonts/Font.ttf"), graphics.width / 30);
			ui.root.AddChild(healthText);

			
			
			input.SetMouseVisible(true, false);
			
			CreateStartMenu();
				

			playing   = false;		
	}
	
	void DelayedStart()
	{
	}
 
 
 
	void Update(float timeStep)
	{
		//Base class  must be called first
		GameObject::Update(timeStep);
		
		if(startMenu_ !is null && startMenu_.startPlay == true  && playing == false)
		{
			playing = true;
			log.Warning("start play");
		
			healthText.text = HealthString + 100 + "%";

			Node @ playerNode = scene.CreateChild("PlayerNode");
			@player_ = cast<Player>(playerNode.CreateScriptObject(scriptFile, "Player"));
			
			if(player_ !is null)
			{
				DeleteStartMenu();
				player_.Play();	
				@enemies_ = cast<Enemies>(node.CreateScriptObject(scriptFile, "Enemies"));
				enemies_.SetPlayer(player_);
				enemies_.StartSpawning();
				
				SpawnCoins();
			}
			
		}
		else if (player_ !is null  && player_.IsAlive == false )
		{
			log.Warning("you died");
			playing = false;
			enemies_.KillAll();
			enemies_.RemovePlayer();
			@player_ = null;
			@enemies_ = null;
			
			DelayedExecute(1.0, false, "void CreateStartMenu()");

			//CreateStartMenu();
			coins = 0;
			coinsText.text = coins + CoinsString;
		}
		
			
			
	}
	
	// spwans a coin every 4 seconds
	void SpawnCoins()
	{
		
		if (player_ !is null  && player_.IsAlive )
		{
			Node @ coinNode = scene.CreateChild("coinNode");
			coinNode.position =  Vector3(Random(-2.0f, 2.0f), 5.0f, 0);
			Coin  @ coin = cast<Coin>(coinNode.CreateScriptObject(scriptFile, "Coin"));
			coin.FireAsync(false);
			actionManager.AddAction( DelayTime(4.0f),coinNode,CALLBACK(this.SpawnCoinsLoop));
		}
	}
	
	
	void SpawnCoinsLoop(ActionID @ actionID)
	{
		// delete coin
		actionID.DeleteTargets();
		
		SpawnCoins();
	}
	
	void OnCoinCollected()
	{
		//log.Warning("OnCoinCollected");
		coins++;
		coinsText.text = coins + CoinsString;
	}
	
	void onPlayerHealthUpdate(float health)
	{
		//log.Warning("onPlayerHealthUpdate " + health);

		healthText.text =HealthString + int(health) + "%";
	}

	void CreateStartMenu()
	{
		log.Warning("CreateStartMenu");
		startMenuNode_ = scene.CreateChild("StartMenuNode");
		if(startMenuNode_ !is null)
		{
			@startMenu_ = cast<StartMenu>(startMenuNode_.CreateScriptObject(scriptFile, "StartMenu"));
		}
	}

	void DeleteStartMenu()
	{
		if(startMenuNode_ !is null)
		{
			log.Warning("DeleteStartMenu");
			startMenuNode_.Remove();
			@startMenu_ = null;
		}

	}

}
