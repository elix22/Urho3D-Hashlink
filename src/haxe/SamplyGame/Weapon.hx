package samplygame;

import haxe.Int64;
import urho3d.*;
import samplygame.Globals.CollisionLayers;

class Weapon extends LogicComponent {
	public var isInited = false;
	public var LastLaunchDate = 0;
	public var ReloadDuration = 500;
	public var Damage = 1;
	public var level = 0;

	public function new(?dyn:Dynamic) {
		super(dyn);
	}

	public var IsReloading(get, never):Bool;

	function get_IsReloading() {
		return LastLaunchDate + ReloadDuration > Time.systemTime;
	}

	public function OnHit(target:LogicComponent, killed:Bool, bulletNode:Node) {
		var body:RigidBody = bulletNode.GetComponent("RigidBody");
		if (body != null)
			body.enabled = false;
		bulletNode.scale = 0;
	}

	public function Stop() {}

	public function FireAsync(byPlayer:Bool):Bool {
		if (!isInited) {
			isInited = true;
			Init();
		}

		if (IsReloading) {
			return false;
		}

		LastLaunchDate = Time.systemTime;
		OnFire(byPlayer);
		return true;
	}

	public function Init() {}

	public function CreateRigidBullet(byPlayer:Bool, collisionBox:Vector3):Node {
		var carrier = node;
		var bullet:Node = scene.CreateChild("bullet");
		bullet.position = carrier.position;
		var body:RigidBody = bullet.CreateComponent("RigidBody");
		var shape:CollisionShape = bullet.CreateComponent("CollisionShape");
		shape.SetBox(collisionBox, new Vector3(0, 0, 0), new Quaternion());
		body.kinematic = true;
		body.collisionLayer = byPlayer ? CollisionLayers.Enemy : CollisionLayers.Player;
		bullet.vars["node"] = node;
		return bullet;
	}

	public function OnFire(byPlayer:Bool) {}
}
