package actions;

import urho3d.Node;
import urho3d.Bone;

class FiniteTimeAction {
	private var duration:Float = 0.0;

	var Tag:Int = -1;
	public var isRepeatForever:Bool = false;

	public var Duration(get, set):Float;

	public function new(duration:Float = 0.0000001) {
		Duration = duration;
		isRepeatForever = false;
	}

	function set_Duration(value) {
		{
			var newDuration:Float = value;

			// Prevent division by 0
			if (newDuration == 0) {
				newDuration = 0.0000001;
			}

			duration = newDuration;
			return duration;
		}
	}

	function get_Duration() {
		return duration;
	}

	public function Reverse() {
		return this;
	}

	public function StartAction(target:Node) {
		return new FiniteTimeActionState(this, target);
	}
}

class FiniteTimeActionState {
	public var firstTick:Bool = false;
	public var Duration:Float = 0.0;
	public var elapsed:Float = 0.0;
	public var Target:Node = null;
	public var OriginalTarget:Node = null;

	var Action:Array<FiniteTimeAction> = new Array<FiniteTimeAction>();

	public var Elapsed(get, never):Float;

	inline function get_Elapsed() {
		return elapsed;
	}

	public function IsDone():Bool {
		return elapsed >= Duration || Target == null;
	}

	public function new(action:FiniteTimeAction, target:Node) {
		Action.push(action);
		Target = target;
		OriginalTarget = target;
		Duration = action.Duration;
		elapsed = 0.0;
		firstTick = true;
	}

	public function Update(time:Float) {}

	public function Step(dt:Float) {
		// log.Warning("Step");
		if (firstTick) {
			firstTick = false;
			elapsed = 0.0;
		} else {
			elapsed += dt;
		}

		Update(Math.max(0.0, Math.min(1.0, elapsed / Math.max(Duration, 0.0000001))));
	}

	public function Stop() {
		Target = null;
	}
}
