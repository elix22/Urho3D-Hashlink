package actions;

import urho3d.*;
import actions.FiniteTimeAction.FiniteTimeActionState;

class ExtraAction extends FiniteTimeAction {
	public function new() {
		super();
	}

	public override function Reverse() {
		return new ExtraAction();
	}

	public override function StartAction(target:Node) {
		return new ExtraActionState(this, target);
	}
}

class ExtraActionState extends FiniteTimeActionState {
	public function new(action:ExtraAction, target:Node) {
		super(action, target);
	}

	public override function Step(dt:Float) {}

	public override function Update(time:Float) {}
}
