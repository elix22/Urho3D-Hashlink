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

class MachineGun : Weapon
{
	float GunOffsetSize = 0.2f; //accuracy (lower - better)
	float currentGunOffset = -GunOffsetSize;
	SoundSource  @ soundSource;
	
	MachineGun()
	{
		ReloadDuration = 50;
		Damage = 3;
	}
	
	
	void OnFire(bool player) override
	{
		currentGunOffset += GunOffsetSize;
		if (currentGunOffset > GunOffsetSize)
			currentGunOffset = -GunOffsetSize;	
			
		Node @ bulletNode = CreateRigidBullet(player);
		bulletNode.Translate( Vector3(currentGunOffset, 0, 0), TS_LOCAL);
		
		StaticModel@ model = bulletNode.CreateComponent("StaticModel");
		model.model = cache.GetResource("Model", "Models/Box.mdl");
		model.material  = cache.GetResource("Material", "Materials/MachineGun.xml");
		
		bulletNode.LookAt( Vector3(bulletNode.worldPosition.x, 10, -10),  Vector3(0, 1, -1), TS_WORLD);
		bulletNode.Rotate( Quaternion(0, 45, 0), TS_LOCAL);
		bulletNode.scale =  Vector3(0.1f, 0.3f, 0.1f);
		
		Sound@ sound = cache.GetResource("Sound", "Sounds/MachineGun.wav");
		if (sound !is null)
		{
			soundSource.Play(sound);
			// In case we also play music, set the sound volume below maximum so that we don't clip the output
			//soundSource.gain = 0.5f;
			// Set the sound component to automatically remove its scene node from the scene when the sound is done playing
			//soundSource.autoRemove = true;
		}
		
		FiniteTimeAction @ moveAction =  MoveBy(0.7f,  Vector3(0, 10, 0) * (player ? 1 : -1));
		actionManager.AddAction(moveAction,bulletNode,CALLBACK(this.bulletNodeRemove));
		
	}
	
	void bulletNodeRemove(ActionID @ actionID)
	{
		//log.Warning("bulletNodeRemove !!");
		actionID.DeleteTargets();
	}
	
	void Init() override
	{
		//log.Warning("MachineGun initialized !!");
		soundSource = node.CreateComponent("SoundSource");
		soundSource.gain = 0.1f;
	}
}