package actions;

import urho3d.*;
import actions.FiniteTimeAction.FiniteTimeActionState;
import actions.MoveBy.MoveByState;

class MoveTo extends MoveBy {

    var EndPosition:Vector3;


	public function new (duration:Float,  position:Vector3) 
	{
		super(duration, position);
		EndPosition = position;
	}


	public var PositionEnd (get,never):Vector3;

	function	get_PositionEnd() { return EndPosition; }
	

	public override function StartAction (target:Node) 
	{
		return  new MoveToState (this, target);
	}
}

class MoveToState extends MoveByState
{
	public function new  ( action:MoveTo, target:Node)
	{ 
		super(action, target);
		StartPosition = target.position;
		PositionDelta = action.PositionEnd - target.position;
		
	}

	public override function Update ( time:Float) 
	{
        
		if (Target != null)
		{
			var newPos = StartPosition + PositionDelta * time;
			Target.position = newPos;
			PreviousPosition = newPos;
        }
        
	}
}