import hl.uv.Stream;
import urho3d.*;
import urho3d.CollisionShape.ShapeType;
import urho3d.Constraint.ConstraintType;

class CreateRagdoll extends LogicComponent {
	public function new() {
		super();
	}

	public override function Start() {
		// Subscribe physics collisions that concern this scene node
		SubscribeToEvent(node, "NodeCollisionStart", "HandleNodeCollision");
	}

	function HandleNodeCollision(eventType:StringHash, eventData:VariantMap) {
		var otherBody:RigidBody = eventData["OtherBody"];

		if (otherBody.mass > 0.0) {
			// We do not need the physics components in the AnimatedModel's root scene node anymore
			node.RemoveComponent("RigidBody");
			node.RemoveComponent("CollisionShape");
			// Create RigidBody & CollisionShape components to bones
			CreateRagdollBone("Bip01_Pelvis", SHAPE_BOX, new Vector3(0.3, 0.2, 0.25), new Vector3(0.0, 0.0, 0.0), new Quaternion(0.0, 0.0, 0.0));
			CreateRagdollBone("Bip01_Spine1", SHAPE_BOX, new Vector3(0.35, 0.2, 0.3), new Vector3(0.15, 0.0, 0.0), new Quaternion(0.0, 0.0, 0.0));
			CreateRagdollBone("Bip01_L_Thigh", SHAPE_CAPSULE, new Vector3(0.175, 0.45, 0.175), new Vector3(0.25, 0.0, 0.0), new Quaternion(0.0, 0.0, 90.0));
			CreateRagdollBone("Bip01_R_Thigh", SHAPE_CAPSULE, new Vector3(0.175, 0.45, 0.175), new Vector3(0.25, 0.0, 0.0), new Quaternion(0.0, 0.0, 90.0));
			CreateRagdollBone("Bip01_L_Calf", SHAPE_CAPSULE, new Vector3(0.15, 0.55, 0.15), new Vector3(0.25, 0.0, 0.0), new Quaternion(0.0, 0.0, 90.0));
			CreateRagdollBone("Bip01_R_Calf", SHAPE_CAPSULE, new Vector3(0.15, 0.55, 0.15), new Vector3(0.25, 0.0, 0.0), new Quaternion(0.0, 0.0, 90.0));
			CreateRagdollBone("Bip01_Head", SHAPE_BOX, new Vector3(0.2, 0.2, 0.2), new Vector3(0.1, 0.0, 0.0), new Quaternion(0.0, 0.0, 0.0));
			CreateRagdollBone("Bip01_L_UpperArm", SHAPE_CAPSULE, new Vector3(0.15, 0.35, 0.15), new Vector3(0.1, 0.0, 0.0), new Quaternion(0.0, 0.0, 90.0));
			CreateRagdollBone("Bip01_R_UpperArm", SHAPE_CAPSULE, new Vector3(0.15, 0.35, 0.15), new Vector3(0.1, 0.0, 0.0), new Quaternion(0.0, 0.0, 90.0));
			CreateRagdollBone("Bip01_L_Forearm", SHAPE_CAPSULE, new Vector3(0.125, 0.4, 0.125), new Vector3(0.2, 0.0, 0.0), new Quaternion(0.0, 0.0, 90.0));
			CreateRagdollBone("Bip01_R_Forearm", SHAPE_CAPSULE, new Vector3(0.125, 0.4, 0.125), new Vector3(0.2, 0.0, 0.0), new Quaternion(0.0, 0.0, 90.0));

			// Create Constraints between bones
			CreateRagdollConstraint("Bip01_L_Thigh", "Bip01_Pelvis", CONSTRAINT_CONETWIST, Vector3.BACK, Vector3.FORWARD, new Vector2(45.0 , 45.0 ), Vector2.ZERO);
			CreateRagdollConstraint("Bip01_R_Thigh", "Bip01_Pelvis", CONSTRAINT_CONETWIST, Vector3.BACK, Vector3.FORWARD, new Vector2(45.0 , 45.0 ), Vector2.ZERO);
			CreateRagdollConstraint("Bip01_L_Calf", "Bip01_L_Thigh", CONSTRAINT_HINGE, Vector3.BACK, Vector3.BACK, new Vector2(90.0 , 0.0 ), Vector2.ZERO);
			CreateRagdollConstraint("Bip01_R_Calf", "Bip01_R_Thigh", CONSTRAINT_HINGE, Vector3.BACK, Vector3.BACK, new Vector2(90.0 , 0.0 ), Vector2.ZERO);
			CreateRagdollConstraint("Bip01_Spine1", "Bip01_Pelvis", CONSTRAINT_HINGE, Vector3.FORWARD, Vector3.FORWARD, new Vector2(45.0 , 0.0 ), new Vector2(-10.0 , 0.0 ));
			CreateRagdollConstraint("Bip01_Head", "Bip01_Spine1", CONSTRAINT_CONETWIST, Vector3.LEFT, Vector3.LEFT, new Vector2(0.0 , 30.0 ), Vector2.ZERO);
			CreateRagdollConstraint("Bip01_L_UpperArm", "Bip01_Spine1", CONSTRAINT_CONETWIST, Vector3.DOWN, Vector3.UP, new Vector2(45.0 , 45.0 ), Vector2.ZERO, false);
			CreateRagdollConstraint("Bip01_R_UpperArm", "Bip01_Spine1", CONSTRAINT_CONETWIST, Vector3.DOWN, Vector3.UP, new Vector2(45.0 , 45.0 ), Vector2.ZERO, false);
			CreateRagdollConstraint("Bip01_L_Forearm", "Bip01_L_UpperArm", CONSTRAINT_HINGE, Vector3.BACK, Vector3.BACK, new Vector2(90.0 , 0.0 ), Vector2.ZERO);
			CreateRagdollConstraint("Bip01_R_Forearm", "Bip01_R_UpperArm", CONSTRAINT_HINGE, Vector3.BACK, Vector3.BACK,new  Vector2(90.0 , 0.0 ), Vector2.ZERO);
		}
	}

	function CreateRagdollBone(boneName:String, type:ShapeType, size:Vector3, position:Vector3, rotation:Quaternion) {
		var boneNode = node.GetChild(boneName, true);
		if (boneNode == null) {
			trace("Could not find bone " + boneName + " for creating ragdoll physics components");
			return;
		}

		var body:RigidBody = boneNode.CreateComponent("RigidBody");
		// Set mass to make movable
		body.mass = 1.0;
		// Set damping parameters to smooth out the motion
		body.linearDamping = 0.05;
		body.angularDamping = 0.85;
		// Set rest thresholds to ensure the ragdoll rigid bodies come to rest to not consume CPU endlessly
		body.linearRestThreshold = 1.5;
		body.angularRestThreshold = 2.5;

		var shape:CollisionShape = boneNode.CreateComponent("CollisionShape");
		// We use either a box or a capsule shape for all of the bones
		if (type == SHAPE_BOX)
			shape.SetBox(size, position, rotation);
		else
			shape.SetCapsule(size.x, size.y, position, rotation);
	}

	function CreateRagdollConstraint(boneName:String, parentName:String, type:ConstraintType, axis:Vector3, parentAxis:Vector3, highLimit:Vector2,
			lowLimit:Vector2, disableCollision:Bool = true) {
		var boneNode = node.GetChild(boneName, true);
		var parentNode = node.GetChild(parentName, true);
		if (boneNode == null) {
			trace("Could not find bone " + boneName + " for creating ragdoll constraint");
			return;
		}
		if (parentNode == null) {
			trace("Could not find bone " + parentName + " for creating ragdoll constraint");
			return;
		}

		var constraint:Constraint = boneNode.CreateComponent("Constraint");
		constraint.constraintType = type;
        // Most of the constraints in the ragdoll will work better when the connected bodies don't collide against each other
        constraint.disableCollision = disableCollision;
        // The connected body must be specified before setting the world position
        constraint.otherBody = parentNode.GetComponent("RigidBody");
        // Position the constraint at the child bone we are connecting
        constraint.worldPosition = boneNode.worldPosition;
        // Configure axes and limits
        constraint.axis = axis;
        constraint.otherAxis = parentAxis;
        constraint.highLimit = highLimit;
        constraint.lowLimit = lowLimit;
	}
}

class RagdollsSample extends Application {
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

		// Create octree, use default volume (-1000, -1000, -1000) to (1000, 1000, 1000)
		// Create a physics simulation world with default parameters, which will update at 60fps. Like the Octree must
		// exist before creating drawable components, the PhysicsWorld must exist before creating physics components.
		// Finally, create a DebugRenderer component so that we can draw physics debug geometry
		scene.CreateComponent("Octree");
		scene.CreateComponent("PhysicsWorld");
		scene.CreateComponent("DebugRenderer");

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

		{
			// Create a floor object, 500 x 500 world units. Adjust position so that the ground is at zero Y
			var floorNode = scene.CreateChild("Floor");
			floorNode.position = new Vector3(0.0, -0.5, 0.0);
			floorNode.scale = new Vector3(500.0, 1.0, 500.0);
			var floorObject:StaticModel = floorNode.CreateComponent("StaticModel");
			floorObject.model = new Model("Models/Box.mdl");
			floorObject.material = new Material("Materials/StoneTiled.xml");

			// Make the floor physical by adding RigidBody and CollisionShape components
			var body:RigidBody = floorNode.CreateComponent("RigidBody");
			// We will be spawning spherical objects in this sample. The ground also needs non-zero rolling friction so that
			// the spheres will eventually come to rest
			body.rollingFriction = 0.15;
			var shape:CollisionShape = floorNode.CreateComponent("CollisionShape");
			// Set a box shape of size 1 x 1 x 1 for collision. The shape will be scaled with the scene node scale, so the
			// rendering and physics representation sizes should match (the box model is also 1 x 1 x 1.)
			shape.SetBox(Vector3.ONE);
		}

		// Create animated models
		for (z in -1...1) {
			for (x in -4...4) {
				var modelNode = scene.CreateChild("Jack");
				modelNode.position = new Vector3(x * 5.0, 0.0, z * 5.0);
				modelNode.rotation = new Quaternion(0.0, 180.0, 0.0);
				var modelObject:AnimatedModel = modelNode.CreateComponent("AnimatedModel");
				modelObject.model = new Model("Models/Jack.mdl");
				modelObject.material = new Material("Materials/Jack.xml");
				modelObject.castShadows = true;
				// Set the model to also update when invisible to avoid staying invisible when the model should come into
				// view, but does not as the bounding box is not updated
				modelObject.updateInvisible = true;

				// Create a rigid body and a collision shape. These will act as a trigger for transforming the
				// model into a ragdoll when hit by a moving object
				var body:RigidBody = modelNode.CreateComponent("RigidBody");
				// The trigger mode makes the rigid body only detect collisions, but impart no forces on the
				// colliding objects
				body.trigger = true;
				var shape:CollisionShape = modelNode.CreateComponent("CollisionShape");
				// Create the capsule shape with an offset so that it is correctly aligned with the model, which
				// has its origin at the feet
				shape.SetCapsule(0.7, 2.0, new Vector3(0.0, 1.0, 0.0));

				// Create a custom script object that reacts to collisions and creates the ragdoll
				// modelNode.CreateScriptObject(scriptFile, "CreateRagdoll");
				modelNode.AddComponent(new CreateRagdoll());
			}
		}

		cameraNode = scene.CreateChild("Camera");
		var camera:Camera = cameraNode.CreateComponent("Camera");
		cameraNode.position = new TVector3(0.0, 5.0, -20.0);
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

		// "Shoot" a physics object with left mousebutton
		if (Input.GetMouseButtonPress(MOUSEB_LEFT))
			SpawnObject();
	}

	public function HandleUpdate(eventType:StringHash, eventData:VariantMap) {
		var step:Float = eventData["TimeStep"];
		MoveCamera(step);
	}

	function SpawnObject() {
		var boxNode = scene.CreateChild("Sphere");
		boxNode.position = cameraNode.position;
		boxNode.rotation = cameraNode.rotation;
		boxNode.scale = 0.25;
		var boxObject:StaticModel = boxNode.CreateComponent("StaticModel");
		boxObject.model = new Model("Models/Sphere.mdl");
		boxObject.material = new Material("Materials/StoneSmall.xml");
		boxObject.castShadows = true;

		var body:RigidBody = boxNode.CreateComponent("RigidBody");
		body.mass = 1.0;
		body.rollingFriction = 0.15;
		var shape:CollisionShape = boxNode.CreateComponent("CollisionShape");
		shape.SetSphere(1.0);

		final OBJECT_VELOCITY = 10.0;

		// Set initial velocity for the RigidBody based on camera forward vector. Add also a slight up component
		// to overcome gravity better
		body.linearVelocity = cameraNode.rotation * new TVector3(0.0, 0.25, 1.0) * OBJECT_VELOCITY;
	}
}
