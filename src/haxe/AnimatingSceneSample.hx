import urho3d.*;
import urho3d.Application;
import urho3d.Graphics.BlendMode;
import urho3d.Zone.AbstractZone;

class Rotator extends LogicComponent {
	private var rotationSpeed:Vector3;

	private var quat:Quaternion = new Quaternion();

	var counter = 1;

	public function new() {
		super();
	}

	public function SetRotationSpeed(speed:Vector3) {
		rotationSpeed = speed;
	}

	public override function Update(timeStep:Float) {
		quat.SetAngles(rotationSpeed.x * timeStep, rotationSpeed.y * timeStep, rotationSpeed.z * timeStep);
		node.Rotate(quat);
		// node.Rotate(new Quaternion(rotationSpeed.x * timeStep, rotationSpeed.y * timeStep, rotationSpeed.z * timeStep));

		// node.RotateEuler(rotationSpeed.x * timeStep, rotationSpeed.y * timeStep, rotationSpeed.z * timeStep);

		counter++;

		if (counter % 200 == 0) {
		   ResetRotation();
		}
		
	}

	public function ResetRotation() {
		node.rotation = new Quaternion(Random(360.0), Random(360.0), Random(360.0));
	}
}

class AnimatingSceneSample extends Application {
	private var scene:Scene = null;
	private var cameraNode:Node = null;
	private var yaw:Float = 0.0;
    private var pitch:Float = 0.0;

	public final NUM_OBJECTS = 4000;

	var counter:Int = 0;

	public override function Setup() {
		trace("Setup");
	}

	public override function Start() {
		CreateScene();
		SetupViewport();
		SubscribeToEvents();
	}

	public function CreateScene() {
		scene = new Scene();

		scene.CreateComponent("Octree");

		var zoneNode = scene.CreateChild("Zone");
		var zone:Zone = zoneNode.CreateComponent("Zone");
		zone.boundingBox = new BoundingBox(-1000.0, 1000.0);
		zone.ambientColor = new Color(0.05, 0.1, 0.15);
		zone.fogColor = new Color(0.1, 0.2, 0.3);
		zone.fogStart = 10.0;
		zone.fogEnd = 100.0;

		for (i in 0...NUM_OBJECTS) {
			var boxNode = scene.CreateChild("Box");
			boxNode.position = new Vector3(Random(200.0) - 100.0, Random(200.0) - 100.0, Random(200.0) - 100.0);
			boxNode.rotation = new Quaternion(Random(360.0), Random(360.0), Random(360.0));
			var boxObject:StaticModel = boxNode.CreateComponent("StaticModel");
			boxObject.model = new Model("Models/Box.mdl");
			boxObject.material = new Material("Materials/Stone.xml");

			var rotator = new Rotator();
			rotator.SetRotationSpeed(new Vector3(10.0, 20.0, 30.0));
			boxNode.AddComponent(rotator);
		}

		cameraNode = scene.CreateChild("Camera");
		var camera:Camera = cameraNode.CreateComponent("Camera");
		camera.farClip = 100.0;

		var light:Light = cameraNode.CreateComponent("Light");
		light.lightType = LIGHT_POINT;
		light.range = 100.0;
	}

	public function SetupViewport() {
		var viewport = new Viewport(scene, cameraNode.GetComponent("Camera"));
		Renderer.SetViewport(0, viewport);
	}

	public function SubscribeToEvents() {
		SubscribeToEvent("Update", "HandleUpdate");
	}

	function MoveCamera(timeStep:Single)
		{
			  final MOVE_SPEED = 20.0;
			  final MOUSE_SENSITIVITY = 0.1;
			  yaw += MOUSE_SENSITIVITY * Input.mouseMove.x;
			  pitch += MOUSE_SENSITIVITY * Input.mouseMove.y;
			  pitch = Clamp(pitch, -90.0, 90.0);
	
			  cameraNode.rotation = new Quaternion(pitch,yaw,0.0);
		}

	public function HandleUpdate(eventType:StringHash, eventData:VariantMap) {
		var step:Single = eventData["TimeStep"];
		MoveCamera(step);
		counter++;

		if ((counter % 1000 == 0)) {
			trace("create scene");
			CreateScene();
			SetupViewport();
		}
	}
}
