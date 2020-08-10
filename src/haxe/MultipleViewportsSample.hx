import urho3d.*;
import urho3d.Application;
import urho3d.KeyCode;

class MultipleViewportsSample extends Application {
	private var scene:Scene = null;
	private var cameraNode:Node = null;
	private var rearCameraNode:Node = null;
	private var yaw:Float;
	private var pitch:Float;
	private var drawDebug:Bool = false;

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

		// Create scene node & StaticModel component for showing a static plane
		var planeNode = scene.CreateChild("Plane");
		planeNode.scale = new Vector3(100.0, 1.0, 100.0);
		var planeObject:StaticModel = planeNode.CreateComponent("StaticModel");
		planeObject.model = new Model("Models/Plane.mdl");
		planeObject.material = new Material("Materials/StoneTiled.xml");

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

		// Create some mushrooms
		final NUM_MUSHROOMS = 240;
		for (i in 0...NUM_MUSHROOMS) {
			var mushroomNode = scene.CreateChild("Mushroom");
			mushroomNode.position = new Vector3(Random(90.0) - 45.0, 0.0, Random(90.0) - 45.0);
			mushroomNode.rotation = new Quaternion(0.0, Random(360.0), 0.0);
			mushroomNode.scale = (0.5 + Random(2.0));
			var mushroomObject:StaticModel = mushroomNode.CreateComponent("StaticModel");
			mushroomObject.model = new Model("Models/Mushroom.mdl");
			mushroomObject.material = new Material("Materials/Mushroom.xml");
			mushroomObject.castShadows = true;
		}

		// Create randomly sized boxes. If boxes are big enough, make them occluders. Occluders will be software rasterized before
		// rendering to a low-resolution depth-only buffer to test the objects in the view frustum for visibility
		final NUM_BOXES = 20;
		for (i in 0...NUM_BOXES) {
			var boxNode = scene.CreateChild("Box");
			var size = 1.0 + Random(10.0);
			boxNode.position = new Vector3(Random(80.0) - 40.0, size * 0.5, Random(80.0) - 40.0);
			boxNode.scale = size;
			var boxObject:StaticModel = boxNode.CreateComponent("StaticModel");
			boxObject.model = new Model("Models/Box.mdl");
			boxObject.material = new Material("Materials/Stone.xml");
			boxObject.castShadows = true;
			if (size >= 3.0)
				boxObject.occluder = true;
		}

		// Create the cameras. Limit far clip distance to match the fog
		cameraNode = scene.CreateChild("Camera");
		var camera:Camera = cameraNode.CreateComponent("Camera");
		camera.farClip = 300.0;

		// Parent the rear camera node to the front camera node and turn it 180 degrees to face backward
		// Here, we use the angle-axis constructor for Quaternion instead of the usual Euler angles
		rearCameraNode = cameraNode.CreateChild("RearCamera");

		rearCameraNode.Rotate(new Quaternion(180.0, Vector3.UP));

		var rearCamera:Camera = rearCameraNode.CreateComponent("Camera");
		rearCamera.farClip = 300.0;
		// Because the rear viewport is rather small, disable occlusion culling from it. Use the camera's
		// "view override flags" for this. We could also disable eg. shadows or force low material quality
		// if we wanted

		// rearCamera.viewOverrideFlags = VO_DISABLE_OCCLUSION;

		// Set an initial position for the front camera scene node above the plane
		cameraNode.position = new Vector3(0.0, 5.0, 0.0);
	}

	public function SetupViewport() {
		Renderer.numViewports = 2;

		// Set up the front camera viewport
		var viewport = new Viewport(scene, cameraNode.GetComponent("Camera"));
		Renderer.viewports[0] = viewport;

		// Clone the default render path so that we do not interfere with the other viewport, then add
		// bloom and FXAA post process effects to the front viewport. Render path commands can be tagged
		// for example with the effect name to allow easy toggling on and off. We start with the effects
		// disabled.
		var effectRenderPath = viewport.renderPath.Clone();
		effectRenderPath.Append(new XMLFile("PostProcess/Bloom.xml"));
		effectRenderPath.Append(new XMLFile("PostProcess/FXAA2.xml"));

		// Make the bloom mixing parameter more pronounced
        // effectRenderPath.shaderParameters["BloomMix"] = Variant(Vector2(0.9f, 0.6f));
        effectRenderPath.SetShaderParameter("BloomMix",new Vector2(0.9, 0.6));
		effectRenderPath.SetEnabled("Bloom", false);
		effectRenderPath.SetEnabled("FXAA2", false);
		viewport.renderPath = effectRenderPath;

		Renderer.viewports[1] = new Viewport(scene, rearCameraNode.GetComponent("Camera"),
			new IntRect(cast(Graphics.width * 2 / 3, Int), 32, Graphics.width - 32, cast(Graphics.height / 3, Int)));
	}

	public function SubscribeToEvents() {
		SubscribeToEvent("Update", "HandleUpdate");
		SubscribeToEvent("PostRenderUpdate", "HandlePostRenderUpdate");
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

		if (Input.keyDown[KEY_W])
			cameraNode.Translate(Vector3.FORWARD * MOVE_SPEED * timeStep);
		if (Input.keyDown[KEY_S])
			cameraNode.Translate(Vector3.BACK * MOVE_SPEED * timeStep);
		if (Input.keyDown[KEY_A])
			cameraNode.Translate(Vector3.LEFT * MOVE_SPEED * timeStep);
		if (Input.keyDown[KEY_D])
            cameraNode.Translate(Vector3.RIGHT * MOVE_SPEED * timeStep);
        
        
    // Toggle post processing effects on the front viewport. Note that the rear viewport is unaffected
   var effectRenderPath = Renderer.viewports[0].renderPath;
    if (Input.keyPress[KEY_B])
        effectRenderPath.ToggleEnabled("Bloom");
    if (Input.keyPress[KEY_F])
        effectRenderPath.ToggleEnabled("FXAA2");

		// Toggle debug geometry with space
		if (Input.keyPress[KEY_SPACE])
			drawDebug = !drawDebug;
	}

	public function HandleUpdate(eventType:StringHash, eventData:VariantMap) {
		var step:Float = eventData["TimeStep"];
		MoveCamera(step);
	}

	public function HandlePostRenderUpdate(eventType:StringHash, eventData:VariantMap) {
		if (drawDebug)
			Renderer.DrawDebugGeometry(true);
	}
}
