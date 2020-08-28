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
#include "Scripts/Weapon.as"

class Coin : Weapon
{

    SamplyGame  @ sampleGame_ = null;

	Coin()
	{
		Damage = 0;
	}

    void Init() override
	{
		InitSamplyGameReference();
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

	void OnFire(bool byPlayer) override
	{
		Node @ bulletNode = CreateRigidBullet(byPlayer);
	
		StaticModel@ model = bulletNode.CreateComponent("StaticModel");
		model.model = cache.GetResource("Model", "Models/Apple.mdl");
		model.material  = cache.GetResource("Material", "Materials/Apple.xml");
		
		bulletNode.SetScale(0.8);
		bulletNode.rotation =  Quaternion(-40, 0, 0);

		
		Array<FiniteTimeAction@> actions;
		actions.Push(MoveBy(duration: 3.0f, position:  Vector3(0, 10 * (byPlayer ? 1 : -1), 0)));
		actions.Push(RotateBy(duration: 3.0f, deltaAngleX: 0, deltaAngleY: 360 * 5, deltaAngleZ: 0));
		actionManager.AddAction(Parallel(actions),bulletNode,CALLBACK(this.bulletNodeRemove));
		
	}
	
	void bulletNodeRemove(ActionID @ actionID)
	{
	//	log.Warning("delete coin");
		actionID.DeleteTargets();
	}
	
	void OnHit(GameObject  @ target, bool killed, Node @ bulletNode) override
	{
	
		SoundSource @ soundSource = node.CreateComponent("SoundSource");
		Sound@ sound = cache.GetResource("Sound", "Sounds/Powerup.wav");
		if (sound !is null)
		{
			soundSource.Play(sound);
			soundSource.gain = 0.1f;
		}
		
		Weapon::OnHit(target, killed, bulletNode);

		if(sampleGame_ !is null)
		{
			sampleGame_.OnCoinCollected();
		}

		/*
		Node @ game =  scene.GetNode(SamplyNodeID);
		if(game !is null)
		{
			Array<Component@>@ instances = game.GetComponents("ScriptInstance");
			
			for (uint i = 0; i < instances.length; ++i)
			{
				ScriptInstance@ instance = cast<ScriptInstance>(instances[i]);	
				if(instance.IsA("SamplyGame"))
				{
					instance.Execute("void OnCoinCollected()");
					break;
				}
			}
		}
		*/
	}
}
