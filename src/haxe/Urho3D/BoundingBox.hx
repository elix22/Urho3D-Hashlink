package urho3d;

import urho3d.MathDefs.Mathdefs;
import haxe.ds.Vector;

typedef HL_URHO3D_BOUNDINGBOX = hl.Abstract<"hl_urho3d_math_boundingbox">;

@:hlNative("Urho3D")
abstract BoundingBox(HL_URHO3D_BOUNDINGBOX) {
	public inline function new(x:Dynamic, y:Dynamic) {
		if (x != null && y != null) {
			if (Type.typeof(x) == TFloat && Type.typeof(y) == TFloat) {
				this = CreateFF(x, y);
			} else if (Vector3.isTypeOf(x) == true && Vector3.isTypeOf(y) == true) {
				this = CreateV3V3(x, y);
			} else {
				this = CreateFF(0.0, 0.0);
			}
		} else {
			this = CreateFF(0.0, 0.0);
		}
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
