package samplygame;

import actions.*;
import actions.ActionManager;
import actions.ActionManager.ActionID;
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
		node.position =  new Vector3(Random(-2.0,2.0), 5.0, 0.0);
		
		// load weapons:
		node.AddLogicComponent(new Joysticks());
		
		super.Init();
	}
}