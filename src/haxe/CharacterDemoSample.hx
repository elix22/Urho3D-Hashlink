import urho3d.*;
import urho3d.Application;
import utils.*;

class CharacterDemoSample extends Application {
	private var scene:Scene = null;
	private var cameraNode:Node = null;
	private var yaw:Float = 0.0;
	private var pitch:Float = 0.0;

	public final NUM_OBJECTS = 4000;

	var counter:Int = 1;

	public override function Setup() {
		trace("Setup");
	}

	public override function Start() {
		CreateScene();
		// SetupViewport();
		SubscribeToEvents();
	}

	public function CreateScene() {
		scene = new Scene();

		// Create scene subsystem components
		scene.CreateComponent("Octree");
		scene.CreateComponent("PhysicsWorld");

		// Create camera and define viewport. Camera does not necessarily have to belong to the scene
		cameraNode = new Node();
		var camera:Camera = cameraNode.CreateComponent("Camera");
		camera.farClip = 300.0;
		cameraNode.position = new Vector3(0.0, 5.0, 0.0);
		Renderer.viewports[0] = new Viewport(scene, camera);

		// Create a Zone component for ambient lighting & fog control
		var zoneNode = scene.CreateChild("Zone");
		var zone:Zone = zoneNode.CreateComponent("Zone");
		zone.boundingBox = new BoundingBox(-1000.0, 1000.0);
		zone.ambientColor = new Color(0.15, 0.15, 0.15);
		zone.fogColor = new Color(0.5, 0.5, 0.7);
		zone.fogStart = 100.0;
		zone.fogEnd = 300.0;

		// Create a directional light to the world. Enable cascaded shadows on it
		var lightNode = scene.CreateChild("DirectionalLight");
		lightNode.direction = new Vector3(0.6, -1.0, 0.8);
		var light:Light = lightNode.CreateComponent("Light");
		light.lightType = LIGHT_DIRECTIONAL;
		light.castShadows = true;
		light.shadowBias = new BiasParameters(0.00025, 0.5);
		// Set cascade splits at 10, 50 and 200 world units, fade shadows out at 80% of maximum shadow distance
		light.shadowCascade = new CascadeParameters(10.0, 50.0, 200.0, 0.0, 0.8);

		// Create the floor object
		var floorNode = scene.CreateChild("Floor");
		floorNode.position = new Vector3(0.0, -0.5, 0.0);
		floorNode.scale = new Vector3(200.0, 1.0, 200.0);
		var object:StaticModel = floorNode.CreateComponent("StaticModel");
		object.model = new Model("Models/Box.mdl");
		object.material = new Material("Materials/Stone.xml");

		var body:RigidBody = floorNode.CreateComponent("RigidBody");
		// Use collision layer bit 2 to mark world scenery. This is what we will raycast against to prevent camera from going
		// inside geometry
		body.collisionLayer = 2;
		var shape:CollisionShape = floorNode.CreateComponent("CollisionShape");
		shape.SetBox(Vector3.ONE);

		// Create mushrooms of varying sizes
		final NUM_MUSHROOMS = 60;
		for (i in 0...NUM_MUSHROOMS) {
			var objectNode = scene.CreateChild("Mushroom");
			objectNode.position = new Vector3(Random(180.0) - 90.0, 0.0, Random(180.0) - 90.0);
			objectNode.rotation = new Quaternion(0.0, Random(360.0), 0.0);
			objectNode.scale = (2.0 + Random(5.0));
			var object:StaticModel = objectNode.CreateComponent("StaticModel");
			object.model = new Model("Models/Mushroom.mdl");
			object.material = new Material("Materials/Mushroom.xml");
			object.castShadows = true;

			var body:RigidBody = objectNode.CreateComponent("RigidBody");
			body.collisionLayer = 2;
			var shape:CollisionShape = objectNode.CreateComponent("CollisionShape");
			shape.SetTriangleMesh(object.model, 0);
		}

		// Create movable boxes. Let them fall from the sky at first
		final NUM_BOXES = 100;
		for (i in 0...NUM_BOXES) {
			var scale = Random(2.0) + 0.5;

			var objectNode = scene.CreateChild("Box");
			objectNode.position = new Vector3(Random(180.0) - 90.0, Random(10.0) + 10.0, Random(180.0) - 90.0);
			objectNode.rotation = new Quaternion(Random(360.0), Random(360.0), Random(360.0));
			objectNode.scale = scale;
			var object:StaticModel = objectNode.CreateComponent("StaticModel");
			object.model = new Model("Models/Box.mdl");
			object.material = new Material("Materials/Stone.xml");
			object.castShadows = true;

			var body:RigidBody = objectNode.CreateComponent("RigidBody");
			body.collisionLayer = 2;
			// Bigger boxes will be heavier and harder to move
			body.mass = scale * 2.0;
			var shape:CollisionShape = objectNode.CreateComponent("CollisionShape");
			shape.SetBox(Vector3.ONE);
		}
	}

	public function SetupViewport() {
		var viewport = new Viewport(scene, cameraNode.GetComponent("Camera"));
		Renderer.SetViewport(0, viewport);
	}

	public function SubscribeToEvents() {
		SubscribeToEvent("Update", "HandleUpdate");
		// Subscribe to PostUpdate event for updating the camera position after physics simulation
		SubscribeToEvent("PostUpdate", "HandlePostUpdate");
	}

	function MoveCamera(timeStep:Float) {
		final MOVE_SPEED = 20.0;

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

		if (Input.GetKeyDown(KEY_W))
			cameraNode.Translate(Vector3.FORWARD * MOVE_SPEED * timeStep);
		if (Input.GetKeyDown(KEY_S))
			cameraNode.Translate(Vector3.BACK * MOVE_SPEED * timeStep);
		if (Input.GetKeyDown(KEY_A))
			cameraNode.Translate(Vector3.LEFT * MOVE_SPEED * timeStep);
		if (Input.GetKeyDown(KEY_D))
			cameraNode.Translate(Vector3.RIGHT * MOVE_SPEED * timeStep);

		if (Input.GetKeyPress(KEY_F5)) {
			var saved = scene.SaveXML("CharacterDemoSample.xml");
			trace("SaveXML = " + saved);
		}

		if (Input.GetKeyPress(KEY_F7)) {
			var loaded = scene.LoadXML("CharacterDemoSample.xml");
			trace("LoadXML = " + loaded);
		}
	}

	public function HandleUpdate(eventType:StringHash, eventData:VariantMap) {
		var step:Float = eventData["TimeStep"];
		MoveCamera(step);
	}

	public function HandlePostUpdate(eventType:StringHash, eventData:VariantMap) {}
}
