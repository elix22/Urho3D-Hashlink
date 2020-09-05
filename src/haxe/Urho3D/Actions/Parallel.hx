
package urho3d.actions;

import urho3d.*;
import urho3d.actions.FiniteTimeAction.FiniteTimeActionState;
import urho3d.actions.MoveBy.MoveByState;

class Parallel extends FiniteTimeAction
{
	public var Actions:Array<FiniteTimeAction>  = []  ;

	public function new (  actions:Array<FiniteTimeAction>)
	{
		super();
		// Can't call base(duration) because max action duration needs to be determined here
		var maxDuration = 0.0;
		
		for(i in 0...actions.length)
		{
			if (actions[i].Duration > maxDuration)
			{
				maxDuration = actions[i].Duration;
			}
			
		}
		
	
		Duration = maxDuration;

		Actions = actions;

		for(i in 0...actions.length)
		{
			var actionDuration = Actions[i].Duration;
			if (actionDuration < Duration)
			{
				var tmp_actions:Array<FiniteTimeAction> = [];
				tmp_actions.push(Actions [i]);
				tmp_actions.push(new DelayTime (Duration - actionDuration));
	
                Actions.remove(Actions[i]);
                Actions.insert(i,new Sequence(tmp_actions));
			}
		}
	}
	
	public override function StartAction(target:Node)
	{
		return new ParallelState (this, target);
	}

	public override function  Reverse () 
	{
        var rev:Array<FiniteTimeAction> = [];
        
		for (i in 0...Actions.length)
		{
			rev[i] = Actions [i].Reverse();
		}

		return  new Parallel (rev);
	}
}

class ParallelState extends FiniteTimeActionState
{

	var Actions:Array<FiniteTimeAction>  = []  ;

	var ActionStates:Array<FiniteTimeActionState> = [];

	public function new (action:Parallel , target:Node)
	{  
		super (action, target);	
        Actions = action.Actions;
		ActionStates.resize(Actions.length);

		for (i in 0...Actions.length)
		{
			ActionStates[i] = Actions[i].StartAction (target);
		}
	}

	public override function Stop () 
	{
		for (i in 0...Actions.length)
		{
			ActionStates[i].Stop ();
		}
		
		super.Stop();
	}

	
	public override function  Update ( time:Float) 
	{
		for (i in 0...Actions.length)
		{
			ActionStates[i].Update(time);
		}
	}
}