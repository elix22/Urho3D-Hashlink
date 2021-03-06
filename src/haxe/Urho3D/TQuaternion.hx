package urho3d;

typedef HL_URHO3D_TQUATERNION = hl.Abstract<"hl_urho3d_math_tquaternion">;

@:hlNative("Urho3D")
abstract TQuaternion(HL_URHO3D_TQUATERNION) {
	public inline function new(x_:Float = 0.0, y_:Float = 0.0, z_:Float = 0.0, ?v:TVector3) {
		if (v != null) {
			this = Create_fv(x_, v);
		} else {
			this = Create(x_, y_, z_);
		}
	}

	public inline function Normalize() {
		_Normalize(cast this);
	}

	@:to
	public inline function toQuaternion():Quaternion {
		return _CastToQuaternion(cast this);
	}

	@:from
	public static inline function fromQuaternion(v:Quaternion):TQuaternion {
		return _CastFromQuaternion(v);
	}

	@:op(A * B)
	public inline function mulTVector3(rhs:TVector3):TVector3 {
		return _MultiplyTVector3(cast this, rhs);
	}

	@:op(A * B)
	public inline function mulVector3(rhs:Vector3):TVector3 {
		var t:TVector3 = rhs;
		return _MultiplyTVector3(cast this, t);
	}

	@:op(A * B)
	public inline function mulTQuaternion(rhs:TQuaternion):TQuaternion {
		return _MultiplyTQuaternion(cast this, rhs);
	}

	@:op(A * B)
	public inline function mulQuaternion(rhs:Quaternion):TQuaternion {
		return _MultiplyTQuaternion(cast this, _CastFromQuaternion(rhs));
	}


	@:hlNative("Urho3D", "_math_t_quaternion_create")
	private static function Create(x:Single, y:Single, z:Single):HL_URHO3D_TQUATERNION {
		return null;
	}

	@:hlNative("Urho3D", "_math_t_quaternion_create_fv")
	private static function Create_fv(x:Single, v:TVector3):HL_URHO3D_TQUATERNION {
		return null;
	}

	@:hlNative("Urho3D", "_math_t_quaternion_cast_from_quaternion")
	public static function _CastFromQuaternion(t:Quaternion):TQuaternion {
		return null;
	}

	@:hlNative("Urho3D", "_math_t_quaternion_cast_to_quaternion")
	public static function _CastToQuaternion(t:TQuaternion):Quaternion {
		return null;
	}

	@:hlNative("Urho3D", "_math_t_quaternion_multiply_tvector3")
	public static function _MultiplyTVector3(t:TQuaternion, v:TVector3):TVector3 {
		return null;
	}

	@:hlNative("Urho3D", "_math_t_quaternion_multiply_tquaternion")
	public static function _MultiplyTQuaternion(t:TQuaternion, v:TQuaternion):TQuaternion {
		return null;
	}

	@:hlNative("Urho3D", "_math_t_quaternion_normalize")
	private static function _Normalize(t:TQuaternion):Void {}
}
