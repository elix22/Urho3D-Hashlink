
package samplygame;

import urho3d.*;
import urho3d.Application;
import actions.*;



class SamplyGame extends Application {

	private var scene:Scene = null;
	private var gameNode:Node = null;

	private var cameraNode:Node = null;

	var startMenu_:StartMenu = null;
	var startMenuNode_:Node =null;
   
    public override function Setup() {
		trace("Setup");
#if URHO3D_HAXE_HASHLINK
		engineParameters[EP_RESOURCE_PATHS] = "Data/SamplyGame;Data;CoreData;";
#else
		engineParameters[EP_RESOURCE_PATHS] = "bin/Data/SamplyGame;bin/Data;bin/CoreData;";
#end
		engineParameters[EP_FULL_SCREEN] = false;
		engineParameters[EP_WINDOW_WIDTH] = 450;
		engineParameters[EP_WINDOW_HEIGHT] = 800;
		engineParameters[EP_WINDOW_TITLE] = "SamplyGame";
		engineParameters[EP_WINDOW_ICON] = "icon.png";
		engineParameters[EP_ORIENTATIONS] = "Portrait";
	}

	public override function Start() {
		CreateScene();
		SubscribeToEvents();

		CreateStartMenu();
	}

	public function CreateScene() {
		scene = new Scene();

		scene.CreateComponent("Octree");

		var physics:PhysicsWorld = scene.CreateComponent("PhysicsWorld");
		physics.gravity = new Vector3(0.0,0.0,0.0);

		cameraNode = scene.CreateChild("Camera");
		var camera:Camera = cameraNode.CreateComponent("Camera");
		cameraNode.position = new Vector3(0.0, 0.0, -10.0);

		var viewport = new Viewport(scene, cameraNode.GetComponent("Camera"));
		Renderer.SetViewport(0, viewport);


		var zoneNode = scene.CreateChild("Zone");
		var zone:Zone = zoneNode.CreateComponent("Zone");
        zone.boundingBox = new BoundingBox(-300.0, 300.0);
        zone.ambientColor = new Color(1.0, 1.0, 1.0);
  
		scene.AddLogicComponent(new Background());


		var lightNode = scene.CreateChild("DirectionalLight");
		lightNode.direction = new TVector3(0.6, -1.0, 0.8); // The direction vector does not need to be normalized
		var light:Light = lightNode.CreateComponent("Light");
        light.lightType = LIGHT_DIRECTIONAL;
        light.color = new Color(0.5, 0.5, 0.5);
        light.castShadows = true;
        light.shadowBias = new BiasParameters(0.00025, 0.5);
        // Set cascade splits at 10, 50 and 200 world units, fade shadows out at 80% of maximum shadow distance
		light.shadowCascade = new CascadeParameters(10.0, 50.0, 200.0, 0.0, 0.8);
		

	

	}

	public function SubscribeToEvents() {
		SubscribeToEvent("Update", "HandleUpdate");
	}

	public function HandleUpdate(eventType:StringHash, eventData:VariantMap) {
		var step:Float = eventData["TimeStep"];
		ActionManager.actionManager.Step(step);
	}

	function CreateStartMenu()
	{
		// log.Warning("CreateStartMenu");
		startMenuNode_ = scene.CreateChild("StartMenuNode");
		if(startMenuNode_ != null)
		{
			startMenu_ = new StartMenu();
		//	trace(startMenu_.className);
			startMenuNode_.AddLogicComponent(startMenu_);
		}
	}
}