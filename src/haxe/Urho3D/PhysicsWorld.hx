package urho3d;

import urho3d.Component.AbstractComponent;

typedef HL_URHO3D_PHYSICS_WORLD = hl.Abstract<"hl_urho3d_physics_physics_world">;

@:hlNative("Urho3D")
abstract PhysicsWorld(HL_URHO3D_PHYSICS_WORLD) {


	@:from
	public static inline function fromComponent(c:AbstractComponent):PhysicsWorld {
		return CastFromComponent(Context.context,c);
	}
	
	public var gravity(get, set):TVector3;

	function set_gravity(g) {
		PhysicsWorld.SetGravity(Context.context, cast this, g);
		return g;
	}

	function get_gravity() {
		return PhysicsWorld.GetGravity(Context.context, cast this);
	}

	public function RaycastSingle(r:TRay, maxDistance:Single, collisionMask:Int):PhysicsRaycastResult {
		if (this != null)
			return _RaycastSingle(Context.context, cast this, r, maxDistance, collisionMask);
		else
			return null;
	}

	@:hlNative("Urho3D", "_physics_physics_world_raycast_single")
	private static function _RaycastSingle(context:Context, o:PhysicsWorld, r:TRay, maxDistance:Single, collisionMask:Int):PhysicsRaycastResult {
		return null;
	}

	@:hlNative("Urho3D", "_physics_physics_world_cast_from_component")
	public static function CastFromComponent(c:Context, s:AbstractComponent):PhysicsWorld {
		return null;
	}

	@:hlNative("Urho3D", "_physics_physics_world_cast_to_component")
	public static function CastToComponent(c:Context, s:PhysicsWorld):AbstractComponent {
		return null;
	}

	@:hlNative("Urho3D", "_physics_physics_world_set_gravity")
	private static function SetGravity(context:Context, o:PhysicsWorld, g:TVector3):Void {}

	@:hlNative("Urho3D", "_physics_physics_world_get_gravity")
	private static function GetGravity(context:Context, o:PhysicsWorld):TVector3 {
		return null;
	}
}
