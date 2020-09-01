package samplygame;

import actions.*;
import actions.ActionManager;
import actions.ActionManager.ActionID;
import urho3d.*;
import samplygame.Globals.CollisionLayers;

class Joysticks extends Weapon
{
	public function new()
	{
        super();
		ReloadDuration = 2000;
		Damage = 10;	
	}
	
	public override function OnFire( byPlayer:Bool) 
	{
			final joysticksCount = 12;
			final length = 10.0;

			var group = new ActionGroup();
			for (i in 0...joysticksCount)
			{
				var angle = (360.0 / joysticksCount * i); //angle per joystick (in radians)
				//x^2 + y^2 = length^2 (Equation of Circle):
				var x =  Math.Cos(angle) * length;
				var y = Math.Sin(angle) * length;
				Fire( new Vector3(x, y, 0), byPlayer,group);
			}

			ActionManager.AddActions(group,this.bulletNodeRemove);			
	}
	
	function Fire( direction:Vector3,  byPlayer:Bool,  group:ActionGroup)
	{
	

		var bulletNode = CreateRigidBullet(byPlayer);
		bulletNode.rotation = new TQuaternion(130, 0, 0);
		bulletNode.scale = 0.8;


		var model:StaticModel = bulletNode.CreateComponent("StaticModel");
		model.model = new Model("Models/SMWeapon.mdl");
		model.material  = new Material("Materials/SMWeapon.xml");

		group.Push(new MoveBy(5.0, direction),bulletNode);
	}
	
	function bulletNodeRemove( actionID:ActionID)
	{
	//	log.Warning("Joysticks remove");
		actionID.DeleteTargets();
	}
}