package urho3d;

import urho3d.MathDefs.Mathdefs;
import haxe.ds.Vector;

typedef HL_URHO3D_VECTOR2 = hl.Abstract<"hl_urho3d_math_vector2">;
typedef StructVector2 = {x:Single, y:Single}

@:hlNative("Urho3D")
abstract Vector2(HL_URHO3D_VECTOR2) {
	public static var ZERO:Vector2 = new Vector2(0.0, 0.0);
	public static var LEFT:Vector2 = new Vector2(-1.0, 0.0);
	public static var RIGHT:Vector2 = new Vector2(1.0, 0.0);
	public static var UP:Vector2 = new Vector2(0.0, 1.0);
	public static var DOWN:Vector2 = new Vector2(0.0, -1.0);
	public static var ONE:Vector2 = new Vector2(1.0, 1.0);

	public inline function new(x_:Single = 0.0, y_:Single = 0.0) {
		this = Create(x_, y_);
	}

	@:hlNative("Urho3D", "_math_vector2_create")
	private static function Create(x:Single, y:Single):HL_URHO3D_VECTOR2 {
		return null;
	}

	// calling trace(Vector2) , will show x:y

	@:to
	public inline function toString():String {
		var s:String = x + ":" + y;
		return s;
	}

	@:from
	public static inline function fromStructVector2(m:StructVector2):Vector2 {
		return new Vector2(m.x, m.y);
	}

	@:to
	public inline function toStructVector2():StructVector2 {
		return {x: x, y: y};
	}

	@:op(A == B)
	public inline function isEqual(rhs:Vector2):Bool {
		return (x == rhs.x && y == rhs.y);
	}

	@:op(A != B)
	public inline function isNotEqual(rhs:Vector2):Bool {
		return !(x == rhs.x && y == rhs.y);
	}

	@:op(A + B)
	public inline function add(rhs:Vector2):Vector2 {
		var x1:Single = x + rhs.x;
		var y1:Single = y + rhs.y;

		return new Vector2(x1, y1);
	}

	@:op(A += B)
	public inline function addTo(rhs:Vector2):Vector2 {
		x += rhs.x;
		y += rhs.y;
		return cast this;
	}

	@:op(A - B)
	public inline function sub(rhs:Vector2):Vector2 {
		var x1:Single = x - rhs.x;
		var y1:Single = y - rhs.y;

		return new Vector2(x1, y1);
	}

	@:op(A -= B)
	public inline function subFrom(rhs:Vector2):Vector2 {
		x -= rhs.x;
		y -= rhs.y;

		return cast this;
	}

	@:op(A * B)
	public inline function mul(rhs:Single):Vector2 {
		var x1:Single = x * rhs;
		var y1:Single = y * rhs;

		return new Vector2(x1, y1);
	}

	@:op(A *= B)
	public inline function mulWith(rhs:Single):Vector2 {
		x *= rhs;
		y *= rhs;

		return cast this;
	}

	@:op(A * B)
	public inline function mulVector2(rhs:Vector2):Vector2 {
		var x1:Single = x * rhs.x;
		var y1:Single = y * rhs.y;

		return new Vector2(x1, y1);
	}

	@:op(A *= B)
	public inline function mulWithVector2(rhs:Vector2):Vector2 {
		x *= rhs.x;
		y *= rhs.y;

		return cast this;
	}

	@:op(A / B)
	public inline function div(rhs:Single):Vector2 {
		var x1:Single = x / rhs;
		var y1:Single = y / rhs;

		return new Vector2(x1, y1);
	}

	@:op(A /= B)
	public inline function divWith(rhs:Single):Vector2 {
		x /= rhs;
		y /= rhs;

		return cast this;
	}

	@:op(A / B)
	public inline function divVector2(rhs:Vector2):Vector2 {
		var x1:Single = x / rhs.x;
		var y1:Single = y / rhs.y;

		return new Vector2(x1, y1);
	}

	@:op(A /= B)
	public inline function divWithVector2(rhs:Vector2):Vector2 {
		x /= rhs.x;
		y /= rhs.y;

		return cast this;
	}

	@:op(-A)
	public inline function neg():Vector2 {
		x = -x;
		y = -y;
		return cast this;
	}

	@:op(--A)
	public inline function preNeg():Vector2 {
		x = --x;
		y = --y;
		return cast this;
	}

	@:op(A--) public inline function postNeg():Vector2 {
		x = x--;
		y = y--;
		return cast this;
	}

	@:op(++A) public inline function preAdd():Vector2 {
		x = ++x;
		y = ++y;
		return cast this;
	}

	@:op(A++) public inline function postAdd():Vector2 {
		x = x++;
		y = y++;
		return cast this;
	}

	public function Normalize() {
		_Normalize(cast this);
	}

	@:hlNative("Urho3D", "_math_vector2_normalize")
	private static function _Normalize(vec2:Vector2):Void {}

	public function Length():Float {
		return _Length(cast this);
	}

	@:hlNative("Urho3D", "_math_vector2_length")
	private static function _Length(vec2:Vector2):Single {
		return 0.0;
	}

	public function LengthSquared():Float {
		return _LengthSquared(cast this);
	}

	@:hlNative("Urho3D", "_math_vector2_length_squared")
	private static function _LengthSquared(vec2:Vector2):Single {
		return 0.0;
	}

	public function DotProduct(rhs:Vector2):Float {
		return _DotProduct(cast this, rhs);
	}

	@:hlNative("Urho3D", "_math_vector2_dot_product")
	private static function _DotProduct(vec2:Vector2, rhs:Vector2):Single {
		return 0.0;
	}

	public function AbsDotProduct(rhs:Vector2):Float {
		return _AbsDotProduct(cast this, rhs);
	}

	@:hlNative("Urho3D", "_math_vector2_dot_product")
	private static function _AbsDotProduct(vec2:Vector2, rhs:Vector2):Single {
		return 0.0;
	}

	public function ProjectOntoAxis(rhs:Vector2):Single {
		return _ProjectOntoAxis(cast this, rhs);
	}

	@:hlNative("Urho3D", "_math_vector2_project_onto_axis")
	private static function _ProjectOntoAxis(vec2:Vector2, rhs:Vector2):Single {
		return 0.0;
	}

	public function Angle(rhs:Vector2):Single {
		return _Angle(cast this, rhs);
	}

	@:hlNative("Urho3D", "_math_vector2_angle")
	private static function _Angle(vec2:Vector2, rhs:Vector2):Single {
		return 0.0;
	}

	public function Lerp(rhs:Vector2, t:Single):Vector2 {
		return _Lerp(cast this, rhs, t);
	}

	@:hlNative("Urho3D", "_math_vector2_lerp")
	private static function _Lerp(vec2:Vector2, rhs:Vector2, t:Single):Vector2 {
		return null;
	}

	public function Equals(rhs:Vector2):Bool {
		return _Equals(cast this, rhs);
	}

	@:hlNative("Urho3D", "_math_vector2_equals")
	private static function _Equals(vec2:Vector2, rhs:Vector2):Bool {
		return false;
	}

	public function IsNaN():Bool {
		return _IsNaN(cast this);
	}

	@:hlNative("Urho3D", "_math_vector2_is_nan")
	private static function _IsNaN(vec2:Vector2):Bool {
		return false;
	}

	public function IsInf():Bool {
		return _IsInf(cast this);
	}

	@:hlNative("Urho3D", "_math_vector2_is_inf")
	private static function _IsInf(vec2:Vector2):Bool {
		return false;
	}

	public function Normalized():Vector2 {
		return _Normalized(cast this);
	}

	@:hlNative("Urho3D", "_math_vector2_normalized")
	private static function _Normalized(vec2:Vector2):Vector2 {
		return null;
	}

	public function NormalizedOrDefault(?defaultValue:Vector2, ?eps:Single):Vector2 {
		if (defaultValue == null) {
			defaultValue = Vector2.ZERO;
		}
		if (eps == null) {
			eps = cast Mathdefs.M_LARGE_EPSILON;
		}
		return _NormalizedOrDefault(cast this, defaultValue, eps);
	}

	@:hlNative("Urho3D", "_math_vector2_normalized_or_default")
	private static function _NormalizedOrDefault(vec2:Vector2, rhs:Vector2, eps:Single):Vector2 {
		return null;
	}

	public function ReNormalized(minLength:Single, maxLength:Single, ?defaultValue:Vector2, ?eps:Single):Vector2 {
		if (defaultValue == null) {
			defaultValue = Vector2.ZERO;
		}
		if (eps == null) {
			eps = cast Mathdefs.M_LARGE_EPSILON;
		}
		return _ReNormalized(cast this, minLength, maxLength, defaultValue, eps);
	}

	@:hlNative("Urho3D", "_math_vector2_renormalized")
	private static function _ReNormalized(vec2:Vector2, minLength:Single, maxLength:Single, defaultValue:Vector2, eps:Single):Vector2 {
		return null;
	}

	/**
	 * =====================================================================
	 */
	public var x(get, set):Single;

	public var y(get, set):Single;

	inline function get_x() {
		return _get_x(cast this);
	}

	@:hlNative("Urho3D", "_math_vector2_get_x")
	private static function _get_x(vec2:Vector2):Single {
		return 0.0;
	}

	inline function set_x(x) {
		return _set_x(cast this, x);
	}

	@:hlNative("Urho3D", "_math_vector2_set_x")
	private static function _set_x(vec2:Vector2, x:Single):Single {
		return 0.0;
	}

	inline function get_y() {
		return _get_y(cast this);
	}

	@:hlNative("Urho3D", "_math_vector2_get_y")
	private static function _get_y(vec2:Vector2):Single {
		return 0.0;
	}

	inline function set_y(y) {
		return _set_y(cast this, y);
	}

	@:hlNative("Urho3D", "_math_vector2_set_y")
	private static function _set_y(vec2:Vector2, x:Single):Single {
		return 0.0;
	}
}
