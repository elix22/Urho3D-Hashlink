import urho3d.*;
import urho3d.Application;


class StaticSceneSample extends Application {
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

		var zoneNode = scene.CreateChild("Zone");
		var zone:Zone = zoneNode.CreateComponent("Zone");
		zone.boundingBox = new BoundingBox(-1000.0, 1000.0);
		zone.ambientColor = new Color(0.05, 0.2, 0.15);
		zone.fogColor = new Color(0.1, 0.2, 0.3);
		zone.fogStart = 10.0;
        zone.fogEnd = 100.0;
        
        var  planeNode = scene.CreateChild("Plane");
        planeNode.scale = new Vector3(100.0, 1.0, 100.0);
        var planeObject:StaticModel  = planeNode.CreateComponent("StaticModel");
        planeObject.model = new Model( "Models/Plane.mdl");
        planeObject.material = new Material( "Materials/StoneTiled.xml");

        var lightNode = scene.CreateChild("DirectionalLight");
        lightNode.direction = new Vector3(0.6, -1.0, 0.8); // The direction vector does not need to be normalized
         var light:Light = lightNode.CreateComponent("Light");
        light.lightType = LIGHT_DIRECTIONAL;


        for (i in 0...NUM_OBJECTS)
            {
                var mushroomNode = scene.CreateChild("Mushroom");
                mushroomNode.position = new Vector3(Random(90.0) - 45.0, 0.0, Random(90.0) - 45.0);
                mushroomNode.rotation = new Quaternion(0.0, Random(360.0), 0.0);
                mushroomNode.scale = (0.5 + Random(2.0));
                var mushroomObject:StaticModel = mushroomNode.CreateComponent("StaticModel");
                mushroomObject.model = new Model("Models/Mushroom.mdl");
                mushroomObject.material = new Material("Materials/Mushroom.xml");
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
    
    function MoveCamera(timeStep:Float)
    {
          final MOVE_SPEED = 20.0;
          final MOUSE_SENSITIVITY = 0.1;
          yaw += MOUSE_SENSITIVITY * Input.mouseMove.x;
          pitch += MOUSE_SENSITIVITY * Input.mouseMove.y;
          pitch = Clamp(pitch, -90.0, 90.0);

          cameraNode.rotation = new Quaternion(pitch,yaw,0.0);
    }

	public function HandleUpdate(eventType:StringHash, eventData:VariantMap) {
        var step:Float = eventData["TimeStep"];
        MoveCamera(step);

	}
}
