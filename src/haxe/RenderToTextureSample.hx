import urho3d.*;
import urho3d.Application;
import urho3d.GraphicsDefs;

class Rotator extends LogicComponent {
	private var rotationSpeed:Vector3;

	public function new() {
		super();
	}

	public function SetRotationSpeed(speed:Vector3) {
		rotationSpeed = speed;
	}

	public override function Update(timeStep:Float) {
		node.Rotate(new TQuaternion(rotationSpeed.x * timeStep, rotationSpeed.y * timeStep, rotationSpeed.z * timeStep));
	}
}

class RenderToTextureSample extends Application {
	private var scene:Scene = null;
	private var cameraNode:Node = null;
	private var rttScene:Scene = null;
	private var rttCameraNode:Node = null;

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
		{
			// Create the scene which will be rendered to a texture
			rttScene = new Scene();

			// Create octree, use default volume (-1000, -1000, -1000) to (1000, 1000, 1000)
			rttScene.CreateComponent("Octree");

			// Create a Zone for ambient light & fog control
			var zoneNode = rttScene.CreateChild("Zone");
			var zone:Zone = zoneNode.CreateComponent("Zone");
			// Set same volume as the Octree, set a close bluish fog and some ambient light
			zone.boundingBox = new BoundingBox(-1000.0, 1000.0);
			zone.ambientColor = new Color(0.05, 0.1, 0.15);
			zone.fogColor = new Color(0.1, 0.2, 0.3);
			zone.fogStart = 10.0;
			zone.fogEnd = 100.0;

			// Create randomly positioned and oriented box StaticModels in the scene
			final NUM_OBJECTS = 2000;
			for (i in 0...NUM_OBJECTS) {
				var boxNode = rttScene.CreateChild("Box");
				boxNode.position = new Vector3(Random(200.0) - 100.0, Random(200.0) - 100.0, Random(200.0) - 100.0);
				// Orient using random pitch, yaw and roll Euler angles
				boxNode.rotation = new Quaternion(Random(360.0), Random(360.0), Random(360.0));
				var boxObject:StaticModel = boxNode.CreateComponent("StaticModel");
				boxObject.model = new Model("Models/Box.mdl");
				boxObject.material = new Material("Materials/Stone.xml");

				// Add our custom Rotator component which will rotate the scene node each frame, when the scene sends its update event.
				// Simply set same rotation speed for all objects
				var rotator = new Rotator();
				rotator.SetRotationSpeed(new TVector3(10.0, 20.0, 30.0));
				boxNode.AddComponent(rotator);
			}

			// Create a camera for the render-to-texture scene. Simply leave it at the world origin and let it observe the scene
			rttCameraNode = rttScene.CreateChild("Camera");
			var camera:Camera = rttCameraNode.CreateComponent("Camera");
			camera.farClip = 100.0;

			// Create a point light to the camera scene node
			var light:Light = rttCameraNode.CreateComponent("Light");
			light.lightType = LIGHT_POINT;
			light.range = 30.0;
        }
        
        {
            // Create the scene in which we move around
            scene = new Scene();
    
            // Create octree, use also default volume (-1000, -1000, -1000) to (1000, 1000, 1000)
            scene.CreateComponent("Octree");
    
            // Create a Zone component for ambient lighting & fog control
            var zoneNode = scene.CreateChild("Zone");
            var zone:Zone = zoneNode.CreateComponent("Zone");
            zone.boundingBox = new BoundingBox(-1000.0, 1000.0);
            zone.ambientColor = new Color(0.1, 0.1, 0.1);
            zone.fogStart = 100.0;
            zone.fogEnd = 300.0;
    
            // Create a directional light without shadows
            var lightNode = scene.CreateChild("DirectionalLight");
            lightNode.direction = new Vector3(0.5, -1.0, 0.5);
            var light:Light = lightNode.CreateComponent("Light");
            light.lightType = LIGHT_DIRECTIONAL;
            light.color = new Color(0.2, 0.2, 0.2);
            light.specularIntensity = 1.0;
    
            // Create a "floor" consisting of several tiles
            for (y in  -5...5)
            {
                for (x in -5...5)
                {
                    var floorNode = scene.CreateChild("FloorTile");
                    floorNode.position = new Vector3(x * 20.5, -0.5, y * 20.5);
                    floorNode.scale = new Vector3(20.0, 1.0, 20.);
                    var floorObject:StaticModel = floorNode.CreateComponent("StaticModel");
                    floorObject.model =new Model("Models/Box.mdl");
                    floorObject.material = new Material("Materials/Stone.xml");
                }
            }
    
            // Create a "screen" like object for viewing the second scene. Construct it from two StaticModels, a box for the frame
            // and a plane for the actual view
            {
                
                var boxNode = scene.CreateChild("ScreenBox");
                boxNode.position = new Vector3(0.0, 10.0, 0.0);
                boxNode.scale = new Vector3(21.0, 16.0, 0.5);
                var boxObject:StaticModel = boxNode.CreateComponent("StaticModel");
                boxObject.model = new Model("Models/Box.mdl");
                boxObject.material = new Material("Materials/Stone.xml");
    
                var screenNode = scene.CreateChild("Screen");
                screenNode.position = new Vector3(0.0, 10.0, -0.27);
                screenNode.rotation = new Quaternion(-90.0, 0.0, 0.0);
                screenNode.scale = new Vector3(20.0, 0.0, 15.0);

                var screenObject:StaticModel = screenNode.CreateComponent("StaticModel");
                screenObject.model = new Model("Models/Plane.mdl");
    
                // Create a renderable texture (1024x768, RGB format), enable bilinear filtering on it
                var renderTexture:Texture2D = new  Texture2D();
                renderTexture.SetSize(1024, 768, Graphics.GetRGBFormat(), TEXTURE_RENDERTARGET);
                renderTexture.filterMode = FILTER_BILINEAR;
    
                // Create a new material from scratch, use the diffuse unlit technique, assign the render texture
                // as its diffuse texture, then assign the material to the screen plane object
                
                
                var renderMaterial = new Material();
                renderMaterial.SetTechnique(0, new Technique("Techniques/DiffUnlit.xml"));
                renderMaterial.SetTexture(TU_DIFFUSE,renderTexture);
                

                // Since the screen material is on top of the box model and may Z-fight, use negative depth bias
                // to push it forward (particularly necessary on mobiles with possibly less Z resolution)
                
                
                renderMaterial.depthBias = new  BiasParameters(-0.001, 0.0);
                screenObject.material = renderMaterial;
                
                // Get the texture's RenderSurface object (exists when the texture has been created in rendertarget mode)
                // and define the viewport for rendering the second scene, similarly as how backbuffer viewports are defined
                // to the Renderer subsystem. By default the texture viewport will be updated when the texture is visible
                // in the main view

                
                var surface = renderTexture.renderSurface;
                var  rttViewport = new Viewport(rttScene, rttCameraNode.GetComponent("Camera"));
                surface.SetViewport(0,rttViewport);
                 
            }
    
            // Create the camera which we will move around. Limit far clip distance to match the fog
            cameraNode = scene.CreateChild("Camera");
            var camera:Camera = cameraNode.CreateComponent("Camera");
            camera.farClip = 300.0;
    
            // Set an initial position for the camera scene node above the plane
            cameraNode.position = new Vector3(0.0, 7.0, -30.0);
        }
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
	}

	public function HandleUpdate(eventType:StringHash, eventData:VariantMap) {
		var step:Float = eventData["TimeStep"];
		MoveCamera(step);
	}
}
