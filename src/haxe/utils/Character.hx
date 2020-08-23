package utils;

import urho3d.*;
import urho3d.Controls;
import Type;
import Reflect;

class Character extends LogicComponent {
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

	 var testVar:Int = 456;
	 var testVarSingle:Single = 567.034;
	 var test3:hl.UI8 = 45;
	 var test4:hl.UI16;
	 var test5:Float;

	// Character controls.
	public var controls:Controls = new Controls();
	// Grounded flag for movement.
	var onGround = false;
	// Jump flag.
	var okToJump = true;
	// In air timer. Due to possible physics inaccuracy, character can be off ground for max. 1/10 second and still be allowed to move.
	var inAirTimer = 0.0;

	public function new(?dyn:Dynamic) {
		super(dyn);
	}

	public override function Start() {
	//	trace("Start");
		this.updateEventMask = USE_FIXEDUPDATE;
		SubscribeToEvent(node, "NodeCollision", "HandleNodeCollision");
	}
	public override function DelayedStart() {
	//	trace("DelayedStart");
	}

	public override function FixedUpdate(timeStep:Float) {
		/// \todo Could cache the components for faster access instead of finding them each frame
		var body:RigidBody = node.GetComponent("RigidBody");
		var animCtrl:AnimationController = node.GetComponent("AnimationController", true);

		// Update the in air timer. Reset if grounded
		if (!onGround)
			inAirTimer += timeStep;
		else
			inAirTimer = 0.0;
		// When character has been in air less than 1/10 second, it's still interpreted as being on ground
		var softGrounded = inAirTimer < INAIR_THRESHOLD_TIME;

		// Update movement & animation
		var rot = node.rotation;
		var moveDir = new Vector3(0.0, 0.0, 0.0);
		var velocity = body.linearVelocity;
		// Velocity on the XZ plane
		var planeVelocity = new Vector3(velocity.x, 0.0, velocity.z);

		if (controls.IsDown(CTRL_FORWARD))
			moveDir += Vector3.FORWARD;
		if (controls.IsDown(CTRL_BACK))
			moveDir += Vector3.BACK;
		if (controls.IsDown(CTRL_LEFT))
			moveDir += Vector3.LEFT;
		if (controls.IsDown(CTRL_RIGHT))
			moveDir += Vector3.RIGHT;

		// Normalize move vector so that diagonal strafing is not faster
		if (moveDir.LengthSquared() > 0.0)
			moveDir.Normalize();

		// If in air, allow control, but slower than when on ground
		body.ApplyImpulse(rot * moveDir * (softGrounded ? MOVE_FORCE : INAIR_MOVE_FORCE));

		if (softGrounded) {
			// When on ground, apply a braking force to limit maximum ground velocity
			var brakeForce = -planeVelocity * BRAKE_FORCE;
			body.ApplyImpulse(brakeForce);

			// Jump. Must release jump control between jumps
			if (controls.IsDown(CTRL_JUMP)) {
				if (okToJump) {
					body.ApplyImpulse(Vector3.UP * JUMP_FORCE);
					okToJump = false;
					animCtrl.PlayExclusive("Models/Mutant/Mutant_Jump1.ani", 0, false, 0.2);
				}
			} else
				okToJump = true;
		}

		if (!onGround) {
			animCtrl.PlayExclusive("Models/Mutant/Mutant_Jump1.ani", 0, false, 0.2);
		} else {
			// Play walk animation if moving on ground, otherwise fade it out
			if (softGrounded && !moveDir.Equals(Vector3.ZERO)) {
				animCtrl.PlayExclusive("Models/Mutant/Mutant_Run.ani", 0, true, 0.2);
				// Set walk animation speed proportional to velocity
				animCtrl.SetSpeed("Models/Mutant/Mutant_Run.ani", planeVelocity.Length() * 0.3);
			} else
				animCtrl.PlayExclusive("Models/Mutant/Mutant_Idle0.ani", 0, true, 0.2);
		}

		// Reset grounded flag for next frame
		onGround = false;
	}

	function HandleNodeCollision(eventType:StringHash, eventData:VariantMap) {
		// trace("HandleNodeCollision");
		var contacts:TVectorBuffer = eventData["Contacts"];

		while (!contacts.eof) {
			var contactPosition = contacts.ReadVector3();
			var contactNormal = contacts.ReadVector3();
			var contactDistance = contacts.ReadFloat();
			var contactImpulse = contacts.ReadFloat();

			// If contact is below node center and pointing up, assume it's a ground contact
			if (contactPosition.y < (node.position.y + 1.0)) {
				var level = contactNormal.y;
				if (level > 0.75)
					onGround = true;
			}
		}
	}
}
