package urho3d;

class Controls {
	public inline function new() {
		buttons = 0;
		yaw = 0.0;
		pitch = 0.0;
		extraData = new VariantMap();
	}

	public  inline function Set(b:Int, down:Bool = true) {
		if (down) {
			buttons |= b;
		} else {
			buttons &= ~b;
		}
	}

	public inline function IsDown(button:Int):Bool {
		//trace("IsDown " + buttons + ":" +button);
		return (buttons & button) != 0;
	}

	public inline function IsPressed(button:Int, previousControls:Controls):Bool {
		return (buttons & button) != 0 && (previousControls.buttons & button) == 0;
	}

	public inline function Reset() {
		buttons = 0;
		yaw = 0.0;
		pitch = 0.0;
		extraData.Clear();
	}

	/// Button state.
	public var buttons:Int = 0;
	/// Mouse yaw.
	public var yaw:Float = 0.0;
	/// Mouse pitch.
	public var pitch:Float = 0.0;

	public var extraData:VariantMap = null;
}
