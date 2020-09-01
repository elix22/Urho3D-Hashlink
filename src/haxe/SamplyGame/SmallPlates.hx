package samplygame;

import actions.*;
import actions.ActionManager;
import actions.ActionManager.ActionID;
import urho3d.*;
import samplygame.Globals.CollisionLayers;

class SmallPlates extends Weapon
{

	public function new ()
	{
        super();
		ReloadDuration = 450;
		Damage = 10;	
	}
	
	public override function OnFire( byPlayer:Bool) 
	{

			var bulletNode = CreateRigidBullet(byPlayer, new Vector3(1.0,1.0,1.0) / 3.0);
			bulletNode.rotation =  new Quaternion(310, 0, 0);
			bulletNode.scale = 1.0;

			var model:StaticModel = bulletNode.CreateComponent("StaticModel");
			model.model = new Model("Models/Enemy3weapon.mdl");
			model.material  = new Material("Materials/Enemy3weapon.xml");
			Launch(bulletNode);	
			
			
	}
	
	function Launch( bulletNode:Node)
	{
		ActionManager.AddAction(new MoveTo(3.0, new Vector3(Random(-6.0, 6.0), -6, 0)),bulletNode,this.bulletNodeRemove);
	}
	
	function bulletNodeRemove(actionID:ActionID)
	{
	//	log.Warning("Small Plates remove");
		actionID.DeleteTargets();
	}
}