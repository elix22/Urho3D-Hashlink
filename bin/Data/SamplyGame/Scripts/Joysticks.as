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



class Joysticks : Weapon
{
	Joysticks()
	{
		ReloadDuration = 2000;
		Damage = 10;	
	}
	
	void OnFire(bool byPlayer) override
	{
			const int joysticksCount = 12;
			const float length = 10.0f;

			ActionGroup group;
			for (int i = 0; i < joysticksCount; i++)
			{
				float angle = (360.0f / joysticksCount * i); //angle per joystick (in radians)
				//x^2 + y^2 = length^2 (Equation of Circle):
				float x =  Cos(angle) * length;
				float y =  Sin(angle) * length;
				Fire( Vector3(x, y, 0), byPlayer,@group);
			}

			actionManager.AddActions(group,CALLBACK(this.bulletNodeRemove));			
	}
	
	void Fire(Vector3 direction, bool byPlayer,ActionGroup @ group)
	{
	

		Node @ bulletNode = CreateRigidBullet(byPlayer);
		bulletNode.rotation =  Quaternion(130, 0, 0);
		bulletNode.SetScale(0.8f);


		StaticModel@ model = bulletNode.CreateComponent("StaticModel");
		model.model = cache.GetResource("Model", "Models/SMWeapon.mdl");
		model.material  = cache.GetResource("Material", "Materials/SMWeapon.xml");

		group.Push(MoveBy(5.0f, direction),bulletNode);
	}
	
	void bulletNodeRemove(ActionID @ actionID)
	{
	//	log.Warning("Joysticks remove");
		actionID.DeleteTargets();
	}
}