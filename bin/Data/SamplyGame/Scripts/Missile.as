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

class Missile : Weapon
{

	Missile()
	{
		ReloadDuration = 3000;
		Damage = 8;
	}
	
	void OnFire(bool player) override
	{
		for (int i = 0; i < 6; i++)
		{
			LaunchSingleMissile( i*0.2f,i % 2 == 0, player: player);
		//	await Node.RunActionsAsync(new DelayTime(0.2f));
		}	
	
	}
	
	void LaunchSingleMissile(float delayLaunchTime,bool left, bool player)
	{
		Node @ carrier = node;
		Vector3  carrierPos = carrier.position;

		Node @ bulletNode = CreateRigidBullet(player);
		bulletNode.position = Vector3(carrierPos.x + 0.7f * (left ? -1 : 1), carrierPos.y + 0.3f, carrierPos.z);
		Node @ bulletModelNode = bulletNode.CreateChild();

		bulletModelNode.scale =  Vector3(1.0f, 2.0f, 1.0f) / 2.5f;
		bulletNode.SetScale(0.3f);

		// Trace-effect using particles	
		ParticleEmitter2D@ particleEmitter = bulletNode.CreateComponent("ParticleEmitter2D");
		ParticleEffect2D@ particleEffect = cache.GetResource("ParticleEffect2D","Particles/MissileTrace.pex");
		particleEmitter.effect = particleEffect;
 
		particleEmitter = bulletNode.CreateComponent("ParticleEmitter2D");
		particleEffect = cache.GetResource("ParticleEffect2D","Particles/Explosion.pex");
		particleEmitter.effect = particleEffect;
	  
	  

		// Route (Bezier)
		float directionY = player ? 1 : -1;
		float directionX = left ? -1 : 1;
		
		BezierConfig	bezierConfig;
		bezierConfig.ControlPoint1 = Vector3(-directionX, 2.0f * directionY, 0);		
		bezierConfig.ControlPoint2 = Vector3(Random(-2, 2) * directionX, 4 * directionY, 0);
		bezierConfig.EndPosition =  Vector3(Random(-1, 1) * directionX, 12 * directionY, 0);
		
		ActionGroup group;
		group.Push(Sequence(DelayTime(delayLaunchTime),BezierBy(1.0f,bezierConfig)),bulletNode);
		//group.Push(BezierBy(1.0f,bezierConfig),bulletNode);
		group.Push(DelayTime(2.0f),bulletNode);
		
		actionManager.AddActions(group,CALLBACK(this.bulletNodeRemove));
		
		
	}
	
	void bulletNodeRemove(ActionID @ actionID)
	{
		actionID.DeleteTargets();
	//	log.Warning("missle remove");
	}
	
	void OnHit(GameObject  @ target, bool killed, Node @ bulletNode) override
	{
		Weapon::OnHit(target, killed, bulletNode);
		Node @ explosionNode = scene.CreateChild();
		
		SoundSource @ soundSource = explosionNode.CreateComponent("SoundSource");
		Sound@ sound = cache.GetResource("Sound", "Sounds/SmallExplosion.wav");
		if (sound !is null)
		{
			soundSource.Play(sound);
			soundSource.gain = 0.2f;
		}
		
		explosionNode.position = target.node.worldPosition;
		explosionNode.SetScale(1.0f);
		
		ParticleEmitter2D @ particleEmitter = explosionNode.CreateComponent("ParticleEmitter2D");
		ParticleEffect2D@ particleEffect = cache.GetResource("ParticleEffect2D", "Particles/MissileTrace.pex");
		particleEmitter.effect = particleEffect;
		
		actionManager.AddAction(Sequence(ScaleTo(0.5f, 0.0f), DelayTime(0.5f)),explosionNode,CALLBACK(this.explosionNodeRemove));
		
	}
	
	void explosionNodeRemove(ActionID @ actionID)
	{
		
		actionID.DeleteTargets();
	}
	

}