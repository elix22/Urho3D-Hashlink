package urho3d.actions;

import urho3d.*;
import urho3d.actions.FiniteTimeAction.FiniteTimeActionState;
import urho3d.actions.ActionEase.ActionEaseState;
import urho3d.actions.EaseRateAction.EaseRateActionState;

class EaseIn extends EaseRateAction
{

	public function new  ( action:FiniteTimeAction, rate:Float) 
	{
		super(action, rate);
	}


	public override function  StartAction (target:Node  ) 
	{
		return  new EaseInState (this, target);
	}

	public override function  Reverse () 
	{
		return new  EaseIn (InnerAction[0].Reverse (), 1 / Rate);
	}
}




class EaseInState extends EaseRateActionState
{
	public function new  ( action:EaseIn, target:Node ) 
	{
		super(action, target);
	}

	public override function   Update ( time:Float) 
	{
		InnerActionState.Update (Math.Pow (time, Rate));
	}
}