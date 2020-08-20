package utils;

import urho3d.*;

class Rotator extends LogicComponent {
	private var rotationSpeed:Vector3 = new Vector3();
	
	public var testString:String = "Hi Eli this is a test string";
	public var SomeVector2:Vector2 = new Vector2();
	public var SomeIntVector2:IntVector2 = new IntVector2();
	public var SomeColor:Color = new Color();

	var counter = 0;

	public function new(?dyn:Dynamic) {
		super(dyn);
		
		updateEventMask = USE_UPDATE;

		SomeVector2 = new Vector2(Random(40), Random(500));
		SomeIntVector2 = new IntVector2(Std.int(Random(4000)), Std.int(Random(5000)));
		SomeColor = new Color(Random(1), Random(1), Random(1), Random(1));
		
	}

	public function SetRotationSpeed(speed:Vector3) {
		// trace("SetRotationSpeed " + speed);
		rotationSpeed = speed;
	}

	public override function Start() {
		//	trace("Start " + rotationSpeed);
	}

	public override function DelayedStart() {
		//	trace("DelayedStart " + rotationSpeed);
	}

	public override function Update(timeStep:Float) {
		if (rotationSpeed != null)
			node.Rotate(new TQuaternion(rotationSpeed.x * timeStep, rotationSpeed.y * timeStep, rotationSpeed.z * timeStep));
	}
}
