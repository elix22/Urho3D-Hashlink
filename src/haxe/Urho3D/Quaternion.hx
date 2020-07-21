package urho3d;


typedef HL_URHO3D_QUATERNION = hl.Abstract<"hl_urho3d_math_quaternion">;


@:hlNative("Urho3D")
abstract Quaternion(HL_URHO3D_QUATERNION) {

	public inline function new(x_:Single = 0.0, y_:Single = 0.0, z_:Single = 0.0) {
		this = Create(x_, y_,z_);
	}

	@:hlNative("Urho3D", "_math_quaternion_create")
	private static function Create(x:Single, y:Single, z:Single):HL_URHO3D_QUATERNION {
		return null;
    }
    
}