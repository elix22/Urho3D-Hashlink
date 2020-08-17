package utils;
import urho3d.*;

class Rotator extends LogicComponent {
	private var rotationSpeed:Vector3;

	var counter = 0;

	public function new(?dyn:Dynamic) {
		super(dyn);
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
