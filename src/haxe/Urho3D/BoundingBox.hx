package urho3d;

import urho3d.MathDefs.Mathdefs;
import haxe.ds.Vector;

typedef HL_URHO3D_BOUNDINGBOX = hl.Abstract<"hl_urho3d_math_boundingbox">;

@:hlNative("Urho3D")
abstract BoundingBox(HL_URHO3D_BOUNDINGBOX) {
	public var min(get, set):TVector3;
	public var max(get, set):TVector3;

	public inline function new(x:Vector3, y:Vector3) {
		this = CreateV3V3(x, y);
	}

	function set_min(m) {
		_SetMin(cast this, m);
		return m;
	}

	function get_min() {
		return _GetMin(cast this);
	}

	function set_max(m) {
		_SetMax(cast this, m);
		return m;
	}

	function get_max() {
		return _GetMax(cast this);
	}

	@:hlNative("Urho3D", "_math_boundingbox_create_ff")
	private static function CreateFF(x:Single, y:Single):HL_URHO3D_BOUNDINGBOX {
		return null;
	}

	@:hlNative("Urho3D", "_math_boundingbox_create_v3_v3")
	private static function CreateV3V3(x:Vector3, y:Vector3):HL_URHO3D_BOUNDINGBOX {
		return null;
	}

	@:hlNative("Urho3D", "_math_boundingbox_set_min")
	private static function _SetMin(b:BoundingBox, y:TVector3):Void {}

	@:hlNative("Urho3D", "_math_boundingbox_get_min")
	private static function _GetMin(b:BoundingBox):TVector3 {
		return null;
	}

	@:hlNative("Urho3D", "_math_boundingbox_set_max")
	private static function _SetMax(b:BoundingBox, y:TVector3):Void {}

	@:hlNative("Urho3D", "_math_boundingbox_get_max")
	private static function _GetMax(b:BoundingBox):TVector3 {
		return null;
	}
}
