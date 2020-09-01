package samplygame;

import actions.*;
import actions.ActionManager;
import actions.ActionManager.ActionID;
import urho3d.*;
import samplygame.Globals.CollisionLayers;


class Enemy extends Aircraft
{

	public function new()
	{
        super();
		CollisionLayer = CollisionLayers.Enemy;
	}
	
	public override function Init() 
	{
		ActionManager.AddAction( new MoveBy(0.6, new Vector3(0, -2, 0)),node,this.InitializedDone);	
	}
	
	public function InitializedDone( actionID)
	{
		MoveRandomly(1,  2,  -3,  3,  1.5);
		StartShooting();	
	}
	
	public function  StartShooting()
	{
		
		if(IsAlive())
		{
            var weapons = node.GetLogicComponents(Weapon);

            for (weapon in weapons) {
                weapon.FireAsync(false);
            }
			
			ActionManager.AddAction( new DelayTime(Random(0.1, 0.5)),node,this.ShootingLoop);	
		}		
	}
	
	public function  ShootingLoop( actionID:ActionID)
	{
		if(IsAlive())
		{
			StartShooting();
		}		
	}
	
	public function  MoveRandomly( minX:Float,  maxX:Float,  minY:Float,  maxY:Float,  duration:Float)
	{
		if(IsAlive())
		{
			var  moveAction:FiniteTimeAction = new MoveBy(duration, new Vector3(Random(minX, maxX), Random(minY, maxY), 0));
			ActionManager.AddAction(new Sequence(moveAction, moveAction.Reverse()),node,this.MoveRandomLoop);
		}
	}
	
	public function  MoveRandomLoop( actionID:ActionID)
	{
		if(IsAlive())
		{
			MoveRandomly(1, 2, -3,  3,  1.5);
		}
	}
	
	public override function Update( timeStep:Float) 
	{
		//Base class  must be called first
		super.Update(timeStep);

		node.LookAt(new Vector3(0, -3, 0),  new Vector3(0, 1, -1), TS_WORLD);
		
	}
	
}