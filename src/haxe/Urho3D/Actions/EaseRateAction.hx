package urho3d.actions;

import urho3d.*;
import urho3d.actions.FiniteTimeAction.FiniteTimeActionState;
import urho3d.actions.ActionEase.ActionEaseState;


class EaseRateAction extends ActionEase
{
	 public var Rate:Float ;

     public function new ( action:FiniteTimeAction,rate:Float) 
	{
		super(action);
		Rate = rate;
	}



	public override function  StartAction ( target:Node ) 
	{
		return  new EaseRateActionState (this, target);
	}

	public override function  Reverse () 
	{
		return new EaseRateAction (InnerAction[0].Reverse (), 1 / Rate);
	}
}


class EaseRateActionState extends ActionEaseState
{
	var Rate:Float ;

    public function new ( action:EaseRateAction, target:Node ) 
	{
		super(action, target);
		Rate = action.Rate;
	}

	public override function  Update ( time:Float) 
	{
		InnerActionState.Update (Math.ExponentialOut (time));
	}
}