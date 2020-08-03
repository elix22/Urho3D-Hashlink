package urho3d;

typedef HL_URHO3D_BILLBOARD = hl.Abstract<"hl_urho3d_graphics_billboard">;

@:hlNative("Urho3D")
abstract Billboard(HL_URHO3D_BILLBOARD) {
	public inline function new() {
		this = null;
	}

	public var position(get, set):TVector3;

	function set_position(p) {
		SetPosition(Context.context, cast this, p);
		return p;
	}

	function get_position() {
		return GetPosition(Context.context, cast this);
	}

	public var size(get, set):TVector2;

	function set_size(p) {
		SetSize(Context.context, cast this, p);
		return p;
	}

	function get_size() {
		return GetSize(Context.context, cast this);
    }
    
    public var rotation(get, set):Float;

	function set_rotation(p) {
		SetRotation(Context.context, cast this, p);
		return p;
	}

	function get_rotation() {
		return GetRotation(Context.context, cast this);
    }
    
    public var enabled(get, set):Bool;

	function set_enabled(p) {
		SetEnabled(Context.context, cast this, p);
		return p;
	}

	function get_enabled() {
		return GetEnabled(Context.context, cast this);
	}

	@:hlNative("Urho3D", "_graphics_billboard_set_position")
	private static function SetPosition(c:Context, s:Billboard, p:TVector3):Void {}

	@:hlNative("Urho3D", "_graphics_billboard_get_position")
	private static function GetPosition(c:Context, s:Billboard):TVector3 {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_billboard_set_size")
	private static function SetSize(c:Context, s:Billboard, p:TVector2):Void {}

	@:hlNative("Urho3D", "_graphics_billboard_get_size")
	private static function GetSize(c:Context, s:Billboard):TVector2 {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_billboard_set_rotation")
	private static function SetRotation(c:Context, s:Billboard, p:Single):Void {}

	@:hlNative("Urho3D", "_graphics_billboard_get_rotation")
	private static function GetRotation(c:Context, s:Billboard):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_graphics_billboard_set_enabled")
	private static function SetEnabled(c:Context, s:Billboard, p:Bool):Void {}

	@:hlNative("Urho3D", "_graphics_billboard_get_enabled")
	private static function GetEnabled(c:Context, s:Billboard):Bool {
		return false;
	}
}
