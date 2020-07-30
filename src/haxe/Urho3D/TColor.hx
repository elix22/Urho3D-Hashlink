package urho3d;

typedef HL_URHO3D_TCOLOR = hl.Abstract<"hl_urho3d_tcolor">;


@:hlNative("Urho3D")
abstract TColor(HL_URHO3D_TCOLOR) {

    public inline function new(r_:Float = 0 , g_:Float=0,b_:Float=0,a_:Float=1.0) {
        this = Create(r_,g_,b_,a_);

    }

    @:hlNative("Urho3D", "_math_tcolor_create")
	private static function Create(r:Single,g:Single,b:Single,a:Single):HL_URHO3D_TCOLOR {
		return null;
    }


    @:to
	public inline function toColor():Color {
		return _CastToColor(cast this);
	}

	@:from
	public static inline function fromColor(v:Color):TColor {
		return _CastFromColor(v);
    }
    


    @:hlNative("Urho3D", "_math_tcolor_cast_from_color")
	private static function _CastFromColor(vec2:Color):TColor {
		return null;
	}

	@:hlNative("Urho3D", "_math_tcolor_cast_to_color")
	private static function _CastToColor(vec2:TColor):Color {
		return null;
    }
    
}