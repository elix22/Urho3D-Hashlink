package urho3d;

import urho3d.MathDefs.Mathdefs;
import haxe.ds.Vector;

typedef HL_URHO3D_VECTOR3 = hl.Abstract<"hl_urho3d_math_vector3">;
typedef StructVector3 = {x:Single, y:Single, z:Single};

@:hlNative("Urho3D")
abstract Vector3(HL_URHO3D_VECTOR3) {
	public static var ZERO:Vector3 = new Vector3(0.0, 0.0,0.0);
	public static var LEFT:Vector3 = new Vector3(-1.0, 0.0,0.0);
	public static var RIGHT:Vector3 = new Vector3(1.0, 0.0,0.0);
	public static var UP:Vector3 = new Vector3(0.0, 1.0,0.0);
	public static var DOWN:Vector3 = new Vector3(0.0, -1.0,0.0);
	public static var ONE:Vector3 = new Vector3(1.0, 1.0,1.0);

	public inline function new(x_:Single = 0.0, y_:Single = 0.0,  z_:Single = 0.0) {
		this = Create(x_, y_,z_);
	}

	@:hlNative("Urho3D", "_math_vector3_create")
	private static function Create(x:Single, y:Single, z:Single):HL_URHO3D_VECTOR3 {
		return null;
	}

	// calling trace(Vector3) , will show x:y

	@:to
	public inline function toString():String {
		var s:String = x + ":" + y + ":" + z;
		return s;
	}

	@:from
	public static inline function fromStructVector3(m:StructVector3):Vector3 {
		return new Vector3(m.x, m.y,m.z);
	}

	@:to
	public inline function toStructVector3():StructVector3 {
		return {x: x, y: y,z:z};
	}

	@:op(A == B)
	public inline function isEqual(rhs:Vector3):Bool {
		return (x == rhs.x && y == rhs.y && z == rhs.z);
	}

	@:op(A != B)
	public inline function isNotEqual(rhs:Vector3):Bool {
		return !(x == rhs.x && y == rhs.y && z == rhs.z);
	}

	@:op(A + B)
	public inline function add(rhs:Vector3):Vector3 {
		var x1:Single = x + rhs.x;
		var y1:Single = y + rhs.y;
        var z1:Single = z + rhs.z;

		return new Vector3(x1, y1,z1);
	}

	@:op(A += B)
	public inline function addTo(rhs:Vector3):Vector3 {
		x += rhs.x;
        y += rhs.y;
        z += rhs.z;
		return cast this;
	}

	@:op(A - B)
	public inline function sub(rhs:Vector3):Vector3 {
		var x1:Single = x - rhs.x;
        var y1:Single = y - rhs.y;
        var z1:Single = z - rhs.z;

		return new Vector3(x1, y1);
	}

	@:op(A -= B)
	public inline function subFrom(rhs:Vector3):Vector3 {
		x -= rhs.x;
		y -= rhs.y;
        z -= rhs.z;
		return cast this;
	}

	@:op(A * B)
	public inline function mul(rhs:Single):Vector3 {
		var x1:Single = x * rhs;
		var y1:Single = y * rhs;
        var z1:Single = z * rhs;
		return new Vector3(x1, y1, z1);
	}

	@:op(A *= B)
	public inline function mulWith(rhs:Single):Vector3 {
		x *= rhs;
		y *= rhs;
        z *= rhs;
		return cast this;
	}

	@:op(A * B)
	public inline function mulVector2(rhs:Vector3):Vector3 {
		var x1:Single = x * rhs.x;
		var y1:Single = y * rhs.y;
        var z1:Single = z * rhs.z;
		return new Vector3(x1, y1, z1);
	}

	@:op(A *= B)
	public inline function mulWithVector2(rhs:Vector3):Vector3 {
		x *= rhs.x;
		y *= rhs.y;
        z *= rhs.z;
		return cast this;
	}

	@:op(A / B)
	public inline function div(rhs:Single):Vector3 {
		var x1:Single = x / rhs;
		var y1:Single = y / rhs;
        var z1:Single = z / rhs;
		return new Vector3(x1, y1, z1);
	}

	@:op(A /= B)
	public inline function divWith(rhs:Single):Vector3 {
		x /= rhs;
		y /= rhs;
        z /= rhs;

		return cast this;
	}

	@:op(A / B)
	public inline function divVector2(rhs:Vector3):Vector3 {
		var x1:Single = x / rhs.x;
		var y1:Single = y / rhs.y;
        var z1:Single = z / rhs.z;

		return new Vector3(x1, y1);
	}

	@:op(A /= B)
	public inline function divWithVector2(rhs:Vector3):Vector3 {
		x /= rhs.x;
		y /= rhs.y;
        z /= rhs.z;
		return cast this;
	}

	@:op(-A)
	public inline function neg():Vector3 {
		x = -x;
        y = -y;
        z = -z;
		return cast this;
	}

	@:op(--A)
	public inline function preNeg():Vector3 {
		x = --x;
        y = --y;
        z = --z;
		return cast this;
	}

	@:op(A--) public inline function postNeg():Vector3 {
		x = x--;
        y = y--;
        z = z--;
		return cast this;
	}

	@:op(++A) public inline function preAdd():Vector3 {
		x = ++x;
        y = ++y;
        z = ++z;
		return cast this;
	}

	@:op(A++) public inline function postAdd():Vector3 {
		x = x++;
        y = y++;
        z = z++;
		return cast this;
	}

	public function Normalize() {
		_Normalize(cast this);
	}

	@:hlNative("Urho3D", "_math_vector3_normalize")
	private static function _Normalize(vec:Vector3):Void {}

	public function Length():Float {
		return _Length(cast this);
	}

	@:hlNative("Urho3D", "_math_vector3_length")
	private static function _Length(vec:Vector3):Single {
		return 0.0;
	}

	public function LengthSquared():Float {
		return _LengthSquared(cast this);
	}

	@:hlNative("Urho3D", "_math_vector3_length_squared")
	private static function _LengthSquared(vec:Vector3):Single {
		return 0.0;
	}

	public function DotProduct(rhs:Vector3):Float {
		return _DotProduct(cast this, rhs);
	}

	@:hlNative("Urho3D", "_math_vector3_dot_product")
	private static function _DotProduct(vec:Vector3, rhs:Vector3):Single {
		return 0.0;
	}

	public function AbsDotProduct(rhs:Vector3):Float {
		return _AbsDotProduct(cast this, rhs);
	}

	@:hlNative("Urho3D", "_math_vector3_dot_product")
	private static function _AbsDotProduct(vec:Vector3, rhs:Vector3):Single {
		return 0.0;
	}

	public function ProjectOntoAxis(rhs:Vector3):Single {
		return _ProjectOntoAxis(cast this, rhs);
	}

	@:hlNative("Urho3D", "_math_vector3_project_onto_axis")
	private static function _ProjectOntoAxis(vec:Vector3, rhs:Vector3):Single {
		return 0.0;
	}

	public function Angle(rhs:Vector3):Single {
		return _Angle(cast this, rhs);
	}

	@:hlNative("Urho3D", "_math_vector3_angle")
	private static function _Angle(vec:Vector3, rhs:Vector3):Single {
		return 0.0;
	}

	public function Lerp(rhs:Vector3, t:Single):Vector3 {
		return _Lerp(cast this, rhs, t);
	}

	@:hlNative("Urho3D", "_math_vector3_lerp")
	private static function _Lerp(vec:Vector3, rhs:Vector3, t:Single):Vector3 {
		return null;
	}

	public function Equals(rhs:Vector3):Bool {
		return _Equals(cast this, rhs);
	}

	@:hlNative("Urho3D", "_math_vector3_equals")
	private static function _Equals(vec:Vector3, rhs:Vector3):Bool {
		return false;
	}

	public function IsNaN():Bool {
		return _IsNaN(cast this);
	}

	@:hlNative("Urho3D", "_math_vector3_is_nan")
	private static function _IsNaN(vec:Vector3):Bool {
		return false;
	}

	public function IsInf():Bool {
		return _IsInf(cast this);
	}

	@:hlNative("Urho3D", "_math_vector3_is_inf")
	private static function _IsInf(vec:Vector3):Bool {
		return false;
	}

	public function Normalized():Vector3 {
		return _Normalized(cast this);
	}

	@:hlNative("Urho3D", "_math_vector3_normalized")
	private static function _Normalized(vec:Vector3):Vector3 {
		return null;
	}

	public function NormalizedOrDefault(?defaultValue:Vector3, ?eps:Single):Vector3 {
		if (defaultValue == null) {
			defaultValue = Vector3.ZERO;
		}
		if (eps == null) {
			eps = cast Mathdefs.M_LARGE_EPSILON;
		}
		return _NormalizedOrDefault(cast this, defaultValue, eps);
	}

	@:hlNative("Urho3D", "_math_vector3_normalized_or_default")
	private static function _NormalizedOrDefault(vec:Vector3, rhs:Vector3, eps:Single):Vector3 {
		return null;
	}

	public function ReNormalized(minLength:Single, maxLength:Single, ?defaultValue:Vector3, ?eps:Single):Vector3 {
		if (defaultValue == null) {
			defaultValue = Vector3.ZERO;
		}
		if (eps == null) {
			eps = cast Mathdefs.M_LARGE_EPSILON;
		}
		return _ReNormalized(cast this, minLength, maxLength, defaultValue, eps);
	}

	@:hlNative("Urho3D", "_math_vector3_renormalized")
	private static function _ReNormalized(vec:Vector3, minLength:Single, maxLength:Single, defaultValue:Vector3, eps:Single):Vector3 {
		return null;
	}

	/**
	 * =====================================================================
	 */
	public var x(get, set):Single;

    public var y(get, set):Single;
    
    public var z(get, set):Single;

	inline function get_x() {
		return _get_x(cast this);
	}

	@:hlNative("Urho3D", "_math_vector3_get_x")
	private static function _get_x(vec:Vector3):Single {
		return 0.0;
	}

	inline function set_x(x) {
		return _set_x(cast this, x);
	}

	@:hlNative("Urho3D", "_math_vector3_set_x")
	private static function _set_x(vec:Vector3, x:Single):Single {
		return 0.0;
	}

	inline function get_y() {
		return _get_y(cast this);
	}

	@:hlNative("Urho3D", "_math_vector3_get_y")
	private static function _get_y(vec:Vector3):Single {
		return 0.0;
	}

	inline function set_y(y) {
		return _set_y(cast this, y);
	}

	@:hlNative("Urho3D", "_math_vector3_set_y")
	private static function _set_y(vec:Vector3, x:Single):Single {
		return 0.0;
    }
    

    inline function get_z() {
		return _get_z(cast this);
	}

	@:hlNative("Urho3D", "_math_vector3_get_z")
	private static function _get_z(vec:Vector3):Single {
		return 0.0;
	}

	inline function set_z(z) {
		return _set_z(cast this, z);
	}

	@:hlNative("Urho3D", "_math_vector3_set_z")
	private static function _set_z(vec:Vector3, x:Single):Single {
		return 0.0;
	}
}
