
package urho3d.actions;

import urho3d.*;
import urho3d.actions.FiniteTimeAction.FiniteTimeActionState;

class DelayTime extends FiniteTimeAction
{

	public function new ( duration:Float) 
	{
		super(duration);
	}


	public override function StartAction ( target:Node ) 
	{
		return  new DelayTimeState (this, target);

	}

	public override function  Reverse () 
	{
		return  new DelayTime (Duration);
	}
}

class DelayTimeState extends FiniteTimeActionState
{

	public function new (  action:DelayTime,  target:Node)
	{
		super(action, target);
	}

	public override function  Update ( time:Float) 
	{
	}
}