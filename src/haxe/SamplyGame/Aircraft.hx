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
    
    public override function DelayedStart() {

    }

    public function Play()
	{
	//	log.Warning("Aircraft::Play() ");
		Health = MaxHealth;
	    var body:RigidBody = node.CreateComponent("RigidBody");
		body.mass = 1;
		//body.kinematic = true;
	//	body.collisionMask = CollisionLayer;
		var shape:CollisionShape = node.CreateComponent("CollisionShape");
		shape.SetBox(CollisionShapeSize,new Vector3(0,0,0), new Quaternion());
		Init();
		SubscribeToEvent(node, "NodeCollisionStart", "HandleNodeCollision");		
    }
    
    public function  Init() {}
	
    public function  HandleNodeCollision( eventType:StringHash,  eventData:VariantMap)
    {	

    }
}
