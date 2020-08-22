package urho3d;

typedef HL_URHO3D_PHYSICS_RAYCAST_RESULT = hl.Abstract<"hl_urho3d_physics_raycast_result">;

@:hlNative("Urho3D")
abstract PhysicsRaycastResult(HL_URHO3D_PHYSICS_RAYCAST_RESULT) {
    
    public var position(get, never):TVector3;
	function get_position() {
		return GetPosition(cast this);
    }
    
    public var normal(get, never):TVector3;
	function get_normal() {
		return GetNormal(cast this);
    }
    
    public var distance(get, never):Float;
	function get_distance() {
		return GetDistance(cast this);
    }

    public var hitFraction(get, never):Float;
	function get_hitFraction() {
		return GetDistance(cast this);
    }

    public var body(get, never):TRigidBody;
	function get_body() {
		return GetRigidBody(cast this);
    }

	@:hlNative("Urho3D", "_physics_raycast_result_get_position")
	private static function GetPosition(r:PhysicsRaycastResult):TVector3 {
		return null;
	}

	@:hlNative("Urho3D", "_physics_raycast_result_get_normal")
	private static function GetNormal(r:PhysicsRaycastResult):TVector3 {
		return null;
	}

	@:hlNative("Urho3D", "_physics_raycast_result_get_distance")
	private static function GetDistance(r:PhysicsRaycastResult):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_physics_raycast_result_get_hit_friction")
	private static function GetHitFriction(r:PhysicsRaycastResult):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_physics_raycast_result_get_rigid_body")
	private static function GetRigidBody(r:PhysicsRaycastResult):TRigidBody {
		return null;
	}
}
