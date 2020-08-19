package utils;
import urho3d.*;

class Rotator extends LogicComponent {
	private var rotationSpeed:Vector3;
	public var testString:String = "Hi Eli this is a test string";
	public var SomeVector2:Vector2 = null;
	public var SomeIntVector2:IntVector2 = null;
	public var SomeColor:Color = null;
	var counter = 0;

	public function new(?dyn:Dynamic) {
		super(dyn);
		SomeVector2 = new Vector2(Random(40),Random(500));
		SomeIntVector2 = new IntVector2(Std.int(Random(4000)),Std.int(Random(5000)));
		SomeColor = new Color(Random(1),Random(1),Random(1),Random(1));
	}

	public function SetRotationSpeed(speed:Vector3) {
		rotationSpeed = speed;
	}

	public override function Start() {
	}

	public override function DelayedStart() {
	}

	public override function Update(timeStep:Float) {
		node.Rotate(new TQuaternion(rotationSpeed.x * timeStep, rotationSpeed.y * timeStep, rotationSpeed.z * timeStep));
	}


	public function ResetRotation() {
		node.rotation = new Quaternion(Random(360.0), Random(360.0), Random(360.0));
	}
}
