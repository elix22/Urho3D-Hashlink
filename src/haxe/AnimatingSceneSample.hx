import urho3d.*;
import urho3d.Application;
import urho3d.Graphics.BlendMode;
import urho3d.Zone.AbstractZone;

class AnimatingSceneSample extends Application {
	private var scene:Scene = null;

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
	}

	public function SubscribeToEvents() {
		SubscribeToEvent("Update", HandleUpdate);
	}

	public function HandleUpdate(eventType:StringHash, eventData:VariantMap) {
		var step:Single = eventData["TimeStep"];
	}
}
