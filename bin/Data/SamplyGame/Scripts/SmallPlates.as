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

class SmallPlates : Weapon
{

	SmallPlates()
	{
		ReloadDuration = 450;
		Damage = 10;	
	}
	
	void OnFire(bool byPlayer) override
	{

			Node @ bulletNode = CreateRigidBullet(byPlayer, Vector3(1.0f,1.0f,1.0f) / 3.0f);
			bulletNode.rotation =  Quaternion(310, 0, 0);
			bulletNode.SetScale(1.0f);

			StaticModel@ model = bulletNode.CreateComponent("StaticModel");
			model.model = cache.GetResource("Model", "Models/Enemy3weapon.mdl");
			model.material  = cache.GetResource("Material", "Materials/Enemy3weapon.xml");
			Launch(bulletNode);	
			
			
	}
	
	void Launch(Node @ bulletNode)
	{
		actionManager.AddAction(MoveTo(3.0f, Vector3(Random(-6.0f, 6.0f), -6, 0)),bulletNode,CALLBACK(this.bulletNodeRemove));
	}
	
	void bulletNodeRemove(ActionID @ actionID)
	{
	//	log.Warning("Small Plates remove");
		actionID.DeleteTargets();
	}
}