package urho3d;


typedef HL_URHO3D_QUATERNION = hl.Abstract<"hl_urho3d_math_quaternion">;
typedef StructQuaternion = {x:Float, y:Float, z:Float};

@:hlNative("Urho3D")
abstract Quaternion(HL_URHO3D_QUATERNION) {

	public inline function new(x_:Float = 0.0, y_:Float = 0.0, z_:Float = 0.0) {
		this = Create(x_, y_,z_);
	}
	

	public inline function SetAngles(x:Float, y:Float, z:Float):Void
		{
			_SetAngles(cast this,x, y, z);
		}

	@:hlNative("Urho3D", "_math_quaternion_create")
	private static function Create(x:Single, y:Single, z:Single):HL_URHO3D_QUATERNION {
		return null;
	}
	
	//DEFINE_PRIM(_VOID, _math_quaternion_set_euler_angles, HL_URHO3D_QUATERNION _F32 _F32 _F32);
	@:hlNative("Urho3D", "_math_quaternion_set_euler_angles")
	private static function _SetAngles(q:Quaternion,x:Single, y:Single, z:Single):Void {
	}
    
}