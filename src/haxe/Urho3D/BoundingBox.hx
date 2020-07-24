package urho3d;

import urho3d.MathDefs.Mathdefs;
import haxe.ds.Vector;

typedef HL_URHO3D_BOUNDINGBOX = hl.Abstract<"hl_urho3d_math_boundingbox">;

@:hlNative("Urho3D")
abstract BoundingBox(HL_URHO3D_BOUNDINGBOX) {
	public inline function new(x:Vector3, y:Vector3) {
		this = CreateV3V3(x, y);
	}

	@:hlNative("Urho3D", "_math_boundingbox_create_ff")
	private static function CreateFF(x:Single, y:Single):HL_URHO3D_BOUNDINGBOX {
		return null;
	}

	@:hlNative("Urho3D", "_math_boundingbox_create_v3_v3")
	private static function CreateV3V3(x:Vector3, y:Vector3):HL_URHO3D_BOUNDINGBOX {
		return null;
	}
}
