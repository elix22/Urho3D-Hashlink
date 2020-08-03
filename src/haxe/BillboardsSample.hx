import urho3d.*;
import urho3d.Application;
import urho3d.Node.AbstractNode;

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

		// Create billboard sets (floating smoke)
		final NUM_BILLBOARDNODES = 25;
		final NUM_BILLBOARDS = 10;

		for (i in 0...NUM_BILLBOARDNODES) {
			var smokeNode = scene.CreateChild("Smoke");
			smokeNode.position = new Vector3(Random(200.0) - 100.0, Random(20.0) + 10.0, Random(200.0) - 100.0);

			var billboardObject:BillboardSet = smokeNode.CreateComponent("BillboardSet");
			billboardObject.numBillboards = NUM_BILLBOARDS;
			billboardObject.material = new Material("Materials/LitSmoke.xml");
			billboardObject.sorted = true;

			for (j in 0...NUM_BILLBOARDS) {
				var bb = billboardObject.billboards[j];
				bb.position = new Vector3(Random(12.0) - 6.0, Random(8.0) - 4.0, Random(12.0) - 6.0);
				bb.size = new Vector2(Random(2.0) + 3.0, Random(2.0) + 3.0);
				bb.rotation = Random() * 360.0;
				bb.enabled = true;
			}

			// After modifying the billboards, they need to be "committed" so that the BillboardSet updates its internals
			billboardObject.Commit();
		}

		// Create shadow casting spotlights
		final NUM_LIGHTS = 9;

		for (i in 0...NUM_LIGHTS) {
			var lightNode = scene.CreateChild("SpotLight");
			var light:Light = lightNode.CreateComponent("Light");

			var angle = 0.0;

			var position = new Vector3((i % 3) * 60.0 - 60.0, 45.0, (i / 3) * 60.0 - 60.0);
			var color = new Color(((i + 1) & 1) * 0.5 + 0.5, (((i + 1) >> 1) & 1) * 0.5 + 0.5, (((i + 1) >> 2) & 1) * 0.5 + 0.5);

			lightNode.position = position;
			lightNode.direction = new Vector3(Math.sin(angle), -1.5, Math.cos(angle));

			light.lightType = LIGHT_SPOT;
			light.range = 90.0;
			light.rampTexture = new Texture2D("Textures/RampExtreme.png");
			light.fov = 45.0;
			light.color = color;
			light.specularIntensity = 1.0;
			light.castShadows = true;
			light.shadowBias = new BiasParameters(0.00002, 0.0);

			// Configure shadow fading for the lights. When they are far away enough, the lights eventually become unshadowed for
			// better GPU performance. Note that we could also set the maximum distance for each object to cast shadows

			light.shadowFadeDistance = 100.0; // Fade start distance
			light.shadowDistance = 125.0; // Fade end distance, shadows are disabled

			// Set half resolution for the shadow maps for increased performance

			light.shadowResolution = 0.5;

			// The spot lights will not have anything near them, so move the near plane of the shadow camera farther
			// for better shadow depth resolution

			light.shadowNearFarRatio = 0.01;
		}

		cameraNode = scene.CreateChild("Camera");
		var camera:Camera = cameraNode.CreateComponent("Camera");
		camera.farClip = 300.0;

        cameraNode.position = new Vector3(0.0, 5.0, 0.0);
        
	}

	public function SetupViewport() {
		var viewport = new Viewport(scene, cameraNode.GetComponent("Camera"));
		Renderer.SetViewport(0, viewport);
	}

	public function SubscribeToEvents() {
		SubscribeToEvent("Update", "HandleUpdate");
		// Subscribe HandlePostRenderUpdate() function for processing the post-render update event, during which we request
		// debug geometry
		SubscribeToEvent("PostRenderUpdate", "HandlePostRenderUpdate");
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
    
    function  AnimateScene(timeStep:Float )
        {
                var lightNodes = scene.GetChildrenWithComponent("Light");
                var billboardNodes = scene.GetChildrenWithComponent("BillboardSet");

                final LIGHT_ROTATION_SPEED = 20.0;
                final  BILLBOARD_ROTATION_SPEED = 50.0;
            
                // Rotate the lights around the world Y-axis
                for (i in 0...lightNodes.length)
                    lightNodes[i].Rotate(new TQuaternion(0.0, LIGHT_ROTATION_SPEED * timeStep, 0.0), TS_WORLD);
            
                // Rotate the individual billboards within the billboard sets, then recommit to make the changes visible
                for (i in  0...billboardNodes.length)
                {
                    var billboardObject:BillboardSet = billboardNodes[i].GetComponent("BillboardSet");
            
                    for (j in  0...billboardObject.numBillboards)
                    {
                        var bb = billboardObject.billboards[j];
                        bb.rotation += BILLBOARD_ROTATION_SPEED * timeStep;
                    }
            
                    billboardObject.Commit();
                }
        }

	public function HandleUpdate(eventType:StringHash, eventData:VariantMap) {
		var step:Float = eventData["TimeStep"];
        MoveCamera(step);
        AnimateScene(step);
	}

	public function HandlePostRenderUpdate(eventType:StringHash, eventData:VariantMap) {}
}
