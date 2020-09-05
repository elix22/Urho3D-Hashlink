package samplygame;

import haxe.extern.AsVar;
import urho3d.actions.*;
import urho3d.actions.ActionManager;
import urho3d.actions.ActionManager.ActionID;
import urho3d.*;
import samplygame.Globals.CollisionLayers;

class EnemyBat extends Enemy
{

	public function new()
	{
        super();
		MaxHealth = 30;
		name = "EnemyBat";
	}

	/*
	void DelayedStart()
	{
		log.Warning("EnemyBat::DelayedStart ");
		Play();
	}
	*/
	
	public override function  Init() 
	{
		var model:StaticModel = node.CreateComponent("StaticModel");
		model.model = new Model("Models/Enemy1.mdl");
		model.material  = new Material("Materials/Enemy1.xml").Clone("");
		node.scale = Random(0.5, 0.8);
		node.position =  new Vector3(Random(-1.5,1.5), 7.0, 0.0);
		
		
		// load weapons:	
		node.AddLogicComponent(new BigWhiteCube());
		
        var fb = Random(1);
		var b = (fb > 0.5) ? 1:0;
		node.position = new Vector3(3 * ((b == 1) ? 1 : -1), Random(0, 2), 0);
		ActionManager.AddAction(new MoveTo(1.0, new Vector3(Random(-2, 2), Random(2, 4), 0)),node,this.StartMoveRandomLoop);
	
		//actionManager.AddAction(MoveTo(5.0f, Vector3(Random(-2, 2), Random(2, 4), 0)),node,CALLBACK(this.RemoveTargets));
	//	StartShooting();
	}
	
	public function StartMoveRandomLoop( actionID:ActionID)
	{
		//log.Warning("EnemyBat::StartMoveRandomLoop ");
		MoveRandomly( -2.0,  2.0,  -1.0,  1.0,  0.5);
		StartShooting();
		
	}
	
	public function RemoveTargets( actionID:ActionID)
	{
		actionID.DeleteTargets();
	}

}