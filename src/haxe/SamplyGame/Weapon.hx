package samplygame;

import urho3d.*;
import samplygame.Globals.CollisionLayers;

class Weapon extends LogicComponent {
	public function new(?dyn:Dynamic) {
		super(dyn);
	}

	public function OnHit(target:LogicComponent, killed:Bool, bulletNode:Node) {}
}
