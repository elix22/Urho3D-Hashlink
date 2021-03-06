import urho3d.*;
import urho3d.Application;
import utils.*;

class AnimatingSceneSample extends Application {
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

		var tmpNode = scene.CreateChild("tempNode");

		for (i in 0...NUM_OBJECTS) {
			var boxNode = tmpNode.CreateChild("Box");
			boxNode.position = new TVector3(Random(200.0) - 100.0, Random(200.0) - 100.0, Random(200.0) - 100.0);
			boxNode.rotation = new TQuaternion(Random(360.0), Random(360.0), Random(360.0));
			var boxObject:StaticModel = boxNode.CreateComponent("StaticModel");
			boxObject.model = new Model("Models/Box.mdl");
			boxObject.material = new Material("Materials/Stone.xml");

			var rotator = new Rotator();
			rotator.SetRotationSpeed(new TVector3(Random(30.0), Random(30.0), Random(30.0)));
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
			var saved = scene.SaveXML("AnimationSceneSample.xml");
			trace("SaveXML = " + saved);
		}

		if (Input.GetKeyPress(KEY_F7)) {
			var loaded = scene.LoadXML("AnimationSceneSample.xml");
			trace("LoadXML = " + loaded);
		}
	}

	public function HandleUpdate(eventType:StringHash, eventData:VariantMap) {
		var step:Float = eventData["TimeStep"];
		MoveCamera(step);

		/*
		counter++;
		if ((counter % 1000 == 0)) {
			if (reload() == true) {
				trace("create scene");
				CreateScene();
				SetupViewport();
			}
		}
		*/
	}

	/*
	static function reload():Bool {
		var is_reload = check_reload();
		// Sys.sleep(1); // make sure timestamp is different
		Sys.command("haxe", ["-cp", "src/haxe", "-hl", "main.hl", "-main", "Main"]);
		Sys.println(is_reload ? "Module Reloaded" : "Module not reloaded");
		return is_reload;
	}

	@:hlNative("std", "sys_check_reload")
	static function check_reload()
		return false;
	*/
}
