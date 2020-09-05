package urho3d.actions;

import urho3d.*;
import urho3d.actions.FiniteTimeAction.FiniteTimeActionState;

class RepeatForever extends FiniteTimeAction {
	public var InnerAction:Array<FiniteTimeAction> = new Array<FiniteTimeAction>();

	public function new(action:FiniteTimeAction) {
		super();
		InnerAction.push(action);
		isRepeatForever = true;
	}

	public override function StartAction(target:Node) {
		return new RepeatForeverState(this, target);
	}

	public override function Reverse() {
		return new RepeatForever(InnerAction[0].Reverse());
	}
}

class RepeatForeverState extends FiniteTimeActionState {
	var InnerActionState:FiniteTimeActionState;
	var InnerAction:Array<FiniteTimeAction> = new Array<FiniteTimeAction>();

	public function new(action:RepeatForever, target:Node) {
		super(action, target);
		InnerAction.push(action.InnerAction[0]);
		InnerActionState = action.InnerAction[0].StartAction(target);
	}

	public override function Step(dt:Float) {
		// log.Warning("Step");
		InnerActionState.Step(dt);
		if (InnerActionState.IsDone()) {
			var diff = InnerActionState.Elapsed - InnerActionState.Duration;
			InnerActionState = InnerAction[0].StartAction(Target);
			InnerActionState.Step(0.0);
			InnerActionState.Step(diff);
		}
	}

	public override function IsDone():Bool {
		return false;
	}
}
