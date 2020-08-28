
package samplygame;

import urho3d.*;
import urho3d.Application;
import samplygame.actions.*;



class SamplyGame extends Application {

	private var scene:Scene = null;
	private var gameNode:Node = null;

	private var cameraNode:Node = null;
   
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

		var lightNode = scene.CreateChild("DirectionalLight");
		lightNode.direction = new TVector3(0.6, -1.0, 0.8); // The direction vector does not need to be normalized
		var light:Light = lightNode.CreateComponent("Light");
        light.lightType = LIGHT_DIRECTIONAL;
       // light.color = new Color(0.5, 0.5, 0.5);
        light.castShadows = true;
        light.shadowBias = new BiasParameters(0.00025, 0.5);
        // Set cascade splits at 10, 50 and 200 world units, fade shadows out at 80% of maximum shadow distance
		light.shadowCascade = new CascadeParameters(10.0, 50.0, 200.0, 0.0, 0.8);
		


		gameNode = scene.CreateChild("SampleyGame");
		gameNode.position = new Vector3(0.0, 0.0, -5.0);
		gameNode.AddLogicComponent(new Background());
		

		cameraNode = scene.CreateChild("Camera");
		var camera:Camera = cameraNode.CreateComponent("Camera");
		cameraNode.position = new Vector3(0.0, 5.0, -25.0);
		//cameraNode.rotation = new Quaternion(-1.0);
	}

	public function SetupViewport() {
		var viewport = new Viewport(scene, cameraNode.GetComponent("Camera"));
		Renderer.SetViewport(0, viewport);
	}

	public function SubscribeToEvents() {
		SubscribeToEvent("Update", "HandleUpdate");
	}

	public function HandleUpdate(eventType:StringHash, eventData:VariantMap) {
		var step:Float = eventData["TimeStep"];
		ActionManager.actionManager.Step(step);
	}
}