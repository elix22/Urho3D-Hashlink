import urho3d.Input.TouchState;
import urho3d.*;
import urho3d.Application;

class SkeletalAnimationSample extends Application {
	private var scene:Scene = null;
	private var cameraNode:Node = null;
	private var yaw:Float;
	private var pitch:Float;

    final NUM_MODELS = 30;
    final MODEL_MOVE_SPEED = 2.0;
    final MODEL_ROTATE_SPEED = 100.0;
    final bounds = new BoundingBox(new TVector3(-20.0, 0.0, -20.0), new TVector3(20.0, 0.0, 20.0));

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
        zone.ambientColor = new Color(0.5, 0.5, 0.5);
        zone.fogColor = new Color(0.4, 0.5, 0.8);
        zone.fogStart = 100.0;
        zone.fogEnd = 300.0;

        var planeNode = scene.CreateChild("Plane");
        planeNode.scale = new TVector3(50.0, 1.0, 50.0);
		var planeObject:StaticModel = planeNode.CreateComponent("StaticModel");
		planeObject.model = new Model("Models/Plane.mdl");
		planeObject.material = new Material("Materials/StoneTiled.xml");

		var lightNode = scene.CreateChild("DirectionalLight");
		lightNode.direction = new TVector3(0.6, -1.0, 0.8); // The direction vector does not need to be normalized
		var light:Light = lightNode.CreateComponent("Light");
        light.lightType = LIGHT_DIRECTIONAL;
       // light.color = new Color(0.5, 0.5, 0.5);
      //  light.castShadows = true;
      //  light.shadowBias = BiasParameters(0.00025f, 0.5f);
        // Set cascade splits at 10, 50 and 200 world units, fade shadows out at 80% of maximum shadow distance
      //  light.shadowCascade = CascadeParameters(10.0f, 50.0f, 200.0f, 0.0f, 0.8f);

		for (i in 0...NUM_MODELS) {

            var modelNode = scene.CreateChild("Jill");
            modelNode.position = new TVector3(Random(40.0) - 20.0, 0.0, Random(40.0) - 20.0);
            modelNode.rotation = new TQuaternion(0.0, Random(360.0), 0.0);
    
            var modelObject:AnimatedModel = modelNode.CreateComponent("AnimatedModel");
            modelObject.model = new Model("Models/Kachujin/Kachujin.mdl");
            modelObject.material = new Material("Models/Kachujin/Materials/Kachujin.xml");

            var walkAnimation = new Animation("Models/Kachujin/Kachujin_Walk.ani");
            var state = modelObject.AddAnimationState(walkAnimation);
            state.weight = 1.0;
            state.looped = true;
            state.time = Random(walkAnimation.length);

            var mover = new Mover();
            mover.SetParameters(MODEL_MOVE_SPEED, MODEL_ROTATE_SPEED, bounds);
			modelNode.AddComponent(mover);

		}

		cameraNode = scene.CreateChild("Camera");
		var camera:Camera = cameraNode.CreateComponent("Camera");
		cameraNode.position = new TVector3(0.0, 5.0, 0.0);
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
					var state:TouchState = Input.touchState(i);

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


class Mover extends LogicComponent {

    var moveSpeed = 0.0;
    var rotationSpeed = 0.0;
    var bounds:BoundingBox;

	public function new() {
		super();
	}


    public function  SetParameters( moveSpeed_:Float, rotationSpeed_:Float, bounds_:BoundingBox)
    {
        moveSpeed = moveSpeed_;
        rotationSpeed = rotationSpeed_;
        bounds = bounds_;
    }

	public override function Start() {

	}

	public override function DelayedStart() {
	}

	public override function Update(timeStep:Float) {

        node.Translate(Vector3.FORWARD * moveSpeed * timeStep);

        var pos = node.position;
        
        if (pos.x < bounds.min.x || pos.x > bounds.max.x || pos.z < bounds.min.z || pos.z > bounds.max.z)
            node.Yaw(rotationSpeed * timeStep);
        

        var model:AnimatedModel = node.GetComponent("AnimatedModel", true);
        var state:AnimationState = model.GetAnimationState(0);
        if (state != null)
            state.AddTime(timeStep);
	}

}

