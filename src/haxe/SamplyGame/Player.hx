package samplygame;

import actions.ActionManager;
import samplygame.Globals.CollisionLayers;
import actions.ActionManager.ActionID;
import urho3d.*;
import actions.*;

class Player extends Aircraft {
	var rotor:Node;
	var actionID:ActionID;
    var offsetY = -50;
    

	public function new(?dyn:Dynamic) {
		super(dyn);

		name = "Player";
		CollisionLayer = CollisionLayers.Player;
		CollisionShapeSize = new Vector3(2.4, 1.2, 1.2);
		MaxHealth = 300;
	}

	public override function Init() {
		var model:StaticModel = node.CreateComponent("StaticModel");
		model.model = new Model("Models/Player.mdl");
		model.material = new Material("Materials/Player.xml");
		node.scale = 0.45;
		node.rotation = new Quaternion(-40, 0, 0);
		node.position = new Vector3(0.0, -6.0, 0.0);

		rotor = node.CreateChild();
		var rotorModel:StaticModel = rotor.CreateComponent("StaticModel");
		rotorModel.model = new Model("Models/Box.mdl");
		rotorModel.material = new Material("Materials/Black.xml");
		rotor.scale = new Vector3(0.1, 1.4, 0.1);
		rotor.rotation = new Quaternion(0, 0, 0);
		rotor.position = new Vector3(0, -0.15, 1.2);
		ActionManager.AddAction(new RepeatForever(new RotateBy(1.0, 0, 0, 360.0 * 4)), rotor);

        node.AddLogicComponent(new MachineGun());
        node.AddLogicComponent(new Missile());


		ActionManager.AddAction(new EaseOut(new MoveBy(0.5, new Vector3(0, 3, 0)), 2), node);

		var sequence1:FiniteTimeAction = new Sequence(new EaseBackInOut(new RotateBy(1.0, 0.0, 0.0, 360.0)), new DelayTime(5));
		var sequence2:FiniteTimeAction = new Sequence(new EaseBackInOut(new RotateBy(1.0, 0.0, 0.0, -360.0)), new DelayTime(5));
		ActionManager.AddAction(new RepeatForever(new Sequence(sequence1, sequence2)), node);

		MoveRandomly();
	}

	public override function Update(timeStep:Float) {
		if (IsAlive()) {
		
			var positionX = 0;
			var positionY = 0;
			var hasInput = false;
			if (Input.numTouches > 0) {
				var state = Input.GetTouch(0);
				var touchPosition = state.position;
				positionX = touchPosition.x;
				positionY = touchPosition.y + offsetY;
                hasInput = true;
              
			}

			if (Input.GetMouseButtonDown(MOUSEB_LEFT)) {
				var mousePos = Input.mousePosition;
				positionX = mousePos.x;
				positionY = mousePos.y + offsetY;
                hasInput = true;
			}

			if (hasInput) {
				var destWorldPos = Renderer.viewports[0].ScreenToWorldPoint(positionX, positionY, 10);
                destWorldPos.z = 0;
                node.Translate(destWorldPos - node.worldPosition, TS_WORLD);
                
                var weapons = node.GetLogicComponents(Weapon);

                for (weapon in weapons) {
                    weapon.FireAsync(true);
                }
			}

			node.LookAt(new TVector3(0, node.worldPosition.y + 10, 10), new TVector3(0, 1, -1), TS_WORLD);
		}
	}

	public function MoveRandomly() {
		if (IsAlive()) {
			var moveAction:FiniteTimeAction = new MoveBy(0.75, new Vector3(Random(-0.4, 0.4), Random(-0.4, 0.4), 0));
			ActionManager.AddAction(new Sequence(moveAction, moveAction.Reverse()), node, this.RandmoMoveDone);
		}
	}

	public function RandmoMoveDone(actionID:ActionID) {
		if (IsAlive()) {
			var moveAction:FiniteTimeAction = new MoveBy(0.75, new Vector3(Random(-0.4, 0.4), Random(-0.4, 0.4), 0));
			ActionManager.AddAction(new Sequence(moveAction, moveAction.Reverse()), node, this.RandmoMoveDone);
		}
	}

	public override function OnExplode(explodeNode:Node) {
		ActionManager.RemoveAllActions(rotor);
		rotor.Remove();

		explodeNode.scale = 1.5;
		var particleEmitter:ParticleEmitter2D = explodeNode.CreateComponent("ParticleEmitter2D");
		var particleEffect:ParticleEffect2D = new ParticleEffect2D("Particles/PlayerExplosion.pex");
		particleEmitter.effect = particleEffect;
    }
    
    public override function SendHealthUpdateToSamplyGame() 
	{
		if(SamplyGame.mainGame != null)
		{
			var h = cast(Health,Float) / MaxHealth;
			h *= 100.0;
			SamplyGame.mainGame.OnPlayerHealthUpdate(h);
		}
	}
}
