import urho3d.*;
import urho3d.Application;
import urho3d.Graphics.BlendMode;
import urho3d.Zone.AbstractZone;

class Rotator extends LogicComponent {
	public function new() {
		super();
	}

	private var rotationSpeed:Vector3;

	public function SetRotationSpeed(speed:Vector3) {
		rotationSpeed = speed;
	}

	public override function Update(timeStep:Float) {
		node.Rotate(new Quaternion(rotationSpeed.x * timeStep, rotationSpeed.y * timeStep, rotationSpeed.z * timeStep));
	}
}

class AnimatingSceneSample extends Application {
	private var scene:Scene = null;
	private var cameraNode:Node = null;

	public final NUM_OBJECTS = 2000;

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
		zone.boundingBox = new BoundingBox(-1000.1, 1000.1);
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
		light.range = 30.0;
	}

	public function SetupViewport() {
		var viewport = new Viewport(scene, cameraNode.GetComponent("Camera"));
		Renderer.SetViewport(0, viewport);
	}

	public function SubscribeToEvents() {
		SubscribeToEvent("Update", HandleUpdate);
	}

	public function HandleUpdate(eventType:StringHash, eventData:VariantMap) {
		var step:Single = eventData["TimeStep"];
	}
}
