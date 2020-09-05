package urho3d.actions;

import urho3d.actions.ActionEase;
import urho3d.actions.ActionEase.ActionEaseState;
import urho3d.*;
import urho3d.actions.FiniteTimeAction;

	class EaseBackInOut extends ActionEase
	{

		public function new ( action:FiniteTimeAction)
		{
            super(action);
		}


        public override function StartAction (target:Node) 
		{
            return  new EaseBackInOutState (this, target);
		}

		public override function  Reverse () 
		{
			return new  EaseBackInOut (InnerAction[0].Reverse());
		}
	}


	class EaseBackInOutState extends ActionEaseState
	{
        public function new  ( action:EaseBackInOut , target:Node) 
		{
            super(action, target);
		}

		public override function  Update ( time:Float) 
		{
			InnerActionState.Update (  Math.BackInOut(time));
		}
	}