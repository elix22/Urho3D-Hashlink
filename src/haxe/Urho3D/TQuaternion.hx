package urho3d;


typedef HL_URHO3D_TQUATERNION = hl.Abstract<"hl_urho3d_math_tquaternion">;


@:hlNative("Urho3D")
abstract TQuaternion(HL_URHO3D_TQUATERNION) {

	public inline function new(x_:Float = 0.0, y_:Float = 0.0, z_:Float = 0.0) {
		this = Create(x_, y_,z_);
	}
    
    
    @:to
	public inline function toQuaternion():Quaternion {
		return _CastToQuaternion(cast this);
	}

	@:from
	public static inline function fromQuaternion(v:Quaternion):TQuaternion {
		return _CastFromQuaternion(v);
    }


	@:hlNative("Urho3D", "_math_tquaternion_create")
	private static function Create(x:Single, y:Single, z:Single):HL_URHO3D_TQUATERNION {
		return null;
	}
    
    
    @:hlNative("Urho3D", "_math_tquaternion_cast_from_quaternion")
	private static function _CastFromQuaternion(t:Quaternion):TQuaternion {
		return null;
    }
    
    @:hlNative("Urho3D", "_math_tquaternion_cast_to_quaternion")
	private static function _CastToQuaternion(t:TQuaternion):Quaternion {
		return null;
	}

}