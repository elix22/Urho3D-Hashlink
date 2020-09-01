package samplygame;

import actions.ActionManager;
import samplygame.Globals.CollisionLayers;
import actions.ActionManager.ActionID;
import urho3d.*;
import actions.*;

class Coin extends Weapon {
	public function new() {
		super();
		Damage = 0;
	}

	public override function OnFire(byPlayer:Bool) {
		var bulletNode = CreateRigidBullet(byPlayer);

		var model:StaticModel = bulletNode.CreateComponent("StaticModel");
		model.model = new Model("Models/Apple.mdl");
		model.material = new Material("Materials/Apple.xml");

		bulletNode.scale = 0.8;
		bulletNode.rotation = new Quaternion(-40, 0, 0);

		var actions:Array<FiniteTimeAction> = [];
		actions.push(new MoveBy(3.0, new Vector3(0, 10 * (byPlayer ? 1 : -1), 0)));
		actions.push(new RotateBy(3.0, 0, 360 * 5, 0));
		ActionManager.AddAction(new Parallel(actions), bulletNode, this.bulletNodeRemove);
	}

	public function bulletNodeRemove(actionID:ActionID) {
		//	log.Warning("delete coin");
		actionID.DeleteTargets();
	}

	public override function OnHit(target:LogicComponent, killed:Bool, bulletNode:Node) {
		var soundSource:SoundSource = node.CreateComponent("SoundSource");
		var sound = new Sound("Sounds/Powerup.wav");
		if (sound != null) {
			soundSource.Play(sound);
			soundSource.gain = 0.1;
		}

		super.OnHit(target, killed, bulletNode);

		if (SamplyGame.mainGame != null) {
			SamplyGame.mainGame.OnCoinCollected();
		}
	}
}
