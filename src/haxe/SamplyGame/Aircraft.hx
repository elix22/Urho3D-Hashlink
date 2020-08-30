package samplygame;

import urho3d.*;
import samplygame.Globals.CollisionLayers;

class Aircraft extends LogicComponent {
	public var Health:Int;
	public var MaxHealth:Int = 30;
	public var level:Int = 0;
	public var CollisionLayer:CollisionLayers = CollisionLayers.Enemy;
	public var CollisionShapeSize = new Vector3(1.2, 1.2, 1.2);
	public var name:String = "";

	public function new(?dyn:Dynamic) {
		super(dyn);
	}

	public function IsAlive():Bool {
		return Health > 0;
	}

	public override function DelayedStart() {}

	public function Play() {
		//	log.Warning("Aircraft::Play() ");
		Health = MaxHealth;
		var body:RigidBody = node.CreateComponent("RigidBody");
		body.mass = 1;
		body.kinematic = true;
		body.collisionMask = CollisionLayer;
		var shape:CollisionShape = node.CreateComponent("CollisionShape");
		shape.SetBox(CollisionShapeSize, new Vector3(0, 0, 0), new Quaternion());
		Init();
		SubscribeToEvent(node, "NodeCollisionStart", "HandleNodeCollision");
	}

	public function Init() {}

	public function HandleNodeCollision(eventType:StringHash, eventData:VariantMap) {
		var bulletNode:Node = eventData["OtherNode"];
		var otherBody:RigidBody = eventData["OtherBody"];
		var body:RigidBody = eventData["Body"];

		if (IsAlive()) {
			var weaponNode:Node = bulletNode.vars["node"];
			var weapons = weaponNode.GetAllLogicComponents();

			for (instance in weapons) {
				if (instance.IsA(Weapon)) {
					var weapon:Weapon = instance;
					var damage = Globals.damageMap[weapon.className];
					Health -= damage;
					var killed = Health <= 0;

					if (killed) {
						Explode();
					} else if (damage > 0) {
						Hit();
					}

					weapon.OnHit(this, killed, bulletNode);
					if (this.name == "Player") {
						SendHealthUpdateToSamplyGame();
					}

					/*assumption is that only 1 script is of type Weapon*/
					break;
				}
			}
		}
	}

	public function SendHealthUpdateToSamplyGame() {}

    public function Hit() 
        {
            var staticModel:StaticModel = node.GetComponent("StaticModel");
            var material = staticModel.material;
            if (material == null)
                return;
        
            material.SetShaderParameter("MatSpecColor",new Color(0, 0, 0, 0));
        }

	public function Explode() {}
}
