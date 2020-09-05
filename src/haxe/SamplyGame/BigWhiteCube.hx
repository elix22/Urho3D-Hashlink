package samplygame;

import urho3d.actions.BezierBy.BezierConfig;
import urho3d.actions.*;
import urho3d.actions.ActionManager;
import urho3d.actions.ActionManager.ActionID;
import urho3d.*;
import samplygame.Globals.CollisionLayers;

class BigWhiteCube extends Weapon
{
	public function new()
	{
        super();
		ReloadDuration = 3000;
		Damage = 20;	
	}
	
	public override function OnFire( player:Bool) 
	{
		var  bulletNode = CreateRigidBullet(player);
		var bulletModelNode = bulletNode.CreateChild();
		
		var model:StaticModel = bulletModelNode.CreateComponent("StaticModel");
		model.model = new Model("Models/Box.mdl");
		
		bulletModelNode.scale = 2.0;
		bulletModelNode.Rotate( new TQuaternion(45, 0, 0), TS_LOCAL);
		bulletNode.scale = Random(0.15, 0.2);	

		var trace = bulletNode.CreateChild();
		trace.scale = 2.0;	
		var particleEmitter:ParticleEmitter2D = trace.CreateComponent("ParticleEmitter2D");
		var particleEffect:ParticleEffect2D = new ParticleEffect2D("Particles/Explosion.pex");
		particleEmitter.effect = particleEffect;

		var direction = player ? 1 : -1;
		var	bezierConfig=new BezierConfig();
		bezierConfig.ControlPoint1 = new Vector3(0, 3.0 * direction, 0);		
		bezierConfig.ControlPoint2 = new Vector3(Random(-3.0, 3.0), 5 * direction, 0);
		bezierConfig.EndPosition =  new Vector3(0, 12 * direction, 0);	


		var group = new ActionGroup();
		group.Push( new RotateBy(3.0, 0, 1000, 0),bulletModelNode);		
		 var moveMissileAction =  new BezierBy(4.0,bezierConfig);
		group.Push(new Sequence(moveMissileAction, new DelayTime(5.0)),bulletNode);
		
		// callback to be called once the action is complete.
		ActionManager.AddActions(group,this.bulletNodeRemove);
			
	}
	
	public function bulletNodeRemove( actionID:ActionID)
	{
		//log.Warning("BigWhiteCube remove");
		actionID.DeleteTargets();
	}
	
	public override function OnHit( target:LogicComponent,  killed:Bool,  bulletNode:Node)
	{
		//log.Warning("BigWhiteCube OnHit");
	}

}