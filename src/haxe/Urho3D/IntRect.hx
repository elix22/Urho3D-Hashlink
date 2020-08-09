package urho3d;

typedef HL_URHO3D_INTRECT = hl.Abstract<"hl_urho3d_math_intrect">;

@:hlNative("Urho3D")
abstract IntRect(HL_URHO3D_INTRECT) {
	public inline function new(left:Int=0,top:Int=0,right:Int=0,bottom:Int=0) {
		this = Create(left,top,right,bottom);
	}

    //HL_PRIM hl_urho3d_math_intrect *HL_NAME(_math_intrect_create)(int left, int top, int right, int bottom)
	@:hlNative("Urho3D", "_math_intrect_create")
	private static function Create(left:Int,top:Int,right:Int,bottom:Int):HL_URHO3D_INTRECT {
		return null;
	}
}
