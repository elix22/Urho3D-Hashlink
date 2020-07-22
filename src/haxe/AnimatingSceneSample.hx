import urho3d.*;
import urho3d.Application;
import urho3d.Graphics.BlendMode;
import urho3d.Zone.AbstractZone;

class Rotator extends LogicComponent {
	public function new() {
		super();
	}

	public override function Start():Void {
		//trace("Rotator Start ");
	}

	public override function DelayedStart():Void {
		//trace("Rotator DelayedStart ");
	}

	public override function Update(timeStep:Float) {
		 trace(timeStep);
	}
}

class AnimatingSceneSample extends Application {
	private var scene:Scene = null;

	public final NUM_OBJECTS = 2000;

	public override function Setup() {
		trace("Setup");
	}

	public override function Start() {
		CreateScene();
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


			boxNode.AddComponent(new Rotator());
		}
	}

	public function SubscribeToEvents() {
		SubscribeToEvent("Update", HandleUpdate);
	}

	public function HandleUpdate(eventType:StringHash, eventData:VariantMap) {
		var step:Single = eventData["TimeStep"];
	}
}
