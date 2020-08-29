package actions;

import urho3d.*;
import actions.FiniteTimeAction.FiniteTimeActionState;

class ActionEase extends FiniteTimeAction
{
	public var InnerAction:Array<FiniteTimeAction > = [];
	 public function new (  action:FiniteTimeAction) 
	{
	    super(action.Duration);
		InnerAction.push(action);
	}



	public override function StartAction ( target:Node) 
	{
		return  new ActionEaseState (this, target);
	}

	public override function  Reverse ()
	{
		return  new ActionEase (InnerAction[0].Reverse ());
	}
}



class ActionEaseState extends FiniteTimeActionState
{
	var InnerActionState:FiniteTimeActionState ;

    public function new  ( action:ActionEase, target:Node ) 
	{
		super(action, target);
		InnerActionState = action.InnerAction[0].StartAction (target);
	}

	public override function  Stop () 
	{
		InnerActionState.Stop ();
		super.Stop ();
	}

	public override function  Update ( time:Float) 
	{
		InnerActionState.Update (time);
	}
}