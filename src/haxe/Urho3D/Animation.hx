package urho3d;

typedef HL_URHO3D_ANIMATION = hl.Abstract<"hl_urho3d_graphics_animation">;

enum abstract WrapMode(Int) to Int from Int
{
    /// Loop mode.
    var WM_LOOP = 0;
    /// Play once, when animation finished it will be removed.
    var WM_ONCE;
    /// Clamp mode.
    var WM_CLAMP;
}

@:hlNative("Urho3D")
abstract Animation(HL_URHO3D_ANIMATION) {
	public var length(get, never):Float;

	public inline function new(name:String) {
		this = Create(Context.context, name);
	}

	function get_length() {
		return GetLength(Context.context, cast this);
	}

	@:hlNative("Urho3D", "_graphics_animation_create")
	private static function Create(context:Context, name:String):HL_URHO3D_ANIMATION {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_animation_get_length")
	private static function GetLength(context:Context, a:Animation):Single {
		return 0.0;
	}
}
