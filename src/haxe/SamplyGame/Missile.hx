package samplygame;

import actions.BezierBy.BezierConfig;
import actions.ActionManager;
import samplygame.Globals.CollisionLayers;
import actions.ActionManager.ActionID;
import urho3d.*;
import actions.*;

class Missile extends Weapon
{

	public function new ()
	{
        super();
		ReloadDuration = 3000;
		Damage = 8;
	}
	
	public override function OnFire( player:Bool) 
	{
		for(i in 0...6)
		{
			LaunchSingleMissile( i*0.2,i % 2 == 0,  player);

		}	
	
	}
	
	public function LaunchSingleMissile( delayLaunchTime:Float, left:Bool,  player:Bool)
	{
		var carrier = node;
		var  carrierPos = carrier.position;

		var bulletNode = CreateRigidBullet(player);
		bulletNode.position = new TVector3(carrierPos.x + 0.7 * (left ? -1 : 1), carrierPos.y + 0.3, carrierPos.z);
		var bulletModelNode = bulletNode.CreateChild();

		bulletModelNode.scale = new TVector3(1.0, 2.0, 1.0) / 2.5;
		bulletNode.scale = 0.3;

		// Trace-effect using particles	
		var particleEmitter:ParticleEmitter2D = bulletNode.CreateComponent("ParticleEmitter2D");
		var particleEffect = new ParticleEffect2D("Particles/MissileTrace.pex");
		particleEmitter.effect = particleEffect;
 
		var particleEmitter:ParticleEmitter2D = bulletNode.CreateComponent("ParticleEmitter2D");
		particleEffect = new ParticleEffect2D("Particles/Explosion.pex");
		particleEmitter.effect = particleEffect;
	  
	  

		// Route (Bezier)
		var directionY = player ? 1 : -1;
		var directionX = left ? -1 : 1;
		
		var	bezierConfig:BezierConfig = new BezierConfig();
		bezierConfig.ControlPoint1 = new TVector3(-directionX, 2.0 * directionY, 0);		
		bezierConfig.ControlPoint2 = new TVector3(Random(-2, 2) * directionX, 4 * directionY, 0);
		bezierConfig.EndPosition =  new TVector3(Random(-1, 1) * directionX, 12 * directionY, 0);
		
		var group:ActionGroup = new ActionGroup();
		group.Push(new Sequence(new DelayTime(delayLaunchTime),new BezierBy(1.0,bezierConfig)),bulletNode);
		//group.Push(BezierBy(1.0f,bezierConfig),bulletNode);
		group.Push(new DelayTime(2.0),bulletNode);
		
		ActionManager.AddActions(group,this.bulletNodeRemove);
		
		
	}
	
	public function bulletNodeRemove( actionID:ActionID )
	{
		actionID.DeleteTargets();
	//	log.Warning("missle remove");
	}
	
	public override function OnHit(target:LogicComponent, killed:Bool, bulletNode:Node)
	{
		super.OnHit(target, killed, bulletNode);
		var explosionNode = scene.CreateChild();
		
		var soundSource:SoundSource = explosionNode.CreateComponent("SoundSource");
		var sound = new Sound("Sounds/SmallExplosion.wav");
		if (sound != null)
		{
			soundSource.Play(sound);
			soundSource.gain = 0.2;
		}
		
		explosionNode.position = target.node.worldPosition;
		explosionNode.scale = 1.0;
		
		var particleEmitter:ParticleEmitter2D = explosionNode.CreateComponent("ParticleEmitter2D");
		var particleEffect = new ParticleEffect2D("Particles/MissileTrace.pex");
		particleEmitter.effect = particleEffect;
		
		ActionManager.AddAction(new Sequence(new ScaleTo(0.5, 0.0), new DelayTime(0.5)),explosionNode,this.explosionNodeRemove);
		
	}
	
	public function explosionNodeRemove( actionID:ActionID)
	{
		
		actionID.DeleteTargets();
	}
	

}