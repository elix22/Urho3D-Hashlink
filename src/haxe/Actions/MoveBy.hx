package actions;

import urho3d.*;
import actions.FiniteTimeAction.FiniteTimeActionState;

class MoveBy extends FiniteTimeAction {
	public var PositionDelta:Vector3;

	public function new(duration:Float, position:Vector3) {
		super(duration);
		PositionDelta = position;
	}

	public override function StartAction(target:Node) {
		return new MoveByState(this, target);
	}

	public override function Reverse() {
		return new MoveBy(Duration, new Vector3(-PositionDelta.x, -PositionDelta.y, -PositionDelta.z));
	}
}

class MoveByState extends FiniteTimeActionState {
	var PositionDelta:Vector3;
	var EndPosition:Vector3;
	var StartPosition:Vector3;
	var PreviousPosition:Vector3;

	public function new(action:MoveBy, tar:Node) {
		super(action, tar);
		PositionDelta = action.PositionDelta;
		PreviousPosition = tar.position;
		StartPosition = tar.position;
	}

	public override function Step(dt:Float) {
		if (firstTick) {
			firstTick = false;
			elapsed = 0.0;
		} else {
			elapsed += dt;
		}

		Update(Math.Max(0.0, Math.Min(1.0, elapsed / Math.Max(Duration, 0.0000001))));
	}

	public override function Update(time:Float) {
		if (Target == null)
			return;

		var currentPos = Target.position;
		var diff = currentPos - PreviousPosition;
		StartPosition = StartPosition + diff;
		var newPos = StartPosition + PositionDelta * time;
		Target.position = newPos;
		PreviousPosition = newPos;
	}
}
