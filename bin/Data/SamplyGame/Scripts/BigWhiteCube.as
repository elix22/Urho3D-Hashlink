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

class BigWhiteCube : Weapon
{
	BigWhiteCube()
	{
		ReloadDuration = 3000;
		Damage = 20;	
	}
	
	void OnFire(bool player) override
	{
		Node @ bulletNode = CreateRigidBullet(player);
		Node @ bulletModelNode = bulletNode.CreateChild();
		
		StaticModel@ model = bulletModelNode.CreateComponent("StaticModel");
		model.model = cache.GetResource("Model", "Models/Box.mdl");
		
		bulletModelNode.SetScale(2.0f);
		bulletModelNode.Rotate( Quaternion(45, 0, 0), TS_LOCAL);
		bulletNode.SetScale(Random(0.15f, 0.2f));	

		Node @ trace = bulletNode.CreateChild();
		trace.SetScale(2.0f);	
		ParticleEmitter2D@ particleEmitter = trace.CreateComponent("ParticleEmitter2D");
		ParticleEffect2D@ particleEffect = cache.GetResource("ParticleEffect2D","Particles/Explosion.pex");
		particleEmitter.effect = particleEffect;

		float direction = player ? 1 : -1;
		BezierConfig	bezierConfig;
		bezierConfig.ControlPoint1 = Vector3(0, 3.0f * direction, 0);		
		bezierConfig.ControlPoint2 = Vector3(Random(-3.0f, 3.0f), 5 * direction, 0);
		bezierConfig.EndPosition =  Vector3(0, 12 * direction, 0);	


		ActionGroup group;
		group.Push( RotateBy(3.0f, 0, 1000, 0),bulletModelNode);		
		FiniteTimeAction @ moveMissileAction = BezierBy(4.0f,bezierConfig);
		group.Push(Sequence(moveMissileAction, DelayTime(5.0f)),bulletNode);
		
		// callback to be called once the action is complete.
		actionManager.AddActions(group,CALLBACK(this.bulletNodeRemove));
			
	}
	
	void bulletNodeRemove(ActionID @ actionID)
	{
		//log.Warning("BigWhiteCube remove");
		actionID.DeleteTargets();
	}
	
	void OnHit(GameObject  @ target, bool killed, Node @ bulletNode) override
	{
		//log.Warning("BigWhiteCube OnHit");
	}

}
