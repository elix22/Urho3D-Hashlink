package samplygame;

import actions.*;
import actions.ActionManager;
import actions.ActionManager.ActionID;
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

	public function Hit() {
		var staticModel:StaticModel = node.GetComponent("StaticModel");
		var material = staticModel.material;
		if (material == null)
			return;

		material.SetShaderParameter("MatSpecColor", new Color(0, 0, 0, 0));
		var specColorAnimation:ValueAnimation = new ValueAnimation();
		specColorAnimation.SetKeyFrame(0.0, new Color(1.0, 1.0, 1.0, 0.5));
		specColorAnimation.SetKeyFrame(0.1, new Color(0, 0, 0, 0));
		material.SetShaderParameterAnimation("MatSpecColor", specColorAnimation, WM_ONCE, 1.0);
	}

	public function Explode() {
		Health = 0;
		var explosionNode = scene.CreateChild();
		var soundSource:SoundSource = explosionNode.CreateComponent("SoundSource");
		var sound = new Sound("Sounds/BigExplosion.wav");
		if (sound != null) {
			soundSource.Play(sound);
			// In case we also play music, set the sound volume below maximum so that we don't clip the output
			soundSource.gain = 0.5;
			// Set the sound component to automatically remove its scene node from the scene when the sound is done playing
			soundSource.autoRemoveMode = REMOVE_COMPONENT;
		}

		explosionNode.position = node.worldPosition;
		OnExplode(explosionNode);
		ActionManager.actionManager.RemoveAllActions(node);
		node.scale = 0.0;

		var group:ActionGroup = new ActionGroup();
		group.Push(new ScaleTo(1.0, 0.0), explosionNode);
		group.Push(new DelayTime(1.0), explosionNode);
		ActionManager.actionManager.AddActions(group, this.ExplodeDone);
	}

	public function OnExplode(explodeNode:Node) {
		explodeNode.scale = 2.0;

		var particleEmitter:ParticleEmitter2D = explodeNode.CreateComponent("ParticleEmitter2D");
		var particleEffect = new ParticleEffect2D("Particles/Explosion.pex");
		particleEmitter.effect = particleEffect;
	}

	public function ExplodeDone(actionID:ActionID) {
		actionID.DeleteTargets();

		var weapons = node.GetAllLogicComponents();

		for (instance in weapons) {
			if (instance.IsA(Weapon)) {
				var weapon:Weapon = instance;
				weapon.Stop();
			}
		}

		ActionManager.actionManager.AddAction(new DelayTime(5.0), node, this.DisableNode);
	}

	public function DisableNode(actionID:ActionID) {
		// log.Warning("DisableNode");
		node.enabled = false;
		node.Remove();
	}
}
