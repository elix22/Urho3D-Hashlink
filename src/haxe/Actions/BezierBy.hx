package actions;

import urho3d.*;
import actions.FiniteTimeAction.FiniteTimeActionState;

class BezierConfig {
	public function new() {}

	public var ControlPoint1:Vector3;
	public var ControlPoint2:Vector3;
	public var EndPosition:Vector3;
}

class BezierBy extends FiniteTimeAction {
    
    public var bezierConfig:BezierConfig;

	public function new(t:Float, config:BezierConfig) {
		super(t);
		bezierConfig = config;
	}

	public override function StartAction(target:Node) {
		return new BezierByState(this, target);
	}

	public override function Reverse() {
		var r:BezierConfig = new BezierConfig();

		r.EndPosition = -bezierConfig.EndPosition;
		r.ControlPoint1 = bezierConfig.ControlPoint2 + -bezierConfig.EndPosition;
		r.ControlPoint2 = bezierConfig.ControlPoint1 + -bezierConfig.EndPosition;

		return new BezierBy(Duration, r);
	}
}

class BezierByState extends FiniteTimeActionState {
	var bezierConfig:BezierConfig;

	var StartPosition:Vector3;

	var PreviousPosition:Vector3;

	public function new(action:BezierBy, target:Node) {
		super(action, target);
		bezierConfig = action.bezierConfig;
		PreviousPosition = target.position;
		StartPosition = target.position;
	}

	public override function Update(time:Float) {
		if (Target != null) {
			var xa = 0;
			var xb = bezierConfig.ControlPoint1.x;
			var xc = bezierConfig.ControlPoint2.x;
			var xd = bezierConfig.EndPosition.x;

			var ya = 0;
			var yb = bezierConfig.ControlPoint1.y;
			var yc = bezierConfig.ControlPoint2.y;
			var yd = bezierConfig.EndPosition.y;

			var za = 0;
			var zb = bezierConfig.ControlPoint1.z;
			var zc = bezierConfig.ControlPoint2.z;
			var zd = bezierConfig.EndPosition.z;

			var x = Math.CubicBezier(xa, xb, xc, xd, time);
			var y = Math.CubicBezier(ya, yb, yc, yd, time);
			var z = Math.CubicBezier(za, zb, zc, zd, time);

			var currentPos = Target.position;
			var diff = currentPos - PreviousPosition;
			StartPosition = StartPosition + diff;

			var newPos = StartPosition + new Vector3(x, y, z);
			Target.position = newPos;

			PreviousPosition = newPos;
		}
	}
}
