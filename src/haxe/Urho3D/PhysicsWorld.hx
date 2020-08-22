package urho3d;

typedef HL_URHO3D_PHYSICS_WORLD = hl.Abstract<"hl_urho3d_physics_physics_world">;

@:hlNative("Urho3D")
abstract PhysicsWorld(HL_URHO3D_PHYSICS_WORLD) {

	public function RaycastSingle(r:TRay, maxDistance:Single, collisionMask:Int):PhysicsRaycastResult {
		if (this != null)
			return _RaycastSingle(Context.context, cast this, r,maxDistance,collisionMask);
		else
			return null;
	}

    //HL_PRIM Urho3D::PhysicsRaycastResult *HL_NAME(_physics_physics_world_raycast_single)(urho3d_context *context, Urho3D::PhysicsWorld *world, hl_urho3d_math_ray *ray, float maxDistance, int collisionMask)

	@:hlNative("Urho3D", "_physics_physics_world_raycast_single")
	private static function _RaycastSingle(context:Context, o:PhysicsWorld, r:TRay, maxDistance:Single, collisionMask:Int):PhysicsRaycastResult {
		return null;
	}
}
