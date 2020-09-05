package urho3d.actions;

import urho3d.*;
import urho3d.actions.FiniteTimeAction.FiniteTimeActionState;

class ScaleTo extends FiniteTimeAction
{
	 public var  EndScaleX:Float ;
	 public var  EndScaleY:Float  ;
	 public var  EndScaleZ:Float  ;


	public function new  ( _duration:Float,  scaleX:Float,  ?scaleY:Float,  ?scaleZ:Float)
	{
		super(_duration);
		EndScaleX = scaleX;
		EndScaleY = (scaleY==null)?scaleX:scaleY;
		EndScaleZ = (scaleZ==null)?scaleX:scaleZ;
	}


	public override function Reverse () 
	{
		return new ScaleTo (duration, EndScaleX);
	}

	public override function StartAction (target:Node  ) 
	{
		return  new ScaleToState (this, target);
	}
}


class ScaleToState extends FiniteTimeActionState
{
	 var  DeltaX:Float;
	 var  DeltaY:Float;
	 var  DeltaZ:Float;
	 var  EndScaleX:Float;
	 var  EndScaleY:Float;
	 var  EndScaleZ:Float;
	 var  StartScaleX:Float;
	 var  StartScaleY:Float;
	 var  StartScaleZ:Float;

	public function new (  action:ScaleTo,  target:Node )
	{
		super(action, target);

		StartScaleX = target.scale.x;
		StartScaleY = target.scale.y;
		StartScaleZ = target.scale.z;
		EndScaleX = action.EndScaleX;
		EndScaleY = action.EndScaleY;
		EndScaleZ = action.EndScaleZ;
		DeltaX = EndScaleX - StartScaleX;
		DeltaY = EndScaleY - StartScaleY;
		DeltaZ = EndScaleZ - StartScaleZ;
	}

	public override function Update ( time:Float) 
	{
		if (Target != null)
		{
			Target.scale =  new TVector3(StartScaleX + DeltaX * time, StartScaleY + DeltaY * time, StartScaleZ + DeltaZ * time);
		}
	}
}