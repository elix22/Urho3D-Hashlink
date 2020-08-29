package urho3d;

typedef HL_URHO3D_QUATERNION = hl.Abstract<"hl_urho3d_math_quaternion">;
typedef StructQuaternion = {x:Float, y:Float, z:Float};

@:hlNative("Urho3D")
abstract Quaternion(HL_URHO3D_QUATERNION) {

	public static var IDENTITY:Quaternion = new Quaternion();

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


	public inline function SetAngles(x:Float, y:Float, z:Float):Void {
		_SetAngles(cast this, x, y, z);
	}

	@:op(A * B)
	public inline function mulTQuaternion(rhs:TQuaternion):TQuaternion {
		return TQuaternion._MultiplyTQuaternion(TQuaternion._CastFromQuaternion(cast this) , rhs);
	}

	@:op(A * B)
	public inline function mulQuaternion(rhs:Quaternion):TQuaternion {
		return TQuaternion._MultiplyTQuaternion(TQuaternion._CastFromQuaternion(cast this), TQuaternion._CastFromQuaternion(rhs));
	}



	@:to
	public inline function toTQuaternion():TQuaternion {
		return TQuaternion._CastFromQuaternion(cast this);
	}

	@:from
	public static inline function fromTQuaternion(q:TQuaternion):Quaternion {
		return TQuaternion._CastToQuaternion(q);
	}

	@:hlNative("Urho3D", "_math_quaternion_create")
	private static function Create(x:Single, y:Single, z:Single):HL_URHO3D_QUATERNION {
		return null;
	}

	@:hlNative("Urho3D", "_math_quaternion_create_fv")
	private static function Create_fv(x:Single, v:TVector3):HL_URHO3D_QUATERNION {
		return null;
	}

	// DEFINE_PRIM(_VOID, _math_quaternion_set_euler_angles, HL_URHO3D_QUATERNION _F32 _F32 _F32);

	@:hlNative("Urho3D", "_math_quaternion_set_euler_angles")
	private static function _SetAngles(q:Quaternion, x:Single, y:Single, z:Single):Void {}

	@:hlNative("Urho3D", "_math_quaternion_normalize")
	private static function _Normalize(t:Quaternion):Void {}
}
