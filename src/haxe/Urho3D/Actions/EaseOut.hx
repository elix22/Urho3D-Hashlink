package urho3d.actions;

import urho3d.Node;
import urho3d.*;
import urho3d.actions.FiniteTimeAction;
import urho3d.actions.EaseRateAction;

class EaseOut extends EaseRateAction
{
	public function new  ( action:FiniteTimeAction,  rate:Float) 
	{
		super(action, rate);
	}

	public override function StartAction ( target:Node) 
	{
		return new  EaseOutState (this, target);
	}

	public override function  Reverse () 
	{
		return  new EaseOut (InnerAction[0].Reverse(), 1 / Rate);
	}
}



class EaseOutState extends EaseRateActionState
{
	public function new  (  action:EaseOut,   target:Node) 
	{
		super(action, target);
	}

	public override function Update (time:Float) 
	{
		InnerActionState.Update(Math.Pow (time, 1 / Rate));      
	}
}