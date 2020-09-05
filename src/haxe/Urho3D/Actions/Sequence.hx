package urho3d.actions;

import urho3d.*;
import urho3d.actions.FiniteTimeAction.FiniteTimeActionState;

class Sequence extends FiniteTimeAction {
	public var Actions:Array<FiniteTimeAction> = [];

	/*
		Sequence (FiniteTimeAction @ action1, FiniteTimeAction @ action2)
		{
			super(action1.Duration + action2.Duration);
			InitSequence (action1, action2);
		}
	 */
	public function new(?action1:FiniteTimeAction, ?action2:FiniteTimeAction, ?actions:Array<FiniteTimeAction>) {
		if (action1 != null && action2 != null) {
			super(action1.Duration + action2.Duration);
			InitSequence(action1, action2);
		} else {
			super();

			var prev:FiniteTimeAction = actions[0];

			// Can't call base(duration) because we need to calculate duration here
			var combinedDuration = 0.0;
			for (i in 0...actions.length) {
				combinedDuration += actions[i].Duration;
			}

			Duration = combinedDuration;

			if (actions.length == 1) {
				InitSequence(prev, new ExtraAction());
			} else {
				// Basically what we are doing here is creating a whole bunch of
				// nested Sequences from the actions.
				for (i in 0...actions.length - 1) {
					prev = new Sequence(prev, actions[i]);
				}

				InitSequence(prev, actions[actions.length - 1]);
			}
		}
	}

	public function InitSequence(actionOne:FiniteTimeAction, actionTwo:FiniteTimeAction) {
		Actions.push(actionOne);
		Actions.push(actionTwo);
	}

	public override function StartAction(target:Node) {
		return new SequenceState(this, target);
	}

	public override function Reverse() {
		return new Sequence(Actions[1].Reverse(), Actions[0].Reverse());
	}
}

class SequenceState extends FiniteTimeActionState {
	var last:Int = -1;
	var actionSequences:Array<FiniteTimeAction> = [];
	var actionStates:Array<FiniteTimeActionState> = [];
	// Array<FiniteTimeActionState@>actionStates;
	var split:Float;
	var hasInfiniteAction:Bool = false;

	public function new(action:Sequence, target:Node) {
		super(action, target);
		actionSequences = action.Actions;
		hasInfiniteAction = (actionSequences[0].isRepeatForever == true) || (actionSequences[1].isRepeatForever == true);
		split = actionSequences[0].Duration / Duration;
		last = -1;
	}

	public override function IsDone():Bool {
		if (hasInfiniteAction && actionSequences[last].isRepeatForever == true) {
			return false;
		}

		return Elapsed >= Duration;
	}

	public override function Stop() {
		// Issue #1305
		if (last != -1) {
			actionStates[last].Stop();
		}
	}

	public override function Step(dt:Float) {
		if (last > -1 && (actionSequences[last].isRepeatForever == true)) {
			actionStates[last].Step(dt);
		} else {
			super.Step(dt);
		}
	}

	public override function Update(time:Float) {
		var found:Int;
		var new_t:Float;

		if (time < split) {
			// action[0]
			found = 0;
			if (split != 0)
				new_t = time / split;
			else
				new_t = 1;
		} else {
			// action[1]
			found = 1;
			if (split == 1)
				new_t = 1;
			else
				new_t = (time - split) / (1 - split);
		}

		if (found == 1) {
			if (last == -1) {
				// action[0] was skipped, execute it.
				actionStates[0] = actionSequences[0].StartAction(Target);
				actionStates[0].Update(1.0);
				actionStates[0].Stop();
			} else if (last == 0) {
				actionStates[0].Update(1.0);
				actionStates[0].Stop();
			}
		} else if (found == 0 && last == 1) {
			// Reverse mode ?
			// XXX: Bug. this case doesn't contemplate when _last==-1, found=0 and in "reverse mode"
			// since it will require a hack to know if an action is on reverse mode or not.
			// "step" should be overriden, and the "reverseMode" value propagated to inner Sequences.
			actionStates[1].Update(0);
			actionStates[1].Stop();
		}

		// Last action found and it is done.
		if (found == last && actionStates[found].IsDone()) {
			return;
		}

		// Last action found and it is done
		if (found != last) {
			actionStates[found] = actionSequences[found].StartAction(Target);
		}

		actionStates[found].Update(new_t);
		last = found;
	}
}
