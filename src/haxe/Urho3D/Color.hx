package urho3d;

typedef HL_URHO3D_COLOR = hl.Abstract<"hl_urho3d_color">;


@:hlNative("Urho3D")
abstract Color(HL_URHO3D_COLOR) {

    public inline function new(r_:Float = 0 , g_:Float=0,b_:Float=0,a_:Float=1.0) {
        this = Create(r_,g_,b_,a_);

    }

    @:hlNative("Urho3D", "_math_create_color")
	private static function Create(r:Single,g:Single,b:Single,a:Single):HL_URHO3D_COLOR {
		return null;
    }

}