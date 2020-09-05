package samplygame;

import urho3d.actions.ActionManager;
import samplygame.Globals.CollisionLayers;
import urho3d.actions.ActionManager.ActionID;
import urho3d.*;
import urho3d.actions.*;

class MachineGun extends Weapon
{
	public var GunOffsetSize:Float = 0.2; //accuracy (lower - better)
	public var  currentGunOffset = -0.2;
	var soundSource:SoundSource  = null;
	
	public function new()
	{
        super();
		ReloadDuration = 50;
		Damage = 3;
	}
	
	
	public override function OnFire( player:Bool) 
	{
		currentGunOffset += GunOffsetSize;
		if (currentGunOffset > GunOffsetSize)
			currentGunOffset = -GunOffsetSize;	
			
		var bulletNode = CreateRigidBullet(player);
		bulletNode.Translate( new TVector3(currentGunOffset, 0, 0), TS_LOCAL);
		
		var model:StaticModel = bulletNode.CreateComponent("StaticModel");
		model.model = new Model("Models/Box.mdl");
		model.material  = new Material("Materials/MachineGun.xml");
		
		bulletNode.LookAt( new TVector3(bulletNode.worldPosition.x, 10, -10),  new TVector3(0, 1, -1), TS_WORLD);
		bulletNode.Rotate( new TQuaternion(0, 45, 0), TS_LOCAL);
		bulletNode.scale =  new TVector3(0.1, 0.3, 0.1);
		
		 var sound:Sound = new Sound("Sounds/MachineGun.wav");
		if (sound != null)
		{
			soundSource.Play(sound);
			// In case we also play music, set the sound volume below maximum so that we don't clip the output
			//soundSource.gain = 0.5f;
			// Set the sound component to automatically remove its scene node from the scene when the sound is done playing
			//soundSource.autoRemove = true;
		}
		
		 var moveAction:FiniteTimeAction = new MoveBy(0.7,  new TVector3(0, 10, 0) * (player ? 1 : -1));
         ActionManager.AddAction( moveAction,bulletNode,this.bulletNodeRemove);
		
	}
	
	public function bulletNodeRemove( actionID:ActionID)
	{
		//log.Warning("bulletNodeRemove !!");
		actionID.DeleteTargets();
	}
	
	public override function Init() 
	{
		//log.Warning("MachineGun initialized !!");
		soundSource = node.CreateComponent("SoundSource");
		soundSource.gain = 0.1;
	}
}