package actions;

import urho3d.*;
import actions.FiniteTimeAction.FiniteTimeActionState;

class RotateBy extends FiniteTimeAction {
	public var AngleX:Float;
	public var AngleY:Float;
	public var AngleZ:Float;

	public function new(duration:Float, deltaAngleX:Float, ?deltaAngleY:Float, ?deltaAngleZ:Float) {
		super(duration);
		AngleX = deltaAngleX;
		if (deltaAngleY == null)
			AngleY = deltaAngleX;
		else
			AngleY = deltaAngleY;

		if (deltaAngleZ == null)
			AngleZ = deltaAngleX;
		else
			AngleZ = deltaAngleZ;
	}

	public override function StartAction(target:Node) {
		return new RotateByState(this, target);
	}

	public override function Reverse() {
		return new RotateBy(Duration, -AngleX, -AngleY, -AngleZ);
	}
}

class RotateByState extends FiniteTimeActionState {
	var StartAngles:Quaternion;
	var AngleX:Float;
	var AngleY:Float;
	var AngleZ:Float;

	public function new(action:RotateBy, target:Node) {
		super(action, target);
		AngleX = action.AngleX;
		AngleY = action.AngleY;
		AngleZ = action.AngleZ;
		StartAngles = target.rotation;
	}

	public override function Step(dt:Float) {
		// log.Warning("Step");
		if (firstTick) {
			firstTick = false;
			elapsed = 0.0;
		} else {
			elapsed += dt;
		}

		Update(Math.Max(0.0, Math.Min(1.0, Elapsed / Math.Max(Duration, 0.0000001))));
	}

	public override function Update(time:Float) {
		if (Target != null) {
            // use TQuaternion instead of Quaternion to boost perfomance
			var newRot:TQuaternion = Target.rotation * new TQuaternion(AngleX * time, AngleY * time, AngleZ * time);
			newRot.Normalize();
			Target.rotation = newRot;
		}
	}
}
