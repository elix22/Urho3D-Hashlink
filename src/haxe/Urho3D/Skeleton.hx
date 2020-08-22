package urho3d;

typedef HL_URHO3D_SKELETON = hl.Abstract<"hl_urho3d_graphics_skeleton">;

@:hlNative("Urho3D")
abstract Skeleton(HL_URHO3D_SKELETON) {
	public inline function GetBone(name:String) {
		return _GetBone(Context.context, cast this, name);
	}

	// DEFINE_PRIM(HL_URHO3D_BONE, _graphics_skeleton_get_bone, URHO3D_CONTEXT HL_URHO3D_SKELETON _STRING);

	@:hlNative("Urho3D", "_graphics_skeleton_get_bone")
	private static function _GetBone(context:Context, skeleton:Skeleton, name:String):Bone {
		return null;
	}
}
