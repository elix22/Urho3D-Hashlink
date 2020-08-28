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
#include "Scripts/Aircraft.as" 
#include "Scripts/MachineGun.as"
#include "Scripts/Missile.as"
#include "Scripts/Joysticks.as"
#include "Scripts/Coin.as"
#include "Scripts/Utilities/Math.as"

class Player : Aircraft
{

	Node  @ rotor;
	ActionID actionID;
	int offsetY = -50;
    SamplyGame  @ sampleGame_ = null;
	Player()
	{
		name = "Player";
		CollisionLayer = CollisionLayers::Player;
		CollisionShapeSize =  Vector3(2.4f, 1.2f, 1.2f);
		MaxHealth = 300;	
	}

	void InitSamplyGameReference()
	{

		Array<Node@> nodes = scene.GetChildrenWithScript("SamplyGame", true);
		if(nodes.length > 0 )
		{
			if(nodes[0] !is null)
			{
				@sampleGame_ = cast<SamplyGame> (nodes[0].GetScriptObject("SamplyGame"));
			}
		}
	}
	
	
	 void Init() override
	 {
		//log.Warning("Player init");
		
		InitSamplyGameReference();

		Array<Node@> nodes = scene.GetChildrenWithScript("SamplyGame", true);

		StaticModel@ model = node.CreateComponent("StaticModel");
		model.model = cache.GetResource("Model", "Models/Player.mdl");
		model.material  = cache.GetResource("Material", "Materials/Player.xml");
		node.SetScale(0.45f);
		node.rotation =  Quaternion(-40, 0, 0);
		node.position =  Vector3(0.0f, -6.0f, 0.0f);
		
		rotor = node.CreateChild();
		StaticModel@ rotorModel = rotor.CreateComponent("StaticModel");
		rotorModel.model = cache.GetResource("Model", "Models/Box.mdl");
		rotorModel.material  = cache.GetResource("Material", "Materials/Black.xml");	
		rotor.scale =  Vector3(0.1f, 1.4f, 0.1f);
		rotor.rotation =  Quaternion(0, 0, 0);
		rotor.position =  Vector3(0, -0.15f, 1.2f);		
		actionManager.AddAction( RepeatForever( RotateBy(1.0f, 0, 0, 360.0f * 4)),rotor);
		
		node.CreateScriptObject(scriptFile, "MachineGun");
		node.CreateScriptObject(scriptFile, "Missile");
		
		actionManager.AddAction( EaseOut( MoveBy(0.5f,  Vector3(0, 3, 0)), 2),node);

		FiniteTimeAction@ sequence1 = Sequence(EaseBackInOut(RotateBy(1.0f, 0.0f, 0.0f, 360.0f)),DelayTime(5));
		FiniteTimeAction@ sequence2 = Sequence(EaseBackInOut(RotateBy(1.0f, 0.0f, 0.0f, -360.0f)),DelayTime(5));
		actionManager.AddAction(RepeatForever( Sequence(sequence1,sequence2)),node);

		MoveRandomly();
	 }
	 
	void Update(float timeStep) 
	{
		
		if (IsAlive)
		{
			int positionX = 0, positionY = 0;
			bool hasInput = false;				
			if ( input.numTouches > 0)
			{
				TouchState@ state = input.touches[0];
				IntVector2 touchPosition = state.position;
				positionX = touchPosition.x;
				positionY = touchPosition.y+offsetY;
				hasInput = true;
			}
			
			if(input.mouseButtonDown[MOUSEB_LEFT])
			{
				IntVector2 mousePos = input.mousePosition;
				positionX = mousePos.x;
				positionY = mousePos.y+offsetY;
				hasInput = true;
			}
			
			if (hasInput)
			{
				Vector3 destWorldPos = renderer.viewports[0].ScreenToWorldPoint(positionX, positionY, 10);
				destWorldPos.z = 0;
				node.Translate(destWorldPos - node.worldPosition, TS_WORLD);
			
				Array<Component@>@ weapons = node.GetComponents("ScriptInstance");
				
				for (uint i = 0; i < weapons.length; ++i)
				{
					ScriptInstance@ instance = cast<ScriptInstance>(weapons[i]);
					Weapon@ weapon = cast<Weapon>(instance.scriptObject);
					if(weapon !is null)
					{
						weapon.FireAsync(true);
					}
				}

								
			}
			
			node.LookAt( Vector3(0, node.worldPosition.y + 10, 10),  Vector3(0, 1, -1), TS_WORLD);

		}

		GameObject::Update(timeStep);

	}
	
	void MoveRandomly()
	{
		if (IsAlive)
		{
			FiniteTimeAction @ moveAction =  MoveBy(0.75f,  Vector3(Random(-0.4f, 0.4f), Random(-0.4f, 0.4f), 0));
			actionManager.AddAction(Sequence(moveAction, moveAction.Reverse()),node,CALLBACK(this.RandmoMoveDone));
		}
	}
	
	void RandmoMoveDone(ActionID @ actionID)
	{
		if (IsAlive)
		{
			FiniteTimeAction @ moveAction =  MoveBy(0.75f,  Vector3(Random(-0.4f, 0.4f), Random(-0.4f, 0.4f), 0));
			actionManager.AddAction(Sequence(moveAction, moveAction.Reverse()),node,CALLBACK(this.RandmoMoveDone));
		}
	}
	
	void OnExplode(Node @ explodeNode) override
	{
		actionManager.RemoveAllActions(rotor);
		rotor.Remove();
		
		explodeNode.SetScale(1.5f);
		ParticleEmitter2D @ particleEmitter = explodeNode.CreateComponent("ParticleEmitter2D");
		ParticleEffect2D@ particleEffect = cache.GetResource("ParticleEffect2D", "Particles/PlayerExplosion.pex");
		particleEmitter.effect = particleEffect;
		
	}

	void SendHealthUpdateToSamplyGame() override
	{
		if(sampleGame_ !is null)
		{
			float h = float(Health) / MaxHealth;
			h *= 100.0f;
			sampleGame_.onPlayerHealthUpdate(h);
		}
	}

}
