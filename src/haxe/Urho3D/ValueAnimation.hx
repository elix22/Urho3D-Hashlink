package urho3d;

typedef HL_URHO3D_VALUE_ANIMATION = hl.Abstract<"hl_urho3d_scene_value_animation">;

@:hlNative("Urho3D")
abstract ValueAnimation(HL_URHO3D_VALUE_ANIMATION) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:hlNative("Urho3D", "_scene_value_animation_create")
	private static function Create(context:Context):HL_URHO3D_VALUE_ANIMATION {
		return null;
	}

	public function SetKeyFrame( time:Float, value:TVariant):Bool
	{
		return _SetKeyFrame(Context.context,cast this,time,value);
	}

	//DEFINE_PRIM(_BOOL, _scene_value_animation_set_keyframe, URHO3D_CONTEXT HL_URHO3D_VALUE_ANIMATION _F32 HL_URHO3D_TVARIANT );
	@:hlNative("Urho3D", "_scene_value_animation_set_keyframe")
	private static function _SetKeyFrame(context:Context,va:ValueAnimation,t:Single,v:TVariant):Bool {
		return false;
	}
}