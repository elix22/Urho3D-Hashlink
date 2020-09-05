package samplygame;

import urho3d.actions.*;
import urho3d.actions.ActionManager;
import urho3d.actions.ActionManager.ActionID;
import urho3d.*;
import samplygame.Globals.CollisionLayers;


class EnemyMonitorScreen extends Enemy
{
	var fromLeftSide:Bool;

	public function new(_fromLeftSide:Bool=false)
	{
        //log.Warning("EnemyMonitorScreen()");
        super();
        fromLeftSide = _fromLeftSide;
		name = "EnemyMonitorScreen";
		MaxHealth = 80;
		CollisionShapeSize  = new Vector3(1,1,1) / 2.0;
	}
	


	public override function Init() 
	{
       // log.Warning("EnemyMonitorScreen::Init");
		var model:StaticModel = node.CreateComponent("StaticModel");
		model.model = new Model("Models/Enemy3.mdl");
		model.material  = new Material("Materials/Enemy3.xml").Clone();
		node.scale = 1.0;

		// load weapons:	
		node.AddLogicComponent(new SmallPlates());
		
		var direction = fromLeftSide ? -1 : 1;
		node.position =  new Vector3(3 * direction, 3, 0);
		ActionManager.AddAction(new MoveTo(0.5, new Vector3(1.1 * direction, 2.0, 0)),node,this.StartMoveRandomLoop);
	}
	
	function StartMoveRandomLoop( actionID:ActionID)
	{
		//log.Warning("EnemyMonitorScreen::StartMoveRandomLoop ");
		MoveRandomly( -0.3, 0.3,  -0.3,  0.3,  1.0);
		StartShooting();
		
	}
}