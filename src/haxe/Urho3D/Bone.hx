package urho3d;

typedef HL_URHO3D_BONE = hl.Abstract<"hl_urho3d_graphics_bone">;

@:hlNative("Urho3D")
abstract Bone(HL_URHO3D_BONE) {
	public var animated(get, set):Bool;

	function set_animated(b) {
		_SetAnimated(Context.context, cast this, b);
		return b;
	}

	function get_animated() {
		return _GetAnimated(Context.context, cast this);
	}

	@:hlNative("Urho3D", "_graphics_bone_set_animated")
	private static function _SetAnimated(context:Context, bone:Bone, animated:Bool):Void {}

	@:hlNative("Urho3D", "_graphics_bone_get_animated")
	private static function _GetAnimated(context:Context, bone:Bone):Bool {
		return false;
	}
}
