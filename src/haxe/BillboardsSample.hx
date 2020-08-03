import urho3d.*;
import urho3d.Application;

class BillboardsSample extends Application {
	private var scene:Scene = null;
	private var cameraNode:Node = null;
	private var yaw:Float;
	private var pitch:Float;

	public final NUM_OBJECTS = 200;

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
		scene.CreateComponent("DebugRenderer");

		var zoneNode = scene.CreateChild("Zone");
		var zone:Zone = zoneNode.CreateComponent("Zone");
		zone.boundingBox = new BoundingBox(-1000.0, 1000.0);
		zone.ambientColor = new Color(0.1, 0.1, 0.1);
		zone.fogColor = new Color(0.1, 0.2, 0.3);
		zone.fogStart = 10.0;
		zone.fogEnd = 100.0;

		// Create a directional light without shadows
		var lightNode = scene.CreateChild("DirectionalLight");
		lightNode.direction = new TVector3(0.5, -1.0, 0.5);
		var light:Light = lightNode.CreateComponent("Light");
		light.lightType = LIGHT_DIRECTIONAL;
		light.color = new Color(0.2, 0.2, 0.2);
		light.specularIntensity = 1.0;

		// Create a "floor" consisting of several tiles
		for (y in -5...5) {
			for (x in -5...5) {
				var floorNode = scene.CreateChild("FloorTile");
				floorNode.position = new Vector3(x * 20.5, -0.5, y * 20.5);
				floorNode.scale = new Vector3(20.0, 1.0, 20.);
				var floorObject:StaticModel = floorNode.CreateComponent("StaticModel");
				floorObject.model = new Model("Models/Box.mdl");
				floorObject.material = new Material("Materials/Stone.xml");
			}
		}

		// Create groups of mushrooms, which act as shadow casters
		final NUM_MUSHROOMGROUPS = 25;
		final NUM_MUSHROOMS = 25;

		for (i in 0...NUM_MUSHROOMGROUPS) {
			// First create a scene node for the group. The individual mushrooms nodes will be created as children
			var groupNode = scene.CreateChild("MushroomGroup");
			groupNode.position = new Vector3(Random(190.0) - 95.0, 0.0, Random(190.0) - 95.0);

			for (j in 0...NUM_MUSHROOMS) {
				var mushroomNode = groupNode.CreateChild("Mushroom");
				mushroomNode.position = new Vector3(Random(25.0) - 12.5, 0.0, Random(25.0) - 12.5);
				mushroomNode.rotation = new Quaternion(0.0, Random() * 360.0, 0.0);
				mushroomNode.scale = (1.0 + Random() * 4.0);

				var mushroomObject:StaticModel = mushroomNode.CreateComponent("StaticModel");
				mushroomObject.model = new Model("Models/Mushroom.mdl");
				mushroomObject.material = new Material("Materials/Mushroom.xml");
				mushroomObject.castShadows = true;
			}
		}

		cameraNode = scene.CreateChild("Camera");
		var camera:Camera = cameraNode.CreateComponent("Camera");
        cameraNode.position = new Vector3(0.0, 5.0, 0.0);
        
	}

	public function SetupViewport() {
		var viewport = new Viewport(scene, cameraNode.GetComponent("Camera"));
		Renderer.SetViewport(0, viewport);
	}

	public function SubscribeToEvents() {
		SubscribeToEvent("Update", "HandleUpdate");
	}

	function MoveCamera(timeStep:Float) {
		if (Input.numTouches > 0) {
			var camera:Camera = cameraNode.GetComponent("Camera");
			final TOUCH_SENSITIVITY = 2.0;

			if (camera != null) {
				for (i in 0...Input.numTouches) {
					var state = Input.GetTouch(i);

					if (state.delta.x != 0 || state.delta.y != 0) {
						yaw += TOUCH_SENSITIVITY * camera.fov / Graphics.height * state.delta.x;
						pitch += TOUCH_SENSITIVITY * camera.fov / Graphics.height * state.delta.y;
						cameraNode.rotation = new TQuaternion(pitch, yaw, 0.0);
					}
				}
			}
		} else {
			final MOUSE_SENSITIVITY = 0.1;
			yaw += MOUSE_SENSITIVITY * Input.mouseMove.x;
			pitch += MOUSE_SENSITIVITY * Input.mouseMove.y;
			pitch = Clamp(pitch, -90.0, 90.0);

			cameraNode.rotation = new TQuaternion(pitch, yaw, 0.0);
		}
	}

	public function HandleUpdate(eventType:StringHash, eventData:VariantMap) {
		var step:Float = eventData["TimeStep"];
		MoveCamera(step);
	}
}
