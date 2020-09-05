package samplygame;

import urho3d.actions.*;
import urho3d.actions.ActionManager;
import urho3d.actions.ActionManager.ActionID;
import urho3d.*;
import samplygame.Globals.CollisionLayers;


class EnemySlotMachine extends Enemy
{

	public function new()
	{
        super();
		MaxHealth = 50;
		name = "EnemySlotMachine";
	}
	
	public override function Init() 
	{
		var model:StaticModel = node.CreateComponent("StaticModel");
		model.model = new Model("Models/Enemy2.mdl");
		model.material  = new Material("Materials/Enemy2.xml").Clone("");
		node.scale = Random(0.85, 1.0);
		node.position =  new Vector3(Random(-1.5,1.5), 6.0, 0.0);
		
		// load weapons:
		node.AddLogicComponent(new Joysticks());
		
		super.Init();
	}
}