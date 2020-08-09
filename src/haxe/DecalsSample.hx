import urho3d.AnimatedModel.AbstractAnimatedModel;
import urho3d.*;
import urho3d.Application;

abstract Ref<T>(haxe.ds.Vector<T>) {
	public var ref(get, set):T;

	inline function new()
		this = new haxe.ds.Vector(1);

	@:to inline function get_ref():T
		return this[0];

	inline function set_ref(param:T)
		return this[0] = param;

	public function toString():String
		return '@[' + Std.string(ref) + ']';

	@:noUsing @:from static inline public function to<A>(v:A):Ref<A> {
		var ret = new Ref();
		ret.ref = v;
		return ret;
	}

	@:to
	public inline function toT():T {
		return ref;
	}
}

class DecalsSample extends Application {
	private var scene:Scene = null;
	private var cameraNode:Node = null;
	private var yaw:Float;
	private var pitch:Float;
	private var drawDebug:Bool = false;

	public override function Setup() {
		trace("Setup");
	}

	public override function Start() {
		CreateScene();
		SetupViewport();
		SubscribeToEvents();
		Input.SetMouseVisible(true);
		// Input.SetMouseMode(MM_ABSOLUTE);
	}

	public function CreateScene() {
		scene = new Scene();

		// Create octree, use default volume (-1000, -1000, -1000) to (1000, 1000, 1000)
		// Also create a DebugRenderer component so that we can draw debug geometry
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

		// Create the camera. Limit far clip distance to match the fog
		cameraNode = scene.CreateChild("Camera");
		var camera:Camera = cameraNode.CreateComponent("Camera");
		camera.farClip = 300.0;
		// Set an initial position for the camera scene node above the plane
		cameraNode.position = new Vector3(0.0, 5.0, 0.0);
	}

	public function SetupViewport() {
		var viewport = new Viewport(scene, cameraNode.GetComponent("Camera"));
		Renderer.SetViewport(0, viewport);
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

		if (Input.GetKeyDown(KEY_W))
			cameraNode.Translate(Vector3.FORWARD * MOVE_SPEED * timeStep);
		if (Input.GetKeyDown(KEY_S))
			cameraNode.Translate(Vector3.BACK * MOVE_SPEED * timeStep);
		if (Input.GetKeyDown(KEY_A))
			cameraNode.Translate(Vector3.LEFT * MOVE_SPEED * timeStep);
		if (Input.GetKeyDown(KEY_D))
			cameraNode.Translate(Vector3.RIGHT * MOVE_SPEED * timeStep);
		// Toggle debug geometry with space
		if (Input.GetKeyPress(KEY_SPACE))
			drawDebug = !drawDebug;

		if (/*ui.cursor.visible &&*/ Input.GetMouseButtonPress(MOUSEB_LEFT))
			PaintDecal();
	}

	public function PaintDecal() {
		trace("PaintDecal");

		var result = Raycast(250.0);
		if (result != null) {
			// Check if target scene node already has a DecalSet component. If not, create now
			var targetNode = result.drawable.node;
			var decal:DecalSet = targetNode.GetComponent("DecalSet");
			if (decal == null) {
				decal = targetNode.CreateComponent("DecalSet");
                decal.material = new Material("Materials/UrhoDecal.xml");
            }
            
            decal.AddDecal(result.drawable, result.position, cameraNode.rotation, 0.5, 1.0, 1.0, Vector2.ZERO, Vector2.ONE);
		}
	}

	public function Raycast(maxDistance:Float):RayQueryResult {
		var pos = UI.cursorPosition;

		var camera:Camera = cameraNode.GetComponent("Camera");
		var cameraRay:Ray = camera.GetScreenRay(pos.x / Graphics.width, pos.y / Graphics.height);
		var result = scene.octree.RaycastSingle(cameraRay, RAY_TRIANGLE, maxDistance, DRAWABLE_GEOMETRY);

		if (result.size > 0) {
			return result[0];
		}

		return null;
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
