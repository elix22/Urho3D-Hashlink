import urho3d.LogicComponent.AbstractLogicComponent;
import urho3d.*;
import urho3d.Application;
import utils.*;

class CharacterDemoSample extends Application {
	private var scene:Scene = null;
	private var cameraNode:Node = null;
	private var characterNode:Node = null;
	var firstPerson:Bool = false;

	final CTRL_FORWARD = 1;
	final CTRL_BACK = 2;
	final CTRL_LEFT = 4;
	final CTRL_RIGHT = 8;
	final CTRL_JUMP = 16;

	final MOVE_FORCE = 0.8;
	final INAIR_MOVE_FORCE = 0.02;
	final BRAKE_FORCE = 0.2;
	final JUMP_FORCE = 7.0;
	final YAW_SENSITIVITY = 0.1;
	final INAIR_THRESHOLD_TIME = 0.1;
	final cameraDistance = 5.0;
	final CAMERA_MIN_DIST = 1.0;

	// Create XML patch instructions for screen joystick layout specific to this sample app
	var patchInstructions:String = "<patch>"
		+ "    <add sel=\"/element\">"
		+ "        <element type=\"Button\">"
		+ "            <attribute name=\"Name\" value=\"Button3\" />"
		+ "            <attribute name=\"Position\" value=\"-120 -120\" />"
		+ "            <attribute name=\"Size\" value=\"96 96\" />"
		+ "            <attribute name=\"Horiz Alignment\" value=\"Right\" />"
		+ "            <attribute name=\"Vert Alignment\" value=\"Bottom\" />"
		+ "            <attribute name=\"Texture\" value=\"Texture2D;Textures/TouchInput.png\" />"
		+ "            <attribute name=\"Image Rect\" value=\"96 0 192 96\" />"
		+ "            <attribute name=\"Hover Image Offset\" value=\"0 0\" />"
		+ "            <attribute name=\"Pressed Image Offset\" value=\"0 0\" />"
		+ "            <element type=\"Text\">"
		+ "                <attribute name=\"Name\" value=\"Label\" />"
		+ "                <attribute name=\"Horiz Alignment\" value=\"Center\" />"
		+ "                <attribute name=\"Vert Alignment\" value=\"Center\" />"
		+ "                <attribute name=\"Color\" value=\"0 0 0 1\" />"
		+ "                <attribute name=\"Text\" value=\"Gyroscope\" />"
		+ "            </element>"
		+ "            <element type=\"Text\">"
		+ "                <attribute name=\"Name\" value=\"KeyBinding\" />"
		+ "                <attribute name=\"Text\" value=\"G\" />"
		+ "            </element>"
		+ "        </element>"
		+ "    </add>"
		+ "    <remove sel=\"/element/element[./attribute[@name='Name' and @value='Button0']]/attribute[@name='Is Visible']\" />"
		+
		"    <replace sel=\"/element/element[./attribute[@name='Name' and @value='Button0']]/element[./attribute[@name='Name' and @value='Label']]/attribute[@name='Text']/@value\">1st/3rd</replace>"
		+ "    <add sel=\"/element/element[./attribute[@name='Name' and @value='Button0']]\">"
		+ "        <element type=\"Text\">"
		+ "            <attribute name=\"Name\" value=\"KeyBinding\" />"
		+ "            <attribute name=\"Text\" value=\"F\" />"
		+ "        </element>"
		+ "    </add>"
		+ "    <remove sel=\"/element/element[./attribute[@name='Name' and @value='Button1']]/attribute[@name='Is Visible']\" />"
		+
		"    <replace sel=\"/element/element[./attribute[@name='Name' and @value='Button1']]/element[./attribute[@name='Name' and @value='Label']]/attribute[@name='Text']/@value\">Jump</replace>"
		+ "    <add sel=\"/element/element[./attribute[@name='Name' and @value='Button1']]\">"
		+ "        <element type=\"Text\">"
		+ "            <attribute name=\"Name\" value=\"KeyBinding\" />"
		+ "            <attribute name=\"Text\" value=\"SPACE\" />"
		+ "        </element>"
		+ "    </add>"
		+ "</patch>";

	public override function Setup() {
		trace("Setup");
		this.SetScreenJoystickPatchString(patchInstructions);
	}

	public override function Start() {
		CreateScene();
		// Create the controllable character
		CreateCharacter();
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
		cameraNode.position = new Vector3(0.0, 2.0, -5.0);
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

	function CreateCharacter() {
		characterNode = scene.CreateChild("Jack");
		characterNode.position = new Vector3(0.0, 1.0, 0.0);

		var adjNode = characterNode.CreateChild("AdjNode");
		adjNode.rotation = new Quaternion(180.0, Vector3.UP);

		// Create the rendering component + animation controller
		var object:AnimatedModel = adjNode.CreateComponent("AnimatedModel");
		object.model = new Model("Models/Mutant/Mutant.mdl");
		object.material = new Material("Models/Mutant/Materials/mutant_M.xml");
		object.castShadows = true;
		adjNode.CreateComponent("AnimationController");

		// Set the head bone for manual control
		object.skeleton.GetBone("Mutant:Head").animated = false;

		// Create rigidbody, and set non-zero mass so that the body becomes dynamic
		var body:RigidBody = characterNode.CreateComponent("RigidBody");
		body.collisionLayer = 1;
		body.mass = 1.0;

		// Set zero angular factor so that physics doesn't turn the character on its own.
		// Instead we will control the character yaw manually
		body.angularFactor = Vector3.ZERO;

		// Set the rigidbody to signal collision also when in rest, so that we get ground collisions properly
		body.collisionEventMode = COLLISION_ALWAYS;

		// Set a capsule shape for collision
		var shape:CollisionShape = characterNode.CreateComponent("CollisionShape");
		shape.SetCapsule(0.7, 1.8, new Vector3(0.0, 0.9, 0.0));

		// Create the character logic object, which takes care of steering the rigidbody
		characterNode.AddLogicComponent(new Character());
	}

	public function SubscribeToEvents() {
		SubscribeToEvent("Update", "HandleUpdate");
		// Subscribe to PostUpdate event for updating the camera position after physics simulation
		SubscribeToEvent("PostUpdate", "HandlePostUpdate");
	}

	public function HandlePostUpdate(eventType:StringHash, eventData:VariantMap) {
		// var step:Float = eventData["TimeStep"];

		if (characterNode == null)
			return;

		var character:Character = characterNode.GetLogicComponent(Character);
		if (character == null)
			return;

		// Get camera lookat dir from character yaw + pitch
		var rot = characterNode.rotation;
		var dir = rot * (new TQuaternion(character.controls.pitch, Vector3.RIGHT));

		// Turn head to camera pitch, but limit to avoid unnatural animation
		var headNode = characterNode.GetChild("Mutant:Head", true);
		var limitPitch = Clamp(character.controls.pitch, -45.0, 45.0);
		var headDir = rot * new TQuaternion(limitPitch, new TVector3(1.0, 0.0, 0.0));
		// This could be expanded to look at an arbitrary target, now just look at a point in front
		var headWorldTarget = headNode.worldPosition + headDir * new TVector3(0.0, 0.0, -1.0);
		headNode.LookAt(headWorldTarget, new TVector3(0.0, 1.0, 0.0));

		if (firstPerson) {
			// First person camera: position to the head bone + offset slightly forward & up
			cameraNode.position = headNode.worldPosition + rot * new TVector3(0.0 , 0.15 , 0.2 );
			cameraNode.rotation = dir;
		} else {
			// Third person camera: position behind the character
			var aimPoint = characterNode.position + rot * new TVector3(0.0, 1.7, 0.0);
			// You can modify x Vector3 value to translate the fixed character position (indicative range[-2;2])

			// Collide camera ray with static physics objects (layer bitmask 2) to ensure we see the character properly
			var rayDir = dir * Vector3.BACK; // For indoor scenes you can use dir * Vector3(0.0, 0.0, -0.5) to prevent camera from crossing the walls
			var rayDistance = cameraDistance;

			var result:PhysicsRaycastResult = scene.physicsWorld.RaycastSingle(new TRay(aimPoint, rayDir), rayDistance, 2);
			if (result.body != null)
				rayDistance = Math.min(rayDistance, result.distance);
			rayDistance = Clamp(rayDistance, CAMERA_MIN_DIST, cameraDistance);

			cameraNode.position = aimPoint + rayDir * rayDistance;
			cameraNode.rotation = dir;
		}
	}

	public function HandleUpdate(eventType:StringHash, eventData:VariantMap) {
		if (characterNode == null)
			return;

		var character:Character = characterNode.GetLogicComponent(Character);

		// Clear previous controls
		character.controls.Set(CTRL_FORWARD | CTRL_BACK | CTRL_LEFT | CTRL_RIGHT | CTRL_JUMP, false);

		// if (IsTouchEnabled() /*|| !useGyroscope*/) {

		character.controls.Set(CTRL_FORWARD, Input.GetKeyDown(KEY_W));
		character.controls.Set(CTRL_BACK, Input.GetKeyDown(KEY_S));
		character.controls.Set(CTRL_LEFT, Input.GetKeyDown(KEY_A));
		character.controls.Set(CTRL_RIGHT, Input.GetKeyDown(KEY_D));

		// }

		character.controls.Set(CTRL_JUMP, Input.GetKeyDown(KEY_SPACE));

		if (Input.numTouches > 0) {
			var camera:Camera = cameraNode.GetComponent("Camera");
			final TOUCH_SENSITIVITY = 2.0;

			if (camera != null) {
				for (i in 0...Input.numTouches) {
					var state = Input.GetTouch(i);

					if (state.delta.x != 0 || state.delta.y != 0) {
						character.controls.yaw += TOUCH_SENSITIVITY * camera.fov / Graphics.height * state.delta.x;
						character.controls.pitch += TOUCH_SENSITIVITY * camera.fov / Graphics.height * state.delta.y;
					}
				}
			}
		} else {
			character.controls.yaw += Input.mouseMoveX * YAW_SENSITIVITY;
			character.controls.pitch += Input.mouseMoveY * YAW_SENSITIVITY;
		}

		// Limit pitch
		character.controls.pitch = Clamp(character.controls.pitch, -80.0, 80.0);
		// Set rotation already here so that it's updated every rendering frame instead of every physics frame
		characterNode.rotation = new TQuaternion(character.controls.yaw, Vector3.UP);

		// Switch between 1st and 3rd person
		if (Input.GetKeyPress(KEY_F))
			firstPerson = !firstPerson;

		// Check for loading / saving the scene
		if (Input.GetKeyPress(KEY_F5)) {
			var saved = scene.SaveXML("CharacterDemo.xml");
			trace("SaveXML = " + saved);
		}
		if (Input.GetKeyPress(KEY_F7)) {
			scene.LoadXML("CharacterDemo.xml");
			// After loading we have to reacquire the character scene node, as it has been recreated
			// Simply find by name as there's only one of them
			characterNode = scene.GetChild("Jack", true);
		}
	}
}
